CREATE DATABASE test_db1
    DEFAULT CHARACTER SET = 'utf8mb4';

show databases;

USE test_db1;

create table SALESPEOPLE(SNUM INT PRIMARY KEY ,SNAME VARCHAR(50), CITY VARCHAR(50), COMM FLOAT(7,2));
show tables;

insert into SALESPEOPLE VALUES(1001, "Peel", "London", 0.12),(1002,"Serres", "San Joe",0.13),(1004,"Motika","London",0.11),(1007,'Rafkin',"Barcelona",0.15),(1003,"Axelrod","NewYork",0.1);

desc SALESPEOPLE;

SELECT * FROM SALESPEOPLE;

create table CUST1(CNUM INT PRIMARY KEY ,CNAME VARCHAR(50), CITY VARCHAR(50),RATING INT, SNUM INT,FOREIGN KEY(SNUM) REFERENCES SALESPEOPLE(SNUM) );
DESC CUST1;

insert into CUST1 VALUES(2001, "Hoffman", "London", 100,1001),(2002,"Giovanne", "Rome",200,1003),(2003,"Liu","SanJoe",300,1002),(2004,'Grass',"Brelin",100,1002),(2006,"Clemens","London",300,1007),(2007,"Pereira","Rome",100,1004);

select * from cust;

create table ORDERS(ONUM INT PRIMARY KEY,AMT DECIMAL(7,2), ODATE DATE, CNUM INT, SNUM INT, FOREIGN KEY (CNUM) REFERENCES CUST1(CNUM),FOREIGN KEY (SNUM) REFERENCES SALESPEOPLE(SNUM));

desc orders;

select *from orders;


I
INSERT INTO ORDERS VALUES (3001, 18.69, '1994-10-03', 2008, 1007);
INSERT INTO ORDERS VALUES (3003, 767.19, '1994-10-03', 2001, 1001);
INSERT INTO ORDERS VALUES (3002, 1900.10, '1994-10-03', 2007, 1004);
INSERT INTO ORDERS VALUES (3005, 5160.45, '1994-10-03', 2003, 1002);
INSERT INTO ORDERS VALUES (3006, 1098.16, '1994-10-04', 2008, 1007);
INSERT INTO ORDERS VALUES (3009, 1713.23, '1994-10-04', 2002, 1003);
INSERT INTO ORDERS VALUES (3007, 75.75, '1994-10-05', 2004, 1002);
INSERT INTO ORDERS VALUES (3008, 4723.00, '1994-10-05', 2006, 1001);
INSERT INTO ORDERS VALUES (3010, 1309.95, '1994-10-06', 2004, 1002);
INSERT INTO ORDERS VALUES (3011, 9891.88, '1994-10-06', 2006, 1001);

INSERT INTO CUST1 VALUES (2008, 'TempCustomer', 'Unknown', 0, 1007);

/*QUERIES
*/
--1.Display snum,sname,city and comm of all salespeople.
	Select snum, sname, city, comm
	from salespeople;

--2.Display all snum without duplicates from all orders.
	Select distinct snum 
	from orders;

--3.Display names and commissions of all salespeople in london.
   SELECT SNAME, COMM FROM SALESPEOPLE WHERE CITY='LONDON';

--4.All customers with rating of 100
select cname from cust1 where rating=100;

--5.Produce orderno, amount and date form all rows in the order table.
select onum,amt,odate from orders;

--6.All customers in San Jose, who have rating more than 200
SELECT CNAME FROM CUST1 WHERE rating>200;

--7.All customers who were either located in San Jose or had a rating above 200.
select cname from cust1 where city='SanJose' or rating >200;

--8.All orders for more than $1000.
select* from orders where amt>1000;


--9.Names and cities of all salespeople in london with commission above 0.10.

select sname,city from salespeople where comm>0.10 and city='London';

--10.All customers excluding those with rating <= 100 unless they are located in Rome.
select cname from cust1 where rating<=100 or city='Rome';

--11.All salespeople either in Barcelona or in london.
select sname from salespeople where city in ('Barcelona','London');

--12.All salespeople with commission between 0.10 and 0.12. (Boundary values should be excluded)
select sname from salespeople where comm>0.10 and comm<0.12;

--13.All customers with NULL values in city column.
select cname from cust1 where city is null;

--14.All orders taken on Oct 3rd and oct 4th 1994
select*from orders where odate in ('1994-10-03','1994-10-04');

