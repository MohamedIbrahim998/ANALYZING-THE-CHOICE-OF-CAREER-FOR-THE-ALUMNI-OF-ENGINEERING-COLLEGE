/*1. Create new schema as alumni.*/

CREATE DATABASE alumni;
---------------------------------------------------------------------------------------------------------
/*2. Import all .csv files into MySQL */

-- All files data imported   --- SCREEN SHOT ATTACHED 
---------------------------------------------------------------------------------------------------------
/*3. Run SQL command to see the structure of six tables.*/

USE alumni;
DESC college_a_hs;
DESC college_a_se;
DESC college_a_sj;
DESC college_b_hs;
DESC college_b_se;
DESC college_b_sj;
----------------------------------------------------------------------------------------------------------
/*4. Display first 1000 rows of tables (college_A_HS, college_A_SE, college_A_SJ, College_B_HS, College_B_SE,
College_B_SJ) with Python.*/

-- IN PYTHON FILE
-----------------------------------------------------------------------------------------------------------
/*5.Import first 1500 rows of tables (College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE,
College_B_SJ) into MS Excel.*/

-- IN EXCEl FILE
-----------------------------------------------------------------------------------------------------------
/*6. Perform data cleaning on table College_A_HS and store cleaned data in view College_A_HS_V, Remove 
null values.*/

CREATE VIEW college_a_hs_v AS SELECT * FROM college_a_hs WHERE RollNo IS NOT NULL AND LastUpdate 
IS NOT NULL AND Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND Batch
IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND HSDegree IS NOT NULL AND EntranceExam
IS NOT NULL AND Institute IS NOT NULL AND Location IS NOT NULL ;

SELECT * FROM college_a_hs_v;
-----------------------------------------------------------------------------------------------------------
/*7. Perform data cleaning on table College_A_SE and store cleaned data in view College_A_SE_V, Remove
null values.*/

CREATE VIEW college_a_se_v AS SELECT * FROM college_a_se WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL AND
Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL
AND PresentStatus IS NOT NULL AND Organization IS NOT NULL AND Location IS NOT NULL;

SELECT * FROM college_a_se_v;
-----------------------------------------------------------------------------------------------------------
/*8.Perform data cleaning on table College_A_SJ and store cleaned data in view College_A_SJ_V, Remove null
values.*/

CREATE VIEW college_a_sj_v AS SELECT * FROM college_a_sj WHERE ROllNo IS NOT NULL AND LastUpdate IS NOT NULL AND
Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT 
NULL AND PresentStatus IS NOT NULL AND Organization IS NOT NULL AND Location IS NOT NULL;

SELECT * FROM college_a_sj_v;
------------------------------------------------------------------------------------------------------------
/*9. Perform data cleaning on table College_B_HS and store cleaned data in view College_B_HS_v, Remove null
values.*/

CREATE VIEW college_b_hs_v AS SELECT * FROM college_b_hs WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL
AND Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND Branch IS NOT NULL AND Batch
IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND HSDegree IS NOT NULL AND EntranceExam
IS NOT NULL AND Institute IS NOT NULL AND Location IS NOT NULL;

SELECT * FROM college_b_hs_v;
-------------------------------------------------------------------------------------------------------------
/*10. Perform data cleaning on table College_B_SE and store cleaned data in view College_B_SE_V, Remove null
values.*/

CREATE VIEW college_b_se_v AS SELECT * FROM college_b_se WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL
AND Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND Branch IS NOT NULL AND Batch
IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND Organization IS NOT NULL AND Location IS
NOT NULL;

SELECT * FROM college_b_se_v;
--------------------------------------------------------------------------------------------------------------
/*11. Perform data cleaning on table College_B_SJ and store cleaned data in view College_B_SJ_V, Remove
null values.*/

CREATE VIEW college_b_sj_v AS SELECT * FROM college_b_sj WHERE RollNo IS NOT NULL AND LastUpdate IS NOT NULL
AND Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND Branch IS NOT NULL AND Batch
IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND Organization IS NOT NULL AND Designation
IS NOT NULL AND Location IS NOT NULL;

SELECT * FROM college_b_sj_v;
--------------------------------------------------------------------------------------------------------------
/*12. Make procedure to use string functions for converting record of Name FatherName, MotherName into lovers
case for views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) */

delimiter /
CREATE PROCEDURE hs1()
BEGIN
SELECT LOWER(Name) name,LOWER(FatherName) fathername,LOWER(MotherName) mothername
FROM college_a_hs_v;
END /
delimiter ;
CALL hs1();

delimiter /
CREATE PROCEDURE se1()
BEGIN
SELECT LOWER(Name) name,LOWER(FatherName) fathername,LOWER(MotherName) mothername
FROM college_a_se_v;
END /
delimiter ;
CALL se1();

