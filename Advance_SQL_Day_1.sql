USE RISEJULY2025

-- ADVANCE SQL DAY 1 --
/*
TOPIC COVERED:
1. STORE PROCEDURE (SP)

*/

/*
STORE PROCEDURE (SP): Wrapping a query into a specific name

- In simple way Store Procedure is a way to hide some procedure
behind some specific name.

Syntex Type 1 (Simple SP):
CREATE PROCEDURE <SP_NAME>
AS
BEGIN
{YOUR QUERY}
END
*/

-- Example:
CREATE PROCEDURE spEMP_SALARY
AS
BEGIN
SELECT ENAME,ESALARY FROM EMPTABLE
END


/* DISPLAYING SP BY DIFFRENT METHODS */
-- METHOD 1
spEMP_SALARY

-- METHOD 2
EXEC spEMP_SALARY

-- METHOD 3
EXECUTE spEMP_SALARY


/* SHOWIN DETAILS OF STORE PROCEDURE LIKE SYNTAX AND HIDDEN QUERY */
SP_HELPTEXT spEMP_SALARY
SP_HELP spEMP_SALARY
SP_DEPENDS spEMP_SALARY


/* ALTERING A STORE PROCEDURE */
ALTER PROCEDURE spEMP_SALARY
WITH ENCRYPTION -- Use to restrict the detail access
AS
BEGIN
SELECT EID,ENAME,ESALARY FROM EMPTABLE
END


SP_HELPTEXT spEMP_SALARY -- Will not show any details after encryption
SP_HELP spEMP_SALARY -- still work
SP_DEPENDS spEMP_SALARY -- still work


/* Dropping the Store Procedure */
DROP PROC spEMP_SALARY
-- drop procedure <procedure_name>

/* TYPE-2 SP: PARAMETERISED STORE PROCEDURE (With Input Parameter) */
CREATE PROCEDURE spEmployeeDetails
@EmpID INT
AS
BEGIN
	SELECT * FROM EMPTABLE
	WHERE EID = @EmpID
END

-- Show Parameterised Store Procedure
spEmployeeDetails 101

EXEC spEmployeeDetails 108

EXECUTE spEmployeeDetails 104

/*
ADVANTAGES OF STORE PROCEDURE:
- REUSABILITY
- PERFORMANCE
- SECURITY
- REDUCES NETWORK TRAFFIC
*/



/* TYPE-3: USING OUTPUT PARAMETER */
CREATE PROCEDURE spTotalEmployee
@DEPT VARCHAR(255),
@EMPCOUNT INT OUTPUT -- STORING OUTPUT IN VARIABLE (ALSO WE CAN USE 'OUT')
AS
BEGIN
	SELECT @EMPCOUNT = COUNT(EID), DID FROM EMPTABLE
	WHERE EDEP = @DEPT
END
---------------------------------------------------------------------------------------------------
-- Displayng Output Parameter SP --
-- METHOD-1
DECLARE @TOTAL_COUNT INT
EXECUTE spTotalEmployee 'QA',
	@TOTAL_COUNT OUTPUT
PRINT @TOTAL_COUNT

-- METHOD-2
DECLARE @TOTAL_COUNT INT
EXECUTE spTotalEmployee 'QA',
	@TOTAL_COUNT OUTPUT
SELECT @TOTAL_COUNT AS TOTAL_EMPLOYEES

--- STORE PROCEDURE USING VARCHAR AS AN OUTPUT ---------------------------------------------------
CREATE PROCEDURE SP_EMP_DEPT
@EID INT ,
@DEP_NAME VARCHAR(50) OUTPUT -- STORING OUTPUT IN VARIABLE (ALSO WE CAN USE 'OUT')
AS
BEGIN
	SELECT @DEP_NAME = EDEP FROM EMPTABLE
	WHERE EID = @EID
END

DECLARE @DEPARTMENT VARCHAR(50)
EXECUTE SP_EMP_DEPT 104,
	--@DEPARTMENT OUTPUT
	@DEP_NAME = @DEPARTMENT OUTPUT
SELECT @DEPARTMENT

---------------------------------------------------------------------------------------------------
SELECT * FROM EMPTABLE

SELECT name FROM SYS.tables

SELECT NAME FROM SYS.procedures