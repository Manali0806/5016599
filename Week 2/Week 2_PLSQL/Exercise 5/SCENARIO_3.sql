SQL> SET SERVEROUTPUT ON;
SQL> CREATE OR REPLACE TRIGGER CHECKTRANSACTIONRULES
  2  BEFORE INSERT ON TRANSACTIONS
  3  FOR EACH ROW
  4  DECLARE
  5      V_BALANCE ACCOUNTS.BALANCE%TYPE;
  6  BEGIN
  7      -- Get the current balance of the account
  8      SELECT BALANCE INTO V_BALANCE
  9      FROM ACCOUNTS
 10      WHERE ACCOUNTID = :NEW.ACCOUNTID
 11      FOR UPDATE;
 12  
 13      -- Check the transaction type and validate accordingly
 14      IF :NEW.TRANSACTIONTYPE = 'Withdrawal' THEN
 15          IF :NEW.AMOUNT > V_BALANCE THEN
 16              RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance for the withdrawal.');
 17          END IF;
 18      ELSIF :NEW.TRANSACTIONTYPE = 'Deposit' THEN
 19          IF :NEW.AMOUNT <= 0 THEN
 20              RAISE_APPLICATION_ERROR(-20002, 'Deposit amount must be positive.');
 21          END IF;
 22      ELSE
 23          RAISE_APPLICATION_ERROR(-20003, 'Invalid transaction type.');
 24      END IF;
 25  END CHECKTRANSACTIONRULES;
 26  /

Trigger created.

SQL> 
SQL> SELECT * FROM ACCOUNTS;

 ACCOUNTID CUSTOMERID ACCOUNTTYPE             BALANCE LASTMODIF                 
---------- ---------- -------------------- ---------- ---------                 
         1          1 Savings                    1415 04-AUG-24                 
         2          2 Checking                   1100 04-AUG-24                 

SQL> SELECT * FROM CUSTOMERS;

CUSTOMERID                                                                      
----------                                                                      
NAME                                                                            
--------------------------------------------------------------------------------
DOB          BALANCE LASTMODIF ISVIP                                            
--------- ---------- --------- ----------                                       
         1                                                                      
JOHN DOE                                                                        
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
SQL> INSERT INTO ACCOUNTS (ACCOUNTID, CUSTOMERID, ACCOUNTTYPE, BALANCE, LASTMODIFIED)
  2  VALUES (4, 1, 'Recurring', 3500, SYSDATE);

1 row created.

SQL> SPOOL OFF
