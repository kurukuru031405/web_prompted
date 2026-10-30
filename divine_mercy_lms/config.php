<?php
declare(strict_types=1);
session_start();
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
function db(): mysqli {
  static $db=null;
  if ($db===null) {
    $host=getenv('DB_HOST') ?: '127.0.0.1';
    $user=getenv('DB_USER') ?: 'root';
    $pass=getenv('DB_PASS') ?: '';
    $name=getenv('DB_NAME') ?: 'divinedb';
    $db=new mysqli($host,$user,$pass,$name);
    $db->set_charset('utf8mb4');
  }
  return $db;
}
function json_out($data, int $status=200): never {
  http_response_code($status); header('Content-Type: application/json; charset=utf-8');
  echo json_encode($data, JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES); exit;
}
function require_role(string $role): void {
  if (empty($_SESSION['role']) || $_SESSION['role']!==$role) json_out(['error'=>'Please sign in again.'],401);
}
function clean_name(string $v): string {
  $v=trim($v);
  if ($v!=='' && !preg_match("/^[\\p{L} .'-]+$/u",$v)) json_out(['error'=>'Names may contain alphabetic letters, spaces, apostrophes, periods, or hyphens only.'],422);
  return $v;
}
function column_exists(mysqli $db,string $table,string $col): bool {
  $s=$db->prepare("SELECT COUNT(*) n FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME=? AND COLUMN_NAME=?");
  $s->bind_param('ss',$table,$col); $s->execute(); return (int)$s->get_result()->fetch_assoc()['n']>0;
}
