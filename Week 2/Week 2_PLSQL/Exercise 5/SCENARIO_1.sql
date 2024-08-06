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
SQL> CREATE OR REPLACE TRIGGER UPDATECUSTOMERLASTMODIFIED
  2  BEFORE UPDATE ON CUSTOMERS
  3  FOR EACH ROW
  4  BEGIN
  5      :NEW.LASTMODIFIED := SYSDATE;
  6      DBMS_OUTPUT.PUT_LINE('LAST MODIFIED UPDATED');
  7  END UPDATECUSTOMERLASTMODIFIED;
  8  /

Trigger created.

SQL> 
SQL> UPDATE CUSTOMERS SET NAME = 'JOHN DOE' WHERE CUSTOMERID = 1;
LAST MODIFIED UPDATED                                                           

1 row updated.

SQL> SPOOL OFF
