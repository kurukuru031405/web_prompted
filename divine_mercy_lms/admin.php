<?php
require __DIR__.'/config.php';
require_login('admin');
$pdo = db();
$user = current_user();
$page = $_GET['page'] ?? 'home';
$allowedPages = ['home','students','teachers','contents','profile'];
if (!in_array($page, $allowedPages, true)) $page = 'home';

function admin_redirect(string $page): never { header('Location: admin.php?page='.$page); exit; }
function admin_col_exists(PDO $pdo, string $table, string $column): bool {
    $q=$pdo->prepare('SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME=? AND COLUMN_NAME=?');
    $q->execute([$table,$column]); return (bool)$q->fetchColumn();
}
function admin_table_exists(PDO $pdo, string $table): bool {
    $q=$pdo->prepare('SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME=?');
    $q->execute([$table]); return (bool)$q->fetchColumn();
}
function admin_password(string $password): string { return password_hash($password, PASSWORD_DEFAULT); }
function admin_make_password(): string { return 'DMCF-'.bin2hex(random_bytes(3)); }
function admin_letters_only(string $value, bool $allowBlank=false): bool {
    $value=trim($value);
    if ($allowBlank && $value==='') return true;
    return $value!=='' && preg_match("/^[\\p{L}]+(?:[ '\\-’][\\p{L}]+)*$/u", $value)===1;
}
function admin_upload_picture(string $field, string $prefix): ?string {
    if (empty($_FILES[$field]['name']) || ($_FILES[$field]['error'] ?? UPLOAD_ERR_NO_FILE) === UPLOAD_ERR_NO_FILE) return null;
    if ($_FILES[$field]['error'] !== UPLOAD_ERR_OK) throw new RuntimeException('The picture upload failed. Please try again.');
    if ($_FILES[$field]['size'] > 4*1024*1024) throw new RuntimeException('Picture must be 4 MB or smaller.');
    $info = @getimagesize($_FILES[$field]['tmp_name']);
    if (!$info || !in_array($info['mime'], ['image/jpeg','image/png','image/webp'], true)) throw new RuntimeException('Use a JPG, PNG, or WebP picture.');
    $ext = ['image/jpeg'=>'jpg','image/png'=>'png','image/webp'=>'webp'][$info['mime']];
    $dir=__DIR__.'/uploads'; if (!is_dir($dir)) mkdir($dir,0755,true);
    $name=$prefix.'-'.bin2hex(random_bytes(8)).'.'.$ext;
    if (!move_uploaded_file($_FILES[$field]['tmp_name'], $dir.'/'.$name)) throw new RuntimeException('Could not save the uploaded picture.');
    return 'uploads/'.$name;
}
function admin_xlsx_rows(string $path): array {
    // Minimal XLSX reader using PHP ZipArchive + SimpleXML; reads the first worksheet.
    if (!class_exists('ZipArchive')) throw new RuntimeException('XLSX import requires PHP ZipArchive. Enable the php_zip extension in XAMPP, or upload a CSV file.');
    $zip=new ZipArchive(); if ($zip->open($path)!==true) throw new RuntimeException('Could not open that Excel workbook.');
    $shared=[];
    $ss=$zip->getFromName('xl/sharedStrings.xml');
    if ($ss!==false) { $xml=@simplexml_load_string($ss); if ($xml) { $xml->registerXPathNamespace('a','http://schemas.openxmlformats.org/spreadsheetml/2006/main'); foreach($xml->si as $si) { $value=''; foreach($si->xpath('.//a:t') ?: [] as $t) $value.=(string)$t; $shared[]=$value; } } }
    $sheet=$zip->getFromName('xl/worksheets/sheet1.xml');
    if ($sheet===false) { $zip->close(); throw new RuntimeException('The workbook has no first worksheet.'); }
    $xml=@simplexml_load_string($sheet); if (!$xml) { $zip->close(); throw new RuntimeException('The Excel worksheet could not be read.'); }
    $xml->registerXPathNamespace('x','http://schemas.openxmlformats.org/spreadsheetml/2006/main');
    $rows=[];
    foreach($xml->xpath('//x:sheetData/x:row') as $row) {
        $cells=[];
        foreach($row->xpath('./x:c') as $cell) {
            $ref=(string)$cell['r']; preg_match('/^[A-Z]+/',$ref,$m); $letters=$m[0]??'A'; $col=0;
            foreach(str_split($letters) as $letter) $col=$col*26+(ord($letter)-64); $col--;
            $v=(string)($cell->v ?? '');
            if ((string)$cell['t']==='s') $v=$shared[(int)$v]??'';
            elseif ((string)$cell['t']==='inlineStr') $v=implode('',array_map('strval',$cell->is->t ?? []));
            $cells[$col]=$v;
        }
        if ($cells) { $max=max(array_keys($cells)); $line=[]; for($i=0;$i<=$max;$i++)$line[]=$cells[$i]??''; $rows[]=$line; }
    }
    $zip->close(); return $rows;
}
function admin_import_rows(string $path, string $extension): array {
    if ($extension==='csv') { $out=[]; $f=fopen($path,'r'); if(!$f) throw new RuntimeException('Could not read the CSV file.'); while(($r=fgetcsv($f))!==false)$out[]=$r; fclose($f); return $out; }
    if ($extension==='xlsx') return admin_xlsx_rows($path);
    throw new RuntimeException('Please upload an .xlsx or .csv file.');
}