--15.All customers serviced by peel or Motika
Select cname from cust1, orders where orders.cnum=cust1.cnum and orders.snum in (select snum from salespeople where sname in ('Peel','Motika'));

--16.All customers whose names begin with a letter from A TO B

select cname from cust1 where cname like 'A%' or cname like 'B%';

--17.All orders except those with 0 or NULL value in amt field.

select onum from orders where amt!=0 or amt is not null;

--18.Count the number of salespeople currently listing orders in the order table.

select count(distinct snum) from orders;

--19.Largest order taken by each salesperson, datewise
select odate ,snum,max(amt) from orders  group by odate,snum order by odate,snum;

--20.Largest order taken by each salesperson with order value more than $3000.
select odate,snum,max(amt) from orders where amt>3000 group by odate,snum order by odate,snum;

--21.Which day had the hightest total amount ordered. 
select odate,snum,onum,amt,cnum
from orders where amt=(select max(amt) from orders);

--22.Count all orders from Oct 3rd
select count(*)
from orders where odate='1994-10-03' ;

--23.Count the number of different non NULL city values in customers table.
select count(distinct city) from cust1;

--24.Swwct each customer's smallest order
select cnum,min(amt) from orders group by cnum;

--25.First customer in alphabetical order whose name begins with G.
select cname from cust1 where cname like 'G%';

--26.Get the output like “ For dd/mm/yy there are ___ orders.
SELECT 
    'For ' + FORMAT(odate, 'dd/MM/yy') +' there are ' + CAST(COUNT(*) AS VARCHAR(50)) + ' orders' AS ORDER_SUMMARY FROM orders GROUP BY odate ORDER BY odate;

--27.Assume that each salesperson has a 12% commission. Produce order no., salesperson no., and amount of salesperson’s commission for that order.
SELECT ONUM,SNUM,AMT,AMT*0.12 FROM ORDERS ORDER BY SNUM;

--28.Find highest rating in each city. Put the output in this form. For the city (city), the highest rating is : (rating).

SELECT CONCAT('For the city (', city, '), the highest rating is: (', MAX(rating), ')') AS RESULT FROM cust1 GROUP BY city;
--Select 'For the city (' || city || '), the highest rating is : (' || 
--max(rating) || ')'
--from cust1 group by city;/*for sql queries*/


--29.Display the totals of orders for each day and place the results in descending order.
-29.Display the totals of orders for each day and place the results in descending order.
select odate , count(onum) from orders group by odate order by count(onum);

--30.All combinations of salespeople and customers who shared a city. (ie same city).
select sname, cname from salespeople,cust1 where salespeople.city=cust1.city;

--31.Name of all customers matched with the salespeople serving them.
select cname from orders,cust1 where orders.cnum=cust1.cnum;

--32.List each order number followed by the name of the customer who made the order.
select onum ,cname from orders,cust1 where orders.cnum=cust1.cnum;

--33.Names of salesperson and customer for each order after the order number.
select onum,sname,cname  from orders,cust1,salespeople where orders.cnum=cust1.cnum and orders.snum=salespeople.snum;

--34.Produce all customer serviced by salespeople with a commission above 12%.
select cname,sname,comm from cust1,salespeople where comm>0.12 and cust1.snum=salespeople.snum;


--35.Calculate the amount of the salesperson’s commission on each order with a rating above 100.
select sname,amt*comm from orders,cust1,salespeople where rating>100 and salespeople.snum=cust1.snum and salespeople.snum=orders.snum and cust1.cnum = orders.cnum;

--36.Find all pairs of customers having the same rating.
select a.cname,b.cname,a.rating from cust1 a,cust b where a.rating=b.rating and a.cnum != b.cnum;

--37.Find all pairs of customers having the same rating, each pair coming once only.
select a.cname,b.cname,a.rating from cust1 a, cust1 b where a.rating=b.rating and a.cnum!=b.cnum 
and a.cnum<b.cnum;

--38.Policy is to assign three salesperson to each customers. Display all such combinations.
SELECT c.cname, s1.sname, s2.sname, s3.sname
FROM cust1 c, salespeople s1, salespeople s2, salespeople s3
WHERE s1.sname < s2.sname
  AND s2.sname < s3.sname
ORDER BY c.cname, s1.sname, s2.sname, s3.sname;

