CREATE TABLE CUSTOMERS(
	CUST_ID INT GENERATED ALWAYS AS IDENTITY,
	SP_ID INT,
	NAME VARCHAR(255) NOT NULL,
	STREET VARCHAR(255),
	CITY VARCHAR(255),
	STATE VARCHAR(2),
	ZIP VARCHAR(5),
	COMPANY_GROSS_INCOME_DOLLARS FLOAT(25),
	PRIMARY KEY(CUST_ID),
	FOREIGN KEY (SP_ID) REFERENCES SALESPERSONS(SP_ID),
);

CREATE TABLE PRODUCTS(
	P_ID INT GENERATED ALWAYS AS IDENTITY,
	NAME VARCHAR(255),
	DESCRIPTION VARCHAR(255),
	PRIMARY KEY(P_ID),
	UNIQUE (NAME)
);

CREATE TABLE SALESPERSONS(
	SP_ID INT GENERATED ALWAYS AS IDENTITY,
	NAME VARCHAR(255) NOT NULL,
	STREET VARCHAR(255),
	CITY VARCHAR(255),
	STATE VARCHAR(2),
	ZIP VARCHAR(5),
	EMAIL VARCHAR(255),
	JOB_TITLE VARCHAR(255),
	PRIMARY KEY(SP_ID)
);

CREATE TABLE EMPLOYEES(
	EMP_ID INT GENERATED ALWAYS AS IDENTITY,
	NAME VARCHAR(255) NOT NULL,
	STREET VARCHAR(255),
	CITY VARCHAR(255),
	STATE VARCHAR(2),
	ZIP VARCHAR(5),
	PHONE VARCHAR(25),
	EMAIL VARCHAR(255),
	PRIMARY KEY(EMP_ID)
);

CREATE TABLE CASES(
	CASE_ID INT GENERATED ALWAYS AS IDENTITY
	SUMMARY VARCHAR(255) NOT NULL,
	DESCRIPTION VARCHAR(255),
	STATUS BOOLEAN NOT NULL,
	EMP_ID INT NOT NULL,
	P_ID INT NOT NULL,
	TIMEOPENED DATE NOT NULL,
	TIMECLOSED DATE,
	PRIMARY KEY(CASE_ID),
	FOREIGN KEY (P_ID) REFERENCES PRODUCTS(P_ID),
	FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEES(EMP_ID)
);

CREATE TABLE CASE_COMMENTS(
	COM_ID INT GENERATED ALWAYS AS IDENTITY,
	CASE_ID INT,
	COMMENT_TIME TIME,
	CASE_COMMENT VARCHAR(255),
	PRIMARY KEY(COM_ID),
	FOREIGN KEY (CASE_ID) REFERENCES CASES(CASE_ID),
	UNIQUE (CASE_ID, COM_ID)
);

CREATE TABLE RESOLUTIONS(
	RES_ID INT GENERATED ALWAYS AS IDENTITY,
	P_ID INT,
	RES_NAME VARCHAR(255),
	STEPS VARCHAR(255),
	PRIMARY KEY(RES_ID),
	FOREIGN KEY (P_ID) REFERENCES PRODUCTS(P_ID)
);

CREATE TABLE SELL(
	SELL_ID SERIAL,
	SP_ID INT,
	P_ID INT,
 	PRIMARY KEY (SELL_ID),
	FOREIGN KEY (SP_ID) REFERENCES SALESPERSONS(SP_ID),
	FOREIGN KEY (P_ID) REFERENCES PRODUCTS(P_ID)
);

CREATE TABLE OWN(
	O_ID SERIAL,
	CUST_ID INT,
	P_ID INT,
 	PRIMARY KEY (O_ID),
	FOREIGN KEY (P_ID) REFERENCES PRODUCTS(P_ID),
	FOREIGN KEY (CUST_ID) REFERENCES CUSTOMERS(CUST_ID)
);

CREATE TABLE NOTE(
	N_ID SERIAL,
	COM_ID INT,
	EMP_ID INT,
 	PRIMARY KEY (N_ID),
	FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEES(EMP_ID),
	FOREIGN KEY (COM_ID) REFERENCES CASE_COMMENTS(COM_ID),
	UNIQUE (EMP_ID, COM_ID)
);

/* Creating Indexes */
CREATE INDEX IX_CUSTOMERS1 on CUSTOMERS(CUST_ID, NAME);

CREATE INDEX IX_PRODUCTS1 on PRODUCTS(P_ID, NAME);

CREATE INDEX IX_EMPLOYEES1 on EMPLOYEES(EMP_ID, NAME);

CREATE INDEX IX_CASES1 on CASES(CASE_ID, STATUS, TIMEOPENED, TIMECLOSED);

CREATE INDEX IX_RESOLUTIONS1 on RESOLUTIONS(RES_ID, PRODUCT);



/* LIST OF QUERIES AND DESCRIPTION OF THEIR FUNCTIONALITY */

/* Search for cases by status and timeframe */
SELECT *
FROM CASES
WHERE STATUS = TRUE 
AND TIMEOPENED >= '20210303' AND TIMECLOSED <= '20210508'
 
/* Search for a customer and view products the customer has purchased */
SELECT C.NAME, P.NAME
FROM CUSTOMERS C, PRODUCTS P, OWN O
WHERE C.CUST_ID = O.CUST_ID AND O.P_ID = P.P_ID
AND C.NAME LIKE '%Bart%'

/* Search for common resolutions by product */
SELECT RES_NAME, PRODUCT, STEPS
FROM RESOLUTIONS
WHERE PRODUCT = 'Icetex'

/* Search for cases by product */


/* Search for cases by customer */
