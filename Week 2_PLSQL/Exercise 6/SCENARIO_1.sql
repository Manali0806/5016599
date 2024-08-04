SQL> SET SERVEROUTPUT ON;
SQL> DECLARE
  2      CURSOR CUR_MONTHLY_TRANSACTIONS IS
  3          SELECT C.CUSTOMERID, C.NAME, T.TRANSACTIONDATE, T.AMOUNT, T.TRANSACTIONTYPE
  4          FROM CUSTOMERS C
  5          JOIN ACCOUNTS A ON C.CUSTOMERID = A.CUSTOMERID
  6          JOIN TRANSACTIONS T ON A.ACCOUNTID = T.ACCOUNTID
  7          WHERE TRUNC(T.TRANSACTIONDATE, 'MM') = TRUNC(SYSDATE, 'MM')
  8          ORDER BY C.CUSTOMERID, T.TRANSACTIONDATE;
  9  
 10      V_CUSTOMER_ID CUSTOMERS.CUSTOMERID%TYPE;
 11      V_CUSTOMER_NAME CUSTOMERS.NAME%TYPE;
 12      V_TRANSACTION_DATE TRANSACTIONS.TRANSACTIONDATE%TYPE;
 13      V_AMOUNT TRANSACTIONS.AMOUNT%TYPE;
 14      V_TRANSACTION_TYPE TRANSACTIONS.TRANSACTIONTYPE%TYPE;
 15  BEGIN
 16      OPEN CUR_MONTHLY_TRANSACTIONS;
 17  
 18      LOOP
 19          FETCH CUR_MONTHLY_TRANSACTIONS INTO V_CUSTOMER_ID, V_CUSTOMER_NAME, V_TRANSACTION_DATE, V_AMOUNT, V_TRANSACTION_TYPE;
 20          EXIT WHEN CUR_MONTHLY_TRANSACTIONS%NOTFOUND;
 21  
 22          DBMS_OUTPUT.PUT_LINE('Customer ID: ' || V_CUSTOMER_ID || ', Name: ' || V_CUSTOMER_NAME);
 23          DBMS_OUTPUT.PUT_LINE('Transaction Date: ' || TO_CHAR(V_TRANSACTION_DATE, 'YYYY-MM-DD') || ', Amount: ' || V_AMOUNT || ', Type: ' || V_TRANSACTION_TYPE);
 24      END LOOP;
 25  
 26      CLOSE CUR_MONTHLY_TRANSACTIONS;
 27  END;
 28  /
Customer ID: 1, Name: JOHN DOE                                                  
Transaction Date: 2024-08-04, Amount: 200, Type: Deposit                        
Customer ID: 2, Name: Jane Smith                                                
Transaction Date: 2024-08-04, Amount: 300, Type: Withdrawal                     
Customer ID: 2, Name: Jane Smith                                                
Transaction Date: 2024-08-04, Amount: 600, Type: Deposit                        

PL/SQL procedure successfully completed.

SQL> SPOOL OFF