--39.Display all customers located in cities where salesman serres has customer.
SELECT c.cname
FROM cust1 c
JOIN salespeople s ON c.snum = s.snum
WHERE s.sname = 'Serres';

--40.Find all pairs of customers served by single salesperson.
select cnum,cname from cust1 where snum in (select snum from cust group by snum having count(snum)>1);

	
--41.Produce all pairs of salespeople which are living in the same city. Exclude combinations of salespeople with themselves as well as 
--duplicates with the order reversed.
select a.sname,b.sname from salespeople a, salespeople b where a.snum>b.snum and a.city=b.city;

--42.Produce all pairs of orders by given customer, names that customers and eliminates duplicates.
	Select c.cname, a.onum, b.onum
	from orders a, orders b, cust c
	where a.cnum = b.cnum and 
	          a.onum > b.onum and
	                      c.cnum = a.cnum;


--43.Produce names and cities of all customers with the same rating as Hoffman.
	Select cname, city
	from cust
	where rating = (select rating
	            		        from cust
	              where cname = 'Hoffman')
	and cname != 'Hoffman';

--44.Extract all the orders of Motika.
	Select onum
	from orders
	where snum = ( select snum
	   from salespeople
	   where sname='MOTIKA');
--45.All orders credited to the same salesperson who services Hoffman.
SELECT ONUM,SNAME,CNAME,AMT FROM ORDERS a,SALESPEOPLE b,CUST1 c 
where a.snum=b.snum and a.cnum=c.cnum and 
a.snum=(select snum from orders where 
cnum=(select cnum from cust1 where cname='HOFFMAN'));

--46.All orders that are greater than the average for Oct 4.
SELECT* FROM ORDERS WHERE AMT>(SELECT AVG(AMT)
FROM ORDERS WHERE ODATE='1994-10-04');

	
--47.Find average commission of salespeople in london.
SELECT AVG(COMM) FROM SALESPEOPLE WHERE CITY='LONDON';

--48.Find all orders attributed to salespeople servicing customers in london.
SELECT SNUM,CNUM FROM ORDERS WHERE CNUM IN (SELECT CNUM FROM CUST1 WHERE CITY='LONDON');

SELECT o.oNUM, o.odate, o.amt, s.sname, c.cname, c.city
FROM Orders o
JOIN CUST1 c ON o.cnum = c.cnum
JOIN Salespeople s ON o.snum = s.snum
WHERE c.city = 'London';

--49.Extract commissions of all salespeople servicing customers in London.
SELECT SNUM,SNAME
FROM SALESPEOPLE WHERE SNUM IN (SELECT SNUM FROM CUST1
WHERE city = 'London');

--50.Find all customers whose cnum is 1000 above the snum of serres.
SELECT CNUM,CNAME FROM CUST1 WHERE CNUM>(SELECT SNUM+1000 
FROM SALESPEOPLE WHERE SNAME='SERRES');

--51.Count the customers with rating  above San Jose’s average.
SELECT COUNT(*) AS customer_count
FROM cust1
WHERE rating > (
    SELECT AVG(rating)
    FROM cust1
    WHERE city = 'SANJOSE'
);

--52.Obtain all orders for the customer named Cisnerous. (Assume you don’t know his customer no. (cnum)).
SELECT *
FROM Orders
WHERE cnum = (
    SELECT cnum
    FROM Cust1
    WHERE cname = 'Cisnerous'
);
SELECT O.*
FROM Orders O
JOIN Cust1 C ON O.cnum = C.cnum
WHERE C.cname = 'Cisnerous';

--53.Produce the names and rating of all customers who have above average orders.
SELECT c.cname, c.rating
FROM Cust1 c
JOIN Orders o ON c.cnum = o.cnum
GROUP BY c.cname, c.rating
HAVING SUM(o.amt) > (
    SELECT AVG(amt)
    FROM Orders
);


--54.Find total amount in orders for each salesperson for whom this total is greater than the amount of the largest order in the table.
SELECT snum, 
       SUM(amt) AS total_amount
FROM Orders
GROUP BY snum
HAVING SUM(amt) > (
    SELECT MAX(amt) 
    FROM Orders
);

--55.Find all customers with order on 3rd Oct.
select c.cnum,c.cname  from cust1 c  join orders o  ON o.cnum=c.cnum where odate='1994-10-03';


