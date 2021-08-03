//Test happy path insertion into each table
//Test that each constraint is properly catching whatever error it is designed to catch.

//Assumptions: System users will not enter numeric characters where it is not appropriate. For example, they will not enter numbers in the CUSTOMERS name, city, state, or company fields. 

/*Note: Wherever a test is marked as PASS, it indicates that the DDL code worked as expected. 
Either 1) an error results where we expected to receive an error or 
2) the code did not result in an error when we did not expect any errors. */

//TEST SALESPERSONS

	//HAPPY PATH
		insert into SALESPERSONS(NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, JOB_TITLE)
		VALUES('Jane Doe', '4739 Collins Avenue', 'TRACY', 'MN', 56175, 'Vorcy1964@jourrapide.com', '412-444-1234', 'Salesperson')

	//TEST EMAIL_FORMAT CHECK -- Email entries that are not in the proper format should result in an error
		insert into SALESPERSONS(NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, JOB_TITLE)
		VALUES('Brian J Wooley', '1733 Nicholas Street', 'Concordia', 'KS', 66901, 'BadFormat', '412-444-1234', 'Salesperson')
		
		insert into SALESPERSONS(NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, JOB_TITLE)
		VALUES('Brian J Wooley', '1733 Nicholas Street', 'Concordia', 'KS', 66901, 'Bad@@Format.com', '412-444-1234', 'Salesperson')
		
		insert into SALESPERSONS(NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, JOB_TITLE)
		VALUES('Brian J Wooley', '1733 Nicholas Street', 'Concordia', 'KS', 66901, 'Bad@Format..com', '412-444-1234', 'Salesperson')
	//Test Result: PASS
	
	//TEST PHONE_FORMAT CHECK -- Phone entries that are not in the proper format should result in an error
		insert into SALESPERSONS(NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, JOB_TITLE)
		VALUES('Brian J Wooley', '1733 Nicholas Street', 'Concordia', 'KS', 66901, 'Vorcy1964@jourrapide.com', '4124441234', 'Salesperson')
		
		insert into SALESPERSONS(NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, JOB_TITLE)
		VALUES('Brian J Wooley', '1733 Nicholas Street', 'Concordia', 'KS', 66901, 'Vorcy1964@jourrapide.com', '412.444.1234', 'Salesperson')
	//Test Result: PASS

	//TEST BLANK AND NULL NAMES
	//Blank or null entries in NAME field should result in an arror.
		insert into SALESPERSONS(NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, JOB_TITLE)
		VALUES('', '4739 Collins Avenue', 'TRACY', 'MN', 56175, 'Vorcy1964@jourrapide.com', 'Salesperson')

		insert into SALESPERSONS(NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, JOB_TITLE)
		VALUES(NULL, '4739 Collins Avenue', 'TRACY', 'MN', 56175, 'Vorcy1964@jourrapide.com', 'Salesperson')
	//Test Result: PASS	

