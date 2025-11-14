use RISEJULY2025

create table sales(
	product_id int,
	product_name varchar(255),
	price money,
	quantity int,
	region int,
)

-- CHANGE OR UPDATE DATATYPES OF THE TABLE --
ALTER TABLE sales
ALTER COLUMN region VARCHAR(10)

insert into sales values
(101,'mobile',50000,5,'vadodara'),
(102,'tablet',20000,15,'anand'),
(103,'laptop',70000,5,'ahemdabad'),
(104,'gaming_pc',40000,2,'rajkot'),
(105,'earbuds',2500,50,'vadodara')

insert into sales values
(105,'mobile',100000,2,'anand')

-- where clause filter --
select * from sales
where product_name = 'mobile'

-- And operator --
select * from sales
where product_name = 'mobile' and quantity = 5

-- Or operator --
select * from sales
where quantity = 5 or region = 'anand'

-- And & Or togather operator --
select * from sales
where (product_id = 105 and region = 'vadodara') or product_name = 'mobile'

-- Between operator --
select * from sales
where product_id between 102 and 104

-- In operator --
select * from sales
where product_name in ('mobile', 'tablet')

-- Arithmetic operators --
-- * operator --
select product_name, price, quantity, (price*quantity) as total_sales from sales

-- < : less then --
select product_name, price from sales
where price < 50000

-- <= : less then or equals to --
select product_name, price from sales
where price <= 50000

-- > : grater then --
select product_name, price from sales
where price > 2500

-- >= : grater then or equals to --
select product_name, price from sales
where price >= 2500

-- = : euqals to --
select product_name, price from sales
where price = 2500

-- <> : not euqals to --
select product_name, price from sales
where price <> 2500

select * from EMPTABLE

-- adding on more column in employee table --
alter table emptable
add email_id varchar(255)

-- adding entries in email_id --
update EMPTABLE
set email_id = 'rise2025@xyz.com'
where EID in (103,104)

-- finding and email id which have specific text using like --
select * from EMPTABLE
where email_id like '%@xyz.com'

-- finding employee name which has h latter in his/her name -- 
select * from EMPTABLE
where ENAME like '%h'

-- is null : rows with no emails --`
select * from EMPTABLE
where email_id is null

-- is not null : only rows with email --
select * from EMPTABLE
where email_id is not null

-- SET Operators --
-- Union, Union All, Intersect, Except --
-- 1. Number of columns must be same in all the columns. --
-- 2. Order of the column must be same. --
-- 3. Datatype must be same. --

create table Bank_Vadodara
(
	Bank_Id int,
	Bank_Name varchar(20),
	Bank_Location varchar(20)
)

insert into Bank_Vadodara values
(101,'SBI','Atladra'),
(102,'HDFC','Sunpharma'),
(103,'BOB','Manjalpur')

create table Bank_Surat
(
	Bank_Id int,
	Bank_Name varchar(20),
	Bank_Location varchar(20)
)

insert into Bank_Surat values
(101,'SBI','Atladra'),
(102,'HDFC','Varacha'),
(103,'BOB','Udhana')

select * from Bank_Vadodara
select * from Bank_Surat

-- Union : Without Duplicate Combine --
-- Method 1 --
select * from Bank_Vadodara
Union
select * from Bank_Surat

-- Method 2 --
select Bank_Id, Bank_Name from Bank_Vadodara
Union
select Bank_Id, Bank_Name from Bank_Surat

-- Union All : With Duplicate Combine --
select * from Bank_Vadodara
Union All
select * from Bank_Surat

-- Intersect : Matching Rows --
select * from Bank_Vadodara
Intersect
select * from Bank_Surat

-- Except : Present Only in One table --
select * from Bank_Vadodara
Except
select * from Bank_Surat