if ($_SERVER['REQUEST_METHOD']==='POST') {
    $action=$_POST['action']??'';
    try {
        if ($action==='create_student') {
            $id=trim($_POST['id']??''); $pw=(string)($_POST['password']??''); $first=trim($_POST['first_name']??''); $middle=trim($_POST['middle_name']??''); $last=trim($_POST['last_name']??''); $section=trim($_POST['section']??'');
            if($id===''||$pw===''||$first===''||$last===''||$section==='') throw new RuntimeException('Student ID, password, first name, surname, and section are required.');
            if(!admin_letters_only($first)||!admin_letters_only($middle,true)||!admin_letters_only($last)||!admin_letters_only(trim($_POST['player_name']??$first))||!admin_letters_only(trim($_POST['gender']??'N'))) throw new RuntimeException('Names and gender must contain alphabet letters only (spaces, apostrophes, and hyphens are allowed in names). Numbers and symbols are not allowed.');
            $q=$pdo->prepare('INSERT INTO student (ID,Password,First_Name,Middle_Initials,Last_Name,Section,PlayerName,PlayerGender,Progress,Mastery,Date_Joined) VALUES (?,?,?,?,?,?,?,?,0,0,CURDATE())');
            $q->execute([$id,admin_password($pw),$first,$middle,$last,$section,trim($_POST['player_name']??$first),trim($_POST['gender']??'N')]);
            if(admin_col_exists($pdo,'student','Status')) $pdo->prepare('UPDATE student SET Status="active" WHERE ID=?')->execute([$id]);
            flash('Student account created and saved to the database.'); admin_redirect('students');
        }
        if ($action==='create_teacher') {
            $id=trim($_POST['id']??''); $pw=(string)($_POST['password']??''); $first=trim($_POST['first_name']??''); $middle=trim($_POST['middle_name']??''); $last=trim($_POST['last_name']??'');
            if($id===''||$pw===''||$first===''||$last==='') throw new RuntimeException('Teacher ID, password, first name, and surname are required.');
            if(!admin_letters_only($first)||!admin_letters_only($middle,true)||!admin_letters_only($last)) throw new RuntimeException('Teacher names must contain alphabet letters only (spaces, apostrophes, and hyphens are allowed). Numbers and symbols are not allowed.');
            $q=$pdo->prepare('INSERT INTO teacher (ID,Password,First_Name,Middle_Initials,Last_Name,Date_Joined,Subject,Profile_Picture) VALUES (?,?,?,?,?,CURDATE(),?,NULL)');
            $q->execute([$id,admin_password($pw),$first,$middle,$last,trim($_POST['subject']??'')]);
            if(admin_col_exists($pdo,'teacher','Status')) $pdo->prepare('UPDATE teacher SET Status="active" WHERE ID=?')->execute([$id]);
            flash('Teacher account created and saved to the database.'); admin_redirect('teachers');
        }
        if ($action==='reset_password') {
            $type=$_POST['account_type']??''; $id=trim($_POST['account_id']??''); $new=trim($_POST['new_password']??'');
            if(!in_array($type,['student','teacher'],true)||$id==='') throw new RuntimeException('Invalid account selected.');
            if($new==='') $new=admin_make_password();
            if(strlen($new)<6) throw new RuntimeException('Use a password with at least 6 characters.');
            $q=$pdo->prepare("UPDATE {$type} SET Password=? WHERE ID=?"); $q->execute([admin_password($new),$id]);
            if(!$q->rowCount()) throw new RuntimeException('Account was not found or the password was unchanged.');
            flash('Password reset for '.$type.' ID '.$id.'. New password: '.$new.' — copy it now and share it securely.'); admin_redirect($type==='student'?'students':'teachers');
        }
        if ($action==='delete_account') {
            $type=$_POST['account_type']??''; $id=trim($_POST['account_id']??'');
            if(!in_array($type,['student','teacher'],true)||$id==='') throw new RuntimeException('Invalid account selected.');
            $q=$pdo->prepare("DELETE FROM {$type} WHERE ID=?"); $q->execute([$id]);
            if(!$q->rowCount()) throw new RuntimeException('Account was not found or was already deleted.');
            flash(ucfirst($type).' account '.$id.' permanently deleted from the database.'); admin_redirect($type==='student'?'students':'teachers');
        }
        if ($action==='toggle_status') {
            $type=$_POST['account_type']??''; $id=trim($_POST['account_id']??''); $status=$_POST['status']??'';
            if(!in_array($type,['student','teacher'],true)||!in_array($status,['active','inactive'],true)||$id==='') throw new RuntimeException('Invalid status change.');
            if(!admin_col_exists($pdo,$type,'Status')) throw new RuntimeException('Run database_migration.sql first to add account status fields.');
            $pdo->prepare("UPDATE {$type} SET Status=? WHERE ID=?")->execute([$status,$id]); flash('Account status updated.'); admin_redirect($type==='student'?'students':'teachers');
        }
        if ($action==='import_students' || $action==='import_teachers') {
            if(empty($_FILES['import_file']['tmp_name']) || ($_FILES['import_file']['error']??UPLOAD_ERR_NO_FILE)!==UPLOAD_ERR_OK) throw new RuntimeException('Choose an Excel (.xlsx) or CSV file to import.');
            if($_FILES['import_file']['size']>8*1024*1024) throw new RuntimeException('Import file must be 8 MB or smaller.');
            $ext=strtolower(pathinfo($_FILES['import_file']['name'],PATHINFO_EXTENSION)); $rows=admin_import_rows($_FILES['import_file']['tmp_name'],$ext);
            if(!$rows) throw new RuntimeException('The file has no rows.');
            $headers=array_map(fn($x)=>strtolower(trim(preg_replace('/[^a-z0-9]+/i','_', (string)$x),'_')),$rows[0]);
            $map=[]; foreach($headers as $i=>$h) $map[$h]=$i;
            $pick=function(array $row,array $names)use($map){foreach($names as $n){if(isset($map[$n]))return trim((string)($row[$map[$n]]??''));}return '';};
            $isTeacher=$action==='import_teachers'; $inserted=0; $skipped=0;
            $pdo->beginTransaction();
            foreach(array_slice($rows,1) as $row) {
                if(!array_filter($row,fn($v)=>trim((string)$v)!=='')) continue;
                $id=$pick($row,['id','student_id','teacher_id','username','account_id']);
                $pw=$pick($row,['password','temporary_password','initial_password']);
                $first=$pick($row,['first_name','firstname','first']); $middle=$pick($row,['middle_name','middle_initials','middle','mi']); $last=$pick($row,['surname','last_name','lastname','last']);
                if($id===''||$first===''||$last===''||!admin_letters_only($first)||!admin_letters_only($middle,true)||!admin_letters_only($last)) { $skipped++; continue; }
                $genderValue=$pick($row,['gender','player_gender'])?:'N';
                if(!$isTeacher && !admin_letters_only($genderValue)) { $skipped++; continue; }
                if(!$isTeacher && !admin_letters_only($pick($row,['player_name','playername'])?:$first)) { $skipped++; continue; }
                if($pw==='') $pw=admin_make_password();
                try {
                    if($isTeacher) {
                        $q=$pdo->prepare('INSERT INTO teacher (ID,Password,First_Name,Middle_Initials,Last_Name,Date_Joined,Subject,Profile_Picture) VALUES (?,?,?,?,?,CURDATE(),?,NULL)');
                        $q->execute([$id,admin_password($pw),$first,$middle,$last,$pick($row,['subject'])]);
                        if(admin_col_exists($pdo,'teacher','Status'))$pdo->prepare('UPDATE teacher SET Status="active" WHERE ID=?')->execute([$id]);
                    } else {
                        $section=$pick($row,['section','class_section']); if($section==='') { $skipped++; continue; }
                        $q=$pdo->prepare('INSERT INTO student (ID,Password,First_Name,Middle_Initials,Last_Name,Section,PlayerName,PlayerGender,Progress,Mastery,Date_Joined) VALUES (?,?,?,?,?,?,?,?,0,0,CURDATE())');
                        $q->execute([$id,admin_password($pw),$first,$middle,$last,$section,$pick($row,['player_name','playername'])?:$first,$genderValue]);
                        if(admin_col_exists($pdo,'student','Status'))$pdo->prepare('UPDATE student SET Status="active" WHERE ID=?')->execute([$id]);
                    }
                    $inserted++;
                } catch(PDOException $e) { if((string)$e->getCode()==='23000') $skipped++; else throw $e; }
            }
            $pdo->commit(); flash("Bulk import finished: {$inserted} created, {$skipped} skipped (missing required fields or duplicate IDs)." ); admin_redirect($isTeacher?'teachers':'students');
        }
        if ($action==='save_admin_profile') {
            // Admin login credentials stay unchanged here; this action only updates the profile picture.
            $name=(string)$user['id'];
            $picture=admin_upload_picture('profile_picture','admin');
            if ($picture) {
                if (!admin_col_exists($pdo,'admin','Profile_Picture')) throw new RuntimeException('Please run database_migration.sql to add the admin profile picture field.');
                $pdo->prepare('UPDATE admin SET Profile_Picture=? WHERE Name=?')->execute([$picture,$name]);
            }
            flash($picture ? 'Admin profile picture updated.' : 'No new picture selected; profile details remain unchanged.');
            admin_redirect('profile');
        }
        if ($action==='change_admin_password') {
            $oldpw=(string)($_POST['current_password']??'');
            $new=(string)($_POST['new_password']??'');
            $confirm=(string)($_POST['confirm_password']??'');
            $q=$pdo->prepare('SELECT Password FROM admin WHERE Name=? LIMIT 1');
            $q->execute([$user['id']]);
            $stored=$q->fetchColumn();
            if ($stored===false) throw new RuntimeException('The administrator account could not be found in the database.');
            if (!verify_legacy_password($oldpw,(string)$stored)) throw new RuntimeException('Current password is incorrect.');
            if (strlen($new)<8) throw new RuntimeException('New password must contain at least 8 characters.');
            if ($new!==$confirm) throw new RuntimeException('New password and confirmation do not match.');
            if ($new===$oldpw) throw new RuntimeException('Choose a new password different from your current password.');
            $update=$pdo->prepare('UPDATE admin SET Password=? WHERE Name=?');
            $update->execute([admin_password($new),$user['id']]);
            if ($update->rowCount()!==1) throw new RuntimeException('The password could not be updated. Please try again.');
            flash('Administrator password changed and saved to the database. Use the new password at your next login.');
            admin_redirect('profile');
        }
        if ($action==='reset_content') {
            flash('Edits were discarded. The question bank has been reloaded from the database.','info');
            admin_redirect('contents');
        }
        if ($action==='save_content') {
            $id=(int)($_POST['id']??0);
            $pdo->prepare('UPDATE admin_content SET Exam=?,Choice1=?,Choice2=?,Choice3=?,Choice4=?,Answer=? WHERE Indicate=?')->execute([trim($_POST['activity']??''),trim($_POST['c1']??''),trim($_POST['c2']??''),trim($_POST['c3']??''),trim($_POST['c4']??''),trim($_POST['answer']??''),$id]);
            flash('Content row #'.$id.' saved to the database.'); admin_redirect('contents');
        }
    } catch(Throwable $e) {
        if($pdo->inTransaction()) $pdo->rollBack();
        flash($e instanceof PDOException ? ((string)$e->getCode()==='23000'?'That ID already exists. Use a unique account ID.':'Database operation failed: '.$e->getMessage()) : $e->getMessage(),'error');
        admin_redirect($page);
    }
}

