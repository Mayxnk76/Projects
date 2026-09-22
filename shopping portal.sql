CREATE TABLE Customer
(
    Customer_ID       NUMBER(5)    PRIMARY KEY,
    Customer_Name     VARCHAR2(50)  NOT NULL,
    Email  VARCHAR2(100)  UNIQUE,
    Mobile_No   VARCHAR2(10) UNIQUE,
    Gender CHAR(1)  CHECK (Gender IN ('M','F','O')),
    City VARCHAR2(30) DEFAULT 'Ahmedabad', 
Registration_Date DATE DEFAULT SYSDATE
);

Table created.

INSERT INTO Customer (Customer_ID, Customer_Name, Email, Mobile_No, Gender, City)
VALUES (101, 'Rahul Patel', 'rahul@gmail.com', '9876543210', 'M', 'Ahmedabad');

INSERT INTO Customer (Customer_ID, Customer_Name, Email, Mobile_No, Gender, City)
VALUES (102, 'Neha Shah', 'neha@gmail.com', '9876543211', 'F', 'Surat');

INSERT INTO Customer (Customer_ID, Customer_Name, Email, Mobile_No, Gender, City)
VALUES (103, 'Amit Mehta', 'amit@gmail.com', '9876543212', 'M', 'Vadodara');

INSERT INTO Customer (Customer_ID, Customer_Name, Email, Mobile_No, Gender, City)
VALUES (104, 'Priya Desai', 'priya@gmail.com', '9876543213', 'F', 'Ahmedabad');

INSERT INTO Customer (Customer_ID, Customer_Name, Email, Mobile_No, Gender, City)
VALUES (105, 'Karan Joshi', 'karan@gmail.com', '9876543214', 'M', 'Rajkot');

CREATE TABLE Category(
    Category_ID       NUMBER(3)  CONSTRAINT PK_Category PRIMARY KEY,
    Category_Name     VARCHAR2(50) CONSTRAINT NN_Category_Name NOT NULL 
    CONSTRAINT UK_Category_Name UNIQUE,
    Description VARCHAR2(200)
);

Table created.

INSERT INTO Category(Category_ID, Category_Name, Description)
VALUES (1, 'Electronics', 'Electronic devices and accessories');

INSERT INTO Category(Category_ID, Category_Name, Description)
VALUES (2, 'Clothing', 'Men and women clothing');

INSERT INTO Category(Category_ID, Category_Name, Description)
VALUES (3, 'Books', 'Academic and general books');



CREATE TABLE Product
(
    Product_ID       NUMBER(5)     CONSTRAINT PK_Product PRIMARY KEY,
    Product_Name     VARCHAR2(100)  CONSTRAINT NN_Product_Name NOT NULL,
    Price  NUMBER(10,2)  CONSTRAINT NN_Product_Price NOT NULL ,
    Stock            NUMBER(5)  DEFAULT 0 ,
    Brand            VARCHAR2(50),
    Category_ID      NUMBER(3)  CONSTRAINT NN_Product_Category NOT NULL,
    CONSTRAINT FK_Product_Category  FOREIGN KEY (Category_ID)  REFERENCES category(Category_ID),
CONSTRAINT CHK_Product_Price CHECK (Price > 0),
CONSTRAINT CHK_Product_Stock CHECK (Stock >= 0)
);

Table created.

INSERT INTO Product (Product_ID, Product_Name, Price, Stock, Brand, Category_ID)
VALUES (201, 'Wireless Headphones', 2499.00, 50, 'Boat', 1);

INSERT INTO Product
(Product_ID, Product_Name, Price, Stock, Brand, Category_ID)
VALUES (202, 'Smart Watch', 3999.00, 30, 'Noise', 1);


INSERT INTO Product(Product_ID, Product_Name, Price, Stock, Brand, Category_ID)
VALUES (203, 'Cotton T-Shirt', 799.00, 100, 'Puma', 2);

INSERT INTO Product (Product_ID, Product_Name, Price, Stock, Brand, Category_ID)
VALUES (204, 'Data Structures Book', 650.00, 40, 'McGraw Hill', 3);
INSERT INTO Product (Product_ID, Product_Name, Price, Stock, Brand, Category_ID)
VALUES (205, 'Python Programming', 850.00, 35, 'Pearson', 3);