//TEST CUSTOMERS

	//HAPPY PATH
		insert into CUSTOMERS(SP_ID, NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, COMPANY, COMPANY_GROSS_INCOME_DOLLARS)
		VALUES(1, 'John Smith', '43 Main Street', 'Wilkinsburg', 'PA', 14447, 'j.smith@gmail.com', '412-333-4567', 'Bob''s Burgers', 250000)

	//TEST BLANK AND NULL NAMES
	//Blank or null entries in NAME field should result in an arror.
		insert into CUSTOMERS(SP_ID, NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, COMPANY, COMPANY_GROSS_INCOME_DOLLARS)
		VALUES(1, '', '43 Main Street', 'Wilkinsburg', 'PA', 14447, 'j.smith@gmail.com', '412-333-4567', 'Bob''s Burgers', 250000)

		insert into CUSTOMERS(SP_ID, NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, COMPANY, COMPANY_GROSS_INCOME_DOLLARS)
		VALUES(1, NULL, '43 Main Street', 'Wilkinsburg', 'PA', 14447, 'j.smith@gmail.com', '412-333-4567', 'Bob''s Burgers', 250000)
	//Test Result: PASS
 

	//TEST BLANK AND NULL SP_ID
	//Blank or null entries in SP_ID field should result in an arror.
		iinsert into CUSTOMERS(SP_ID, NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, COMPANY, COMPANY_GROSS_INCOME_DOLLARS)
		VALUES('', 'Test Name', '43 Main Street', 'Wilkinsburg', 'PA', 14447, 'j.smith@gmail.com', '412-333-4567', 'Bob''s Burgers', 250000)

		insert into CUSTOMERS(SP_ID, NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, COMPANY, COMPANY_GROSS_INCOME_DOLLARS)
		VALUES(NULL, 'Test Name', '43 Main Street', 'Wilkinsburg', 'PA', 14447, 'j.smith@gmail.com', '412-333-4567', 'Bob''s Burgers', 250000)
	//Test Result: PASS
	
	//TEST EMAIL_FORMAT CHECK -- Email entries that are not in the proper format should result in an error
		insert into CUSTOMERS(SP_ID, NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, COMPANY, COMPANY_GROSS_INCOME_DOLLARS)
		VALUES(1, 'John Smith', '43 Main Street', 'Wilkinsburg', 'PA', 14447, 'badformat', '412-333-4567', 'Bob''s Burgers', 250000)
		
		insert into CUSTOMERS(SP_ID, NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, COMPANY, COMPANY_GROSS_INCOME_DOLLARS)
		VALUES(1, 'John Smith', '43 Main Street', 'Wilkinsburg', 'PA', 14447, 'bad@@@format...com', '412-333-4567', 'Bob''s Burgers', 250000)
		
	//Test Result: PASS
	
	//TEST PHONE_FORMAT CHECK -- Phone entries that are not in the proper format should result in an error
		insert into CUSTOMERS(SP_ID, NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, COMPANY, COMPANY_GROSS_INCOME_DOLLARS)
		VALUES(1, 'John Smith', '43 Main Street', 'Wilkinsburg', 'PA', 14447, 'j.smith@gmail.com', '4123334567', 'Bob''s Burgers', 250000)
		
		insert into CUSTOMERS(SP_ID, NAME, STREET, CITY, STATE, ZIP, EMAIL, PHONE, COMPANY, COMPANY_GROSS_INCOME_DOLLARS)
		VALUES(1, 'John Smith', '43 Main Street', 'Wilkinsburg', 'PA', 14447, 'j.smith@gmail.com', '412.333.4567', 'Bob''s Burgers', 250000)
	//Test Result: PASS

//TEST PRODUCTS
	//HAPPY PATH
		insert into PRODUCTS(NAME, DESCRIPTION)

	//TEST BLANK AND NULL NAMES
	//Blank or null entries in NAME field should result in an arror.
		insert into PRODUCTS(NAME, DESCRIPTION)
		VALUES('', 'Test Description')

		insert into PRODUCTS(NAME, DESCRIPTION)
		VALUES(NULL, 'Test Description')
	//Test Result: PASS

	//TEST BLANK AND NULL DESCRIPTIONS
	//Blank or null entries in DESCRIPTION field should result in an arror.
		insert into PRODUCTS(NAME, DESCRIPTION)
		VALUES('Test Name', '')

		insert into PRODUCTS(NAME, DESCRIPTION)
		VALUES('Test Name', NULL)
	//Test Result: PASS	



//TEST EMPLOYEES
	//HAPPY PATH
		insert into EMPLOYEES(NAME, STREET, CITY, STATE, ZIP, PHONE, EMAIL)
		VALUES('Antonio M Burnside', '105 Woodland Avenue', 'New Orleans', 'LA', 70112, '202-555-0543', 'yicaxe9769@ovooovo.com')
	
	//TEST NULL NAMES
	//Blank or null entries in NAME field should result in an arror.
		insert into EMPLOYEES(NAME, STREET, CITY, STATE, ZIP, PHONE, EMAIL)
		VALUES('', '105 Woodland Avenue', 'New Orleans', 'LA', 70112, '202-555-0543', 'yicaxe9769@ovooovo.com')

		insert into EMPLOYEES(NAME, STREET, CITY, STATE, ZIP, PHONE, EMAIL)
		VALUES(NULL, '105 Woodland Avenue', 'New Orleans', 'LA', 70112, '202-555-0543', 'yicaxe9769@ovooovo.com')
	//Test Result: PASS

	//TEST EMAIL_FORMAT CHECK
		insert into EMPLOYEES(NAME, STREET, CITY, STATE, ZIP, PHONE, EMAIL)
		VALUES('James V Haman', '4009 Walkers Ridge Way', 'SHASTA', 'CA', 96087, '202-555-0708', 'badformat@@@oeee...cccc')	
	
	//TEST PHONE_FORMAT CHECK
		insert into EMPLOYEES(NAME, STREET, CITY, STATE, ZIP, PHONE, EMAIL)
		VALUES('Cynthia M Hall', '410 Patterson Fork Road', 'Lombard', 'IL', 60148, '3126717922', 'yicaxe9769@ovooovo.com')


