SQL> SELECT * FROM CUSTOMERS;

CUSTOMERID                                                                      
----------                                                                      
NAME                                                                            
--------------------------------------------------------------------------------
DOB          BALANCE LASTMODIF ISVIP                                            
--------- ---------- --------- ----------                                       
         1                                                                      
John Doe                                                                        
15-MAY-85       1000 04-AUG-24 FALSE                                            
                                                                                
         2                                                                      
Jane Smith                                                                      
20-JUL-90       1500 04-AUG-24 FALSE                                            

CUSTOMERID                                                                      
----------                                                                      
NAME                                                                            
--------------------------------------------------------------------------------
DOB          BALANCE LASTMODIF ISVIP                                            
--------- ---------- --------- ----------                                       
                                                                                

SQL> 
SQL> SET SERVEROUTPUT ON;
SQL> 
SQL> CREATE OR REPLACE PROCEDURE ADDNEWCUSTOMER(
  2      P_CUSTOMER_ID IN CUSTOMERS.CUSTOMERID%TYPE,
  3      P_NAME IN CUSTOMERS.NAME%TYPE,
  4      P_DOB IN CUSTOMERS.DOB%TYPE,
  5      P_BALANCE IN CUSTOMERS.BALANCE%TYPE
  6  ) AS
  7  BEGIN
  8      -- Attempt to insert the new customer
  9      DBMS_OUTPUT.PUT_LINE('INSERTING...');
 10      DBMS_OUTPUT.PUT_LINE('CUSTOMER_ID : ' || P_CUSTOMER_ID);
 11      DBMS_OUTPUT.PUT_LINE('NAME : ' || P_NAME);
 12      DBMS_OUTPUT.PUT_LINE('DOB : ' || P_DOB);
 13      DBMS_OUTPUT.PUT_LINE('BALANCE : ' || P_BALANCE);
 14  
 15      INSERT INTO CUSTOMERS (CUSTOMERID, NAME, DOB, BALANCE, LASTMODIFIED)
 16      VALUES (P_CUSTOMER_ID, P_NAME, TO_DATE(P_DOB,'YYYY-MM-DD'), P_BALANCE, SYSDATE);
 17  
 18      COMMIT;
 19      DBMS_OUTPUT.PUT_LINE('Customer added successfully.');
 20  EXCEPTION
 21      WHEN DUP_VAL_ON_INDEX THEN
 22          DBMS_OUTPUT.PUT_LINE('Error: Customer ID ' || P_CUSTOMER_ID || ' already exists.');
 23      WHEN OTHERS THEN
 24          ROLLBACK;
 25          DBMS_OUTPUT.PUT_LINE('Customer addition failed: ' || SQLERRM);
 26  END ADDNEWCUSTOMER;
 27  /

Procedure created.

SQL> 
SQL> EXEC ADDNEWCUSTOMER(3,'ARKA PRATIM GHOSH','21-10-2002',50000);
BEGIN ADDNEWCUSTOMER(3,'ARKA PRATIM GHOSH','21-10-2002',50000); END;

                                                                                                                                                          *
ERROR at line 1:
ORA-01843: not a valid month 
ORA-06512: at line 1 


SQL> 
SQL> SELECT * FROM CUSTOMERS;

CUSTOMERID                                                                      
----------                                                                      
NAME                                                                            
--------------------------------------------------------------------------------
DOB          BALANCE LASTMODIF ISVIP                                            
--------- ---------- --------- ----------                                       
         1                                                                      
John Doe                                                                        
15-MAY-85       1000 04-AUG-24 FALSE                                            
                                                                                
         2                                                                      
Jane Smith                                                                      
20-JUL-90       1500 04-AUG-24 FALSE                                            

CUSTOMERID                                                                      
----------                                                                      
NAME                                                                            
--------------------------------------------------------------------------------
DOB          BALANCE LASTMODIF ISVIP                                            
--------- ---------- --------- ----------                                       
                                                                                

SQL> SPOOL OFF