CREATE TABLE Orders
(
    Order_ID         NUMBER(5)      CONSTRAINT PK_Orders PRIMARY KEY,
    Customer_ID      NUMBER(5)  CONSTRAINT NN_Orders_Customer NOT NULL,
    Order_Date       DATE        DEFAULT SYSDATE,
    Total_Amount     NUMBER(10,2)  CONSTRAINT CHK_Order_Amount   CHECK (Total_Amount >= 0),
    Payment_Mode     VARCHAR2(20) CONSTRAINT CHK_Payment_Mode  CHECK (Payment_Mode IN ('Cash','UPI','Card','NetBanking')),
Status VARCHAR2(20) DEFAULT 'Pending' 
CONSTRAINT CHK_Order_Status  CHECK (Status IN ('Pending','Confirmed','Shipped','Delivered','Cancelled')),
CONSTRAINT FK_Orders_Customer FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

Table created.

INSERT INTO Orders (Order_ID, Customer_ID, Order_Date, Total_Amount, Payment_Mode, Status)
VALUES (301, 101, TO_DATE('01-08-2026','DD-MM-YYYY'), 2499, 'UPI', 'Delivered');

INSERT INTO Orders (Order_ID, Customer_ID, Order_Date, Total_Amount, Payment_Mode, Status)
VALUES (302, 102, TO_DATE('02-08-2026','DD-MM-YYYY'), 3999, 'Card', 'Shipped');

INSERT INTO Orders (Order_ID, Customer_ID, Order_Date, Total_Amount, Payment_Mode, Status)
VALUES (303, 103, TO_DATE('02-08-2026','DD-MM-YYYY'), 1598, 'Cash', 'Delivered');

INSERT INTO Orders (Order_ID, Customer_ID, Order_Date, Total_Amount, Payment_Mode, Status)
VALUES (304, 101, TO_DATE('03-08-2026','DD-MM-YYYY'), 1500, 'UPI', 'Confirmed');

INSERT INTO Orders (Order_ID, Customer_ID, Order_Date, Total_Amount, Payment_Mode, Status)
VALUES (305, 104, TO_DATE('03-08-2026','DD-MM-YYYY'), 850, 'Card', 'Delivered');

INSERT INTO Orders (Order_ID, Customer_ID, Order_Date, Total_Amount, Payment_Mode, Status)
VALUES (306, 105, TO_DATE('04-08-2026','DD-MM-YYYY'), 4798, 'NetBanking', 'Shipped');

INSERT INTO Orders (Order_ID, Customer_ID, Order_Date, Total_Amount, Payment_Mode, Status)
VALUES (307, 102, TO_DATE('05-08-2026','DD-MM-YYYY'), 1450, 'UPI', 'Pending');

INSERT INTO Orders (Order_ID, Customer_ID, Order_Date, Total_Amount, Payment_Mode, Status)
VALUES (308, 103, TO_DATE('05-08-2026','DD-MM-YYYY'), 650, 'Cash', 'Delivered');

INSERT INTO Orders
(Order_ID, Customer_ID, Order_Date, Total_Amount, Payment_Mode, Status)
VALUES (309, 104, TO_DATE('06-08-2026','DD-MM-YYYY'), 2499, 'Card', 'Confirmed');

INSERT INTO Orders (Order_ID, Customer_ID, Order_Date, Total_Amount, Payment_Mode, Status)
VALUES (310, 101, TO_DATE('06-08-2026','DD-MM-YYYY'), 4798, 'UPI', 'Pending');


CREATE TABLE Order_Details
(
    Order_ID  NUMBER(5),
    Product_ID       NUMBER(5),
    Quantity         NUMBER(5) Not Null,
    Price            NUMBER(10,2) NOT NULL,
CONSTRAINT CHK_OrderDetails_Price  CHECK (Price > 0),
CONSTRAINT CHK_OrderDetails_Quantity  CHECK (Quantity > 0),
CONSTRAINT PK_OrderDetails   PRIMARY KEY (Order_ID, Product_ID),
CONSTRAINT FK_OrderDetails_Order    FOREIGN KEY (Order_ID)    REFERENCES Orders(Order_ID),
CONSTRAINT FK_OrderDetails_Product    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

Table created.

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (301, 201, 1, 2499);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (301, 203, 1, 799);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (302, 202, 1, 3999);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (303, 203, 2, 799);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (304, 204, 1, 650);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (304, 205, 1, 850);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (305, 205, 1, 850);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (306, 201, 1, 2499);
INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (306, 202, 1, 3999);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (307, 204, 1, 650);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (307, 205, 1, 850);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (308, 204, 1, 650);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (309, 201, 1, 2499);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (309, 203, 1, 799);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (310, 201, 1, 2499);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (310, 202, 1, 3999);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (310, 205, 2, 850);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (303, 205, 1, 850);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (305, 204, 1, 650);

INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Price)
VALUES (308, 205, 1, 850);
Commit;


Student Practice Questions:
Customer Table

Q1. Display the details of all customers.

SQL> select * from customer;

CUSTOMER_ID  CUSTOMER_NAME  EMAIL             MOBILE_NO   G  CITY
-----------  -------------  ----------------  ----------  -  ----------
101          Rahul Patel    rahul@gmail.com   9876543210  M  Ahmedabad
102          Neha Shah      neha@gmail.com    9876543211  F  Surat
103          Amit Mehta     amit@gmail.com    9876543212  M  Vadodara
104          Priya Desai    priya@gmail.com   9876543213  F  Ahmedabad
105          Karan Joshi    karan@gmail.com   9876543214  M  Rajkot

Q2. Display the name, email and city of all customers who live in Ahmedabad.

SQL> select customer_name,email,city from customer where city='Ahmedabad';

CUSTOMER_NAME  EMAIL             CITY
-------------  ----------------  ----------
Rahul Patel    rahul@gmail.com   Ahmedabad
Priya Desai    priya@gmail.com   Ahmedabad

Q3. Display all customers whose gender is female.

SQL> select * from customer where gender = 'F';

CUSTOMER_ID  CUSTOMER_NAME  EMAIL             MOBILE_NO   G  CITY
-----------  -------------  ----------------  ----------  -  ----------
102          Neha Shah      neha@gmail.com    9876543211  F  Surat
104          Priya Desai    priya@gmail.com   9876543213  F  Ahmedabad

Q4. Display the details of customers who are from either Ahmedabad or Surat.

SQL> select * from customer where city in('Ahmedabad','Surat');

CUSTOMER_ID  CUSTOMER_NAME  EMAIL             MOBILE_NO   G  CITY
-----------  -------------  ----------------  ----------  -  ----------
101          Rahul Patel    rahul@gmail.com   9876543210  M  Ahmedabad
102          Neha Shah      neha@gmail.com    9876543211  F  Surat
104          Priya Desai    priya@gmail.com   9876543213  F  Ahmedabad

Q5. Display customers who are not from Ahmedabad.

SQL> select * from customer where city <> 'Ahmedabad';

CUSTOMER_ID  CUSTOMER_NAME  EMAIL             MOBILE_NO   G  CITY
-----------  -------------  ----------------  ----------  -  ----------
102          Neha Shah      neha@gmail.com    9876543211  F  Surat
103          Amit Mehta     amit@gmail.com    9876543212  M  Vadodara
105          Karan Joshi    karan@gmail.com   9876543214  M  Rajkot

Q6. Display customers whose names start with the letter R.

SQL> select * from customer where customer_name like'R%';

CUSTOMER_ID  CUSTOMER_NAME  EMAIL             MOBILE_NO   G  CITY
-----------  -------------  ----------------  ----------  -  ----------
101          Rahul Patel    rahul@gmail.com   9876543210  M  Ahmedabad

Q7. Display customers whose names end with the letter a.

SQL> select * from customer where customer_name like'%a';

no rows selected

Q8. Display customers whose names contain the letter e.

SQL> select * from customer where customer_name like'%e%';

CUSTOMER_ID  CUSTOMER_NAME  EMAIL             MOBILE_NO   G  CITY
-----------  -------------  ----------------  ----------  -  ----------
102          Neha Shah      neha@gmail.com    9876543211  F  Surat
103          Amit Mehta     amit@gmail.com    9876543212  M  Vadodara
104          Priya Desai    priya@gmail.com   9876543213  F  Ahmedabad
105          Karan Joshi    karan@gmail.com   9876543214  M  Rajkot

Q9. Display customers whose names have exactly 4 characters.

SQL> select * from customer where customer_name like'____';

no rows selected

Q10. Display all customers in alphabetical order of their names.

SQL> select * from customer order by customer_name asc;

CUSTOMER_ID  CUSTOMER_NAME
-----------  -------------
103          Amit Mehta
105          Karan Joshi
102          Neha Shah
104          Priya Desai
101          Rahul Patel

----------Category Table:---------
Q11. Display all categories in descending order of category name.

SQL> select * from category order by category_name desc;

CATEGORY_ID  CATEGORY_NAME  DESCRIPTION
-----------  -------------  --------------------------------
3            Books          Academic and general books
2            Clothing       Men and women clothing
1            Electronics    Electronic devices and accessories

Q12. Display categories whose names are either Electronics or Books.

SQL> select * from category where category_name in ('Electronics','Books');

CATEGORY_ID  CATEGORY_NAME  DESCRIPTION
-----------  -------------  --------------------------------
1            Electronics    Electronic devices and accessories
3            Books          Academic and general books

Q13. Display categories whose names are not Clothing.

SQL> select * from category where category_name<>'Clothing';

CATEGORY_ID  CATEGORY_NAME  DESCRIPTION
-----------  -------------  --------------------------------
1            Electronics    Electronic devices and accessories
3            Books          Academic and general books

Q14. Display categories whose names start with the letter E.

SQL> select * from category where category_name like'E%';

CATEGORY_ID  CATEGORY_NAME  DESCRIPTION
-----------  -------------  --------------------------------
1            Electronics    Electronic devices and accessories

Q15. Display categories whose names contain the letter o.

SQL> select * from category where category_name like'%o%';

CATEGORY_ID  CATEGORY_NAME  DESCRIPTION
-----------  -------------  --------------------------------
1            Electronics    Electronic devices and accessories
2            Clothing       Men and women clothing
3            Books          Academic and general books

---------Product Table:----------
Q16. Display all products having a price greater than 1000.

SQL> select * from product where price > 1000;

PRODUCT_ID  PRODUCT_NAME        PRICE    STOCK  BRAND  CATEGORY_ID
----------  ------------------  -------  -----  -----  -----------
201         Wireless Headphones 2499.00  50     Boat   1
202         Smart Watch         3999.00  30     Noise  1

Q17. Display product name, price and brand for products having price less than or equal to 1000.

SQL> select product_name,price,brand from product where price <= 1000;

PRODUCT_NAME          PRICE  BRAND
--------------------  -----  -----------
Cotton T-Shirt        799    Puma
Data Structures Book  650    McGraw Hill
Python Programming    850    Pearson

Q18. Display products whose price is between 500 and 3000.

SQL> select * from product where price between 500 and 3000;

PRODUCT_ID  PRODUCT_NAME          PRICE    STOCK  BRAND         CATEGORY_ID
----------  --------------------  -------  -----  ------------  -----------
201         Wireless Headphones   2499.00  50     Boat          1
203         Cotton T-Shirt        799.00   100    Puma          2
204         Data Structures Book  650.00   40     McGraw Hill   3
205         Python Programming    850.00   35     Pearson       3

Q19. Display products whose price is not between 500 and 3000.

SQL> select * from product where price not between 500 and 3000;

PRODUCT_ID  PRODUCT_NAME  PRICE    STOCK  BRAND  CATEGORY_ID
----------  ------------  -------  -----  -----  -----------
202         Smart Watch   3999.00  30     Noise  1

Q20. Display products belonging to category 1 or category 3.

SQL> select * from product where category_id in (1,3);

PRODUCT_ID  PRODUCT_NAME          PRICE    STOCK  BRAND         CATEGORY_ID
----------  --------------------  -------  -----  ------------  -----------
201         Wireless Headphones   2499.00  50     Boat          1
202         Smart Watch            3999.00  30     Noise         1
204         Data Structures Book   650.00   40     McGraw Hill   3
205         Python Programming     850.00   35     Pearson       3

Q21. Display products whose category is not 2.

PRODUCT_ID  PRODUCT_NAME          PRICE    STOCK  BRAND         CATEGORY_ID
----------  --------------------  -------  -----  ------------  -----------
201         Wireless Headphones   2499.00  50     Boat          1
202         Smart Watch            3999.00  30     Noise         1
204         Data Structures Book   650.00   40     McGraw Hill   3
205         Python Programming     850.00   35     Pearson       3

SQL> select * from product where category_id<>2;

Q22. Display products having stock greater than 40 and price less than 3000.

SQL> select * from product where stock > 40 and price < 3000;

PRODUCT_ID  PRODUCT_NAME         PRICE    STOCK  BRAND  CATEGORY_ID
----------  -------------------  -------  -----  -----  -----------
201         Wireless Headphones  2499.00  50     Boat   1

Q23. Display products having stock less than 40 or price greater than 3000.

SQL> select * from product where stock < 40 and price > 3000;

PRODUCT_ID  PRODUCT_NAME  PRICE    STOCK  BRAND  CATEGORY_ID
----------  ------------  -------  -----  -----  -----------
202         Smart Watch   3999.00  30     Noise  1

Q24. Display products whose names start with the letter S.

SQL> select * from product where product_name like'S%';

PRODUCT_ID  PRODUCT_NAME  PRICE    STOCK  BRAND  CATEGORY_ID
----------  ------------  -------  -----  -----  -----------
202         Smart Watch   3999.00  30     Noise  1

Q25. Display products whose names contain the word Book.

SQL> select * from product where product_name like'%Book%';

PRODUCT_ID  PRODUCT_NAME          PRICE   STOCK  BRAND        CATEGORY_ID
----------  --------------------  ------  -----  -----------  -----------
204         Data Structures Book  650.00  40     McGraw Hill  3

Q26. Display all products in increasing order of price.

SQL> select * from product order by price asc;

PRODUCT_ID  PRODUCT_NAME          PRICE    STOCK  BRAND         CATEGORY_ID
----------  --------------------  -------  -----  ------------  -----------
204         Data Structures Book  650.00   40     McGraw Hill   3
203         Cotton T-Shirt        799.00   100    Puma          2
205         Python Programming    850.00   35     Pearson       3
201         Wireless Headphones   2499.00  50     Boat          1
202         Smart Watch           3999.00  30     Noise         1

Q27. Display all products in decreasing order of stock.

SQL> select * from product order by stock desc;

PRODUCT_ID  PRODUCT_NAME          PRICE    STOCK  BRAND         CATEGORY_ID
----------  --------------------  -------  -----  ------------  -----------
203         Cotton T-Shirt        799.00   100    Puma          2
201         Wireless Headphones   2499.00  50     Boat          1
204         Data Structures Book  650.00   40     McGraw Hill   3
205         Python Programming    850.00   35     Pearson       3
202         Smart Watch           3999.00  30     Noise         1

-----Orders Table:-----

Q28. Display all orders having UPI as the payment mode.

SQL> select * from orders where payment_mode = 'UPI';

ORDER_ID  CUSTOMER_ID  ORDER_DATE  TOTAL_AMOUNT  PAYMENT_MODE  STATUS
--------  -----------  ----------  ------------  ------------  ---------
301       101          01-AUG-26   2499          UPI           Delivered
304       101          03-AUG-26   1500          UPI           Confirmed
307       102          05-AUG-26   1450          UPI           Pending
310       101          06-AUG-26   4798          UPI           Pending

Q29. Display orders whose status is either Pending or Confirmed, and arrange them in increasing order of Total_Amount.

SQL> select * from orders where status in ('Pending','Confirmed') order by total_amount asc;

ORDER_ID  CUSTOMER_ID  ORDER_DATE  TOTAL_AMOUNT  PAYMENT_MODE  STATUS
--------  -----------  ----------  ------------  ------------  ---------
307       102          05-AUG-26   1450          UPI           Pending
304       101          03-AUG-26   1500          UPI           Confirmed
310       101          06-AUG-26   4798          UPI           Pending

Q30. Display orders having a total amount greater than 2000 and whose payment mode is not Cash. Arrange the result in descending order of total amount.

SQL> select * from orders where total_amount > 2000 and payment_mode <> 'Cash' order by total_amount desc;

ORDER_ID  CUSTOMER_ID  ORDER_DATE  TOTAL_AMOUNT  PAYMENT_MODE  STATUS
--------  -----------  ----------  ------------  ------------  ---------
310       101          06-AUG-26   4798          UPI           Pending
306       105          04-AUG-26   4798          NetBanking    Shipped
302       102          02-AUG-26   3999          Card          Shipped
301       101          01-AUG-26   2499          UPI           Delivered
309       104          06-AUG-26   2499          Card          Confirmed


--------------------------More Practice……---------------------------
Q1. Display the name, city and gender of customers who are either from Ahmedabad or Rajkot
and arrange the result alphabetically by city and then by customer name.

SQL> select customer_name,city,gender from customer where city in('Ahmedabad','Rajkot') order by city asc,customer_name asc;

CUSTOMER_NAME  CITY       G
-------------  ---------  -
Rahul Patel    Ahmedabad  M
Priya Desai    Ahmedabad  F
Karan Joshi    Rajkot     M

Q2. Display all customers whose name starts with P or R, but exclude customers from
Ahmedabad. Arrange the result in descending order of customer name.

SQL> select * from customer where (customer_name like 'P%' or customer_name like 'R%') and city <> 'Ahmedabad' order by customer_name desc;

no rows selected

Q3. Display the name, email and city of customers who are not from Surat or Rajkot and whose
gender is F. Arrange the result first by city in ascending order and then by name in
descending order.

SQL> select customer_name,email,city from customer where city not in('Surat','Rajkot') and gender = 'F' order by city asc, customer_name desc;

CUSTOMER_NAME  EMAIL            CITY
-------------  ---------------  ----------
Priya Desai    priya@gmail.com  Ahmedabad

Q4. Display all products whose price is between ₹500 and ₹3000 and whose stock is greater than
30. Arrange them by price from highest to lowest.

SQL> select * from product where price between 500 and 3000 and stock > 30 order by price desc;

PRODUCT_ID  PRODUCT_NAME          PRICE    STOCK  BRAND         CATEGORY_ID
----------  --------------------  -------  -----  ------------  -----------
201         Wireless Headphones   2499.00  50     Boat          1
205         Python Programming     850.00   35     Pearson       3
203         Cotton T-Shirt         799.00   100    Puma          2
204         Data Structures Book   650.00   40     McGraw Hill   3

Q5. Display product name, price, stock and brand for products whose price is either below ₹1000
or above ₹3000. Arrange the result by stock in ascending order and price in descending order.


SQL> select product_name,price,stock,brand from product where price < 1000 or price > 3000 order by stock asc, price desc;

PRODUCT_NAME                                                                                              PRICE      STOCK BRAND
---------------------------------------------------------------------------------------------------- ---------- ---------- --------------------------------------------------
Smart Watch                                                                                                3999         30 Noise
Python Programming                                                                                          850         35 Pearson
Data Structures Book                                                                                        650         40 McGraw Hill
Cotton T-Shirt                                                                                              799        100 Puma


Q6. Display all products whose category is either 1 or 3, whose stock is not less than 30, and
whose price is below ₹4000. Arrange the products alphabetically by brand and then by price
in descending order.


SQL> select * from product where  category_id in(1,3) and stock >= 30 and price < 4000 order by brand asc, price desc;

PRODUCT_ID PRODUCT_NAME                                                         PRICE       STOCK BRAND                                              CATEGORY_ID
---------- ---------------------------------------------------------------------------------------------------- ---------- ---------- -------------------------------------------------- -----------
       201 Wireless Headphones                                                   2499          50 Boat                                                    1
       204 Data Structures Book                                                   650          40 McGraw Hill                                                    3
       202 Smart Watch                                                           3999          30 Noise                                                   1
       205 Python Programming                                                     850          35 Pearson                                                 3
Q7. Display all products whose name contains the letter o and whose price is greater than ₹500.
Arrange them in descending order of price.

SQL> set linesize 200;
SQL> SELECT * FROM Product WHERE LOWER(Product_Name) LIKE '%o%' AND Price > 500 ORDER BY Price DESC;

PRODUCT_ID PRODUCT_NAME                                                                                              PRICE      STOCK BRAND                 CATEGORY_ID
---------- ---------------------------------------------------------------------------------------------------- ---------- ---------- -------------------------------------------------- -----------
       201 Wireless Headphones                                                                                        2499         50 Boat                    1
       205 Python Programming                                                                                          850         35 Pearson                 3
       203 Cotton T-Shirt                                                                                              799        100 Puma                    2
       204 Data Structures Book                                                                                        650         40 McGraw Hill             3
Q8. Display all products whose name does not start with the letter C and whose stock is between
30 and 100. Arrange them first by stock in descending order and then by product name in
ascending order.

SQL> SELECT * FROM Product WHERE Product_Name NOT LIKE 'C%' AND Stock BETWEEN 30 AND 100 ORDER BY Stock DESC, Product_Name ASC;

PRODUCT_ID PRODUCT_NAME                                                                                              PRICE      STOCK BRAND                 CATEGORY_ID
---------- ---------------------------------------------------------------------------------------------------- ---------- ---------- -------------------------------------------------- -----------
       201 Wireless Headphones                                                                                        2499         50 Boat                    1
       204 Data Structures Book                                                                                        650         40 McGraw Hill             3
       205 Python Programming                                                                                          850         35 Pearson                 3
       202 Smart Watch                                                                                                3999         30 Noise                   1
Q9. Display all products having a price between ₹600 and ₹4000 but exclude products belonging
to category 2. Arrange the result by category number and then by price from highest to
lowest.

SQL> SELECT * FROM Product WHERE Price BETWEEN 600 AND 4000 AND Category_ID <> 2 ORDER BY Category_ID ASC, Price DESC;

PRODUCT_ID PRODUCT_NAME                                                                                              PRICE      STOCK BRAND                 CATEGORY_ID
---------- ---------------------------------------------------------------------------------------------------- ---------- ---------- -------------------------------------------------- -----------
       202 Smart Watch                                                                                                3999         30 Noise                   1
       201 Wireless Headphones                                                                                        2499         50 Boat                    1
       205 Python Programming                                                                                          850         35 Pearson                 3
       204 Data Structures Book                                                                                        650         40 McGraw Hill             3

Q10. Display all products whose brand name contains the letter a, whose price is less than ₹3000,
and whose stock is greater than 30. Arrange the result alphabetically by brand.


SQL> SELECT * FROM Product WHERE LOWER(Brand) LIKE '%a%' AND Price < 3000 AND Stock > 30 ORDER BY Brand ASC;

PRODUCT_ID PRODUCT_NAME                                                                                              PRICE      STOCK BRAND                 CATEGORY_ID
---------- ---------------------------------------------------------------------------------------------------- ---------- ---------- -------------------------------------------------- -----------
       201 Wireless Headphones                                                                                        2499         50 Boat                    1
       204 Data Structures Book                                                                                        650         40 McGraw Hill             3
       205 Python Programming                                                                                          850         35 Pearson                 3
       203 Cotton T-Shirt                                                                                              799        100 Puma                    2

Q11. Display all orders paid using either UPI or Card and having a total amount between ₹1000
and ₹5000. Arrange the result by payment mode alphabetically and then by total amount from
highest to lowest.


SQL> SELECT * FROM Orders WHERE Payment_Mode IN ('UPI', 'Card') AND Total_Amount BETWEEN 1000 AND 5000 ORDER BY Payment_Mode ASC, Total_Amount DESC;

  ORDER_ID CUSTOMER_ID ORDER_DAT TOTAL_AMOUNT PAYMENT_MODE         STATUS
---------- ----------- --------- ------------ -------------------- --------------------
       302         102 02-AUG-26         3999 Card                 Shipped
       309         104 06-AUG-26         2499 Card                 Confirmed
       310         101 06-AUG-26         4798 UPI                  Pending
       301         101 01-AUG-26         2499 UPI                  Delivered
       304         101 03-AUG-26         1500 UPI                  Confirmed
       307         102 05-AUG-26         1450 UPI                  Pending

6 rows selected.

Q12. Display all orders whose status is not Cancelled and whose total amount is greater than
₹1500. Arrange them by status in ascending order and total amount in descending order.


SQL> SELECT * FROM Orders WHERE Status <> 'Cancelled' AND Total_Amount > 1500 ORDER BY Status ASC, Total_Amount DESC;

  ORDER_ID CUSTOMER_ID ORDER_DAT TOTAL_AMOUNT PAYMENT_MODE         STATUS
---------- ----------- --------- ------------ -------------------- --------------------
       309         104 06-AUG-26         2499 Card                 Confirmed
       301         101 01-AUG-26         2499 UPI                  Delivered
       303         103 02-AUG-26         1598 Cash                 Delivered
       310         101 06-AUG-26         4798 UPI                  Pending
       306         105 04-AUG-26         4798 NetBanking           Shipped
       302         102 02-AUG-26         3999 Card                 Shipped

6 rows selected.

Q13. Display all orders placed by customers with Customer_ID 101, 102 or 104, where the
payment mode is not Cash. Arrange the result by Customer_ID in ascending order and
Order_Date in descending order.


SQL> SELECT * FROM Orders WHERE Customer_ID IN (101, 102, 104) AND Payment_Mode <> 'Cash' ORDER BY Customer_ID ASC, Order_Date DESC;

  ORDER_ID CUSTOMER_ID ORDER_DAT TOTAL_AMOUNT PAYMENT_MODE         STATUS
---------- ----------- --------- ------------ -------------------- --------------------
       310         101 06-AUG-26         4798 UPI                  Pending
       304         101 03-AUG-26         1500 UPI                  Confirmed
       301         101 01-AUG-26         2499 UPI                  Delivered
       307         102 05-AUG-26         1450 UPI                  Pending
       302         102 02-AUG-26         3999 Card                 Shipped
       309         104 06-AUG-26         2499 Card                 Confirmed
       305         104 03-AUG-26          850 Card                 Delivered

7 rows selected.

Q14. Display all orders whose payment mode is either UPI or NetBanking, whose status is not
Delivered, and whose total amount is greater than ₹1000. Arrange them by total amount in
descending order.


SQL> SELECT * FROM Orders WHERE Payment_Mode IN ('UPI', 'NetBanking') AND Status <> 'Delivered' AND Total_Amount > 1000 ORDER BY Total_Amount DESC;

  ORDER_ID CUSTOMER_ID ORDER_DAT TOTAL_AMOUNT PAYMENT_MODE         STATUS
---------- ----------- --------- ------------ -------------------- --------------------
       306         105 04-AUG-26         4798 NetBanking           Shipped
       310         101 06-AUG-26         4798 UPI                  Pending
       304         101 03-AUG-26         1500 UPI                  Confirmed
       307         102 05-AUG-26         1450 UPI                  Pending

Q15. Display all orders having a total amount between ₹500 and ₹3000, except those paid by Card.
Arrange the result by Payment_Mode alphabetically and then Total_Amount in ascending
order.

SQL> SELECT * FROM Orders WHERE Total_Amount BETWEEN 500 AND 3000 AND Payment_Mode <> 'Card' ORDER BY Payment_Mode ASC, Total_Amount ASC;

  ORDER_ID CUSTOMER_ID ORDER_DAT TOTAL_AMOUNT PAYMENT_MODE         STATUS
---------- ----------- --------- ------------ -------------------- --------------------
       308         103 05-AUG-26          650 Cash                 Delivered
       303         103 02-AUG-26         1598 Cash                 Delivered
       307         102 05-AUG-26         1450 UPI                  Pending
       304         101 03-AUG-26         1500 UPI                  Confirmed
       301         101 01-AUG-26         2499 UPI                  Delivered

Q16. Display all order details where the quantity is greater than 1 or the price is greater than
₹2000. Arrange the result by quantity in descending order and price in ascending order.


SQL> SELECT * FROM Order_Details WHERE Quantity > 1 OR Price > 2000 ORDER BY Quantity DESC, Price ASC;

  ORDER_ID PRODUCT_ID   QUANTITY      PRICE
---------- ---------- ---------- ----------
       303        203          2        799
       310        205          2        850
       301        201          1       2499
       310        201          1       2499
       306        201          1       2499
       309        201          1       2499
       310        202          1       3999
       302        202          1       3999
       306        202          1       3999

9 rows selected.

Q17. Display all order details where the quantity is between 1 and 2 and the price is not between
₹700 and ₹3000. Arrange the result first by price in descending order and then by quantity in
ascending order.

SQL> SELECT * FROM Order_Details WHERE Quantity BETWEEN 1 AND 2 AND Price NOT BETWEEN 700 AND 3000 ORDER BY Price DESC, Quantity ASC;

  ORDER_ID PRODUCT_ID   QUANTITY      PRICE
---------- ---------- ---------- ----------
       310        202          1       3999
       306        202          1       3999
       302        202          1       3999
       308        204          1        650
       305        204          1        650
       304        204          1        650
       307        204          1        650

7 rows selected.

Q18. Display all order details where the Product_ID is either 201, 203 or 205 and the quantity is
greater than 0. Arrange the result by Product_ID in ascending order and Quantity in
descending order.

SQL> SELECT * FROM Order_Details WHERE Product_ID IN (201, 203, 205) AND Quantity > 0 ORDER BY Product_ID ASC, Quantity DESC;

  ORDER_ID PRODUCT_ID   QUANTITY      PRICE
---------- ---------- ---------- ----------
       301        201          1       2499
       310        201          1       2499
       306        201          1       2499
       309        201          1       2499
       303        203          2        799
       309        203          1        799
       301        203          1        799
       310        205          2        850
       303        205          1        850
       308        205          1        850
       305        205          1        850

  ORDER_ID PRODUCT_ID   QUANTITY      PRICE
---------- ---------- ---------- ----------
       304        205          1        850
       307        205          1        850

13 rows selected.

Q19. Display all customers whose name contains the letter a, whose city is not Ahmedabad, and
whose gender is either M or F. Arrange the result by gender and then by customer name.

SQL> SELECT * FROM Customer WHERE LOWER(Customer_Name) LIKE '%a%' AND City <> 'Ahmedabad' AND Gender IN ('M', 'F') ORDER BY Gender ASC, Customer_Name ASC;

CUSTOMER_ID CUSTOMER_NAME                                      EMAIL                                                                                           MOBILE_NO  G
----------- -------------------------------------------------- ---------------------------------------------------------------------------------------------------- ---------- -
CITY                           REGISTRAT
------------------------------ ---------
        102 Neha Shah                                          neha@gmail.com                                                                                  9876543211 F
Surat                          23-AUG-26

        103 Amit Mehta                                         amit@gmail.com                                                                                  9876543212 M
Vadodara                       23-AUG-26

        105 Karan Joshi                                        karan@gmail.com                                                                                 9876543214 M
Rajkot                         23-AUG-26

Q20. Display all products whose name contains the letter i, whose price is between ₹500 and
₹4000, and whose stock is not between 30 and 50. Arrange the result by stock in ascending
order and price in descending order.

SQL> SELECT * FROM Product WHERE LOWER(Product_Name) LIKE '%i%' AND Price BETWEEN 500 AND 4000 AND Stock NOT BETWEEN 30 AND 50 ORDER BY Stock ASC, Price DESC;

PRODUCT_ID PRODUCT_NAME                                                                                              PRICE      STOCK BRAND                 CATEGORY_ID
---------- ---------------------------------------------------------------------------------------------------- ---------- ---------- -------------------------------------------------- -----------
       203 Cotton T-Shirt                                                                                              799        100 Puma                    2

:-UPDATE / Change / Modify DATA in the table.- With Rollback and Commit :
Q1. Change the city of the customer whose Customer_ID is 101 to Mumbai.

UPDATE Customer SET City = 'Mumbai' WHERE Customer_ID = 101;

Q2. Change the email address of customer 103 to amit.mehta@gmail.com.

UPDATE Customer SET Email = 'amit.mehta@gmail.com' WHERE Customer_ID = 103;

Q3. Change the stock of product 201 to 75.

UPDATE Product SET Stock = 75 WHERE Product_ID = 201;

Q4. Increase the price of product 203 to 899.

UPDATE Product SET Price = 899 WHERE Product_ID = 203;

Q5. Change the brand of product 205 to O&#39;Reilly.

UPDATE Product SET Brand = 'O''Reilly' WHERE Product_ID = 205;

Q6. Change the status of order 302 to Delivered.

UPDATE Orders SET Status = 'Delivered' WHERE Order_ID = 302;

Q7. Change the payment mode of order 307 to Card.

UPDATE Orders SET Payment_Mode = 'Card' WHERE Order_ID = 307;

Q8. Increase the stock of all products belonging to category 3 by 10.

UPDATE Product SET Stock = Stock + 10 WHERE Category_ID = 3;

Q9. Change the city of all customers from Surat to Ahmedabad.

UPDATE Customer SET City = 'Ahmedabad' WHERE City = 'Surat';

Q10. Change the status of all Pending orders to Confirmed.

UPDATE Orders SET Status = 'Confirmed' WHERE Status = 'Pending';

Q11. Increase the price of all products having a current price less than 1000 by 10%.

UPDATE Product SET Price = Price * 1.10 WHERE Price < 1000;

Q12. Increase the stock by 20 for products whose stock is less than 50 and whose price is less than
3000.

UPDATE Product SET Stock = Stock + 20 WHERE Stock < 50 AND Price < 3000;

Q13. Give a 15% discount on the price of all products belonging to category 3 whose current price
is greater than 700.

UPDATE Product SET Price = Price * 0.85 WHERE Category_ID = 3 AND Price > 700;

Q14. Change the status to Shipped for all orders whose status is Confirmed and whose payment
mode is either UPI or Card.

UPDATE Orders SET Status = 'Shipped' WHERE Status = 'Confirmed' AND Payment_Mode IN ('UPI', 'Card');

Q15. Change the city to Ahmedabad for customers who are currently from either Surat or
Vadodara and whose gender is F.

UPDATE Customer SET City = 'Ahmedabad' WHERE City IN ('Surat', 'Vadodara') AND Gender = 'F';

Q16. Increase the price of products whose name starts with S by 5%.

UPDATE Product SET Price = Price * 1.05 WHERE Product_Name LIKE 'S%';

Q17. Set the stock to 0 for all products whose stock is between 30 and 40 and whose category is 3.

UPDATE Product SET Stock = 0 WHERE Stock BETWEEN 30 AND 40 AND Category_ID = 3;

Q18. Change the payment mode to UPI for all orders whose current payment mode is Cash and
whose total amount is greater than 1000.

UPDATE Orders SET Payment_Mode = 'UPI' WHERE Payment_Mode = 'Cash' AND Total_Amount > 1000;

Q19. Increase the price by 8% for products belonging to category 1 or 2, but only when their current
stock is greater than 30.

UPDATE Product SET Price = Price * 1.08 WHERE Category_ID IN (1, 2) AND Stock > 30;

Q20. Change the status of orders to Cancelled where the current status is Pending and the total
amount is less than 1500.

UPDATE Orders SET Status = 'Cancelled' WHERE Status = 'Pending' AND Total_Amount < 1500; 