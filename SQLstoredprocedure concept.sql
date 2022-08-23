-- stored proc syntax without parameters

/* create / alter procdure procdurename
as
begin
pdrodurce body like quries
end */


-- stored proc with parameters

/* create/alter proc procname
{
  @param1 datatype,
  @param2,datatype,
  @param3, datatype }

as
begin
proc body
end  */



-- to call sp

/*
 exec procname values
or
 executive procname values
or
 procname values
 */

 -- basic sp procdure example 
 create procedure spwelcome
 as
 begin 
   print 'HELLO ALL, WELCOME TO STORED PROCEDURE CONCEPT'
 end


 -- we have successfully created stored procedure spwelcome now we see the out by call spwelcome

 exec spwelcome  /* by calling exec command */
 or
 spwelcome  /* directlycalling with stored proc name */


 -- Create Employee Table
CREATE TABLE spexampleEmployee1
(
  ID INT PRIMARY KEY,
  Name VARCHAR(50),
  Gender VARCHAR(50),
  DOB DATETIME,
  DeptID INT
)
GO

-- Populate the Employee Table with test data
INSERT INTO spexampleEmployee1 VALUES(1, 'Pranaya', 'Male','1996-02-29 10:53:27.060', 1)
INSERT INTO spexampleEmployee1 VALUES(2, 'Priyanka', 'Female','1995-05-25 10:53:27.060', 2)
INSERT INTO spexampleEmployee1 VALUES(3, 'Anurag', 'Male','1995-04-19 10:53:27.060', 2)
INSERT INTO spexampleEmployee1 VALUES(4, 'Preety', 'Female','1996-03-17 10:53:27.060', 3)
INSERT INTO spexampleEmployee1 VALUES(5, 'Sambit', 'Male','1997-01-15 10:53:27.060', 1)
INSERT INTO spexampleEmployee1 VALUES(6, 'Hina', 'Female','1995-07-12 10:53:27.060', 2)
GO


create procedure spgetemp
as 
begin
 select id, name, DOB from spexampleEmployee1
end

spgetemp

-- How to View the text of a Stored Procedure in SQL Server?
sp_helptext spgetemp

--alter to change the stored procdure body

alter procedure spgetemp
as
begin
 select  name, dob,gender
 from spexampleemployee1
 order by gender,name
end

spgetemp

-- to alte or rename procedure name 

exec sp_rename 'spgetemp', 'spgetemployeedetails'

spgetemployeedetails

-- Stored Procedure for adding two variables value

create procedure spaddtwonumbers
( @no1 int,
  @no2 int )
as
begin
 declare @result int
 set @result=@no1 + @no2
 print @result
end

spaddtwonumbers @no1=200,@no2=300

or 

exec spaddtwonumbers 100,200

--Stored Procedure with Output Parameter
 create procedure spgetempwithoutpara
 (
 @no1 int ,
 @no2 int ,
 @result int output )
as
begin 
 set @result = @no1 + @no2
end

declare @result int
exec spgetempwithoutpara 10,20 , @result out
print @result

--examples for a better understanding of SQL Server stored procedure output parameters.

CREATE PROCEDURE spGetEmployeeCountByGender
( @gender varchar(20),
  @employeecount int output )
as
begin 
select @employeecount = count(id)
from spexampleemployee1
where gender = @gender
end

-- exec above sp
declare @employeecount int
exec spGetEmployeeCountByGender 'female', @employeecount out
print @employeecount

select * from spexampleemployee1



-- to check whether it print null or not check the following query

declare @employeecount int
exec spGetEmployeeCountByGender 'male',@employeecount out
if (@employeecount is null)
 print ' NULL VALUES ARE ACCEPTED IN SP'
else
 print cast(@employeecount as varchar) + ' IS THE COUNT OF EMPOYEES'

-- FOLLOW THE ORDER WHILE ENTER PARAMETERS OR ELSE MENTION THE COLUMMN NAME LIKE THIS

DECLARE @EmployeeTotal INT
EXECUTE spGetEmployeeCountByGender @EmployeeCount = @EmployeeTotal OUTPUT, @Gender ='Male'
PRINT @EmployeeTotal 



-- What are Temporary Stored Procedures in SQL Server?

/* The stored procedures which are created temporarily in a database , 
the stored procedures which are not stored permanently in a database are called temporary stored procedures. 
The SQL Server Temporary Stored Procedures are of two types such as

Private/Local Temporary Stored Procedure
Public/Global Temporary Stored Procedure. */

/* When we created the stored procedure by using the # prefix before the stored procedure name 
then it is called Local or Private Temporary Stored Procedure.*/

--syntax for temp stored procdure 

/* create procedure #procname
as
begin
  procedure BODY
end  */

create procedure #sptempprocedure
as 
begin
  print ' this is a temp stored procedure'
end

-- exec temp stored procedure

#sptempprocedure 

or 

exec #sptempprocedure

--  what is a Public/Global Temporary Stored Procedures?

/* Whenever the stored procedure is created by using the ## prefix then it is called Global Temporary Procedure in SQL Server.
The Global temporary stored procedures are accessed by other connections in SQL Server */

-- syntax for global temporary stored procdure

CREATE PROCEDURE ##GlobalProcedue
AS
BEGIN
  PRINT 'This is Global Temporary Procedure'
END

-- Calling the Global Temporary Procedure
EXEC ##GlobalProcedue


-- What is the use of Temporary Stored Procedure?
-- The Temporary Stored Procedures are useful when you are connecting to the earlier versions of 
-- SQL Server that do not support the reuse of execution plans for Transact-SQL statements or batches.