--56.Find names and numbers of all salesperson who have more than one customer.
SELECT s.SNUM, s.SName, COUNT(c.CNUM) AS CustomerCount
FROM SalespEOPLE s
JOIN Cust1 c ON s.SNUM = c.SNUM
GROUP BY s.SNUM, s.SName
HAVING COUNT(c.CNUM) > 1;

--57.Check if the correct salesperson was credited with each sale.
SELECT 
    CASE 
        WHEN o.SNUM = c.SNUM THEN 'Correctly Credited'
        WHEN c.CNUM IS NULL THEN 'Customer Missing'
        ELSE 'Incorrectly Credited'
    END AS Result,
    COUNT(*) AS Total_Orders
FROM ORDERS o
LEFT JOIN CUST c ON o.CNUM = c.CNUM
GROUP BY 
    CASE 
        WHEN o.SNUM = c.SNUM THEN 'Correctly Credited'
        WHEN c.CNUM IS NULL THEN 'Customer Missing'
        ELSE 'Incorrectly Credited'
    END;

--58.Find all orders with above average amounts for their customers
SELECT o.ONUM, o.CNUM, o.AmT
FROM Orders o
WHERE o.AmT > (
    SELECT AVG(o2.AmT)
    FROM Orders o2
    WHERE o2.CNUM= o.CNUM
);

--59.Find the sums of the amounts from order table grouped by date, 
--eliminating all those dates where the sum was not at least 2000 above the maximum amount.
SELECT odate, SUM(amt) AS total_amount
FROM orders
GROUP BY odate
HAVING SUM(amt) >= (
    SELECT MAX(amt) FROM orders
) + 2000;


--60.Find names and numbers of all customers with ratings equal to the maximum for their city.

SELECT c.Cname, c.cnum, c.city, c.rating
FROM Cust1 c
WHERE c.rating = (
    SELECT MAX(c2.rating)
    FROM Cust1 c2
    WHERE c2.city = c.city
);


SELECT s.snum, s.sname, s.city
FROM Salespeople s
WHERE EXISTS (
    SELECT 1
    FROM Customers c
    WHERE c.city = s.city
      AND c.snum <> s.snum
);

--62.Extract cnum,cname and city from customer table if and only if one or more of the customers in the table are located in San Jose.
SELECT *
FROM CUST1
WHERE CITY = 'SanJoe';

SELECT*FROM CUST1;

--63.Find salespeople no. who have multiple customers.
SELECT SNUM FROM CUST1 GROUP BY SNUM HAVING COUNT(CNUM)>1;

--64.Find salespeople number, name and city who have multiple customers.
SELECT S.SNUM,S.SNAME,
S.CITY FROM SALESPEOPLE S JOIN CUST1 C ON S.SNUM=C.SNUM GROUP BY S.SNUM, S.SNAME,S.CITY HAVING COUNT(C.CNUM)>1;

--65.Find salespeople who serve only one customer.
SELECT S.SNUM, S.SNAME FROM SALESPEOPLE S JOIN CUST1 C ON S.SNUM=C.SNUM GROUP BY S.SNUM,S.SNAME HAVING COUNT(DISTINCT C.CNUM)=1;


--66.Extract rows of all salespeople with more than one current order.
SELECT S.SNUM, S.SNAME, COUNT(O.ONUM) AS CURRENT_ORDER_COUNT FROM SALESPEOPLE S JOIN ORDERS O ON
S.SNUM=O.SNUM GROUP BY S.SNUM, S.SNAME, S.CITY,S.COMM HAVING COUNT(O.ONUM)
>1;


--67.Find all salespeople who have customers with a rating of 300. (use EXISTS)
SELECT S.SNUM,S.SNAME FROM SALESPEOPLE S WHERE EXISTS(SELECT 1 FROM CUST1 C WHERE C.SNUM=S.SNUM AND C.RATING=300);

--68.Find all salespeople who have customers with a rating of 300. (use Join).

SELECT S.SNUM,S.SNAME FROM SALESPEOPLE S JOIN CUST1 C ON C.SNUM=S.SNUM WHERE C.RATING=300;

--69.Select all salespeople with customers located in their cities who are not assigned to them. (use EXISTS).
SELECT S.SNUM, S.SNAME, S.CITY FROM SALESPEOPLE S WHERE EXISTS(SELECT 1 FROM CUST1 C WHERE C.CITY = S.CITY AND C.SNUM<> S.SNUM);

