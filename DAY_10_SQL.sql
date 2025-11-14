USE RISEJULY2025

-- INDEX
-- CLUSTERED 
-- SYNTAX: CREATE INDEX <INDEX_NAME>
--			ON <TABLE_NAME(COLUMN_NAME)>

-- TYPE OF INDEX: NONCLUSTERED, CLUSTERED, UNIQUE
-- 1. CLUSTERED INDEX
-- Definition: Sorts and stores the actual data rows in the table based on the index key.
-- Only one allowed per table.
-- The table itself is physically ordered by this index.
-- Default index on PRIMARY KEY (unless specified otherwise).
-- When you frequently query using ORDER BY or range filters on a column.

-- 2. NONCLUSTERED INDEX
-- Definition: Creates a separate structure from the table data.
-- Points to the data rows using row locators (e.g., RID or Clustered Index key).
-- You can have many nonclustered indexes on a table.
-- Best for search on non-primary columns or frequently used WHERE conditions.

-- 3. UNIQUE INDEX
-- Definition: Ensures that all values in the index key column(s) are distinct.
-- Can be Clustered or Nonclustered.
-- Automatically created with UNIQUE constraints.
-- Enforce data integrity on columns like Email, Username, etc.

CREATE NONCLUSTERED INDEX IX_EMP5_SALARY
ON EMP5 (ESALARY)

SELECT ESALARY FROM EMP5
SELECT * FROM EMP5

SELECT ENAME,ESALARY FROM EMP5
WHERE ESALARY > 20000 -- CONDITION SHOULD BE THERE TO SHOW THE INDEX ORDER

DROP INDEX EMP5.IX_EMP5_SALARY

SP_HELPINDEX EMP5