SQL> DELETE FROM CUSTOMERS WHERE CUSTOMERID = 3;

0 rows deleted.

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
SQL> CREATE OR REPLACE FUNCTION CALCULATEAGE(
  2      P_DOB IN DATE
  3  ) RETURN NUMBER IS
  4      V_AGE NUMBER;
  5  BEGIN
  6      V_AGE := TRUNC((SYSDATE - P_DOB) / 365);
  7      RETURN V_AGE;
  8  END CALCULATEAGE;
  9  /

Function created.

SQL> 
SQL> SET SERVEROUTPUT ON;
SQL> DECLARE
  2      CURSOR CURSOR_CUST IS SELECT CUSTOMERID, DOB FROM CUSTOMERS;
  3      V_CUSTOMERID CUSTOMERS.CUSTOMERID%TYPE;
  4      V_DOB CUSTOMERS.DOB%TYPE;
  5      V_AGE NUMBER;
  6  BEGIN
  7      OPEN CURSOR_CUST;
  8      LOOP
  9          FETCH CURSOR_CUST INTO V_CUSTOMERID, V_DOB;
 10          EXIT WHEN CURSOR_CUST%NOTFOUND;
 11  
 12          V_AGE := CALCULATEAGE(V_DOB);
 13  
 14          DBMS_OUTPUT.PUT_LINE('CUSTOMER ID : ' || V_CUSTOMERID || ' AGE : ' || V_AGE);
 15      END LOOP;
 16      CLOSE CURSOR_CUST;
 17  END;
 18  /
CUSTOMER ID : 1 AGE : 39                                                        
CUSTOMER ID : 2 AGE : 34                                                        

PL/SQL procedure successfully completed.

SQL> SPOOL OFF