--70.Extract from customers table every customer assigned the a salesperson who currently has at least one other customer
-- ( besides the customer being selected) with orders in order table.
SELECT C.* FROM CUST1 C WHERE EXISTS (
	SELECT 1 FROM CUST1 C2  
	  
	JOIN ORDERS O ON C2.CNUM = O.CNUM 
	WHERE C2.SNUM=C.SNUM  
	AND C2.CNUM<>C.CNUM
);

--71.Find salespeople with customers located in their cities ( using both ANY and IN).
SELECT S.SNAME,S.CITY FROM SALESPEOPLE S WHERE S.CITY=ANY(
	SELECT C.CITY FROM CUST1 C WHERE C.SNUM=S.SNUM
);

--72..Find all salespeople for whom there are customers that follow them in alphabetical order. (Using ANY and EXISTS)
SELECT DISTINCT S.SNUM, S.SNAME FROM SALESPEOPLE S WHERE S.SNAME< ANY(
	SELECT C.CNAME FROM CUST1 C WHERE C.SNUM=S.SNUM
);
SELECT DISTINCT s.SNUM, s.sname
FROM Salespeople s
WHERE EXISTS (
    SELECT 1
    FROM CusT1 C
    WHERE c.snum=s.snum
      AND c.cname > s.sname
);

--73.Select customers who have a greater rating than any customer in rome.
select * from cust1 where rating> any(
	select rating from cust1 where city='ROME'
);

--74.Select all orders that had amounts that were greater that atleast one of the orders from Oct 6th.
SELECT * FROM ORDERS WHERE AMT> ANY(
	SELECT AMT FROM ORDERS WHERE ODATE='1994-10-03'
);

--75.Find all orders with amounts smaller than any amount for a customer in San Jose. (Both using ANY and without ANY)
--USING ANY
SELECT * FROM ORDERS WHERE AMT<ANY(
	SELECT AMT FROM ORDERS where cnum IN (
       SELECT CNUM FROM CUST1 WHERE CITY='SanJoe'
	)
);

--without any using max
select * from orders where amt<(
	select max(amt)
	from orders where cnum in(
		select cnum from cust1 where city='SanJoe'
	)
);

---76.Select those customers whose ratings are higher than every customer in Paris. ( Using both ALL and NOT EXISTS).
SELECT cname, cname, rating
FROM Cust1
WHERE rating > ALL (
    SELECT rating
    FROM Cust1
    WHERE city = 'Paris'
);
--using NOT EXISTS
SELECT CNUM,CNAME, RATING FROM CUST1 C WHERE NOT EXISTS(
	SELECT 1 FROM CUST1 P WHERE P.CITY='Paris'
	AND p.rating>=c.rating
);

--77.Select all customers whose ratings are equal to or greater than ANY of the Seeres.
SELECT * FROM CUST1 WHERE RATING>= ANY(
    SELECT RATING FROM CUST1 WHERE CNAME='Seeres'
);

---78.Find all salespeople who have no customers located in their city. ( Both using ANY and ALL)
--using any
SELECT s.snum, s.sname, s.city
FROM Salespeople s
WHERE s.city <> ANY (
    SELECT c.city
    FROM Cust1 c
    WHERE c.snum = s.snum
);
--USING ALL
SELECT * FROM SALESPEOPLE S WHERE S.CITY <> ALL(SELECT C.CITY FROM CUST1 C);

--79.Find all orders for amounts greater than any for the customers in London.
select * from orders where amt>ANY(SELECT AMT FROM ORDERS O JOIN CUST1 C ON O.CNUM=C.CNUM
WHERE C.CITY='London'
);

--80.Find all salespeople and customers located in london.
select sname,city,'SALESPEOPLE' as role FROM SALESPEOPLE  where city='London' UNION
SELECT CNAME,CITY,'CUSTOMERS' AS ROLE FROM CUST1 WHERE CITY='London';

--81.For every salesperson, dates on which highest and lowest orders were brought.
SELECT 
    SNUM,
    MAX(Amt) AS MaxOrder,
    MIN(Amt) AS MinOrder
FROM Orders
GROUP BY SNUM;

SELECT 
    O.SNUM,
    MAXCASE.ODate AS MaxOrderDate,
    MINCASE.ODate AS MinOrderDate
