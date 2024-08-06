SQL> SET SERVEROUTPUT ON;
SQL> DECLARE
  2      CURSOR CUR_ACCOUNTS IS
  3          SELECT ACCOUNTID, BALANCE
  4          FROM ACCOUNTS;
  5  
  6      V_ACCOUNT_ID ACCOUNTS.ACCOUNTID%TYPE;
  7      V_BALANCE ACCOUNTS.BALANCE%TYPE;
  8      V_ANNUAL_FEE CONSTANT NUMBER := 50; -- Annual fee amount
  9  BEGIN
 10      OPEN CUR_ACCOUNTS;
 11  
 12      LOOP
 13          FETCH CUR_ACCOUNTS INTO V_ACCOUNT_ID, V_BALANCE;
 14          EXIT WHEN CUR_ACCOUNTS%NOTFOUND;
 15  
 16          UPDATE ACCOUNTS
 17          SET BALANCE = BALANCE - V_ANNUAL_FEE,
 18              LASTMODIFIED = SYSDATE
 19          WHERE ACCOUNTID = V_ACCOUNT_ID;
 20  
 21          DBMS_OUTPUT.PUT_LINE('Annual fee of ' || V_ANNUAL_FEE || ' deducted from Account ID: ' || V_ACCOUNT_ID);
 22      END LOOP;
 23  
 24      CLOSE CUR_ACCOUNTS;
 25  
 26      COMMIT;
 27  END;
 28  /
Annual fee of 50 deducted from Account ID: 1                                    
Annual fee of 50 deducted from Account ID: 2                                    
Annual fee of 50 deducted from Account ID: 4                                    

PL/SQL procedure successfully completed.

SQL> SPOOL OFF
