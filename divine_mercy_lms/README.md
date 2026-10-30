# Divine Mercy College Foundation Inc. — LMS

A PHP + MySQL/MariaDB local web app based on the supplied `divinedb` dump.

## Included
- Red/white landing page using the supplied college seal
- Teacher/admin login using the existing `teacher` and `admin` tables
- Teacher dashboard with section progress ranking, section filter, student list, clickable student profiles, and recorded pre/post-test results
- Teacher content editor connected to `teacher_content`; Reset copies the current defaults from `admin_content`
- Admin home, student/teacher account management, password resets, delete account, CSV bulk import, admin content editor, profile picture upload, password change
- Names and gender fields are validated in the browser and server-side. Student/teacher name fields accept alphabetic characters plus spaces, apostrophes, periods, and hyphens. IDs and passwords may contain numbers.
- Profile images are stored under `uploads/` per local account.

## Requirements
- PHP 8.1+ with `mysqli` enabled
- MySQL/MariaDB
- Apache/Nginx or PHP's built-in local server

## Setup (XAMPP example)
1. Copy the `divine_mercy_lms` folder into `C:\xampp\htdocs\`.
2. Open phpMyAdmin and import the supplied `divinedb-1(1).sql` dump into a database named `divinedb`.
3. If the dump has not already created `teacher_content`, ensure it exists. The supplied SQL contains `admin_content`, `teacher_content`, `student`, `teacher`, `section`, `assessment_mastery_scores`, and `records`.
4. Edit the environment settings if needed. Defaults are host `127.0.0.1`, user `root`, empty password, database `divinedb`. Set `DB_HOST`, `DB_USER`, `DB_PASS`, `DB_NAME` in your PHP server environment if your setup differs.
5. Visit `http://localhost/divine_mercy_lms/`.

## Existing sample credentials from the supplied SQL
- Admin username: `admin`
- Admin password in the dump: `LMSJdSdMdZ`
- Teacher IDs/passwords are in the `teacher` table. Example: ID `15218`, password `taNA0h`.

For security, change sample credentials after first login. The supplied dump stores passwords as plain text; this app keeps compatibility with that schema. Do not deploy publicly as-is. A production version should migrate passwords to `password_hash()` and `password_verify()`, add CSRF protection, and use a dedicated least-privilege database user.

## Notes / schema limits
- The provided teacher table does not contain a subject field, and the admin table has only `Name` and `Password`. The profile shows a clear placeholder for teacher subject rather than inventing a value.
- The student table has no active/inactive status column. The admin home currently lists existing student records as Active; delete removes the account permanently. Add a `Status` column if true inactive status is required.
- Bulk import supports CSV files (including Excel's “CSV UTF-8” export). Direct `.xlsx` import requires PhpSpreadsheet, which is not bundled.
- `Middle_Initials` is the field name in the existing database, so it is used for the middle-name display.
- Score rows are read from `assessment_mastery_scores` (`PreTest`/`PostTest`); if none exist, the app attempts to use the legacy `records` table.
