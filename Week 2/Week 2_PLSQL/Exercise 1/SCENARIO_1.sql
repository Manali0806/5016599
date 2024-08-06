SQL> SELECT * FROM CUSTOMERS;

CUSTOMERID                                                                      
----------                                                                      
NAME                                                                            
--------------------------------------------------------------------------------
DOB          BALANCE LASTMODIF                                                  
--------- ---------- ---------                                                  
         1                                                                      
John Doe                                                                        
15-MAY-85       1000 04-AUG-24                                                  
                                                                                
         2                                                                      
Jane Smith                                                                      
20-JUL-90       1500 04-AUG-24                                                  

CUSTOMERID                                                                      
----------                                                                      
NAME                                                                            
--------------------------------------------------------------------------------
DOB          BALANCE LASTMODIF                                                  
--------- ---------- ---------                                                  
                                                                                

SQL> SELECT * FROM LOANS;

    LOANID CUSTOMERID LOANAMOUNT INTERESTRATE STARTDATE ENDDATE                 
---------- ---------- ---------- ------------ --------- ---------               
         1          1       5000            5 04-AUG-24 04-AUG-29               

SQL> SET SERVEROUTPUT ON;
SQL> DECLARE
  2      CURSOR CUSTOMER_CURSOR IS
  3          SELECT CUSTOMERID, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DOB) AS AGE
  4          FROM CUSTOMERS;
  5      VAR_CUSTOMER_ID CUSTOMERS.CUSTOMERID%TYPE;
  6      VAR_AGE NUMBER;
  7  BEGIN
  8      FOR CUSTOMER_RECORD IN CUSTOMER_CURSOR LOOP
  9          VAR_CUSTOMER_ID := CUSTOMER_RECORD.CUSTOMERID;
 10          VAR_AGE := CUSTOMER_RECORD.AGE;
 11          IF VAR_AGE > 60 THEN
 12              UPDATE LOANS
 13              SET INTERESTRATE = INTERESTRATE - 1
 14              WHERE CUSTOMERID = VAR_CUSTOMER_ID;
 15          ELSE
 16              DBMS_OUTPUT.PUT_LINE('CUSTOMER WITH CUSTOMER ID : ' || VAR_CUSTOMER_ID || ' IS OF AGE : ' || VAR_AGE);
 17              DBMS_OUTPUT.PUT_LINE('NO CHANGE IN LOAN');
 18          END IF;
 19      END LOOP;
 20      COMMIT;
 21  END;
 22  /
CUSTOMER WITH CUSTOMER ID : 1 IS OF AGE : 39                                    
NO CHANGE IN LOAN                                                               
CUSTOMER WITH CUSTOMER ID : 2 IS OF AGE : 34                                    
NO CHANGE IN LOAN                                                               

PL/SQL procedure successfully completed.

SQL> SELECT * FROM LOANS;

    LOANID CUSTOMERID LOANAMOUNT INTERESTRATE STARTDATE ENDDATE                 
---------- ---------- ---------- ------------ --------- ---------               
         1          1       5000            5 04-AUG-24 04-AUG-29               

SQL> SPOOL OFF
