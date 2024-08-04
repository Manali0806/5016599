SQL> SELECT * FROM ACCOUNTS;

 ACCOUNTID CUSTOMERID ACCOUNTTYPE             BALANCE LASTMODIF                 
---------- ---------- -------------------- ---------- ---------                 
         1          1 Savings                    1415 04-AUG-24                 
         2          2 Checking                   1100 04-AUG-24                 

SQL> 
SQL> SET SERVEROUTPUT ON;
SQL> 
SQL> CREATE OR REPLACE FUNCTION HASSUFFICIENTBALANCE(
  2      P_ACCOUNT_ID IN ACCOUNTS.ACCOUNTID%TYPE,
  3      P_AMOUNT IN NUMBER
  4  ) RETURN BOOLEAN IS
  5      V_BALANCE ACCOUNTS.BALANCE%TYPE;
  6  BEGIN
  7      SELECT BALANCE INTO V_BALANCE
  8      FROM ACCOUNTS
  9      WHERE ACCOUNTID = P_ACCOUNT_ID;
 10  
 11      RETURN V_BALANCE >= P_AMOUNT;
 12  EXCEPTION
 13      WHEN NO_DATA_FOUND THEN
 14          RETURN FALSE;
 15      WHEN OTHERS THEN
 16          RAISE_APPLICATION_ERROR(-20002, 'Error checking balance: ' || SQLERRM);
 17  END HASSUFFICIENTBALANCE;
 18  /

Function created.

SQL> 
SQL> SET SERVEROUTPUT ON;
SQL> DECLARE
  2      V_ACCOUNTID ACCOUNTS.ACCOUNTID%TYPE := &ACCOUNTID;
  3      V_AMOUNT NUMBER := &AMOUNT;
  4      V_HAS BOOLEAN;
  5  BEGIN
  6      V_HAS  := HASSUFFICIENTBALANCE(V_ACCOUNTID, V_AMOUNT);
  7      IF V_HAS = TRUE THEN DBMS_OUTPUT.PUT_LINE(V_ACCOUNTID || ' HAS SUFFICIENT AMOUNT');
  8      ELSE DBMS_OUTPUT.PUT_LINE(V_ACCOUNTID || ' DOES NOT HAVE SUFFICIENT AMOUNT');
  9      END IF;
 10  END;
 11  /
Enter value for accountid: 1
old   2:     V_ACCOUNTID ACCOUNTS.ACCOUNTID%TYPE := &ACCOUNTID;
new   2:     V_ACCOUNTID ACCOUNTS.ACCOUNTID%TYPE := 1;
Enter value for amount: 1000
old   3:     V_AMOUNT NUMBER := &AMOUNT;
new   3:     V_AMOUNT NUMBER := 1000;
1 HAS SUFFICIENT AMOUNT                                                         

PL/SQL procedure successfully completed.

SQL> SPOOL OFF
