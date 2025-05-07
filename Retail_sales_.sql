create table Retail_Sales_data(
  transactions_id int primary key,
  sale_date date, 
  sale_time time,
  customer_id int,
  gender Varchar (50),
  age int,
  category varchar (50),
  quantiy int ,
  price_per_unit float,
  cogs float,
  total_sale float
)
select * from Retail_Sales_data

copy
Retail_Sales_data(transactions_id,sale_date,sale_time,customer_id,gender,age,category,quantiy,price_per_unit,cogs,total_sale)
from 'D:\Retail SQL Project\SQL - Retail Sales Analysis_utf .csv'
delimiter ','
csv header;

-- data Cleaning

select * from Retail_Sales_data
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null

-- Data Exploration

delete from Retail_Sales_data
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null

--q1) How many sales we have ?
 select sum(total_sale) as Total_revenue
 from Retail_Sales_data

--Q2) How many unique  Customers We have ? 
  select count (distinct customer_id) as Total_customers from Retail_Sales_data

--Q3) write  a sql query to retirved all column for sales made on '2022-11-05'
   select * from Retail_Sales_data
   where sale_date = '2022-11-05'

--Q4) Write a sql query to retivred all transations where the category is 'Cloting' and the qyantity sold is more 4 in the month of nov 2022
    SELECT * 
FROM Retail_Sales_data
WHERE category = 'Clothing' 
  AND quantiy >= 4  
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

--5) write a sql query to calcuate the total sales ( Total_sale ) for Each Category 
  select category, sum(total_sale) as Total_sales_By_category
  from Retail_Sales_data
  group by category

--6)  Write a  sql query to find the average age  of customers who purchased from 'Beauti' category 
  select  round( avg(age)) as Average_age
   from Retail_Sales_data
  where category = 'Beauty'
  
--7) Write Sql Query to find all transations where the total_sale is grether than 1000
     select * from Retail_Sales_data
	 where total_sale > 1000

--8) write sql query to find the total of transation ( Transation_id ) made by each gender in each cateogry
    select
	  category, 
	  gender,
	  count(*) as Total_tras
	  from Retail_Sales_data
	  group by
	   category,
	   gender
	   order by 1

--9) write sql query to calcuate the average sale of each month . find out the best selling month in each month
     select
	 extract (year from sale_date) as year ,
	 extract (month from sale_date) as month, 
	  round (avg(total_sale)) as total_sales
	 from Retail_Sales_data
	 group by 1, 2
	 order by 1 , 3 desc

--10) write sql query to find the top 5 customers based on the highest total
   select  customer_id,
    sum(total_sale) as Total_sales
   from Retail_Sales_data
   group by 1
   order by 2 desc limit(5)

 --11) write sql query to find the number of unique customers who puchased item from each category
    select 
	category,
	count(distinct customer_id) as unique_customers
	 from Retail_Sales_data
	 group by category
	 
--12) write sql query to create each shift and numbers of orders ( Example Morning <=12 , afternoon betwen 12 & 17 , evening > 17 )

  SELECT
  COUNT(CASE WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 1 END) AS Morning_Orders,
  COUNT(CASE WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 1 END) AS Afternoon_Orders,
  COUNT(CASE WHEN EXTRACT(HOUR FROM sale_time) > 17 THEN 1 END) AS Evening_Orders
FROM Retail_Sales_data;

