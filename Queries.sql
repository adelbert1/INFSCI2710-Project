/* LIST OF QUERIES AND DESCRIPTION OF THEIR FUNCTIONALITY */

/* Search for a list of all available products */
SELECT *
FROM PRODUCTS

/* Search for products owned by a specific customer */
SELECT C.NAME, P.NAME AS PRODUCT, COUNT(P.NAME)
FROM PRODUCTS P, CUSTOMERS C, OWN O
WHERE O.P_ID = P.P_ID AND O.CUST_ID = C.CUST_ID
AND C.NAME LIKE '%Bart Simpson%'
GROUP BY P.NAME, C.NAME 
ORDER BY C.NAME

/* Search for all customers with or including given name and return all of their information. */
SELECT * 
FROM CUSTOMERS
WHERE NAME LIKE '%Bart%'

/* Search for personal and contact information about a customer */
SELECT NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, COMPANY, COMPANY_GROSS_INCOME_DOLLARS
FROM CUSTOMERS
WHERE NAME LIKE '%Bart%'

/* See general information for a specific case given the case number (status, customer name, product, case summary, case description, case comments) */
SELECT DISTINCT CA.CASE_ID, CA.STATUS, CU.NAME, P.NAME, CA.SUMMARY, CA.DESCRIPTION, CA.TIMEOPENED, CA.TIMECLOSED, CC.CASE_COMMENT 
FROM CASES CA, CUSTOMERS CU, RESOLUTIONS R, CASE_COMMENTS CC, OWN O, PRODUCTS P
WHERE CA.CASE_ID = 1
AND CA.O_ID = O.O_ID AND O.CUST_ID = CU.CUST_ID AND O.P_ID = P.P_ID AND CC.CASE_ID = CA.CASE_ID

/* Search for open cases by status and timeframe */
SELECT *
FROM CASES
WHERE STATUS = TRUE 
AND TIMEOPENED >= '20210303'

/* Search for closed cases by status and timeframe */
SELECT *
FROM CASES
WHERE STATUS = FALSE 
AND TIMEOPENED >= '20210303' AND TIMECLOSED <= '20210508'

/* Search for common resolutions by product */
SELECT P.NAME, R.RES_NAME, R.STEPS
FROM RESOLUTIONS R, CASES C, OWN O, PRODUCTS P
WHERE R.CASE_ID = C.CASE_ID AND C.O_ID = O.O_ID AND O.P_ID = P.P_ID
AND P.NAME = 'Alphalax'

/* Search for cases by product */
SELECT *
FROM CASES C, PRODUCTS P, OWN O
WHERE O.O_ID = C.O_ID AND O.P_ID = P.P_ID
AND P.NAME = 'Alphalax'

/* Search for cases by customer */
SELECT CU.NAME, CA.CASE_ID, CA.STATUS, CA.EMP_ID, CA.SUMMARY, CA.DESCRIPTION, CA.TIMEOPENED, CA.TIMECLOSED 
FROM CASES CA, CUSTOMERS CU, OWN O
WHERE CA.O_ID = O.O_ID AND O.CUST_ID = CU.CUST_ID 
AND CU.NAME LIKE '%Bart Simpson%'

/* Number of Support Cases by Product (ordered by largest) */
SELECT P.NAME as PRODUCT, COUNT(CASE_ID) as CASE_COUNT
FROM CASES C, PRODUCTS P, OWN O
WHERE C.O_ID = O.O_ID AND O.P_ID = P.P_ID
GROUP BY P.NAME
ORDER BY COUNT(CASE_ID) DESC

/* Number of Support Cases Closed by Employee (ordered by largest) */
SELECT E.NAME, COUNT(CASE_ID) as CASE_COUNT
FROM CASES C, EMPLOYEES E
WHERE C.EMP_ID = E.EMP_ID AND C.STATUS = FALSE
GROUP BY E.NAME
ORDER BY COUNT(CASE_ID) DESC

/* Number of Support Cases by Customer (ordered by largest) */
SELECT CU.NAME, COUNT(CASE_ID) as CASE_COUNT
FROM CASES CA, CUSTOMERS CU, OWN O
WHERE CA.O_ID = O.O_ID AND O.CUST_ID = CU.CUST_ID
GROUP BY CU.NAME
ORDER BY COUNT(CASE_ID) DESC

