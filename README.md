
# SQL Practice Queries (Beginner to Advance)

This repository contains a collection of SQL queries and scripts performed during a **Full Stack Developer internship at Rishabh Software**, Vadodara, Gujarat. It serves as a comprehensive guide and practice log, progressing from fundamental database concepts to advanced SQL programming and query optimization.

## 📂 Repository Structure & Daily Breakdown

The repository is organized by "Days" representing the learning progression, along with specific practice tasks and mini-projects.

### 🟢 Beginner to Intermediate SQL

  * **[Day 1: Basics & DDL]**
      * Creating, altering, and dropping databases and tables.
      * Data Definition Language (DDL) operations.
      * Basic `INSERT`, `UPDATE`, and `DELETE` operations.
  * **[Day 2: Filtering & Operators]**
      * `WHERE` clause filtering.
      * Logical Operators (`AND`, `OR`, `NOT`).
      * Comparison Operators (`BETWEEN`, `IN`, `LIKE`, `IS NULL`).
      * Set Operators (`UNION`, `UNION ALL`, `INTERSECT`, `EXCEPT`).
  * **[Day 3: Constraints & Aggregation]**
      * Table Constraints: `IDENTITY`, `CHECK`, `DEFAULT`, `NOT NULL`, `UNIQUE`.
      * Aggregate Functions: `COUNT`, `SUM`, `MAX`, `MIN`, `AVG`.
      * `GROUP BY` clauses.
  * **[Day 4: Keys & Dates]**
      * Primary Key and Foreign Key relationships.
      * Cascading actions (`ON UPDATE CASCADE`, `ON DELETE CASCADE`).
      * Date and Time functions (`GETDATE`, `DATETIME`).
      * `HAVING` clause usage.
  * **[Day 5: Subqueries]**
      * Nested queries (Subqueries).
      * Finding Nth highest/lowest records using subqueries and `OFFSET-FETCH`.
  * **[Day 6: Joins (ANSI)]**
      * Inner Join, Left Join, Right Join, Full Join.
      * Exclusive Joins (Left/Right/Full Exclusive).
      * Cross Join.
  * **[Day 7: Joins (Non-ANSI) & Self Join]**
      * Equi Joins and Non-Equi Joins.
      * Self Joins (joining a table to itself).
  * **[Day 8: Complex Joins Practice]**
      * Real-world scenarios using Employee, Manager, Department, and Project tables.
      * Advanced joining logic (e.g., finding employees not working on any project).
  * **[Day 9: Views]**
      * Creating, Altering, and Dropping Views.
      * Understanding Views as virtual tables for security and simplification.
  * **[Day 10: Indexing]**
      * Clustered vs. Non-Clustered Indexes.
      * Unique Indexes.
      * Performance implications of indexing.

-----

### 🔴 Advanced SQL

  * **[Advance Day 1: Stored Procedures]**
      * Creating basic Stored Procedures.
      * Parameterized SPs (Input parameters).
      * Output Parameters (`OUTPUT`).
      * SP Encryption and Security.
  * **[Advance Day 2: Triggers]**
      * DML Triggers (`FOR INSERT`, `FOR UPDATE`, `FOR DELETE`).
      * Audit Tables: Automatically tracking changes and salary history.
      * `INSTEAD OF` Triggers (for Views).
      * DDL Triggers (Preventing `CREATE` or `DROP` table on Database/Server scope).
      * Transaction control (`ROLLBACK`).
  * **[Query Optimization]**
      * `IF EXISTS` for safe updates/deletes.
      * Handling NULLs with `ISNULL()`.
      * **CTEs (Common Table Expressions)** for temporary result sets and readability.

-----

### 📝 Practice Tasks & Case Studies

This repo includes extensive case studies to apply the learned concepts:

1.  **Railway Booking System [PRACTICE\_TASK\_2.sql]**

      * **Schema:** `Trains`, `Passengers`, `Reservation`.
      * **Scope:** A massive set of **75+ practice queries** covering everything from basic filtering to complex aggregations, joins, and analytical questions about railway data.

2.  **Student Management System [PRACTICE\_TASK\_1.sql]**

      * **Schema:** `Students`, `Courses`, `Enrollments`, `Grades`.
      * **Scope:** Managing course enrollments, calculating grades, and student analytics.

3.  **Customer Orders Analysis**

      * Found in `Day_1_Task.sql` and `DAY_7_TASK.sql`.
      * Focuses on Customer and Order relationships, revenue calculation, and finding top-spending customers.

-----

## 🛠️ Key Concepts Covered

  - **DDL & DML**: Create, Alter, Drop, Insert, Update, Delete.
  - **Data Integrity**: Primary/Foreign Keys, Constraints (Check, Unique, Default).
  - **Querying**: Joins (Inner, Outer, Self, Cross), Set Operators, Subqueries, CTEs.
  - **Programmability**: Stored Procedures, Triggers (After, Instead Of), Views.
  - **Optimization**: Indexing, Exists, Transaction Management.

## 🚀 How to Use

1.  Open SQL Server Management Studio (SSMS).
2.  Create the practice databases as specified in the scripts (e.g., `RISEJULY2025`, `RISE_TASKS_1`).
3.  Execute the script files sequentially to recreate the tables and run the examples.

-----

*Author: Sheshang Zalamakwana*
