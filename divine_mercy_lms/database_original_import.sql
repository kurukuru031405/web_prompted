-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 30, 2026 at 06:33 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `divinedb`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `Name` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`Name`, `Password`) VALUES
('admin', 'LMSJdSdMdZ');

-- --------------------------------------------------------

--
-- Table structure for table `admin_content`
--

CREATE TABLE `admin_content` (
  `Indicate` int(11) NOT NULL,
  `Exam` varchar(255) NOT NULL,
  `Choice1` varchar(255) NOT NULL,
  `Choice2` varchar(255) NOT NULL,
  `Choice3` varchar(255) NOT NULL,
  `Choice4` varchar(255) NOT NULL,
  `Answer` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_content`
--

INSERT INTO `admin_content` (`Indicate`, `Exam`, `Choice1`, `Choice2`, `Choice3`, `Choice4`, `Answer`) VALUES
(1, 'This is the sequence of statements that\'s intended to accomplish certain tasks.', 'Programming', 'Syntax', 'Computer program', 'Program', 'Computer program'),
(2, 'What is the process of planning and creating a program.', 'Programming', 'Computer program', 'Syntax', ' 	Assembler', 'Programming'),
(3, 'What is the language that is in charge if dealing with the computer\'s hardware?', 'High-level Languages', 'Low-level Languages', 'Machine Language', 'Assembly Language', 'Low-level Languages'),
(4, 'It is the most basic set of instructions that the computer can execute. Machine language programs', ' Interpreter', 'Assembler', 'Assembly Language', 'Machine Language', 'Machine Language'),
(5, 'This type of low-level languages can be read by people.', 'Assembly Language', ' Assembler', 'Machine Language', 'Compiler', 'Assembly Language'),
(6, 'What is the name of a program that can translate assembly language instructions into machine languag', 'Commands', 'Assembly Language', 'Assembler', 'Compiler', 'Assembler'),
(7, 'What kind of programming language uses natural language such as English language?', 'Machine Language', 'High-level Languages ', 'Low-level Languages', 'Computer program', 'High-level Languages '),
(8, 'This is what developers call the \"rules of the language\" what is it called?', 'Syntax', 'Compiler', 'Commands', 'Interpreter', 'Syntax'),
(9, 'What is the program statements that carries the tasks of the program called?', 'Syntax', 'Compiler', 'Commands', 'Interpreter', 'Commands'),
(10, 'What is the program that translates a program written in a High-level language to low-level language', 'Interpreter', 'Commands', 'Syntax', 'Compiler', 'Compiler'),
(11, 'What do you call the program that acts a compiler, but only translates one (1) program?', 'Compiler', 'Interpreter', 'Commands', 'Syntax', 'Interpreter'),
(12, 'What do you call the errors that can be encounter during the process of translation?', 'Type errors', 'Reference errors', 'Logical errors', 'Syntax errors', 'Syntax errors'),
(13, 'This only occurs when the expected output is not correct but the syntax is correct, what kind of err', 'Logical errors ', 'Reference errors', 'Type errors', 'Syntax errors', 'Logical errors '),
(14, 'What do they call the process of locating the errors of a program?', 'Algorithm', 'Coding', 'Debugging', 'Programming', 'Debugging'),
(15, 'It is a step-by-step problem-solving\r\nprocess in which a solution is arrived at in a finite amount o', ' Execution', 'Algorithm', 'Problem Analysis', 'Algorithm Design', 'Algorithm'),
(16, 'What step of algorithm does where the problem is being analyze and its solution requirements?', 'Algorithm Design', 'Algorithm', 'Execution', 'Problem Analysis', 'Problem Analysis'),
(17, 'What step does the deign of the algorithm usually formed to solve the problem?', 'Algorithm Design', 'Algorithm', 'Execution', 'Problem Analysis', 'Algorithm Design'),
(18, 'What step does an algorithm is implemented to the programming language?', 'Syntax', 'Debugging', 'Coding', 'Execution', 'Coding'),
(19, 'What step is focused on verification if the algorithm works?', 'Debugging', 'Execution', 'Coding', 'Syntax', 'Execution'),
(20, 'what is the method of algorithm where it describes algorithms using the combination of natural langu', 'C#', 'Flowchart', 'Java', 'Pseudocode', 'Pseudocode '),
(21, 'What does it call the operation that uses this symbols (+, -, *, /)?', 'Logical', 'Comparison', 'Assignment', 'Arithmetic operations ', 'Arithmetic operations '),
(22, 'What is the operation that is focus on assigning values to variables?', 'Logical', 'Comparison', 'Arithmetic operations ', 'Assignment', 'Assignment'),
(23, 'What is this operators called (=, ≠, <, >, ≤, ≥)?', 'Comparison', 'Assignment', 'Arithmetic', 'Logical', 'Comparison'),
(24, 'What is the operation that is focused on on combining, inverting, or comparing conditional statement', 'Logical ', 'Assignment', 'Comparison', 'Arithmetic', 'Logical'),
(25, 'What are the symbols used for arithmetic operation?', '+, -, *, /', '=', '=, ≠, <, >, ≤, ≥', '&&, ||', '+, -, *, /'),
(26, 'What symbol is used for assigning variable', '+, -, *, /', '=', '=, ≠, <, >, ≤, ≥', '&&, ||', '='),
(27, 'What symbol is used for comparing two (2) variables?', '+, -, *, /', '=, ≠, <, >, ≤, ≥', '&&, ||', '=', '=, ≠, <, >, ≤, ≥'),
(28, 'What is the two (2) logical operator used in psuedocode?', 'div, mul', 'and, or', 'not, xor', 'add, sub', 'and, or'),
(29, 'What are the keywords used as commands in pseudocode?', 'String, Int, and Char', 'PRINT, WRITE, READ, SET, GO TO', 'Class, public, and private', 'byte, long, double, and float', 'PRINT, WRITE, READ, SET, GO TO'),
(30, 'What is used to indicate branches and loops of instruction called?', 'Space', 'Indentation ', 'New line', 'Terminal block', 'Indentation '),
(31, 'What is the keyword used to show the output?', 'WRITE', 'PRINT', 'READ', 'SET', 'PRINT'),
(32, 'What is the keyword used to show the output?', 'PRINT', 'SET', 'WRITE', 'READ', 'WRITE'),
(33, 'What is the command that is used to capture input statement of user?', 'PRINT', 'SET', 'READ', 'WRITE', 'READ'),
(34, 'What command is used to initialize a variable or assign a value to a variable?', 'PRINT', 'WRITE', 'SET', 'READ', 'SET'),
(35, 'This tool representing algorithm contains shapes describing how an algorithm or program operates.', 'C#', 'Pseudocode', 'Java', 'Flowchart', 'Flowchart'),
(36, 'What is the the shape that is used to indicate the direction of the process flow?', 'Flow lines', 'Terminal block', 'Process', 'Data', 'Flow lines'),
(37, 'What shape is used to represent the beginning or end of a program?', 'Flow lines', 'Terminal block', 'Process', 'Data', 'Terminal block'),
(38, 'What shape is used to represent a process or activity such as computation?', ' Flow lines', 'Terminal block', 'Process', 'Data', 'Process'),
(39, 'What shape is used to store the data used as inputs or output?', 'Flow lines', 'Terminal block', 'Process', 'Data', 'Data'),
(40, 'What shape is used for decision making process?', 'Decision block', 'Connector', 'Predefined Process', 'Process', 'Decision block'),
(41, 'What shape is used to combine flow lines?', 'Decision block', 'Connector', 'Predefined Process', 'Process', 'Connector'),
(42, 'What shape is used to use algorithm outside of program?', 'Decision block', 'Connector', 'Predefined Process', 'Process', 'Predefined Process'),
(43, 'What do you call an approach used to analyze such complex problems by planning other software\'s?', 'Java', 'Object-Oriented Programming', 'Procedural Programming', 'Programming methodology', 'Programming methodology '),
(44, 'This approach is suitable only for small programs that have a low level of complexity.', 'Java', 'Object-Oriented Programming', 'Procedural Programming', 'Programming methodology ', 'Procedural Programming'),
(45, 'It deals with how to store data related to the entities, how the entities behave, and how they inter', 'Java', 'Object-Oriented Programming', 'Procedural Programming', 'Object-Oriented Programming', 'Object-Oriented Programming'),
(46, 'What do you call a high-level programming language that was developed by Sun Microsystems for general-purpose business applications?', 'Java', 'C#', 'C++', 'C', 'Java'),
(47, 'What do you call an environment that translates Java bytecode into machine language?', 'Java compiler', 'Java Environment Machine (JVM)', 'Java interpreter', 'Java Development Kit (JDK)', 'Java Environment Machine (JVM)'),
(48, 'This is created using a text editor or a development environment.', 'Java interpreter', 'Java compiler', 'Source code', 'Development Environment', 'Source code'),
(49, 'What do you call a set of tools that help write programs easily, such as NetBeans?', 'Java interpreter', 'Java compiler', 'Source code', 'Development Environment ', 'Development Environment'),
(50, 'What do you call a program that converts the source code into binary program of bytecode?', 'Java interpreter', 'Java compiler', 'Source code', 'Java compiler', 'Java compiler'),
(51, 'What do you call a program that checks the bytecode and communicates with the operating system, executing the bytecode instructions line by line within the Java?', 'Java interpreter', 'Java compiler', 'Source code', 'Java compiler', 'Java interpreter'),
(52, 'What do you call a java program that is a stand-alone program?', 'Windowed application', 'Console application ', 'Application ', 'Web Application', 'Application '),
(53, 'What do you call an application that supports character output to a computer screen in a DOS window?', 'Windowed application', 'Console application ', 'Application ', 'Web Application', 'Console application '),
(54, 'What do you call an application that creates a GUI with elements such as menus and button?', ' 	Console application ', 'Application ', 'Windowed  application', 'Web Application', 'Windowed application'),
(55, 'What do you call a program that is embedded in to a web page?', 'Applet', 'Kotlin', 'xcode', 'Lua', 'Applet'),
(56, 'What do you call a java programming that is used to group java codes?', 'Arguments ', 'class', 'main', 'Statement', 'class'),
(57, 'What do you call the keyword used to identify the class accessibility?', 'Arguments ', 'main', 'access  modifier', 'class', 'access modifier'),
(58, 'A Java class can only have one of what method?', 'Arguments ', 'access modifier', 'class', 'main', 'main'),
(59, 'What do you call an action that the program has to perform?', 'Statement', 'class', 'access modifier', 'main', 'Statement'),
(60, 'What do you call a information that is passed to a method so it can perform task?', 'Comments', 'Arguments ', 'access modifier', 'Keywords', 'Arguments '),
(61, 'What do you call a word that has predefined meaning and cant be used for naming?', 'Comments', 'Arguments ', 'Keywords', 'access modifier', 'Keywords'),
(62, 'Find the correct syntax of the main method.', 'int main(void){}', 'def main():', 'static void main(String[] args) { }', 'public static void main(String[] args) { }', 'public static void main(String[] args) { }'),
(63, 'What is the core software bundle used by developers to write, compile, debug, and run Java applications?', 'Java Environment Machine (JVM)', 'Java Development Kit (JDK)', 'Java Runtime Environment (JRE)', 'Development Environment', 'Java Development Kit (JDK)'),
(64, 'what is the software package that provides the files, class libraries, and the Java Virtual Machine (JVM) needed to run Java programs?', 'Java Runtime Environment (JRE) ', 'Java Environment Machine (JVM)', 'Java Runtime Environment (JRE)', 'Development Environment', 'Java Runtime Environment (JRE) '),
(65, 'What do you call a invalid statement that Java compiler encounter?', 'Reference errors', 'Logical errors', 'Syntax errors', 'Comments', 'Syntax errors'),
(66, 'What do you call a line of code that is ignored by the compiler and used to explain details in the program?', 'Reference errors', 'Logical errors', 'Syntax errors', 'Comments', 'Comments'),
(67, 'What do you call a comment that begins with // and can be placed anywhere in the line?', 'Multiple-character comments', 'Single-character comment', 'Multiple-line comments', 'Single-line comments', 'Single-line comments'),
(68, 'What do you call a comment that is enclosed between /* and */', 'Multiple-character comments', 'Multiple-line comments', 'Single-line comments', 'Single-character comment', 'Multiple-line comments'),
(69, 'What do single-line comments use to indicate that the line of code is a comment?', '[ ]', '{ }', '//', '/* and */', '// '),
(70, 'What do multiple-line comment use to indicate that the multiple line of code is a comment?', ' [ ]', '/* and */', '//', '{ }', '/* and */'),
(71, 'What is the collections of related classes that is grouped together into a folder called?', 'Packages', 'import', 'Java Development Kit (JDK)', 'Java Runtime Environment (JRE) ', 'Packages'),
(72, 'What is the reserved keyword in Java used to access the classes in a package called?', 'Data type', 'String', 'Packages', 'import', 'import'),
(73, 'What is the syntax for importing a package member?', 'import java.util.*;', 'import java.util.Date;', 'import java.util.File;', 'import java.util.Timer;', 'import java.util.Date;'),
(74, 'What is the syntax for importing all the classes in a particular package?', 'import java.util.Timer;', 'import java.util.Date;', 'import  java.util.*;', 'import java.util.File;', 'import java.util.*;'),
(75, 'What is used to specify the type  of value that a variable can hold?', 'Data type', 'Keywords', 'Arguments', 'Statement', 'Data type'),
(76, 'These are predefined data types by the language and named by a keyword.', 'Data type', ' Primitive data types', 'Arguments', 'Statement', 'Primitive data types'),
(77, 'What is the data type that can save memory space in a large array called?', 'float', 'int', 'byte', 'short', 'byte'),
(78, 'What is the data type that has a larger capacity than byte but do the same is called?', 'float', 'int', 'byte', 'short', 'short'),
(79, 'What is the data type that is generally as the default data type for integral values?', 'float', 'int', 'byte', 'short', 'int'),
(80, 'What is the data type that is being used because of its wider range than int called?', 'float', 'byte', ' long', 'short', 'long'),
(81, 'What do you call the data type that is used to save large memory of arrays of floating-point numbers?', 'float', 'int', 'byte', 'short', 'float'),
(82, 'What is the default data type being used for decimal values?', 'float', 'int', 'double', 'short', 'double'),
(83, 'What data type only has two (2) values?', 'varchar', 'String', 'char', 'boolean', 'boolean'),
(84, 'What data type stores a single character only?', 'char', 'String', 'varchar', 'boolean', 'char'),
(85, 'What is the name for a memory location that stores a specific value such as numbers and letters?', 'Argument', 'Variable', 'Constant', 'final', 'Variable'),
(86, 'What is the memory location whose value cannot be changed during program execution?', 'Argument', 'final', 'Constant', 'Variable', 'Constant'),
(87, 'What is the keyword used to fixate the value stored in a variable_name?', 'Argument', 'Variable', 'Data type', 'final', 'final'),
(88, 'What do you call the conversion of value from a specific type to a variable of another type?', 'Narrowing conversion (explicit casting)', ' 	Widening conversion (implicit casting)', 'coercion', 'Type casting', 'Type casting '),
(89, 'What do you call a conversion from lower to higher precision data type?', 'Narrowing conversion (explicit casting)', 'Widening conversion (implicit casting)', 'coercion', 'Type casting', 'Widening conversion (implicit casting)'),
(90, 'What do you call a conversion from higher to lower precision data type?', 'Narrowing conversion (explicit casting)', 'Narrowing conversion (explicit casting)', 'coercion', 'Type casting', 'Narrowing conversion (explicit casting)'),
(91, 'What do you call a specific symbols used in programming language?', 'Equation', 'Formula', 'Expression', 'Operators', 'Operators'),
(92, 'What operator is used to perform mathematical operation?', 'Arithmetic operators', 'Logical operators', 'Assignment operators', 'Comparison operators', 'Arithmetic operators'),
(93, 'What do you call the value on the either side of an operator?', 'parameter', 'argument', 'operand', 'statement', 'operand'),
(94, 'What is the arithmetic operator used to add two (2) or more operand?', '- ', '/', '+', '+', '+'),
(95, 'What is the arithmetic operator used to subtract two (2) or more operand?', '- ', '/', '- ', '%', '- '),
(96, 'What is the arithmetic operator used to multiply two (2) or more operand?', '- ', '*', '+', '%', '*'),
(97, 'What is the arithmetic operator used to divide two (2)?', '/', '/', '+', '%', '/'),
(98, 'What is the arithmetic operator used to find the remainder of two (2) operand?', '- ', '%', '+', '+', '%'),
(99, 'What do you call when either or both of the operand is a floating-point value and the result is a floating-point value?', 'Extenal division', 'Intenal division', 'Floating-point division', 'Integer division ', 'Floating-point division'),
(100, 'What do you call a division where both operand and the result is an integer?', 'Extenal division', 'Intenal division', 'Floating-point division', 'Integer division ', 'Integer division ');

-- --------------------------------------------------------

--
-- Table structure for table `content_v1`
--

CREATE TABLE `content_v1` (
  `Indicate` int(11) NOT NULL,
  `Activity` varchar(255) NOT NULL,
  `Quiz` varchar(255) NOT NULL,
  `Exam` varchar(255) NOT NULL,
  `Answer` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `content_v1`
--

INSERT INTO `content_v1` (`Indicate`, `Activity`, `Quiz`, `Exam`, `Answer`) VALUES
(1, 'List down the two (2) levels of programming languages', 'It is a sequence of statements intended to accomplish a certain task. It is a set of instructions fo', 'This is the sequence of statements that\'s intended to accomplish certain tasks.', 'Computer program'),
(2, '________ is a process of planning and creating a program', 'It is a process of planning and creating a program.', 'What is the process of planning and creating a program.', 'Programming'),
(3, 'List down the two (2) low-levels languages', 'These are the languages that deal with a computer’s hardware components', 'What is the language that is in charge if dealing with the computer\'s hardware?', 'Low-level Languages'),
(4, '_________ is the language that the computer can directly understand', 'It is the language that the computer can directly understand.', 'It is the most basic set of instructions that the computer can execute. Machine language programs', 'Machine Language'),
(5, '________ is a symbolic form of machine language that is easier for people to read', 'It is a symbolic form of machine language that is easier for people to read.', 'This type of low-level languages can be read by people.', 'Assembly Language'),
(6, '_________ is a program that translates assembly language instructions into machine language.', 'This is a program that translates assembly language instructions into machine language.', 'What is the name of a program that can translate assembly language instructions into machine languag', 'Assembler'),
(7, 'List down all the high-level languages.', 'These are the programming languages that use natural languages, such as the English language.', 'What kind of programming language uses natural language such as English language?', 'High-level Languages '),
(8, '________ are set of rules of the language, for example, print or write is used to produce an output.', 'Rules of the language, for example, print or write is used to produce an output', 'This is what developers call the \"rules of the language\" what is it called?', 'Syntax'),
(9, '_________ are program statements that carry out tasks that the program has to perform, for example, ', 'These are program statements that carry out tasks that the program has to perform.', 'What is the program statements that carries the tasks of the program called?', 'Commands'),
(10, '_________ is a program that translates a program written in a high-level language into a low-level l', 'This is a program that translates a program written in a high-level language into a low-level langua', 'What is the program that translates a program written in a High-level language to low-level language', 'Compiler'),
(11, '_________ acts as a compiler, but it translates one (1) program statement at a time, this executes t', 'This acts as a compiler, but it translates one (1) program statement at a time, this executes the st', 'What do you call the program that acts a compiler, but only translates one (1) program?', 'Interpreter'),
(12, '_________ _____ are errors that might be encountered during the process of translation. An example i', 'These are errors that might be encountered during the process of translation.', 'What do you call the errors that can be encounter during the process of translation?', 'Syntax errors'),
(13, '_______ _____ are errors that occur when the syntax of the program is correct, but the expected outp', 'These are errors that occur when the syntax of the program is correct, but the expected output is no', 'This only occurs when the expected output is not correct but the syntax is correct, what kind of err', 'Logical errors '),
(14, '_______ is the process of locating and correcting the errors of a program.', 'This is the process of locating and correcting the errors of a program.', 'What do they call the process of locating the errors of a program?', 'Debugging'),
(15, 'list the steps of the problem-solving process in the programming environment.', 'It is a problem-solving technique used in solving programming problems. ', 'It is a step-by-step problem-solving\r\nprocess in which a solution is arrived at in a finite amount o', 'Algorithm'),
(16, '________ _______ analyzes the problem and outline the problem and its solution requirements.', 'This is part of algorithm where it analyze the problem and outline the problem and its solution requ', 'What step of algorithm does where the problem is being analyze and its solution requirements?', 'Problem Analysis'),
(17, '__________ _______ is the design to an algorithm to solve the problem.', 'This step is where the design of an algorithm to solve the problem is formed.', 'What step does the deign of the algorithm usually formed to solve the problem?', 'Algorithm Design'),
(18, '_______ is the implementation the algorithm in a programming language.', 'This step of algorithm is the implementation of the algorithm in a programming language.', 'What step does an algorithm is implemented to the programming language?', 'Coding'),
(19, '_________ is to verify that the algorithm works.', 'This is the last step of an algorithm and it verifies if the algorithm works.', 'What step is focused on verification if the algorithm works?', 'Execution'),
(20, 'List the two (2) commonly used tool in representing algorithm.', 'It is a method of describing computer algorithms using a combination of natural language and program', 'what is the method of algorithm where it describes algorithms using the combination of natural langu', 'Pseudocode '),
(21, 'List the arithmetic operators.', 'This is an operation where it is focused on mathematics.', 'What does it call the operation that uses this symbols (+, -, *, /)?', 'Arithmetic operations '),
(22, '__ this operator is used for assigning variables.', 'This is an operation that is focused on assigning values in variables.', 'What is the operation that is focus on assigning values to variables?', 'Assignment'),
(23, 'List all the comparison operators.', 'This is the operation that is focus on comparing variables.', 'What is this operators called (=, ≠, <, >, ≤, ≥)?', 'Comparison'),
(24, 'Enumerate the two (2) logical operators', 'This is an operation is focused on combine, invert, or compare conditional statements.', 'What is the operation that is focused on on combining, inverting, or comparing conditional statement', 'Logical '),
(25, 'List down the symbols of arithmetic operation.', 'This symbols are focus on arithmetic operation.', 'What are the symbols used for arithmetic operation?', '+, -, *, /'),
(26, 'The symbol __ is for assigning variable.', 'This symbol is for assigning variable.', 'What symbol is used for assigning variable', '='),
(27, 'List down the symbols of comparison operation.', 'This are symbols used to compare two (2) variables.', 'What symbol is used for comparing two (2) variables?', '=, ≠, <, >, ≤, ≥'),
(28, 'List the two (2) logical operation.', 'This is the two (2) logical operation used in pseudocode.', 'What is the two (2) logical operator used in psuedocode?', 'and, or'),
(29, 'List all the certain keywords used as commands.', 'This are the certain keywords used as commands in pseudocode.', 'What are the keywords used as commands in pseudocode?', 'PRINT, WRITE, READ, SET, GO TO'),
(30, '__________ is used to indicate branches and loops of instructions.', 'This is used to indicate branches and loops of instruction.', 'What is used to indicate branches and loops of instruction called?', 'Indentation '),
(31, 'The keyword ____ is used to show the output.', 'This is a keyword that is used to show the output.', 'What is the keyword used to show the output?', 'PRINT'),
(32, 'The keyword ____ is used to show the output.', 'This is a keyword that is used to display the output.', 'What is the keyword used to show the output?', 'WRITE'),
(33, 'The ____ is an input statement used to capture data from a user ', 'This command is used to capture input statement data from the user.', 'What is the command that is used to capture input statement of user?', 'READ'),
(34, 'The command ___ is for assigning value to a variable or to initialize a variable.', 'This command is used to assign a value to a variable or to initialize a variable', 'What command is used to initialize a variable or assign a value to a variable?', 'SET'),
(35, 'Name all the flowchart shapes.', 'This is a visual representation of an algorithm. ', 'This tool representing algorithm contains shapes describing how an algorithm or program operates.', 'Flowchart'),
(36, 'The ______ ____ is the indicator of the direction of the process flow.', 'This is used to indicate the direction of the process flow by connecting other shapes.', 'What is the the shape that is used to indicate the direction of the process flow?', 'Flow lines'),
(37, 'The shape ______ ____ is used to start and beginning of the program.', 'This is used to represent the beginning or end of a program.', 'What shape is used to represent the beginning or end of a program?', 'Terminal block'),
(38, 'The shape _______ represent a process step or activity such as computation.', 'This is used to represent a process step or activity, such as computation, initialization, etc.', 'What shape is used to represent a process or activity such as computation?', 'Process'),
(39, 'The _____ represents the data used as inputs or output.', 'This represents the data used as inputs or outputs, such as user input and display text.', 'What shape is used to store the data used as inputs or output?', 'Data'),
(40, 'The _______ ____ indicates a decision operation where it has two (2) alternatives: true or false.', 'This indicates a decision operation in the process where there are two (2) alternatives: true and fa', 'What shape is used for decision making process?', 'Decision block'),
(41, 'The ________ is used to combine flow lines by indicating an identifier such as letters.', 'This is used as a connector to combine flow lines by indicating an identifier, such as letters. This', 'What shape is used to combine flow lines?', 'Connector'),
(42, 'The _______ ______ indicates the use of an algorithm specified outside the program, such as methods ', 'This indicates that it uses algorithm specified outside of program.', 'What shape is used to use algorithm outside of program?', 'Predefined Process'),
(43, 'List down the two (2) programming methodology.', 'This approach is used to analyzing such complex problems by planning software development and contro', 'What do you call an approach used to analyze such complex problems by planning other software\'s?', 'Programming methodology '),
(44, 'The __________ ___________ approach,  the problem is broken down into functions that perform one (1)', 'This approach, the problem is broken down into functions that perform one (1) task each. ', 'This approach is suitable only for small programs that have a low level of complexity.', 'Procedural Programming'),
(45, 'The _______ _ _______ __________ approach,\r\nprograms are organized around objects rather than action', 'This approach, programs are organized around objects rather than actions, and data rather than logic', 'It deals with how to store data related to the entities, how the entities behave, and how they inter', 'Object-Oriented Programming'),
(46, '_____ is a high-level programming language that was developed by Sun Microsystems for general-purpose business applications and interactive.', 'This is a high-level programming language that was developed by Sun Microsystems for general-purpose business\r\napplications and interactive', 'What do you call a high-level programming language that was developed by Sun Microsystems for general-purpose business applications?', 'Java'),
(47, '___ is an an environment that translates Java bytecode into machine language and executes it.', 'This is an environment that translates Java bytecode into machine language and executes ', 'What do you call an environment that translates Java bytecode into machine language?', 'Java Environment Machine (JVM)'),
(48, '_______ ____ is a programming statements written in a high-level language. ', 'This is the programming statements written in a high-level language.', 'This is created using a text editor or a development environment.', 'Source code'),
(49, '_____________ ___________ is a set of tools that help write programs easily, such as NetBeans.', 'This is a set of tools that help write programs easily, such as NetBeans.', 'What do you call a set of tools that help write programs easily, such as NetBeans?', 'Development Environment '),
(50, 'the ____ ________ converts the source code into a binary program of bytecode.', 'This converts the source code into binary program of bytecode.', 'What do you call a program that converts the source code into binary program of bytecode?', 'Java compiler'),
(51, 'The __________ _______ then checks\r\nthe bytecode and communicates with the operating system, executing the bytecode instructions line by line within the Java\r\nVirtual Machine.', 'This checks the bytecode and communicates with the operating system, executing the bytecode instructions line by line within the Java\r\nVirtual Machine.', 'What do you call a program that checks the bytecode and communicates with the operating system, executing the bytecode instructions line by line within the Java?', 'Java interpreter'),
(52, 'List down the two (2) Java program', 'this is a stand-alone program.', 'What do you call a java program that is a stand-alone program?', 'Application '),
(53, '________ ________ supports character output to a computer screen in a DOS window.', 'This supports character output to a computer screen in a DOS window.', 'What do you call an application that supports character output to a computer screen in a DOS window?', 'Console application '),
(54, '_________ _________ creates a GUI with elements such as menus, buttons, dialog boxes, etc.', 'This creates a GUI with elements such as menus, buttons, dialog boxes, etc.', 'What do you call an application that creates a GUI with elements such as menus and button?', 'Windowed application '),
(55, '_____ is a program embedded in a Web page. It runs in a browser.', 'This is a program embedded in a Web page. It runs in a browser.', 'What do you call a program that is embedded in to a web page?', 'Applet'),
(56, 'A ______ is the basic unit of a Java program.', 'This is a basic unit of java programming that is used to group java codes.', 'What do you call a java programming that is used to group java codes?', 'class'),
(57, '________ _______ is used to determine the accessibility of a class.', 'This determines the class accessibility.', 'What do you call the keyword used to identify the class accessibility?', 'access modifier'),
(58, 'The ____ method is a special method and is the entry point of the program execution.', 'This is a special method that is the entry point of the program execution.', 'A Java class can only have one of what method?', 'main'),
(59, 'A _________ is an action that the program has to perform.', 'This is an action that the program has to perform.', 'What do you call an action that the program has to perform?', 'Statement'),
(60, '__________ are information passed to a method so it can perform its task.', 'This are information passed to a method so it can perform its task.', 'What do you call a information that is passed to a method so it can perform task?', 'Arguments '),
(61, 'Reserved words or _________ have special predefined meaning and cannot be used in naming variables, classes, methods, or identifiers.', 'This are words used that has predefined meaning and it cannot be used for naming.', 'What do you call a word that has predefined meaning and cant be used for naming?', 'Keywords'),
(62, 'Write the main method.', 'This is the syntax of the main method.', 'Find the correct syntax of the main method.', 'public static void main(String[] args) { }'),
(63, '___ includes a complete set of JRE tools for developing, debugging, and monitoring Java applications. ', 'This includes a complete set of JRE tools for developing, debugging, and monitoring Java applications.', 'What is the core software bundle used by developers to write, compile, debug, and run Java applications?', 'Java Development Kit (JDK)'),
(64, '___ covers most end-users needs. It contains everything required to run Java applications on a system. ', 'This covers most end-users needs. It  contains everything required to run Java applications on a system.', 'what is the software package that provides the files, class libraries, and the Java Virtual Machine (JVM) needed to run Java programs?', 'Java Runtime Environment (JRE) '),
(65, '_______ ______ are invalid statements that the Java compiler (javac) might encounter.', 'These are invalid statements that the Java compiler might encounter.', 'What do you call a invalid statement that Java compiler encounter?', 'Syntax errors'),
(66, '_______ are ignored by the compiler, meaning they are not executed when the Java programs run.', 'This is a line of code that is ignored by the compiler and its used to explain details in the program.', 'What do you call a line of code that is ignored by the compiler and used to explain details in the program?', 'Comments'),
(67, '________ _ ________ ________ are comments that begin with // and can be placed anywhere in the line.', 'These are comments that begin with // and can be placed anywhere in the line.', 'What do you call a comment that begins with // and can be placed anywhere in the line?', 'Single-line comments'),
(68, '_______ _ _____ _______ are comments that are enclosed between /* and */.', 'These comments are enclosed between /* and */.', 'What do you call a comment that is enclosed between /* and */', 'Multiple-line comments '),
(69, 'These comment begins with __ that can be places anywhere in the line. ', 'This is a single-line comments that can be placed anywhere in the line.', 'What do single-line comments use to indicate that the line of code is a comment?', '// '),
(70, 'The multiple-line comment are enclosed between __ and __', 'This comment is enclosed.', 'What do multiple-line comment use to indicate that the multiple line of code is a comment?', '/* and */'),
(71, '_______ are collections of related classes that have been grouped together into a folder.', 'These are collections of related classes that have been grouped together into a folder. ', 'What is the collections of related classes that is grouped together into a folder called?', 'Packages'),
(72, 'The ________ is a reserved keyword that is used to access the classes in a package', 'This is a reserved keyword in Java used to access the classes in a package. ', 'What is the reserved keyword in Java used to access the classes in a package called?', 'import'),
(73, 'import _____.util.Date;', 'This is a common way of importing a package member.', 'What is the syntax for importing a package member?', 'import java.util.Date;'),
(74, 'import java.____.*;', 'This is a common way to import all the classes in a particular package.', 'What is the syntax for importing all the classes in a particular package?', 'import java.util.*;'),
(75, '____ ____ is used as a specification on what type of value can a variable hold.', 'This is used to specify the types of values that a variable can hold.', 'What is used to specify the type  of value that a variable can hold?', 'Data type '),
(76, '_________ ____ _____ are the fundamental data types in Java.', 'These are the fundamental data types in Java.', 'These are predefined data types by the language and named by a keyword.', 'Primitive data types'),
(77, 'The ____ data type can be useful for saving memory space in large arrays. ', 'This data type is can be useful for saving memory space in a large array.', 'What is the data type that can save memory space in a large array called?', 'byte'),
(78, 'The ____ data type has a larger capacity than byte and also useful for saving memory space in large arrays.', 'This is data type has a larger capacity than byte and this is used for saving memory space in a large array.', 'What is the data type that has a larger capacity than byte but do the same is called?', 'short'),
(79, '___ data type is generally used as the default data type for integral values unless there is a concern about\r\nmemory space. ', 'This data type is generally used as the default data type for integral values unless there is a concern about\r\nmemory space. ', 'What is the data type that is generally as the default data type for integral values?', 'int'),
(80, '____ data type is used when a wider range than int is needed.', 'This data type is used when a wider range than int is needed.', 'What is the data type that is being used because of its wider range than int called?', 'long '),
(81, '_____ data type is also used to save memory in large arrays of floating-point numbers.', 'This data type is used to save memory in large arrays of floating-point numbers. ', 'What do you call the data type that is used to save large memory of arrays of floating-point numbers?', 'float '),
(82, 'The _______ data type is generally the default data type for decimal values.', 'This data type is used as the default data type for decimal values. ', 'What is the default data type being used for decimal values?', 'double'),
(83, 'The ________ ____ type has only two (2) possible values:', 'This data type has only two (2) possible values.', 'What data type only has two (2) values?', 'boolean'),
(84, 'The ____ data type is used to store a single character. In Java, the character is enclosed in single quotes.', 'This data type is used to store a single character only.', 'What data type stores a single character only?', 'char'),
(85, '________ is a name for a memory location that stores a specific value, such as numbers and letters.', 'This is a name for a memory location that stores a specific value, such as numbers and letters.', 'What is the name for a memory location that stores a specific value such as numbers and letters?', 'Variable'),
(86, '________ is a memory location whose value cannot be changed during program execution.', 'This is a memory location whose value cannot be changed during program execution.', 'What is the memory location whose value cannot be changed during program execution?', 'Constant'),
(87, 'The _____ is a reserved keyword used to specify that the value stored in the variable_name is fixed.', 'This keyword is used to specify that the value stored in the variable_name is fixed and cannot be changed. ', 'What is the keyword used to fixate the value stored in a variable_name?', 'final'),
(88, '____ _______ refers to converting a value from a specific type to a variable of another type', 'This refers to converting a value from a specific type to a variable of another type.', 'What do you call the conversion of value from a specific type to a variable of another type?', 'Type casting '),
(89, '__________ __________ the conversion of the lower precision data type to a value of a higher precision data type. ', 'the conversion of the lower precision data type to a value of a higher\r\nprecision data type. ', 'What do you call a conversion from lower to higher precision data type?', 'Widening conversion (implicit casting)'),
(90, '_______ __________ the conversion of a higher precision data type into a value of a lower precision data type.', 'This is the conversion of a higher precision data type into a value of a lower precision data type.', 'What do you call a conversion from higher to lower precision data type?', 'Narrowing conversion (explicit casting)'),
(91, '________ are specific symbols in a programming language. ', 'These are specific symbols in a programming language.', 'What do you call a specific symbols used in programming language?', 'Operators'),
(92, '__________ ________ are used to perform basic mathematical operations on numerical values.', 'These are used to perform basic mathematical operations on numerical values.', 'What operator is used to perform mathematical operation?', 'Arithmetic operators'),
(93, 'A value used on either side\r\nof an operator is an _______.', 'This is the value that is used on the either side of the operator.', 'What do you call the value on the either side of an operator?', 'operand'),
(94, '1 _ 1 = 2', 'This arithmetic operator is used to add two (2) or more operand.', 'What is the arithmetic operator used to add two (2) or more operand?', '+'),
(95, '4 _ 2 = 2 ', 'This arithmetic operator is used to subtract two (2) or more operand.', 'What is the arithmetic operator used to subtract two (2) or more operand?', '- '),
(96, '2 _ 3 = 6', 'This arithmetic operator is used to multiply two (2) or more operand.', 'What is the arithmetic operator used to multiply two (2) or more operand?', '*'),
(97, '6 _ 2 = 3', 'This arithmetic operator is used to divide two (2) operand.', 'What is the arithmetic operator used to divide two (2)?', '/'),
(98, '11 _ 3 = 2', 'This arithmetic operator is used to divide to find the remainder two (2) operand.', 'What is the arithmetic operator used to find the remainder of two (2) operand?', '%'),
(99, '________-_____ ________ occurs when either or both of the operands are floating-point values and the result is a floating-point value.', 'This occurs when either or both of the operands are floating-point values and the result is a floating-point value.', 'What do you call when either or both of the operand is a floating-point value and the result is a floating-point value?', 'Floating-point division'),
(100, '_______ ________ occurs when both of the operands are integers.', 'This occurs when both of the operands are integers. ', 'What do you call a division where both operand and the result is an integer?', 'Integer division ');

-- --------------------------------------------------------

--
-- Table structure for table `content_v2`
--

CREATE TABLE `content_v2` (
  `Indicate` int(11) NOT NULL,
  `Activity` varchar(200) NOT NULL,
  `Quiz` varchar(200) NOT NULL,
  `Exam` varchar(200) NOT NULL,
  `Answer` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `content_v2`
--

INSERT INTO `content_v2` (`Indicate`, `Activity`, `Quiz`, `Exam`, `Answer`) VALUES
(1, '________ is a global network of interconnected networks that enables communication and data exchange.', 'This is a global network of interconnected networks that enables communication and data exchange.', 'What is the global network of interconnected networks that enables communication called?', 'Internet'),
(2, '_____ ____ ___ is a collection of interconnected web pages and resources accessed through the Internet using web browsers.', 'This is a collection of interconnected web pages and resources accessed through the Internet using web browsers.', 'What is the collection of interconnected web pages and resources called?', 'World Wide Web (WWW)'),
(3, '___________ is the use of internet that involves email, video calls, instant messaging.', 'This is the use of internet that involves email, video calls, instant messaging.', 'What internet use involves email, video calls, instant messaging?', 'Communication'),
(4, '____ ______ is the use of internet that involves file transfer and cloud storage.', 'This is the use of internet that involves file transfer and cloud storage.', 'What internet use involves file transfer and cloud storage?', 'File Sharing'),
(5, '______ ________ is the use of internet that involves  banking, payments and other online services.', 'This is the use of internet that involves  banking, payments and other online services.', 'What internet use involves banking, payments and other online services?', 'Online Services'),
(6, '_____________ is the use of internet that involves online gaming, streaming and music.', 'This is the use of internet that involves online gaming, streaming and music.', 'What internet use involves online gaming, streaming and music?', 'Entertainment'),
(7, '______ ______ is the use of internet that involves accessing computers, servers and network resources.', 'This is the use of internet that involves accessing computers, servers and network resources.', 'What internet use involves accessing computers, servers and network resources?', 'Remote Access'),
(8, '___________ ______ is the use of world wide web that involves websites, news and online articles.', 'This is the use of world wide web that involves websites, news and online articles.', 'What world wide web use involves websites, news and online articles?', 'Information Access'),
(9, '_____________ is the use of world wide web that involves web-based email, forums and social media.', 'This is the use of world wide web that involves web-based email, forums and social media.', 'What world wide web use involves web-based email, forums and social media?', 'Communication'),
(10, '_________ is the use of world wide web that involves online courses, e-books and virtual classrooms.', 'This is the use of world wide web that involves online courses, e-books and virtual classrooms.', 'What world wide web use involves online courses, e-books and virtual classrooms?', 'Education'),
(11, '______ ________ is the use of world wide web that involves E-commerce websites and marketplaces.', 'This is the use of world wide web that involves E-commerce websites and marketplaces.', 'What world wide web use involves E-commerce websites and marketplaces?', 'Online Shopping'),
(12, '_____________ is the use of world wide web that involves video streaming, web games and music platforms.', 'This is the use of world wide web that involves video streaming, web games and music platforms.', 'What world wide web use involves video streaming, web games and music platforms?', 'Entertainment'),
(13, '_________ ______ ________ is the standard markup language for creating Web pages. ', 'This is the standard markup language for creating Web pages, no matter how simple or complex.', 'What do you call the the standard markup language for creating website?', 'HyperText Markup Language (HTML) '),
(14, 'The “_________” in HTML refers to how links on the Web let users\r\nmove from one document to another', 'This refers to how links on web let users move from one document to another.', 'What do you call the links on web that let users move from one document to another?', 'HyperText'),
(15, '___ _______-___ is the person that is who invented HTML.', 'This is the person that is who invented HTML.', 'Who is the person that invented HTML?', 'Tim Berners-Lee\'s '),
(16, '____ is when Tim Burners-Lee introduced HTML.', 'This is when Tim Burners-Lee introduced HTML.', 'When did Tim Burners-Lee introduced HTML?', '1993'),
(17, '_____ is the latest update of HTML.', 'This is the latest version of HTML.', 'What is the latest version of HTML?', 'HTML5'),
(18, '_____ _____ ____ __________ manages the specifications of what is in HTML and what is not. ', 'This manages the specifications of what is in HTML and what is not. ', 'What is the one that manages the specification of what is in HTML and what is not?', 'World Wide Web Consortium (W3C)'),
(19, '____ ________ is a text file created in any text editor containing textual content, elements, attributes, and tag.', 'This is a text file created in any text editor containing textual content,\r\nelements, attributes, and tag.', 'What do you call the text file created containing textual content, elements, attribute, and tag?', 'HTML Document'),
(20, '____ _______ is the component of an HTML document containing formats, instructions, and semantic meaning.', 'This is the component of an HTML document containing formats, instructions, and semantic meaning.', 'What do you call the component of HTML document containing the formats, instruction, and semantic meaning?', 'HTML Element'),
(21, '_________<_></_> is the basic unit of text in an HTML document.', 'This is the basic unit of text in an HTML document.', 'What is the most basic unit of text in an HTML document?', 'Paragraph <p></p>'),
(22, '<______></_______>', 'This is a format of a text that makes a text in bold.', 'This is one of the ways to make a text bold in HTML.', '<strong></strong>'),
(23, '<__> is used to to insert a line break.', 'This is used to to insert a line break.', 'What is used to insert a line break in HTML?', '<br> '),
(24, '____ _________ is placed within an element\'s opening tag, which can contain multiple attributes separated by a space. ', 'This is placed within an element\'s opening tag, which can contain multiple attributes separated by a space. ', 'In HTML what is placed within an element\'s opening tag that contains multiple attributes separated by space?', 'HTML Attribute'),
(25, '____ ____ are keywords define how web browsers will format and display the content on an HTML file.', 'These keywords define how web browsers will format and display the content on an HTML file.', 'What is the keywords that defines how web browsers will format and display the content on an HTML file?', 'HTML Tags'),
(26, '________ are titles or subtitles that can be displayed on a webpage.', 'These are titles or subtitles that can be displayed on a webpage.', 'What do you call the title or subtile that can be displayed on a webpage?', 'Headings'),
(27, '_____ is used to define the relationship between the current document and an external resource.', 'This is used to define the relationship between the current document and an external resource.', 'What do you call the HTML tag that defines the relationship between the current document and an external resource?', 'Links'),
(28, '____ __________ specifies the URL of the webpage the link goes to. ', 'This attribute that specifies the URL of the webpage the link goes to. ', 'What attribute specifies the URL of the webpage the link goes to?', 'href attribute '),
(29, 'Write the syntax for absolute URL.', 'This is an absolute URL syntax that directs you to another website.', 'What is the syntax for absolute URL?', '<a href=https://www.google.com.ph> Google </a>'),
(30, 'Write the syntax for relative URL.', 'This is an relative URL syntax that directs you to another website.', 'What is the syntax for relative URL?', '<a href=”image.html”> Sample Products </a>'),
(31, '____ is an alternative way to interact with the server and collect user inputs. ', 'This is an alternative way to interact with the server and collect user inputs. ', 'What is the alternative way to interact with the server and collect user inputs?', 'Form'),
(32, '____ ______ is consists of cells that allows the web developers to arrange data into columns and rows.', 'This consists of cells that allows the web developers to arrange data into columns and rows.', 'What HTML tag is consists of cells that allows the web developers to arrange data into columns and rows?', 'HTML Table'),
(33, '_____ ______ is the top row of the table.', 'This is the top row of the table.', 'What do you call the top row of the table?', 'Table Header'),
(34, '______ ___ is used to indicate the number of rows displayed.', 'This is used to indicate the number of rows displayed.', 'In table what is used to indicate the number of rows displayed?', 'Table Row'),
(35, '________ ______ holds the data displayed in a table.', 'This holds the data displayed in a table.', 'In table what holds the data that is displayed?', 'Table Data'),
(36, '_______ is used to join two or more columns in a table.', 'This is used to join two or more columns in a table.', 'In table what us used used to join two or more columns in a table?', 'Colspan'),
(37, '________ is used to join two (2) or more rows in a table.', 'This is used to join two (2) or more rows in a table.', 'In table what is used to join two or more rows?', 'Rowspan'),
(38, '<____>', 'This is used to group up table head.', 'What is the syntax used for grouping table head?', '<thead>'),
(39, '<_____>', 'This is used to group table footer', 'What is the syntax used for grouping table foot?', '<tfoot>'),
(40, '<_____>', 'This is used to group the table body.', 'What is the syntax used for grouping table body?', '<tbody>'),
(41, '______ is used to separate the table cells.', 'This is used to separate the table cells.', 'What is used to separate the table cells?', 'Border'),
(42, '<!_______> is short for Document Type Definition that tells the browser or any software reading the HTML document what type of document is about to be processed. ', 'This is short for Document Type Definition that tells the browser or any software reading the HTML document what type of document is about to be processed. ', 'In HTML structure tells the browser or any software reading the HTML document?', '<!DOCTYPE> '),
(43, '<____> is the container for all other HTML elements except for Document type.', 'This is the container for all other HTML elements except for Document type.', 'In HTML structure what is the container for all the elements called? ', '<html>'),
(44, '<_____> shows extra information about an element.', 'This shows extra information about an element.', 'In HTML structure what is the extra information about an element is called?', '<title>'),
(45, '<____> is the container for metadata (data about data) which is placed between the <html> and the <body> tags.', 'This is the container for metadata (data about data) which is placed between the <html> and the <body> tags.', 'In HTML structure what is the container for metadata (data about data) which is\r\nplaced between the <html> and the <body> tags?', '<head> '),
(46, '<____>  is used to specify the page description.', 'This is used to specify the page description.', 'In HTML structure what is used to specify the page description?', '<meta>'),
(47, '<____> defines the content in an HTML document displayed.', 'This defines the content in an HTML document displayed.', 'In HTML structure what defines the content in an HTML document displayed called?', '<body>'),
(48, '<____> defines the connection between the current document and an external source.', 'This defines the connection between the current document and an external source.', 'In HTML structure what defines the connection between the current document\r\nand an external source?', '<link>'),
(49, '<______> is used to embed a client-side script (JavaScript) that either contains scripting statements or points to an external script file.', 'This is used to embed a client-side script (JavaScript) that either contains scripting statements or points to an external script file.', 'In HTML structure what is used to embed a client-side script (JavaScript) that either contains scripting statements or points to an external script file?', '<script>'),
(50, '<__> This is the highest level of header.', 'This is the highest level of header.', 'What is the highest level of header?', '<h1>');

-- --------------------------------------------------------

--
-- Table structure for table `pre-post_test`
--

CREATE TABLE `pre-post_test` (
  `Chapter` int(11) NOT NULL,
  `Pre-test Scores` int(11) NOT NULL,
  `Post-test Scores` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `section`
--

CREATE TABLE `section` (
  `Name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `section`
--

INSERT INTO `section` (`Name`) VALUES
('Grade 11 - Matthew (ABM)'),
('Grade 12 - Trustworthy (ICT)');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `ID` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `First_Name` varchar(255) NOT NULL,
  `Middle_Initials` varchar(255) NOT NULL,
  `Last_Name` varchar(255) NOT NULL,
  `Section` varchar(255) NOT NULL,
  `PlayerName` varchar(255) NOT NULL,
  `PlayerGender` varchar(255) NOT NULL,
  `Progress` decimal(5,2) NOT NULL,
  `Mastery` decimal(5,2) DEFAULT NULL,
  `Date_Joined` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`ID`, `Password`, `First_Name`, `Middle_Initials`, `Last_Name`, `Section`, `PlayerName`, `PlayerGender`, `Progress`, `Mastery`, `Date_Joined`) VALUES