FROM Orders O
JOIN (
    SELECT SNUM, MAX(AMt) AS MaxOrder, MIN(Amt) AS MinOrder
    FROM Orders
    GROUP BY SNUM
) Agg ON O.SNUM = Agg.SNUM
JOIN Orders MAXCASE ON MAXCASE.SNUM = Agg.SNUM AND MAXCASE.Amt = Agg.MaxOrder
JOIN Orders MINCASE ON MINCASE.SNUM = Agg.SNUM AND MINCASE.AMT = Agg.MinOrder;


--82.List all of the salespeople and indicate those who don’t have customers in their cities as well as those who do have.
SELECT S.SNUM,S.SNAME,S.CITY AS SALESPEOPLE_CITY, 
CASE 
WHEN EXISTS(
    SELECT 1 FROM CUST1 C WHERE C.SNUM=S.SNUM  
      AND  C.CITY=S.CITY 
)THEN 'HAS CUSTOMERS IN THEIR CITY'
ELSE 'No customers in thieir city'
end as city_customer_status
from salespeople S;


--83.Append strings to the selected fields, indicating weather or not a given salesperson was matched to a customer in his city.
SELECT S.SNUM,S.SNAME,S.CITY,
CASE WHEN EXISTS(
    SELECT 1 FROM CUST1 C WHERE C.SNUM=S.SNUM AND C.CITY=S.CITY)
    THEN CONCAT(S.CITY,'-Matched')
    else concat(s.city,'-Not Matched')
    end as city_status
from Salespeople s;

---84.Create a union of two queries that shows the names, cities and ratings of all customers. Those with a rating of 200 or greater will also have the words ‘High Rating’, while the others will have the words ‘Low Rating’.
select cname, city,rating,'Highest Rating' AS RatingCategory
FROM CUST1 WHERE RATING>=200
UNION 
SELECT CNAME,CITY, RATING,'Low Rating' asRatingCategory
FROM CUST1 WHERE RATING<200;

--85.Write command that produces the name and number of each salesperson and each customer with more than one current order. Put the result in alphabetical order.
SELECT S.SNAME AS SALESPERSON_NAME,
       S.SNUM AS SALESPERSON_NUMBER,
       C.CNAME AS CUSTOMR_NAME,
       C.CNUM AS CUSTOMER_NAME
FROM SALESPEOPLE S
JOIN ORDERS O ON S.SNUM = O.SNUM  
JOIN CUST1 C ON C.CNUM=O.CNUM   
GROUP BY S.SNAME,S.SNUM,C.CNAME, C.CNUM    
HAVING COUNT(O.ONUM)>1
ORDER BY S.SNAME ASC, C.CNAME ASC;

--86.Form a union of three queries. Have the first select the snums of all salespeople in San Jose, 
--then second the cnums of all customers in San Jose and the third the onums of all orders on Oct.3. 
--Retain duplicates between the last two queries, but eliminates and redundancies between either of them and the first.
SELECT SNUM FROM SALESPEOPLE WHERE CITY='SanJoe'
union 
(
    SELECT CNUM FROM CUST1 WHERE CITY='SanJoe'
    UNION ALL 
    SELECT ONUM FROM ORDERS WHERE ODATE='1994-10-03'
);

--87.Produce all the salesperson in London who had at least one customer there.
SELECT DISTINCT S.SNAME FROM SALESPEOPLE S JOIN CUST1 C ON S.Snum=C.Snum WHERE
S.CITY='London'
AND C.CITY='London';

--88.Produce all the salesperson in London who did not have customers there.
select s.snum, s.Sname from salespeople s where s.city='London' AND NOT EXISTS( SELECT 1 FROM
CUST1 C WHERE C.CITY='London'
  AND C.SNUM=S.SNUM);


--89.We want to see salespeople matched to their customers without excluding those salesperson 
--who were not currently assigned to any customers. (User OUTER join and UNION)

SELECT S.SNUM,S.SNAME AS SALESPERSON_NAME,
       C.CNUM,C.CNAME AS CUSTOMER_NAME
        FROM SALESPEOPLE S
    LEFT OUTER JOIN CUST1 C
    ON S.SNUM=C.SNUM  
UNION 
SELECT S.SNUM,S.SNAME AS SALESPERSON_NAME,
       C.CNUM,C.CNAME AS CUSTOMER_NAME
FROM SALESPEOPLE S
RIGHT OUTER JOIN CUST1 C
ON S.SNUM=C.SNUM;

