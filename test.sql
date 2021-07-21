#Test happy path insertion into each table
#Test that each constraint is properly catching whatever error it is designed to catch.

#TEST CUSTOMERS

	#HAPPY PATH
		insert into CUSTOMERS(NAME,STREET, CITY, STATE, ZIP, COMPANY_GROSS_INCOME_DOLLARS)
		VALUES('John Smith', '43 Main Street', 'Wilkinsburg', 'PA', 14447, 250000)

#TEST PRODUCTS
	#We already have a script where we insert products, so that part seems fine.

#TEST SALESPERSONS
	#HAPPY PATH
		insert into SALESPERSONS(NAME, STREET, CITY, STATE, ZIP, EMAIL, JOB_TITLE)
		VALUES('Jane Doe', '4739 Collins Avenue', 'TRACY', 'MN', 56175, 'Vorcy1964@jourrapide.com', 'Salesperson')

	#TEST EMAIL_FORMAT CHECK -- Should throw an error
		insert into SALESPERSONS(NAME, STREET, CITY, STATE, ZIP, EMAIL, JOB_TITLE)
		VALUES('Brian J Wooley', '1733 Nicholas Street', 'Concordia', 'KS', 66901, 'BadFormat', 'Salesperson')

#TEST EMPLOYEES
	#HAPPY PATH
		insert into EMPLOYEES(NAME, STREET, CITY, STATE, ZIP, PHONE, EMAIL)
		VALUES('Antonio M Burnside', '105 Woodland Avenue', 'New Orleans', 'LA', 70112, '202-555-0543', 'yicaxe9769@ovooovo.com')
	#TEST EMAIL_FORMAT CHECK
		insert into EMPLOYEES(NAME, STREET, CITY, STATE, ZIP, PHONE, EMAIL)
		VALUES('James V Haman', '4009 Walkers Ridge Way', 'SHASTA', 'CA', 96087, '202-555-0708', 'badformat@@@oeee...cccc')	
	#TEST PHONE_FORMAT CHECK
		insert into EMPLOYEES(NAME, STREET, CITY, STATE, ZIP, PHONE, EMAIL)
		VALUES('Cynthia M Hall', '410 Patterson Fork Road', 'Lombard', 'IL', 60148, '3126717922', 'yicaxe9769@ovooovo.com')

#TEST CASES
	#HAPPY PATH
		insert into CASES(SUMMARY, DESCRIPTION, STATUS, EMPLOYEE_ID, PRODUCT_ID, TIMEOPENED, TIMECLOSED)
		VALUES('Broken valve', 'Valve breaks upon attempting to turn with high-powered drill.', TRUE, 1, 2, TO_DATE('20210304','YYYYMMDD'), TO_DATE('20210512','YYYYMMDD'))
    
  #TEST NOT NULL TIMEOPENED FORMAT 
		insert into CASES(SUMMARY, DESCRIPTION, STATUS, EMPLOYEE_ID, PRODUCT_ID, TIMEOPENED, TIMECLOSED)
    VALUES('Broken valve', 'Valve breaks upon attempting to turn with high-powered drill.', TRUE, 1, 2, NULL, TO_DATE('20210512','YYYYMMDD'))

#TEST CASE_COMMENTS
	#HAPPY PATH
		insert into CASE_COMMENTS(CASE_ID, COMMENT_TIME, CASE_COMMENT)
		VALUES(1, '12:00:00', 'Maybe don''t use a high-powered drill to turn a valve, idiot')

	#M: Insert more case comments into the same case?
	#A: Yes, it would make sense to enable multiple case comments for a single case. Reflecting on this, I think the intention is to record the time of the comment was made, 
	#   so I made an edit to the CASE_COMMENTS table where CASE_TIME is now changed to COMMENT_TIME.
	#A: I had to put single quotes around the COMMENT_TIME to have the code work without errors.

#TEST RESOLUTIONS
	#HAPPY PATH
		insert into RESOLUTIONS(RES_NAME, PRODUCT, STEPS)
		VALUES('Valve Adaptation', 'Icetex', 'Customer was instructed to turn the valve with their hand rather than a high-powered drill. Customer reports product is now working effectively') 

	#A: I'm wondering if there is a way to create a constraint where the product specified in a resolution must also match the product specified in the case that LEADS_TO the associated resolution.
  #M: I think we can avoid this by resolving the LEADS_TO issue we previously specified.

#TEST SERVE
	#HAPPY PATH
	insert into SERVE(SP_ID, CUST_ID)
	VALUES(1,1)

	#Try to insert the same value and see if you get an error (you should)
	insert into SERVE(SP_ID, CUST_ID)
	VALUES(1,1)	

	#Test one(SP) to many(CUST)
	insert into SERVE(SP_ID, CUST_ID)
	VALUES(1,2)	
	
	#Test one(CUST) to many(SP)
	insert into SERVE(SP_ID, CUST_ID)
	VALUES(2,1)	

#TEST SELL
	#HAPPY PATH
	insert into SELL(SP_ID, P_ID)
	VALUES(1,1)

	#Try to insert the same value and see if you get an error (you should)
	insert into SELL(SP_ID, P_ID)
	VALUES(1,1)	

	#Test one(SP) to many(P)
	insert into SELL(SP_ID, P_ID)
	VALUES(1,2)	
	
	#Test one(P) to many(SP)
	insert into SELL(SP_ID, P_ID)
	VALUES(2,1)	

#TEST OWN
	#HAPPY PATH
	insert into OWN(CUST_ID, P_ID)
	VALUES(1,1)

	#Try to insert the same value and see if you get an error (you should)
	insert into OWN(CUST_ID, P_ID)
	VALUES(1,1)	

	#Test one(cust) to many(product)
	insert into OWN(CUST_ID, P_ID)
	VALUES(1,2)	
	
	#Test one(product) to many(cust)
	insert into OWN(CUST_ID, P_ID)
	VALUES(2,1)	

#TEST SUPPORT
	#HAPPY PATH
	insert into SUPPORT(CASE_ID, P_ID)
	VALUES(1,1)

	#Try to insert the same value and see if you get an error (you should)
	insert into SUPPORT(CASE_ID, P_ID)
	VALUES(1,1)	

	#Test one(case) to many(product) (should fail; only one product for case)
	insert into SUPPORT(CASE_ID, P_ID)
	VALUES(1,2)	
	
	#Test one(product) to many(case)
	insert into SUPPORT(CASE_ID, P_ID)
	VALUES(2,1)	

#TEST LEAD_TO
	#HAPPY PATH
	insert into LEAD_TO(CASE_ID, RES_ID)
	VALUES(1, 1)

	#Try to insert the same value and see if you get an error (you should)
	insert into LEAD_TO(CASE_ID, RES_ID)
	VALUES(1, 1)	

	#Test one(case) to many(resolution) (should fail; only one resolution for case)
	LEAD_TO(CASE_ID, RES_ID)
	VALUES(1,2)	
	
	#Test one(resolution) to many(case) (should fail; only one case for each resolution)
	insert into SUPPORT(CASE_ID, P_ID)
	VALUES(2,1)	

#TEST OPEN
	#None yet, as I have questions about its implementation

#TEST NOTE
	#None yet, as I have questions about its implementation

#TEST RELATE_TO
	#None yet, as I have questions about its implementation