('100031536', 'whatnot12', '', '', '', 'Grade 12 - Trustworthy (ICT)', 'Paras', 'M', 30.00, 2.75, '2026-10-19'),
('100032965', 'VFqdnElrTY', 'John', 'M', 'Reyes', 'Grade 11 - Matthew (ABM)', 'Rey', 'N', 0.00, 0.00, '2026-10-28'),
('100035126', 'Mercy912', '', '', '', 'Grade 12 - Trustworthy (ICT)', 'rico', 'M', 43.00, 1.50, '2026-10-19'),
('100037418', 'sera09723', '', '', '', 'Grade 12 - Trustworthy (ICT)', 'reslieno', 'F', 34.00, 1.75, '2026-10-19'),
('100041253', 'Ace56475', '', '', '', 'Grade 12 - Trustworthy (ICT)', 'John Wade', 'M', 50.00, 1.25, '2026-10-19'),
('100041567', 'master12', '', '', '', 'Grade 12 - Trustworthy (ICT)', 'Cristan', 'F', 37.00, 2.00, '2026-10-19'),
('100043216', 'qwerty', 'Juan', 'Q', 'Dela Cruz', 'Grade 11 - Matthew (ABM)', 'DellCruz', 'N', 0.00, 0.00, '2026-10-28'),
('100043632', 'deas1452', '', '', '', 'Grade 12 - Trustworthy (ICT)', 'Jardomeo', 'M', 25.00, 2.00, '2026-10-19'),
('100045628', 'guess143', '', '', '', 'Grade 12 - Trustworthy (ICT)', 'laog', 'M', 2.25, 3.00, '2026-10-19'),
('100045876', 'ashley143', '', '', '', 'Grade 12 - Trustworthy (ICT)', 'Roblon', 'F', 48.00, 2.25, '2026-10-19'),
('100047865', 'distro67', '', '', '', 'Grade 12 - Trustworthy (ICT)', 'Galang', 'M', 49.00, 2.50, '2026-10-19'),
('100053168', 'Adam7485', '', '', '', 'Grade 12 - Trustworthy (ICT)', 'miko', 'M', 18.00, 1.25, '2026-10-19'),
('100056482', 'touchgrassn0w', '', '', '', 'Grade 12 - Trustworthy (ICT)', 'Stevo', 'M', 38.00, 1.75, '2026-10-19'),
('100056873', 'fwPfcHiFAi', 'Santos', 'G', 'Santos', 'Grade 11 - Matthew (ABM)', 'GAB', 'N', 0.00, 0.00, '2026-10-28'),
('100057246', 'Kukuru2565', '', '', '', 'Grade 12 - Trustworthy (ICT)', 'John Raeven', 'M', 16.00, 2.75, '2026-10-19'),
('100065849', 'asfe1231', '', '', '', 'Grade 12 - Trustworthy (ICT)', 'Cabillian', 'F', 46.00, 3.00, '2026-10-19'),
('100069751', 'alice15647', '', '', '', 'Grade 12 - Trustworthy (ICT)', 'Cagiwa', 'M', 24.00, 3.00, '2026-10-19'),
('100098765', '123456', 'Justine Ray', 'O', 'Biag', 'Grade 11 - Matthew (ABM)', 'Blobbles', 'N', 0.00, 0.00, '2026-10-29'),
('2000260236', '123456', 'Biag', 'O', 'Biag', 'Grade 11 - Matthew (ABM)', 'Bubbles', 'N', 0.00, 0.00, '2026-10-27');

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `ID` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `First_Name` varchar(255) NOT NULL,
  `Middle_Initials` varchar(255) NOT NULL,
  `Last_Name` varchar(255) NOT NULL,
  `Date_Joined` date DEFAULT NULL,
  `Subject` varchar(255) NOT NULL DEFAULT '',
  `Profile_Picture` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher`
--

INSERT INTO `teacher` (`ID`, `Password`, `First_Name`, `Middle_Initials`, `Last_Name`, `Date_Joined`, `Subject`, `Profile_Picture`) VALUES
('1000123456', '123456', 'Basics', 'B', 'Basics', '2026-10-27', '', NULL),
('15218', '$2y$10$r0vJ.I.xmoHQtKfi5/IvIuvXtGzHf4EIoKgViAabFJPHhuRz7E6Lq', 'Enrique', 'K', 'Dela Cruz', '2026-10-19', '', NULL),
('23512', 'Raven.Ashley14', 'Raven Ashley', 'H', 'Santiago', '2026-10-19', '', NULL),
('54321', 'asdf1234', 'Garcia', 'Q', 'Garcia', '2026-10-29', '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_content`
--

