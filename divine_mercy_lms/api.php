<?php
require __DIR__.'/config.php';
$action=$_GET['action'] ?? '';
try {
  $db=db();
  if ($action==='login') {
    $role=$_POST['role']??''; $id=trim($_POST['username']??''); $pw=$_POST['password']??'';
    if (!in_array($role,['teacher','admin'],true)) json_out(['error'=>'Choose a valid login type.'],422);
    if ($role==='admin') {
      $q=$db->prepare("SELECT Name,Password FROM admin WHERE Name=? LIMIT 1"); $q->bind_param('s',$id); $q->execute(); $r=$q->get_result()->fetch_assoc();
      if (!$r || !hash_equals((string)$r['Password'],$pw)) json_out(['error'=>'Invalid admin username or password.'],401);
      session_regenerate_id(true); $_SESSION=['role'=>'admin','username'=>$r['Name']];
      json_out(['ok'=>true,'role'=>'admin']);
    }
    $q=$db->prepare("SELECT ID,Password,First_Name,Middle_Initials,Last_Name,Date_Joined FROM teacher WHERE ID=? LIMIT 1"); $q->bind_param('s',$id); $q->execute(); $r=$q->get_result()->fetch_assoc();
    if (!$r || !hash_equals((string)$r['Password'],$pw)) json_out(['error'=>'Invalid teacher ID or password.'],401);
    session_regenerate_id(true); $_SESSION=['role'=>'teacher','username'=>$r['ID']];
    json_out(['ok'=>true,'role'=>'teacher']);
  }
  if ($action==='session') json_out(['role'=>$_SESSION['role']??null,'username'=>$_SESSION['username']??null]);
  if ($action==='logout') { $_SESSION=[]; session_destroy(); json_out(['ok'=>true]); }
  if ($action==='dashboard') {
    require_role('teacher');
    $section=trim($_GET['section']??'');
    $sections=[]; $res=$db->query("SELECT DISTINCT Section FROM student ORDER BY Section"); while($r=$res->fetch_assoc()) $sections[]=$r['Section'];
    if ($section==='') $section=$sections[0]??'';
    $q=$db->prepare("SELECT ID,First_Name,Middle_Initials,Last_Name,Section,Progress,Mastery FROM student WHERE Section=? ORDER BY Last_Name,First_Name"); $q->bind_param('s',$section); $q->execute(); $students=$q->get_result()->fetch_all(MYSQLI_ASSOC);
    $rank=[]; foreach($sections as $sec){$s=$db->prepare("SELECT AVG(Progress) avg_progress FROM student WHERE Section=?");$s->bind_param('s',$sec);$s->execute();$rank[]=['section'=>$sec,'progress'=>round((float)($s->get_result()->fetch_assoc()['avg_progress']??0),1)];}
    usort($rank,fn($a,$b)=>$b['progress']<=>$a['progress']);
    json_out(['sections'=>$sections,'selected'=>$section,'students'=>$students,'ranking'=>$rank]);
  }
  if ($action==='student_profile') {
    require_role('teacher'); $id=trim($_GET['id']??'');
    $q=$db->prepare("SELECT ID,First_Name,Middle_Initials,Last_Name,Section,Progress,Mastery,PlayerName,PlayerGender,Date_Joined FROM student WHERE ID=?");$q->bind_param('s',$id);$q->execute();$student=$q->get_result()->fetch_assoc();
    if(!$student) json_out(['error'=>'Student not found.'],404);
    // The student profile's pre-test/post-test table is sourced directly from `records`.
    // That table does not define total-question counts or timestamps, so do not fabricate them.
    $scores=[];
    if (column_exists($db,'records','ID')) {
      $q=$db->prepare("SELECT Chapter1_Pre,Chapter1_Post,Chapter2_Pre,Chapter2_Post FROM records WHERE ID=?");
      $q->bind_param('s',$id); $q->execute(); $record=$q->get_result()->fetch_assoc();
      if ($record) {
        foreach ([1,2] as $chapter) {
          foreach (['Pre'=>'PreTest','Post'=>'PostTest'] as $suffix=>$type) {
            $column="Chapter{$chapter}_{$suffix}";
            if (array_key_exists($column,$record) && $record[$column]!==null) {
              $scores[]=['chapter'=>$chapter,'quiz_type'=>$type,'correct_answers'=>$record[$column],'total_questions'=>null,'updated_at'=>null];
            }
          }
        }
      }
    }
    json_out(['student'=>$student,'scores'=>$scores]);
  }
  if ($action==='content_list') {
    require_role($_SESSION['role']??'');
    $table=($_SESSION['role']==='admin')?'admin_content':'teacher_content';
    $res=$db->query("SELECT Indicate,Exam,Choice1,Choice2,Choice3,Choice4,Answer FROM `$table` ORDER BY Indicate");
    json_out(['rows'=>$res->fetch_all(MYSQLI_ASSOC),'table'=>$table]);
  }
  if ($action==='content_save') {
    require_role($_SESSION['role']??''); $table=($_SESSION['role']==='admin')?'admin_content':'teacher_content';
    $data=json_decode(file_get_contents('php://input'),true)??[];
    $id=(int)($data['Indicate']??0); if($id<1) json_out(['error'=>'Invalid row.'],422);
    $fields=[]; foreach(['Exam','Choice1','Choice2','Choice3','Choice4','Answer'] as $k) $fields[$k]=(string)($data[$k]??'');
    $q=$db->prepare("UPDATE `$table` SET Exam=?,Choice1=?,Choice2=?,Choice3=?,Choice4=?,Answer=? WHERE Indicate=?");
    $q->bind_param('ssssssi',$fields['Exam'],$fields['Choice1'],$fields['Choice2'],$fields['Choice3'],$fields['Choice4'],$fields['Answer'],$id);$q->execute();
    json_out(['ok'=>true]);
  }
  if ($action==='content_reset') {
    require_role('teacher'); $db->query("DELETE FROM teacher_content");
    $db->query("INSERT INTO teacher_content (Indicate,Exam,Choice1,Choice2,Choice3,Choice4,Answer) SELECT Indicate,Exam,Choice1,Choice2,Choice3,Choice4,Answer FROM admin_content");
    json_out(['ok'=>true]);
  }
  if ($action==='admin_students' || $action==='admin_teachers') {
    require_role('admin'); $table=$action==='admin_students'?'student':'teacher';
    $cols=$table==='student'?'ID,First_Name,Middle_Initials,Last_Name,Section,PlayerGender,Progress,Mastery,Date_Joined':'ID,First_Name,Middle_Initials,Last_Name,Date_Joined';
    $res=$db->query("SELECT $cols FROM `$table` ORDER BY Last_Name,First_Name");json_out(['rows'=>$res->fetch_all(MYSQLI_ASSOC)]);
  }
  if ($action==='admin_home') {
    require_role('admin');$res=$db->query("SELECT ID,First_Name,Middle_Initials,Last_Name,Section FROM student ORDER BY Last_Name,First_Name");$rows=$res->fetch_all(MYSQLI_ASSOC);json_out(['rows'=>$rows]);
  }
  if ($action==='create_account') {
    require_role('admin');$d=json_decode(file_get_contents('php://input'),true)??[];$kind=$d['kind']??'student';
    if(!in_array($kind,['student','teacher'],true)) json_out(['error'=>'Invalid account type.'],422);
    $id=trim((string)($d['ID']??''));$pw=(string)($d['Password']??'');
    $fn=clean_name((string)($d['First_Name']??''));$mi=clean_name((string)($d['Middle_Initials']??''));$ln=clean_name((string)($d['Last_Name']??''));
    if($id===''||$pw===''||$fn===''||$ln==='') json_out(['error'=>'ID, password, first name and last name are required.'],422);
    if($kind==='teacher'){$q=$db->prepare("INSERT INTO teacher (ID,Password,First_Name,Middle_Initials,Last_Name,Date_Joined) VALUES (?,?,?,?,?,CURDATE())");$q->bind_param('sssss',$id,$pw,$fn,$mi,$ln);$q->execute();}
    else {$section=trim((string)($d['Section']??''));$gender=clean_name((string)($d['PlayerGender']??''));if($section==='')json_out(['error'=>'Section is required.'],422);$player=trim((string)($d['PlayerName']??$fn));$zero=0.0;$q=$db->prepare("INSERT INTO student (ID,Password,First_Name,Middle_Initials,Last_Name,Section,PlayerName,PlayerGender,Progress,Mastery,Date_Joined) VALUES (?,?,?,?,?,?,?,?,?,?,CURDATE())");$q->bind_param('ssssssssdd',$id,$pw,$fn,$mi,$ln,$section,$player,$gender,$zero,$zero);$q->execute();}
    json_out(['ok'=>true]);
  }
  if ($action==='delete_account') {
    require_role('admin');$d=json_decode(file_get_contents('php://input'),true)??[];$kind=$d['kind']??'student';$id=(string)($d['ID']??'');$table=$kind==='teacher'?'teacher':'student';$q=$db->prepare("DELETE FROM `$table` WHERE ID=?");$q->bind_param('s',$id);$q->execute();json_out(['ok'=>true]);
  }
  if ($action==='reset_account_password') {
    require_role('admin');$d=json_decode(file_get_contents('php://input'),true)??[];$kind=$d['kind']??'student';$id=(string)($d['ID']??'');$pw=(string)($d['Password']??'');if($pw==='')json_out(['error'=>'Password is required.'],422);$table=$kind==='teacher'?'teacher':'student';$q=$db->prepare("UPDATE `$table` SET Password=? WHERE ID=?");$q->bind_param('ss',$pw,$id);$q->execute();json_out(['ok'=>true]);
  }
  if ($action==='profile') {
    require_role($_SESSION['role']??'');$role=$_SESSION['role'];
    if($role==='admin'){$q=$db->prepare("SELECT Name AS ID,Name AS First_Name,'' AS Middle_Initials,'' AS Last_Name,'' AS Date_Joined FROM admin WHERE Name=?");$q->bind_param('s',$_SESSION['username']);}
    else {$q=$db->prepare("SELECT ID,First_Name,Middle_Initials,Last_Name,Date_Joined FROM teacher WHERE ID=?");$q->bind_param('s',$_SESSION['username']);}
    $q->execute();json_out(['profile'=>$q->get_result()->fetch_assoc()]);
  }
  if ($action==='change_password') {
    require_role($_SESSION['role']??'');$d=json_decode(file_get_contents('php://input'),true)??[];$old=(string)($d['old']??'');$new=(string)($d['new']??'');if(strlen($new)<6)json_out(['error'=>'New password must be at least 6 characters.'],422);
    if($_SESSION['role']==='admin'){$q=$db->prepare("SELECT Password FROM admin WHERE Name=?");$q->bind_param('s',$_SESSION['username']);$q->execute();$r=$q->get_result()->fetch_assoc();if(!$r||!hash_equals((string)$r['Password'],$old))json_out(['error'=>'Current password is incorrect.'],401);$q=$db->prepare("UPDATE admin SET Password=? WHERE Name=?");$q->bind_param('ss',$new,$_SESSION['username']);}
    else {$q=$db->prepare("SELECT Password FROM teacher WHERE ID=?");$q->bind_param('s',$_SESSION['username']);$q->execute();$r=$q->get_result()->fetch_assoc();if(!$r||!hash_equals((string)$r['Password'],$old))json_out(['error'=>'Current password is incorrect.'],401);$q=$db->prepare("UPDATE teacher SET Password=? WHERE ID=?");$q->bind_param('ss',$new,$_SESSION['username']);}
    $q->execute();json_out(['ok'=>true]);
  }
  if ($action==='save_avatar') {
    require_role($_SESSION['role']??'');$d=json_decode(file_get_contents('php://input'),true)??[];$img=(string)($d['image']??'');if(!str_starts_with($img,'data:image/'))json_out(['error'=>'Invalid image.'],422);
    if(strlen($img)>2500000)json_out(['error'=>'Image must be under 1.8 MB.'],422);$dir=__DIR__.'/uploads';if(!is_dir($dir))mkdir($dir,0755,true);$safe=preg_replace('/[^a-zA-Z0-9_-]/','',$_SESSION['role'].'_'.$_SESSION['username']);$path=$dir.'/'.$safe.'.txt';file_put_contents($path,$img);json_out(['ok'=>true,'url'=>'uploads/'.$safe.'.txt']);
  }
  if ($action==='avatar') {require_role($_SESSION['role']??'');$safe=preg_replace('/[^a-zA-Z0-9_-]/','',$_SESSION['role'].'_'.$_SESSION['username']);$p=__DIR__.'/uploads/'.$safe.'.txt';json_out(['image'=>is_file($p)?file_get_contents($p):null]);}
  json_out(['error'=>'Unknown action.'],404);
} catch(Throwable $e) { json_out(['error'=>'Server/database error: '.$e->getMessage()],500); }