/* Number of Support cases by customer’s company(ordered by largest) */
SELECT CU.COMPANY, COUNT(CASE_ID) as CASE_COUNT
FROM CASES CA, CUSTOMERS CU, OWN O
WHERE CA.O_ID = O.O_ID AND O.CUST_ID = CU.CUST_ID
GROUP BY CU.COMPANY
ORDER BY COUNT(CASE_ID) DESC

/* Total number of products sold, grouped by product */
SELECT P.NAME, COUNT(O.P_ID) as NUMBER_SOLD
FROM OWN O, PRODUCTS P
WHERE O.P_ID = P.P_ID
GROUP BY P.NAME
ORDER BY NUMBER_SOLD DESC

/* The total number of products that have been sold by individual salespeople, grouped by product */
SELECT S.NAME, P.NAME, COUNT(O.O_ID) AS Total_Products_Sold
FROM SALESPERSONS S, PRODUCTS P, OWN O, CUSTOMERS C
WHERE S.SP_ID = C.SP_ID AND C.CUST_ID = O.CUST_ID AND O.P_ID = P.P_ID
GROUP BY S.NAME, P.NAME
ORDER BY S.NAME, Total_Products_Sold DESC

/* The total amount of money a specific company has spent on products. */ 
SELECT distinct COMPANY, SUM(COMPANY_GROSS_INCOME_DOLLARS) as Total_Gross
FROM CUSTOMERS
GROUP BY COMPANY 
ORDER BY Total_Gross DESC

/* The number of cases a specific employee currently has opened and the number that employee has closed */
SELECT C.STATUS, COUNT(CASE_ID) as CASE_COUNT
FROM CASES C
WHERE C.EMP_ID = 1
GROUP BY C.STATUS
ORDER BY CASE_COUNT

/* --QUERIES FOR CREATION OF NEW TUPLES IN EACH TABLE-- */

/* Insert new salesperson info */
insert into SALESPERSONS(NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, JOB_TITLE)
VALUES('Jane Doe', '4739 Collins Avenue', 'TRACY', 'MN', 56175, 'Vorcy1964@jourrapide.com', '657-444-5555', 'Salesperson')

/* Insert new customer information */
INSERT INTO CUSTOMERS (NAME, SP_ID, STREET, CITY, STATE, ZIP, EMAIL, PHONE, COMPANY, COMPANY_GROSS_INCOME_DOLLARS)
VALUES('Bart Simpson', 3, '123 Main St.', 'Springfield', 'IL', '12345', 'bart@gmail.com', '555-555-5555', 'Springfield Elementary', 10)

/* Insert new product information */
INSERT INTO PRODUCTS(NAME, DESCRIPTION)
VALUES('Alphalax', 'Never go on a rollercoaster again!')

/* Create a record of product ownership */
INSERT INTO OWN(CUST_ID, P_ID) 
VALUES(1,1)

/* Insert new case */
insert into CASES(SUMMARY, DESCRIPTION, STATUS, EMP_ID, O_ID, TIMEOPENED, TIMECLOSED)
VALUES('Broken valve', 'Valve breaks upon attempting to turn with high-powered drill.', TRUE, 1, 1, TO_DATE('20210304','YYYYMMDD'), NULL)

/* Insert new case comments */
insert into CASE_COMMENTS(CASE_ID, COMMENT_TIME, COMMENT_DATE, CASE_COMMENT)
VALUES (1, '12:00:00', TO_DATE('20210304','YYYYMMDD'), 'Maybe don''t use a high-powered drill to turn a valve, idiot')

/* Insert new resolution */
insert into RESOLUTIONS(RES_NAME, STEPS, CASE_ID)
VALUES('Valve Fixed', 'Customer was instructed to reverse the high-powered drill and run it in the opposite direction.', 1)

/* Insert new sell info */
insert into SELL(SP_ID, P_ID)
VALUES(1,1)

--UPDATE AND DELETE CASES

--Update address of customer
UPDATE CUSTOMER
SET STREET = '123 MAIN STREET', CITY = 'EXAMPLETOWN', STATE = 'CA', ZIP = '60999'
WHERE CUST_ID = 1

--Delete Salesperson from Table
DELETE FROM SALESPERSONS
WHERE SP_ID = 1

--Close case
UPDATE CASE
SET TIMECLOSED = TO_DATE('01/02/2021', 'MM/DD/YYYY')
WHERE CASE_ID = 1