CREATE TABLE `teacher_content` (
  `Indicate` int(11) NOT NULL,
  `Exam` varchar(255) NOT NULL,
  `Choice1` varchar(255) NOT NULL,
  `Choice2` varchar(255) NOT NULL,
  `Choice3` varchar(255) NOT NULL,
  `Choice4` varchar(255) NOT NULL,
  `Answer` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teacher_content`
--

INSERT INTO `teacher_content` (`Indicate`, `Exam`, `Choice1`, `Choice2`, `Choice3`, `Choice4`, `Answer`) VALUES
(1, 'This is the sequence of statements that\'s intended to accomplish certain tasks.', 'Programming', 'Syntax', 'Computer program', 'Program', 'Computer program'),
(2, 'What is the process of planning and creating a program.', 'Programming', 'Computer program', 'Syntax', ' 	Assembler', 'Programming'),
(3, 'What is the language that is in charge if dealing with the computer\'s hardware?', 'High-level Languages', 'Low-level Languages', 'Machine Language', 'Assembly Language', 'Low-level Languages'),
(4, 'It is the most basic set of instructions that the computer can execute. Machine language programs', ' Interpreter', 'Assembler', 'Assembly Language', 'Machine Language', 'Machine Language'),
(5, 'This type of low-level languages can be read by people.', 'Assembly Language', ' Assembler', 'Machine Language', 'Compiler', 'Assembly Language'),
(6, 'What is the name of a program that can translate assembly language instructions into machine languag', 'Commands', 'Assembly Language', 'Assembler', 'Compiler', 'Assembler'),
(7, 'What kind of programming language uses natural language such as English language?', 'Machine Language', 'High-level Languages ', 'Low-level Languages', 'Computer program', 'High-level Languages '),
(8, 'This is what developers call the \"rules of the language\" what is it called?', 'Syntax', 'Compiler', 'Commands', 'Interpreter', 'Syntax'),
(9, 'What is the program statements that carries the tasks of the program called?', 'Syntax', 'Compiler', 'Commands', 'Interpreter', 'Commands'),
(10, 'What is the program that translates a program written in a High-level language to low-level language', 'Interpreter', 'Commands', 'Syntax', 'Compiler', 'Compiler'),
(11, 'What do you call the program that acts a compiler, but only translates one (1) program?', 'Compiler', 'Interpreter', 'Commands', 'Syntax', 'Interpreter'),
(12, 'What do you call the errors that can be encounter during the process of translation?', 'Type errors', 'Reference errors', 'Logical errors', 'Syntax errors', 'Syntax errors'),
(13, 'This only occurs when the expected output is not correct but the syntax is correct, what kind of err', 'Logical errors ', 'Reference errors', 'Type errors', 'Syntax errors', 'Logical errors '),
(14, 'What do they call the process of locating the errors of a program?', 'Algorithm', 'Coding', 'Debugging', 'Programming', 'Debugging'),
(15, 'It is a step-by-step problem-solving\r\nprocess in which a solution is arrived at in a finite amount o', ' Execution', 'Algorithm', 'Problem Analysis', 'Algorithm Design', 'Algorithm'),
(16, 'What step of algorithm does where the problem is being analyze and its solution requirements?', 'Algorithm Design', 'Algorithm', 'Execution', 'Problem Analysis', 'Problem Analysis'),
(17, 'What step does the deign of the algorithm usually formed to solve the problem?', 'Algorithm Design', 'Algorithm', 'Execution', 'Problem Analysis', 'Algorithm Design'),
(18, 'What step does an algorithm is implemented to the programming language?', 'Syntax', 'Debugging', 'Coding', 'Execution', 'Coding'),
(19, 'What step is focused on verification if the algorithm works?', 'Debugging', 'Execution', 'Coding', 'Syntax', 'Execution'),
(20, 'what is the method of algorithm where it describes algorithms using the combination of natural langu', 'C#', 'Flowchart', 'Java', 'Pseudocode', 'Pseudocode '),
(21, 'What does it call the operation that uses this symbols (+, -, *, /)?', 'Logical', 'Comparison', 'Assignment', 'Arithmetic operations ', 'Arithmetic operations '),
(22, 'What is the operation that is focus on assigning values to variables?', 'Logical', 'Comparison', 'Arithmetic operations ', 'Assignment', 'Assignment'),
(23, 'What is this operators called (=, ≠, <, >, ≤, ≥)?', 'Comparison', 'Assignment', 'Arithmetic', 'Logical', 'Comparison'),
(24, 'What is the operation that is focused on on combining, inverting, or comparing conditional statement', 'Logical ', 'Assignment', 'Comparison', 'Arithmetic', 'Logical'),
(25, 'What are the symbols used for arithmetic operation?', '+, -, *, /', '=', '=, ≠, <, >, ≤, ≥', '&&, ||', '+, -, *, /'),
(26, 'What symbol is used for assigning variable', '+, -, *, /', '=', '=, ≠, <, >, ≤, ≥', '&&, ||', '='),
(27, 'What symbol is used for comparing two (2) variables?', '+, -, *, /', '=, ≠, <, >, ≤, ≥', '&&, ||', '=', '=, ≠, <, >, ≤, ≥'),
(28, 'What is the two (2) logical operator used in psuedocode?', 'div, mul', 'and, or', 'not, xor', 'add, sub', 'and, or'),
(29, 'What are the keywords used as commands in pseudocode?', 'String, Int, and Char', 'PRINT, WRITE, READ, SET, GO TO', 'Class, public, and private', 'byte, long, double, and float', 'PRINT, WRITE, READ, SET, GO TO'),
(30, 'What is used to indicate branches and loops of instruction called?', 'Space', 'Indentation ', 'New line', 'Terminal block', 'Indentation '),
(31, 'What is the keyword used to show the output?', 'WRITE', 'PRINT', 'READ', 'SET', 'PRINT'),
(32, 'What is the keyword used to show the output?', 'PRINT', 'SET', 'WRITE', 'READ', 'WRITE'),
(33, 'What is the command that is used to capture input statement of user?', 'PRINT', 'SET', 'READ', 'WRITE', 'READ'),
(34, 'What command is used to initialize a variable or assign a value to a variable?', 'PRINT', 'WRITE', 'SET', 'READ', 'SET'),
(35, 'This tool representing algorithm contains shapes describing how an algorithm or program operates.', 'C#', 'Pseudocode', 'Java', 'Flowchart', 'Flowchart'),
(36, 'What is the the shape that is used to indicate the direction of the process flow?', 'Flow lines', 'Terminal block', 'Process', 'Data', 'Flow lines'),
(37, 'What shape is used to represent the beginning or end of a program?', 'Flow lines', 'Terminal block', 'Process', 'Data', 'Terminal block'),
(38, 'What shape is used to represent a process or activity such as computation?', ' Flow lines', 'Terminal block', 'Process', 'Data', 'Process'),
(39, 'What shape is used to store the data used as inputs or output?', 'Flow lines', 'Terminal block', 'Process', 'Data', 'Data'),
(40, 'What shape is used for decision making process?', 'Decision block', 'Connector', 'Predefined Process', 'Process', 'Decision block'),
(41, 'What shape is used to combine flow lines?', 'Decision block', 'Connector', 'Predefined Process', 'Process', 'Connector'),
(42, 'What shape is used to use algorithm outside of program?', 'Decision block', 'Connector', 'Predefined Process', 'Process', 'Predefined Process'),
(43, 'What do you call an approach used to analyze such complex problems by planning other software\'s?', 'Java', 'Object-Oriented Programming', 'Procedural Programming', 'Programming methodology', 'Programming methodology '),
(44, 'This approach is suitable only for small programs that have a low level of complexity.', 'Java', 'Object-Oriented Programming', 'Procedural Programming', 'Programming methodology ', 'Procedural Programming'),
(45, 'It deals with how to store data related to the entities, how the entities behave, and how they inter', 'Java', 'Object-Oriented Programming', 'Procedural Programming', 'Object-Oriented Programming', 'Object-Oriented Programming'),
(46, 'What do you call a high-level programming language that was developed by Sun Microsystems for general-purpose business applications?', 'Java', 'C#', 'C++', 'C', 'Java'),
(47, 'What do you call an environment that translates Java bytecode into machine language?', 'Java compiler', 'Java Environment Machine (JVM)', 'Java interpreter', 'Java Development Kit (JDK)', 'Java Environment Machine (JVM)'),
(48, 'This is created using a text editor or a development environment.', 'Java interpreter', 'Java compiler', 'Source code', 'Development Environment', 'Source code'),
(49, 'What do you call a set of tools that help write programs easily, such as NetBeans?', 'Java interpreter', 'Java compiler', 'Source code', 'Development Environment ', 'Development Environment'),
(50, 'What do you call a program that converts the source code into binary program of bytecode?', 'Java interpreter', 'Java compiler', 'Source code', 'Java compiler', 'Java compiler'),
(51, 'What do you call a program that checks the bytecode and communicates with the operating system, executing the bytecode instructions line by line within the Java?', 'Java interpreter', 'Java compiler', 'Source code', 'Java compiler', 'Java interpreter'),
(52, 'What do you call a java program that is a stand-alone program?', 'Windowed application', 'Console application ', 'Application ', 'Web Application', 'Application '),
(53, 'What do you call an application that supports character output to a computer screen in a DOS window?', 'Windowed application', 'Console application ', 'Application ', 'Web Application', 'Console application '),
(54, 'What do you call an application that creates a GUI with elements such as menus and button?', ' 	Console application ', 'Application ', 'Windowed  application', 'Web Application', 'Windowed application'),
(55, 'What do you call a program that is embedded in to a web page?', 'Applet', 'Kotlin', 'xcode', 'Lua', 'Applet'),
(56, 'What do you call a java programming that is used to group java codes?', 'Arguments ', 'class', 'main', 'Statement', 'class'),
(57, 'What do you call the keyword used to identify the class accessibility?', 'Arguments ', 'main', 'access  modifier', 'class', 'access modifier'),
(58, 'A Java class can only have one of what method?', 'Arguments ', 'access modifier', 'class', 'main', 'main'),
(59, 'What do you call an action that the program has to perform?', 'Statement', 'class', 'access modifier', 'main', 'Statement'),
(60, 'What do you call a information that is passed to a method so it can perform task?', 'Comments', 'Arguments ', 'access modifier', 'Keywords', 'Arguments '),
(61, 'What do you call a word that has predefined meaning and cant be used for naming?', 'Comments', 'Arguments ', 'Keywords', 'access modifier', 'Keywords'),
(62, 'Find the correct syntax of the main method.', 'int main(void){}', 'def main():', 'static void main(String[] args) { }', 'public static void main(String[] args) { }', 'public static void main(String[] args) { }'),
(63, 'What is the core software bundle used by developers to write, compile, debug, and run Java applications?', 'Java Environment Machine (JVM)', 'Java Development Kit (JDK)', 'Java Runtime Environment (JRE)', 'Development Environment', 'Java Development Kit (JDK)'),
(64, 'what is the software package that provides the files, class libraries, and the Java Virtual Machine (JVM) needed to run Java programs?', 'Java Runtime Environment (JRE) ', 'Java Environment Machine (JVM)', 'Java Runtime Environment (JRE)', 'Development Environment', 'Java Runtime Environment (JRE) '),
(65, 'What do you call a invalid statement that Java compiler encounter?', 'Reference errors', 'Logical errors', 'Syntax errors', 'Comments', 'Syntax errors'),
(66, 'What do you call a line of code that is ignored by the compiler and used to explain details in the program?', 'Reference errors', 'Logical errors', 'Syntax errors', 'Comments', 'Comments'),
(67, 'What do you call a comment that begins with // and can be placed anywhere in the line?', 'Multiple-character comments', 'Single-character comment', 'Multiple-line comments', 'Single-line comments', 'Single-line comments'),
(68, 'What do you call a comment that is enclosed between /* and */', 'Multiple-character comments', 'Multiple-line comments', 'Single-line comments', 'Single-character comment', 'Multiple-line comments'),
(69, 'What do single-line comments use to indicate that the line of code is a comment?', '[ ]', '{ }', '//', '/* and */', '// '),
(70, 'What do multiple-line comment use to indicate that the multiple line of code is a comment?', ' [ ]', '/* and */', '//', '{ }', '/* and */'),
(71, 'What is the collections of related classes that is grouped together into a folder called?', 'Packages', 'import', 'Java Development Kit (JDK)', 'Java Runtime Environment (JRE) ', 'Packages'),
(72, 'What is the reserved keyword in Java used to access the classes in a package called?', 'Data type', 'String', 'Packages', 'import', 'import'),
(73, 'What is the syntax for importing a package member?', 'import java.util.*;', 'import java.util.Date;', 'import java.util.File;', 'import java.util.Timer;', 'import java.util.Date;'),
(74, 'What is the syntax for importing all the classes in a particular package?', 'import java.util.Timer;', 'import java.util.Date;', 'import  java.util.*;', 'import java.util.File;', 'import java.util.*;'),
(75, 'What is used to specify the type  of value that a variable can hold?', 'Data type', 'Keywords', 'Arguments', 'Statement', 'Data type'),
(76, 'These are predefined data types by the language and named by a keyword.', 'Data type', ' Primitive data types', 'Arguments', 'Statement', 'Primitive data types'),
(77, 'What is the data type that can save memory space in a large array called?', 'float', 'int', 'byte', 'short', 'byte'),
(78, 'What is the data type that has a larger capacity than byte but do the same is called?', 'float', 'int', 'byte', 'short', 'short'),
(79, 'What is the data type that is generally as the default data type for integral values?', 'float', 'int', 'byte', 'short', 'int'),
(80, 'What is the data type that is being used because of its wider range than int called?', 'float', 'byte', ' long', 'short', 'long'),
(81, 'What do you call the data type that is used to save large memory of arrays of floating-point numbers?', 'float', 'int', 'byte', 'short', 'float'),
(82, 'What is the default data type being used for decimal values?', 'float', 'int', 'double', 'short', 'double'),
(83, 'What data type only has two (2) values?', 'varchar', 'String', 'char', 'boolean', 'boolean'),
(84, 'What data type stores a single character only?', 'char', 'String', 'varchar', 'boolean', 'char'),
(85, 'What is the name for a memory location that stores a specific value such as numbers and letters?', 'Argument', 'Variable', 'Constant', 'final', 'Variable'),
(86, 'What is the memory location whose value cannot be changed during program execution?', 'Argument', 'final', 'Constant', 'Variable', 'Constant'),
(87, 'What is the keyword used to fixate the value stored in a variable_name?', 'Argument', 'Variable', 'Data type', 'final', 'final'),
(88, 'What do you call the conversion of value from a specific type to a variable of another type?', 'Narrowing conversion (explicit casting)', ' 	Widening conversion (implicit casting)', 'coercion', 'Type casting', 'Type casting '),
(89, 'What do you call a conversion from lower to higher precision data type?', 'Narrowing conversion (explicit casting)', 'Widening conversion (implicit casting)', 'coercion', 'Type casting', 'Widening conversion (implicit casting)'),
(90, 'What do you call a conversion from higher to lower precision data type?', 'Narrowing conversion (explicit casting)', 'Narrowing conversion (explicit casting)', 'coercion', 'Type casting', 'Narrowing conversion (explicit casting)'),
(91, 'What do you call a specific symbols used in programming language?', 'Equation', 'Formula', 'Expression', 'Operators', 'Operators'),
(92, 'What operator is used to perform mathematical operation?', 'Arithmetic operators', 'Logical operators', 'Assignment operators', 'Comparison operators', 'Arithmetic operators'),
(93, 'What do you call the value on the either side of an operator?', 'parameter', 'argument', 'operand', 'statement', 'operand'),
(94, 'What is the arithmetic operator used to add two (2) or more operand?', '- ', '/', '+', '+', '+'),
(95, 'What is the arithmetic operator used to subtract two (2) or more operand?', '- ', '/', '- ', '%', '- '),
(96, 'What is the arithmetic operator used to multiply two (2) or more operand?', '- ', '*', '+', '%', '*'),
(97, 'What is the arithmetic operator used to divide two (2)?', '/', '/', '+', '%', '/'),
(98, 'What is the arithmetic operator used to find the remainder of two (2) operand?', '- ', '%', '+', '+', '%'),
(99, 'What do you call when either or both of the operand is a floating-point value and the result is a floating-point value?', 'Extenal division', 'Intenal division', 'Floating-point division', 'Integer division ', 'Floating-point division'),
(100, 'What do you call a division where both operand and the result is an integer?', 'Extenal division', 'Intenal division', 'Floating-point division', 'Integer division ', 'Integer division ');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`Name`);

--
-- Indexes for table `admin_content`
--
ALTER TABLE `admin_content`
  ADD PRIMARY KEY (`Indicate`);

--
-- Indexes for table `content_v1`
--
ALTER TABLE `content_v1`
  ADD PRIMARY KEY (`Indicate`);

--
-- Indexes for table `content_v2`
--
ALTER TABLE `content_v2`
  ADD PRIMARY KEY (`Indicate`);

--
-- Indexes for table `pre-post_test`
--
ALTER TABLE `pre-post_test`
  ADD PRIMARY KEY (`Chapter`);

--
-- Indexes for table `section`
--
ALTER TABLE `section`
  ADD PRIMARY KEY (`Name`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `teacher_content`
--
ALTER TABLE `teacher_content`
  ADD PRIMARY KEY (`Indicate`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_content`
--
ALTER TABLE `admin_content`
  MODIFY `Indicate` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `content_v1`
--
ALTER TABLE `content_v1`
  MODIFY `Indicate` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `content_v2`
--
ALTER TABLE `content_v2`
  MODIFY `Indicate` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `pre-post_test`
--
ALTER TABLE `pre-post_test`
  MODIFY `Chapter` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teacher_content`
--
ALTER TABLE `teacher_content`
  MODIFY `Indicate` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
