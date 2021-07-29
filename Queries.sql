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

/* Search for personal and contact information about a customer */
SELECT NAME, STREET, CITY, STATE, ZIP, COMPANY, COMPANY_GROSS_INCOME_DOLLARS
FROM CUSTOMERS
WHERE NAME LIKE '%Bart%'

/* See general information for a specific case given the case number (status, customer name, product, case summary, case description, case comments)
SELECT DISTINCT CA.CASE_ID, CA.STATUS, CU.NAME, P.NAME, CA.SUMMARY, CA.DESCRIPTION, CA.TIMEOPENED, CA.TIMECLOSED, CC.CASE_COMMENT 
FROM CASES CA, CUSTOMERS CU, RESOLUTIONS R, CASE_COMMENTS CC, OWN O, PRODUCTS P
WHERE CA.CASE_ID = 1
AND CA.O_ID = O.O_ID AND O.CUST_ID = CU.CUST_ID AND O.P_ID = P.P_ID AND CC.CASE_ID = CA.CASE_ID
/* Search for cases by status and timeframe */
SELECT *
FROM CASES
WHERE STATUS = TRUE 
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
SELECT distinct COMPANY, SUM(COMPANY_GROSS_INCOME_DOLLARS)
FROM CUSTOMERS
GROUP BY COMPANY

/* The number of cases a specific employee currently has opened and the number that employee has closed */
SELECT C.STATUS, COUNT(CASE_ID) as CASE_COUNT
FROM CASES C
WHERE C.EMP_ID = 1
GROUP BY C.STATUS
ORDER BY CASE_COUNT

