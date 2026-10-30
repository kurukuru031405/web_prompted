-- Run once AFTER importing _divinedb_.sql into MySQL/MariaDB.
USE divinedb;

-- Add account identifiers as unique keys. The supplied export did not define primary keys.
ALTER TABLE student ADD UNIQUE KEY uq_student_id (ID);
ALTER TABLE teacher ADD UNIQUE KEY uq_teacher_id (ID);
ALTER TABLE admin ADD UNIQUE KEY uq_admin_name (Name);

-- Account state used by the admin dashboard. Existing accounts start as active.
ALTER TABLE student ADD COLUMN Status ENUM('active','inactive') NOT NULL DEFAULT 'active';
ALTER TABLE teacher ADD COLUMN Status ENUM('active','inactive') NOT NULL DEFAULT 'active';

-- Admin profile fields, matching the teacher profile experience.
ALTER TABLE admin ADD COLUMN Profile_Picture VARCHAR(255) DEFAULT NULL;
ALTER TABLE admin ADD COLUMN Date_Joined DATE DEFAULT NULL;
UPDATE admin SET Date_Joined = CURRENT_DATE WHERE Date_Joined IS NULL;

-- Assessment rows belong to a specific student. The legacy pre-post_test table
-- does not include a student ID, so its rows cannot safely be attributed.
CREATE TABLE IF NOT EXISTS student_test_scores (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  student_id VARCHAR(255) NOT NULL,
  Chapter INT NOT NULL,
  Pre_test_Scores INT NOT NULL DEFAULT 0,
  Post_test_Scores INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_student_chapter (student_id, Chapter),
  CONSTRAINT fk_test_scores_student FOREIGN KEY (student_id)
    REFERENCES student(ID) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Bulk import supports .xlsx with PHP ZipArchive and SimpleXML enabled in XAMPP,
-- and .csv without any additional package.