//TEST OWN
	//HAPPY PATH
		insert into OWN(CUST_ID, P_ID)
		VALUES(1,1)

	//TEST MANY-TO-MANY RELATIONSHP BETWEEN CUSTOMERS AND PRODUCTS
	/*A Customer should be able to own many different products. 
	Conversely, any individual product should be able to be owned by many different customers.
	The addition of multiple entries should not result in any errors.*/

	//Test one(CUST) to many(P)
		insert into OWN(CUST_ID, P_ID)
		VALUES (1,1), (1,2)	
	//Test Result: PASS
	
	//Test one(P) to many(CUST)
		insert into OWN(CUST_ID, P_ID)
		VALUES (1, 1), (2,1)
	//Test Result: PASS	


//TEST CASES
	//HAPPY PATH
		insert into CASES(SUMMARY, DESCRIPTION, STATUS, EMP_ID, O_ID, TIMEOPENED, TIMECLOSED)
		VALUES('Broken valve', 'Valve breaks upon attempting to turn with high-powered drill.', TRUE, 1, 2, TO_DATE('20210304','YYYYMMDD'), NULL)

	//TEST BLANK AND NULL SUMMARY
	//Blank or null entries in SUMMARY field should result in an arror.
		insert into CASES(SUMMARY, DESCRIPTION, STATUS, EMP_ID, O_ID, TIMEOPENED, TIMECLOSED)
		VALUES('', 'Test Case', TRUE, 1, 2, TO_DATE('20210304','YYYYMMDD'), NULL)

		insert into CASES(SUMMARY, DESCRIPTION, STATUS, EMP_ID, O_ID, TIMEOPENED, TIMECLOSED)
		VALUES(NULL, 'Test Case', TRUE, 1, 2, TO_DATE('20210304','YYYYMMDD'), NULL)
	//Test Result: PASS

	//TEST BLANK OR NULL STATUS
	//Blank or null entries in STATUS field should result in an arror.
		insert into CASES(SUMMARY, DESCRIPTION, STATUS, EMP_ID, O_ID, TIMEOPENED, TIMECLOSED)
		VALUES('Test Case', 'Test Case', "", 1, 2, TO_DATE('20210304','YYYYMMDD'), NULL)

		insert into CASES(SUMMARY, DESCRIPTION, STATUS, EMP_ID, O_ID, TIMEOPENED, TIMECLOSED)
		VALUES('Test Case', 'Test Case', NULL, 1, 2, TO_DATE('20210304','YYYYMMDD'), NULL)
	//Test Result: PASS		

	//TEST NON-BOOLEAN STATUS
	//Non-boolean entries in STATUS field should result in an arror.
		insert into CASES(SUMMARY, DESCRIPTION, STATUS, EMP_ID, O_ID, TIMEOPENED, TIMECLOSED)
		VALUES('Test Case', 'Test Case', 3, 1, 2, TO_DATE('20210304','YYYYMMDD'), NULL)
	//Test Result: PASS

	//TEST BLANK AND NULL TIMEOPENED
	//Blank or null entries in TIMEOPENED field should result in an arror.
		insert into CASES(SUMMARY, DESCRIPTION, STATUS, EMP_ID, O_ID, TIMEOPENED, TIMECLOSED)
		VALUES('Test Case', 'Test Case', TRUE, 1, 2, "", NULL)

		insert into CASES(SUMMARY, DESCRIPTION, STATUS, EMP_ID, O_ID, TIMEOPENED, TIMECLOSED)
		VALUES('Test Case', 'Test Case', TRUE, 1, 2, NULL, NULL)
	//Test Result: PASS			
	
	//TEST CONDITIONAL TIMECLOSED
	//TIMECLOSED should not accept an entry unless that status of the case is set to closed.
		insert into CASES(SUMMARY, DESCRIPTION, STATUS, EMP_ID, O_ID, TIMEOPENED, TIMECLOSED)
		VALUES('Test Case', 'Test Case', TRUE, 1, 2, TO_DATE('20210304','YYYYMMDD'), TO_DATE('20210305','YYYYMMDD'))
		//The above result should be a failure
		
		insert into CASES(SUMMARY, DESCRIPTION, STATUS, EMP_ID, O_ID, TIMEOPENED, TIMECLOSED)
		VALUES('Test Case', 'Test Case', FALSE, 1, 2, TO_DATE('20210304','YYYYMMDD'), TO_DATE('20210305','YYYYMMDD'))
		//The above result should be a success
	//Test Result: PASS		
	