$sections=$pdo->query('SELECT Name FROM section ORDER BY Name')->fetchAll(PDO::FETCH_COLUMN);
$selectedSection=trim((string)($_GET['section']??''));
$studentCount=(int)$pdo->query('SELECT COUNT(*) FROM student')->fetchColumn();
$teacherCount=(int)$pdo->query('SELECT COUNT(*) FROM teacher')->fetchColumn();
$activeStudentExpr=admin_col_exists($pdo,'student','Status') ? "COALESCE(Status,'active')" : "'active'";
$activeTeacherExpr=admin_col_exists($pdo,'teacher','Status') ? "COALESCE(Status,'active')" : "'active'";
$students=[]; $teachers=[]; $rows=[]; $adminRow=[];
if($page==='home') {
    $sql="SELECT ID,First_Name,Middle_Initials,Last_Name,PlayerName,Section,{$activeStudentExpr} AS AccountStatus FROM student";
    if($selectedSection!=='') { $q=$pdo->prepare($sql.' WHERE Section=? ORDER BY Last_Name,First_Name'); $q->execute([$selectedSection]); $students=$q->fetchAll(); }
    else $students=$pdo->query($sql.' ORDER BY Last_Name,First_Name')->fetchAll();
}
if($page==='students') {
    $sql="SELECT ID,First_Name,Middle_Initials,Last_Name,PlayerName,Section,{$activeStudentExpr} AS AccountStatus FROM student";
    if($selectedSection!=='') { $q=$pdo->prepare($sql.' WHERE Section=? ORDER BY Last_Name,First_Name'); $q->execute([$selectedSection]); $students=$q->fetchAll(); }
    else $students=$pdo->query($sql.' ORDER BY Last_Name,First_Name')->fetchAll();
}
if($page==='teachers') $teachers=$pdo->query("SELECT ID,First_Name,Middle_Initials,Last_Name,Subject,{$activeTeacherExpr} AS AccountStatus FROM teacher ORDER BY Last_Name,First_Name")->fetchAll();
if($page==='contents') $rows=$pdo->query('SELECT * FROM admin_content ORDER BY Indicate')->fetchAll();
if($page==='profile') { $q=$pdo->prepare('SELECT * FROM admin WHERE Name=?');$q->execute([$user['id']]);$adminRow=$q->fetch()?:[]; }
show_flash();
$nav=[ 'home'=>['⌂','Home'], 'students'=>['♙','Manage students'], 'teachers'=>['♧','Manage teachers'], 'contents'=>['▤','Manage contents'], 'profile'=>['⚙','Admin profile'] ];
$pageTitles=['home'=>'Administration home','students'=>'Manage students','teachers'=>'Manage teachers','contents'=>'Manage contents','profile'=>'Admin profile'];
?>
<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title><?=e($pageTitles[$page])?> | Divine Mercy</title><link rel="stylesheet" href="assets/style.css"><style>
.admin-nav{display:flex;flex-direction:column}.admin-nav a{display:flex;align-items:center;gap:11px}.admin-nav a span{width:20px;text-align:center;font-size:17px}.admin-toolbar{display:flex;gap:10px;align-items:center;flex-wrap:wrap}.section-filter-label{display:flex;align-items:center;gap:8px;color:#6f6870;font-size:11px;font-weight:700}.section-filter{max-width:260px;min-width:155px;border:1px solid #e5dfe0;border-radius:7px;padding:10px;background:#fff;color:#373139;font:inherit;font-weight:400}.admin-btn{display:inline-flex;align-items:center;justify-content:center;border:1px solid #c8101e;border-radius:7px;background:#c8101e;color:white;padding:10px 14px;font-weight:700;font-size:11px;cursor:pointer;text-decoration:none}.admin-btn.secondary{background:#fff;color:#c8101e}.admin-btn.neutral{background:#fff;color:#514a52;border-color:#e7dfe0}.admin-form-grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:13px}.admin-form-grid label,.admin-field{display:block;font-size:11px;font-weight:700;color:#554e56}.admin-form-grid input,.admin-form-grid select,.admin-field input,.admin-field select,.admin-field textarea{display:block;width:100%;margin-top:7px;border:1px solid #e5dfe0;border-radius:7px;padding:11px;background:white;font:inherit;font-weight:400;color:#373139}.admin-form-grid .span-all{grid-column:1/-1}.admin-actions{display:flex;gap:6px;align-items:center;flex-wrap:wrap}.admin-actions form{margin:0}.status-pill{display:inline-block;border-radius:20px;padding:5px 9px;font-size:10px;font-weight:800;text-transform:capitalize}.status-pill.active{color:#147447;background:#e7f7ee}.status-pill.inactive{color:#9c2d38;background:#ffeaec}.admin-table{min-width:760px}.admin-table .password-form{display:flex;gap:5px;min-width:210px}.admin-table .password-form input{width:125px;padding:7px;border:1px solid #e5dfe0;border-radius:5px;font-size:10px}.admin-table .password-form button{padding:7px 9px}.admin-hint{font-size:11px;color:#827a83;line-height:1.65}.import-box{background:#fffafa;border:1px dashed #e5b8bd;border-radius:9px;padding:16px;margin:14px 0 20px}.import-box input[type=file]{max-width:100%;font-size:11px;margin:10px 0}.modal-form{display:none;border-top:1px solid #f0e7e8;padding-top:20px;margin-top:20px}.modal-form.open{display:block}.admin-stat-grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:14px;margin-bottom:18px}.admin-stat{background:#fff;border:1px solid var(--line);border-radius:10px;padding:18px}.admin-stat small{display:block;color:#817983;font-size:11px}.admin-stat strong{display:block;font-size:28px;margin:8px 0;color:#2f2930}.admin-stat span{font-size:10px;color:#c8101e}.admin-profile-layout{display:grid;grid-template-columns:minmax(250px,.8fr) minmax(380px,1.2fr);gap:18px}.admin-profile-picture{display:block;flex:0 0 112px;width:112px;height:112px;max-width:112px;object-fit:cover;object-position:center;border-radius:50%;border:5px solid #fff;box-shadow:0 2px 12px #24080a22;background:#f7dfe1;margin:0;position:relative;z-index:1}.admin-profile-hero{display:flex;align-items:center;flex-direction:column;text-align:center;padding:0 20px 22px;margin-top:-56px;position:relative;z-index:1;overflow:visible}.admin-profile-hero h2{margin:14px 0 5px}.admin-profile-layout>.panel{overflow:visible}.admin-profile-layout>.panel .profile-cover{border-radius:10px 10px 0 0}.admin-profile-hero h2{margin:13px 0 5px}.admin-profile-hero p{color:#817983;font-size:11px}.admin-inline{display:inline}.admin-table tr td{vertical-align:middle}.admin-empty{padding:28px;text-align:center;color:#8b838b}.required-note{font-size:10px;color:#918892;margin:12px 0 0}
@media(max-width:900px){.admin-form-grid{grid-template-columns:repeat(2,minmax(0,1fr))}.admin-profile-layout{grid-template-columns:1fr}}@media(max-width:760px){.admin-nav{flex-direction:row;overflow:auto}.admin-nav a{white-space:nowrap;flex:0 0 auto}.admin-nav a span{display:none}.admin-form-grid,.admin-stat-grid{grid-template-columns:1fr}.admin-form-grid .span-all{grid-column:auto}.admin-toolbar{width:100%}.admin-toolbar .admin-btn{flex:1}}
</style></head><body class="app-body">
<aside class="sidebar"><a class="side-brand" href="admin.php?page=home"><img src="assets/logo.png" alt=""><span>DIVINE MERCY<small>COLLEGE FOUNDATION INC.</small></span></a><div class="side-label">ADMINISTRATION</div><nav class="side-nav admin-nav"><?php foreach($nav as $key=>$item):?><a class="<?= $page===$key?'active':'' ?>" href="admin.php?page=<?=$key?>"><span><?=e($item[0])?></span><?=e($item[1])?></a><?php endforeach;?></nav><div class="sidebar-bottom"><div class="mini-user"><div class="avatar">A</div><div><strong><?=e($user['name']??'Administrator')?></strong><small>Administrator</small></div></div><a class="logout-link" href="logout.php">↪ Log out</a></div></aside>
<main class="workspace"><header class="topbar"><div><div class="eyebrow red">DIVINE MERCY LMS</div><h1><?=e($pageTitles[$page])?></h1></div><div class="topbar-right">Administrator <div class="top-avatar">A</div></div></header><div class="page-content">
<?php if($page==='home'): ?>
<div class="welcome-row"><div><h2>Welcome to the admin portal</h2><p>Monitor student accounts and manage school learning resources.</p></div><span class="date-chip"><?=date('F j, Y')?></span></div>
<div class="admin-stat-grid"><div class="admin-stat"><small>Total students</small><strong><?=$studentCount?></strong><span>Student accounts in the database</span></div><div class="admin-stat"><small>Total teachers</small><strong><?=$teacherCount?></strong><span>Teacher accounts in the database</span></div><div class="admin-stat"><small>Learning content</small><strong><?= (int)$pdo->query('SELECT COUNT(*) FROM admin_content')->fetchColumn() ?></strong><span>Admin question-bank items</span></div></div>
<section class="panel"><div class="panel-heading"><div><h3>Student directory</h3><p>First name, middle name, surname, section, and current account status.</p></div><form method="get" class="admin-toolbar"><input type="hidden" name="page" value="home"><label class="section-filter-label">Section <select name="section" class="section-filter" onchange="this.form.submit()"><option value="">All sections</option><?php foreach($sections as $section):?><option value="<?=e($section)?>" <?=$selectedSection===$section?'selected':''?>><?=e($section)?></option><?php endforeach;?></select></label><a class="admin-btn" href="admin.php?page=students<?= $selectedSection!==''?'&section='.rawurlencode($selectedSection):'' ?>">Manage students →</a></form></div><div class="table-scroll"><table class="admin-table"><thead><tr><th>First name</th><th>Middle name</th><th>Surname</th><th>Section</th><th>Status</th></tr></thead><tbody><?php foreach($students as $s):?><tr><td><strong><?=e($s['First_Name']?:$s['PlayerName'])?></strong></td><td><?=e($s['Middle_Initials'])?></td><td><?=e($s['Last_Name'])?></td><td><?=e($s['Section'])?></td><td><span class="status-pill <?=e(strtolower($s['AccountStatus']))?>"><?=e($s['AccountStatus'])?></span></td></tr><?php endforeach;?><?php if(!$students):?><tr><td colspan="5" class="admin-empty">No student accounts found for this section.</td></tr><?php endif;?></tbody></table></div></section>
<?php elseif($page==='students' || $page==='teachers'): $isStudent=$page==='students'; $list=$isStudent?$students:$teachers; $kind=$isStudent?'student':'teacher'; ?>
<div class="welcome-row"><div><h2><?= $isStudent?'Student accounts':'Teacher accounts' ?></h2><p>Create accounts, import a spreadsheet, permanently delete accounts, or reset passwords.</p></div><button class="admin-btn" type="button" onclick="toggleCreate()">＋ Create <?=e($kind)?></button></div>
<section class="panel"><div class="panel-heading"><div><h3>Create a <?=e($kind)?> account</h3><p>New credentials are saved in the existing <?=e($kind)?> table.</p></div><button class="admin-btn secondary" type="button" onclick="toggleCreate()">Show / hide form</button></div><div id="createForm" class="modal-form"><form method="post"><input type="hidden" name="action" value="create_<?=e($kind)?>"><div class="admin-form-grid"><label>Username / <?= $isStudent?'student':'teacher' ?> ID *<input name="id" required></label><label>Temporary password *<input name="password" type="text" minlength="6" required></label><label>First name *<input name="first_name" required pattern="[\p{L}]+([ '’-][\p{L}]+)*" title="Letters only; spaces, apostrophes, and hyphens are allowed."></label><label>Middle name / initial<input name="middle_name" pattern="[\p{L}]+([ '’-][\p{L}]+)*" title="Letters only; spaces, apostrophes, and hyphens are allowed."></label><label>Surname *<input name="last_name" required pattern="[\p{L}]+([ '’-][\p{L}]+)*" title="Letters only; spaces, apostrophes, and hyphens are allowed."></label><?php if($isStudent):?><label>Section *<select name="section" required><option value="">Choose section</option><?php foreach($sections as $section):?><option value="<?=e($section)?>"><?=e($section)?></option><?php endforeach;?></select></label><label>Player name (optional)<input name="player_name" placeholder="Defaults to first name" pattern="[\p{L}]+([ '’-][\p{L}]+)*" title="Letters only; spaces, apostrophes, and hyphens are allowed."></label><label>Gender<input name="gender" value="N" maxlength="20" required pattern="[\p{L}]+" title="Letters only; no numbers or symbols."></label><?php else:?><label>Subject<input name="subject"></label><?php endif;?></div><p class="required-note">* Required fields. Passwords are stored as secure hashes.</p><div class="admin-toolbar" style="margin-top:15px"><button class="admin-btn" type="submit">Create account</button></div></form></div></section>
<section class="panel"><div class="panel-heading"><div><h3>Bulk import <?=e($kind==='student'?'students':'teachers')?></h3><p>Upload an Excel workbook (.xlsx) or CSV file. The first row must contain column headings.</p></div></div><div style="padding:0 20px 18px"><form class="import-box" method="post" enctype="multipart/form-data"><input type="hidden" name="action" value="import_<?= $isStudent?'students':'teachers' ?>"><strong>Choose a spreadsheet</strong><br><input type="file" name="import_file" accept=".xlsx,.csv" required><div class="admin-hint">Required headings: <code>id</code>, <code>first_name</code>, <code>last_name</code>, and <code>password</code> (optional; missing passwords are generated). <?= $isStudent?'Students also require a <code>section</code> column. Optional columns: middle_name, player_name, gender.':'Optional column: subject.' ?> Duplicate IDs and incomplete rows are skipped.</div><div class="admin-toolbar" style="margin-top:10px"><button class="admin-btn" type="submit">Import spreadsheet</button><a class="admin-btn neutral" href="admin.php?page=<?=$page?>&template=1" onclick="return downloadTemplate('<?=e($kind)?>')">Download CSV template</a></div></form></div></section>
<section class="panel"><div class="panel-heading"><div><h3><?= $isStudent?'Student list':'Teacher list' ?></h3><p><?=count($list)?> account(s)<?= $isStudent && $selectedSection!==''?' in '.e($selectedSection):'' ?> currently shown.</p></div><?php if($isStudent):?><form method="get" class="admin-toolbar"><input type="hidden" name="page" value="students"><label class="section-filter-label">Section <select name="section" class="section-filter" onchange="this.form.submit()"><option value="">All sections</option><?php foreach($sections as $section):?><option value="<?=e($section)?>" <?=$selectedSection===$section?'selected':''?>><?=e($section)?></option><?php endforeach;?></select></label></form><?php endif;?></div><div class="table-scroll"><table class="admin-table"><thead><tr><th>Username / ID</th><th>Full name</th><?php if($isStudent):?><th>Section</th><?php else:?><th>Subject</th><?php endif;?><th>Status</th><th>Reset password</th><th>Delete account</th></tr></thead><tbody><?php foreach($list as $a):?><tr><td><strong><?=e($a['ID'])?></strong></td><td><?=e(full_name($a) ?: ($a['PlayerName']??''))?></td><td><?=e($isStudent?$a['Section']:$a['Subject'])?></td><td><span class="status-pill <?=e(strtolower($a['AccountStatus']))?>"><?=e($a['AccountStatus'])?></span></td><td><form class="password-form" method="post" onsubmit="return confirm('Reset this account password?')"><input type="hidden" name="action" value="reset_password"><input type="hidden" name="account_type" value="<?=e($kind)?>"><input type="hidden" name="account_id" value="<?=e($a['ID'])?>"><input name="new_password" minlength="6" placeholder="New password (optional)" aria-label="New password"><button class="admin-btn" type="submit">Reset</button></form></td><td><form method="post" class="admin-actions" onsubmit="return confirm('Permanently delete this account from the database? This cannot be undone.')"><input type="hidden" name="action" value="delete_account"><input type="hidden" name="account_type" value="<?=e($kind)?>"><input type="hidden" name="account_id" value="<?=e($a['ID'])?>"><button class="admin-btn danger" type="submit">Delete</button></form></td></tr><?php endforeach;?><?php if(!$list):?><tr><td colspan="6" class="admin-empty">No accounts found.</td></tr><?php endif;?></tbody></table></div></section>
<?php elseif($page==='contents'): ?>
<div class="welcome-row"><div><h2>Manage learning content</h2><p>Edit a row, then select Save to write changes to <code>admin_content</code>.</p></div><span class="date-chip"><?=count($rows)?> activities</span></div>
<section class="panel"><div class="panel-heading"><div><h3>Activity question bank</h3><p>Each row is saved individually to the local MySQL database.</p></div></div><div class="table-scroll content-scroll"><table class="content-table"><thead><tr><th>#</th><th>Activity / question</th><th>Choice 1</th><th>Choice 2</th><th>Choice 3</th><th>Choice 4</th><th>Answer</th><th>Actions</th></tr></thead><tbody><?php foreach($rows as $r):?><tr data-content-row="<?=e($r['Indicate'])?>"><td><?=e($r['Indicate'])?></td><?php foreach(['Exam'=>'activity','Choice1'=>'c1','Choice2'=>'c2','Choice3'=>'c3','Choice4'=>'c4','Answer'=>'answer'] as $field=>$key):?><td><textarea class="content-input" data-field="<?=e($key)?>" disabled rows="3"><?=e($r[$field])?></textarea></td><?php endforeach;?><td class="actions-cell"><button class="mini-btn edit-btn" type="button">Edit</button><form method="post" class="inline-form"><input type="hidden" name="action" value="save_content"><input type="hidden" name="id" value="<?=e($r['Indicate'])?>"><?php foreach(['activity','c1','c2','c3','c4','answer'] as $key):?><input type="hidden" name="<?=$key?>" value="<?=e($r[['activity'=>'Exam','c1'=>'Choice1','c2'=>'Choice2','c3'=>'Choice3','c4'=>'Choice4','answer'=>'Answer'][$key]])?>"><?php endforeach;?><button class="mini-btn save-btn" type="submit" disabled>Save</button></form><form method="post" class="inline-form reset-form"><input type="hidden" name="action" value="reset_content"><button class="mini-btn reset-btn" type="submit" disabled>Reset</button></form></td></tr><?php endforeach;?><?php if(!$rows):?><tr><td colspan="8" class="admin-empty">No content found in the question bank.</td></tr><?php endif;?></tbody></table></div></section>
<?php elseif($page==='profile'): $pic=$adminRow['Profile_Picture']??''; $adminName=$adminRow['Name']??$user['name']??$user['id']; ?>
<div class="welcome-row"><div><h2>Administrator profile</h2><p>Manage your profile picture, review account details, and securely change your password.</p></div></div>
<div class="profile-layout admin-profile-matching">
  <section class="panel profile-card">
    <div class="profile-cover"></div>
    <div class="profile-main">
      <?php if($pic && is_file(__DIR__.'/'.$pic)): ?><img class="profile-photo" src="<?=e($pic)?>" alt="Administrator profile picture"><?php else: ?><div class="profile-photo profile-placeholder" aria-label="Administrator avatar">A</div><?php endif; ?>
      <h2><?=e($adminName)?></h2><p>Administrator · Divine Mercy College Foundation Inc.</p>
      <form method="post" enctype="multipart/form-data" class="picture-form">
        <input type="hidden" name="action" value="save_admin_profile">
        <label class="btn btn-outline file-button">Choose picture<input type="file" name="profile_picture" accept="image/jpeg,image/png,image/webp" required></label>
        <small>JPG, PNG or WebP · Maximum 4 MB</small>
        <button class="btn btn-red" type="submit">Upload picture</button>
      </form>
    </div>
    <div class="profile-facts"><div><small>Account username</small><strong><?=e($adminName)?></strong></div><div><small>Account created</small><strong><?=e($adminRow['Date_Joined']??'Not recorded')?></strong></div><div><small>Account type</small><strong>Administrator</strong></div></div>
  </section>
  <section class="panel profile-edit">
    <div class="panel-heading"><div><h3>Account information</h3><p>Your administrator username and existing login credentials are preserved.</p></div></div>
    <div class="stack-form"><label>Admin username<input value="<?=e($adminName)?>" readonly aria-readonly="true"></label><label style="margin-top:14px">Organization<input value="Divine Mercy College Foundation Inc." readonly aria-readonly="true"></label></div>
    <hr>
    <div class="panel-heading"><div><h3>Change password</h3><p>Your new password is securely hashed and saved directly to the admin table in the database.</p></div></div>
    <form method="post" class="stack-form" autocomplete="off"><input type="hidden" name="action" value="change_admin_password">
      <label>Current password<input name="current_password" type="password" autocomplete="current-password" required></label>
      <div class="form-grid"><label>New password<input name="new_password" type="password" minlength="8" autocomplete="new-password" required></label><label>Confirm new password<input name="confirm_password" type="password" minlength="8" autocomplete="new-password" required></label></div>
      <button class="btn btn-red" type="submit">Update password</button>
    </form>
    <a class="btn btn-outline logout-profile" href="logout.php">↪ Log out</a>
  </section>
</div>
<?php endif; ?></div></main>
<script>
function toggleCreate(){const e=document.getElementById('createForm');if(e)e.classList.toggle('open')}
function downloadTemplate(kind){const student=kind==='student';const headers=student?'id,password,first_name,middle_name,last_name,section,player_name,gender':'id,password,first_name,middle_name,last_name,subject';const sample=student?'10001234,TempPass123,Alex,M,Reyes,Grade 11 - Matthew (ABM),Alex,N':'T1001,TempPass123,Alex,M,Reyes,Mathematics';const blob=new Blob([headers+'\r\n'+sample+'\r\n'],{type:'text/csv;charset=utf-8;'});const a=document.createElement('a');a.href=URL.createObjectURL(blob);a.download=kind+'_import_template.csv';a.click();URL.revokeObjectURL(a.href);return false}
</script><script src="assets/app.js"></script></body></html>