delimiter /
CREATE PROCEDURE sj1()
BEGIN
SELECT LOWER(Name) name,LOWER(FatherName) fathername,LOWER(MotherName) mothername
FROM college_a_sj_v;
END /
delimiter ;
CALL sj1();

delimiter /
CREATE PROCEDURE hs2()
BEGIN
SELECT LOWER(Name) name,LOWER(FatherName) fathername,LOWER(MotherName) mothername
FROM college_b_hs_v;
END /
delimiter ;
CALL hs2();

delimiter /
CREATE PROCEDURE se2()
BEGIN
SELECT LOWER(Name) name,LOWER(FatherName) fathername,LOWER(MotherName) mothername
FROM college_b_se_v;
END /
delimiter ;
CALL se2();

delimiter /
CREATE PROCEDURE sj2()
BEGIN
SELECT LOWER(Name) name,LOWER(FatherName) fathername,LOWER(MotherName) mothername
FROM college_b_sj_v;
END /
delimiter ;
CALL sj2();
--------------------------------------------------------------------------------------------------------------------
/*13. Import the created views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V,
College_B_SE_V, College_B_SJ_V) into MS Excel and make pivot chart for location of Alumni.*/

-- IN EXCEL FILE
--------------------------------------------------------------------------------------------------------------------
/*14. Write a query to create procedure get_name_college A using the cursor to fetch names of all students from college
A.*/

DELIMITER //
CREATE PROCEDURE get_name_collegeA(INOUT n TEXT(20000))
BEGIN
    DECLARE finished INT DEFAULT 0;
    DECLARE namelist VARCHAR(400) DEFAULT '';
    
    DECLARE namedetails CURSOR FOR
        SELECT Name FROM college_a_hs
        UNION
        SELECT Name FROM college_a_se
        UNION
        SELECT Name FROM college_a_sj;
        
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    
    OPEN namedetails;
    GETNAME:
    LOOP
        FETCH namedetails INTO namelist;
        IF finished = 1 THEN
            LEAVE GETNAME;
		END IF ;
        
        SET n = CONCAT(namelist,';',n);
	END LOOP GETNAME;
    CLOSE namedetails;
END //
DELIMITER ;

SET @nm1=' ';
CALL get_name_collegeA(@nm1) ;
SELECT @nm1 get_name_collegeA;
---------------------------------------------------------------------------------------------------------------------
/*15. Write a query to create procedure get_name_collegeB using the cursor to fetch names of all students from college B.*/

DELIMITER $$
CREATE PROCEDURE get_name_collegeB(INOUT n TEXT(20000))
BEGIN
      DECLARE finished INT DEFAULT 0;
	DECLARE namelist VARCHAR(400) DEFAULT '';
    
    DECLARE namedetails CURSOR FOR
            SELECT Name FROM college_b_hs
            UNION
            SELECT Name FROM college_b_se
            UNION
            SELECT Name FROM college_b_sj;
            
	  DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished =1;
	
    OPEN namedetails;
    GETNAME:
    LOOP
            FETCH namedetails INTO namelist;
		IF finished = 1 THEN
                  LEAVE GETNAME;
			END IF;
            
		SET n = CONCAT(namelist,';',n);
	   END LOOP GETNAME;
	  CLOSE namedetails;
END $$
DELIMITER ;

SET @nm2=' ';
CALL get_name_collegeB(@nm2);
SELECT @nm2 get_name_collegeB;
-------------------------------------------------------------------------------------------------------------------
/*16. Calculate the percentage of career choice of college A and College B Alumni --(w.r.t Higher Studies, Self Employed
and Service/Job) Note: Approximate percentges are considered for career choices.*/

SELECT 'Higher Studies',(COUNT(college_a_hs.Rollno)/(college_a_hs.Rollno))*100 CollegeA_percentage,
(COUNT(college_b_hs.Rollno)/(college_b_hs.Rollno))*100 CollegeB_percentage FROM college_a_hs CROSS JOIN college_b_hs
UNION
SELECT 'Self Employment',(COUNT(college_a_se.Rollno)/(college_a_se.Rollno))*100 CollegeA_percentage,
(COUNT(college_b_se.Rollno)/(college_b_se.Rollno))*100 CollegeB_percentage FROM college_a_se CROSS JOIN college_b_se
UNION
SELECT 'Service/Job',(COUNT(college_a_sj.Rollno)/(college_a_sj.Rollno))*100 CollegeA_percentage,
(COUNT(college_b_sj.Rollno)/(college_b_sj.Rollno))*100 CollegeB_percentage FROM college_a_sj CROSS JOIN college_b_sj;

