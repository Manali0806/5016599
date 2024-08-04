SQL> SELECT * FROM ACCOUNTS;

 ACCOUNTID CUSTOMERID ACCOUNTTYPE             BALANCE LASTMODIF                 
---------- ---------- -------------------- ---------- ---------                 
         1          1 Savings                    1000 04-AUG-24                 
         2          2 Checking                   1500 04-AUG-24                 

SQL> 
SQL> SET SERVEROUTPUT ON;
SQL> CREATE OR REPLACE PROCEDURE SAFETRANSFERFUNDS(
  2      P_FROM_ACCOUNT_ID IN ACCOUNTS.ACCOUNTID%TYPE,
  3      P_TO_ACCOUNT_ID IN ACCOUNTS.ACCOUNTID%TYPE,
  4      P_AMOUNT IN NUMBER
  5  ) AS
  6      V_FROM_BALANCE ACCOUNTS.BALANCE%TYPE;
  7      V_TO_BALANCE ACCOUNTS.BALANCE%TYPE;
  8  BEGIN
  9  
 10      SELECT BALANCE INTO V_FROM_BALANCE
 11      FROM ACCOUNTS
 12      WHERE ACCOUNTID = P_FROM_ACCOUNT_ID
 13      FOR UPDATE;
 14  
 15      SELECT BALANCE INTO V_TO_BALANCE
 16      FROM ACCOUNTS
 17      WHERE ACCOUNTID = P_TO_ACCOUNT_ID
 18      FOR UPDATE;
 19  
 20      -- Check for sufficient funds
 21      IF V_FROM_BALANCE < P_AMOUNT THEN
 22          RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds in the source account.');
 23      END IF;
 24  
 25      -- Perform the transfer
 26      UPDATE ACCOUNTS
 27      SET BALANCE = BALANCE - P_AMOUNT,
 28          LASTMODIFIED = SYSDATE
 29      WHERE ACCOUNTID = P_FROM_ACCOUNT_ID;
 30  
 31      UPDATE ACCOUNTS
 32      SET BALANCE = BALANCE + P_AMOUNT,
 33          LASTMODIFIED = SYSDATE
 34      WHERE ACCOUNTID = P_TO_ACCOUNT_ID;
 35  
 36      COMMIT;
 37      DBMS_OUTPUT.PUT_LINE('Transfer successful.');
 38  EXCEPTION
 39      WHEN OTHERS THEN
 40          ROLLBACK;
 41          DBMS_OUTPUT.PUT_LINE('Transfer failed: ' || SQLERRM);
 42  END SAFETRANSFERFUNDS;
 43  /

Procedure created.

SQL> 
SQL> EXEC SAFETRANSFERFUNDS(2,1,500);
Transfer successful.                                                            

PL/SQL procedure successfully completed.

SQL> SELECT * FROM ACCOUNTS;

 ACCOUNTID CUSTOMERID ACCOUNTTYPE             BALANCE LASTMODIF                 
---------- ---------- -------------------- ---------- ---------                 
         1          1 Savings                    1500 04-AUG-24                 
         2          2 Checking                   1000 04-AUG-24                 

SQL> SPOOL OFF