//TEST CASE_COMMENTS
	//HAPPY PATH
		insert into CASE_COMMENTS(CASE_ID, COMMENT_TIME, COMMENT_DATE, CASE_COMMENT)
		VALUES(1, '12:00:00', TO_DATE('20210304','YYYYMMDD'), 'Maybe don''t use a high-powered drill to turn a valve, idiot')

	//TEST BLANK AND NULL COMMENT_TIME
	//Blank or null entries in COMMENT_TIME field should result in an arror.
		insert into CASE_COMMENTS(CASE_ID, COMMENT_TIME, COMMENT_DATE, CASE_COMMENT)
		VALUES(1, '', TO_DATE('20210304','YYYYMMDD'), 'Maybe don''t use a high-powered drill to turn a valve, idiot')
		
		insert into CASE_COMMENTS(CASE_ID, COMMENT_TIME, COMMENT_DATE, CASE_COMMENT)
		VALUES(1, NULL, TO_DATE('20210304','YYYYMMDD'), 'Maybe don''t use a high-powered drill to turn a valve, idiot')
	//Test Result: PASS

	//TEST BLANK AND NULL CASE_DATE
	//Blank or null entries in CASE_DATE field should result in an arror.
		insert into CASE_COMMENTS(CASE_ID, COMMENT_TIME, COMMENT_DATE, CASE_COMMENT)
		VALUES(1, '12:00:00', '', 'Maybe don''t use a high-powered drill to turn a valve, idiot')
		
		insert into CASE_COMMENTS(CASE_ID, COMMENT_TIME, COMMENT_DATE, CASE_COMMENT)
		VALUES(1, '12:00:00', NULL, 'Maybe don''t use a high-powered drill to turn a valve, idiot')
	//Test Result: PASS	

	//TEST BLANK AND NULL CASE_COMMENT
	//Blank or null entries in CASE_COMMENT field should result in an arror.
		insert into CASE_COMMENTS(CASE_ID, COMMENT_TIME, COMMENT_DATE, CASE_COMMENT)
		VALUES(1, '12:00:00', TO_DATE('20210304','YYYYMMDD'), '')
		
		insert into CASE_COMMENTS(CASE_ID, COMMENT_TIME, COMMENT_DATE, CASE_COMMENT)
		VALUES(1, '12:00:00', TO_DATE('20210304','YYYYMMDD'), NULL)
	//Test Result: PASS			


//TEST RESOLUTIONS
	//HAPPY PATH
		insert into RESOLUTIONS(RES_NAME, STEPS, CASE_ID)
		VALUES('Valve Adaptation', 'Customer was instructed to turn the valve with their hand rather than a high-powered drill. Customer reports product is now working effectively', 1) 
	
	//TEST BLANK AND NULL RES_NAME
	//Blank or null entries in RES_NAME field should result in an arror.
		insert into RESOLUTIONS(RES_NAME, STEPS, CASE_ID)
		VALUES('', 'Test Steps', 2) 

		insert into RESOLUTIONS(RES_NAME, STEPS, CASE_ID)
		VALUES(NULL, 'Test Steps', 2) 
	//Test Result: PASS

	//TEST BLANK AND NULL STEPS
	//Blank or null entries in STEPS field should result in an arror.
		insert into RESOLUTIONS(RES_NAME, STEPS, CASE_ID)
		VALUES('Test Resolution', '', 2)

		insert into RESOLUTIONS(RES_NAME, STEPS, CASE_ID)
		VALUES('Test Resolution', NULL, 2)
 	//Test Result: PASS	

	//TEST ONE-TO-ONE RELATIONSHIP WITH CASES
	//A single case can not have more than one resolution. Accordingly, the entry of a second resolution for a case should result in an error.
		insert into RESOLUTIONS(RES_NAME, STEPS, CASE_ID)
		VALUES('Test Resolution', 'Test Steps', 1), ('Test Resolution2', 'Test Steps2', 1) 
	//Test Result: PASS	


//TEST SELL
	//HAPPY PATH
		insert into SELL(SP_ID, P_ID)
		VALUES(1,1)

	//TEST MANY-TO-MANY RELATIONSHP BETWEEN SALESPERSONS AND PRODUCTS
	/*A Salesperson should be able to sell many different products. 
	Conversely, any individual product should be able to be sold by many different salespeople.
	The addition of multiple entries should not result in any errors.*/

	//Test one(SP) to many(P)
		insert into SELL(SP_ID, P_ID)
		VALUES (1,1), (1,2)	
	//Test Result: PASS
	
	//Test one(P) to many(SP)
		insert into SELL(SP_ID, P_ID)
		VALUES (1, 1), (2,1)
	//Test Result: PASS	
