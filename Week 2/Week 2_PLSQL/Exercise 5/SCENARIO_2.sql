SQL> CREATE TABLE AUDITLOG (
  2      LOGID           NUMBER PRIMARY KEY,
  3      TRANSACTIONID   NUMBER,
  4      ACCOUNTID       NUMBER,
  5      TRANSACTIONDATE DATE,
  6      AMOUNT          NUMBER,
  7      TRANSACTIONTYPE VARCHAR2(10),
  8      LOGTIMESTAMP    DATE DEFAULT SYSDATE
  9  );

Table created.

SQL> 
SQL> SELECT * FROM TRANSACTIONS;

TRANSACTIONID  ACCOUNTID TRANSACTI     AMOUNT TRANSACTIO                        
------------- ---------- --------- ---------- ----------                        
            1          1 04-AUG-24        200 Deposit                           
            2          2 04-AUG-24        300 Withdrawal                        

SQL> 
SQL> CREATE SEQUENCE AUDITLOG_SEQ
  2  START WITH 1
  3  INCREMENT BY 1;

Sequence created.

SQL> 
SQL> SET SERVEROUTPUT ON;
SQL> CREATE OR REPLACE TRIGGER LOGTRANSACTIONS
  2  AFTER INSERT ON TRANSACTIONS
  3  FOR EACH ROW
  4  BEGIN
  5      INSERT INTO AUDITLOG (LOGID, TRANSACTIONID, ACCOUNTID, TRANSACTIONDATE, AMOUNT, TRANSACTIONTYPE)
  6      VALUES (AUDITLOG_SEQ.NEXTVAL, :NEW.TRANSACTIONID, :NEW.ACCOUNTID, SYSDATE, :NEW.AMOUNT, :NEW.TRANSACTIONTYPE);
  7      DBMS_OUTPUT.PUT_LINE('INSERT SUCCESSFUL');
  8  END LOGTRANSACTIONS;
  9  /

Trigger created.

SQL> 
SQL> INSERT INTO TRANSACTIONS (TRANSACTIONID, ACCOUNTID, TRANSACTIONDATE, AMOUNT, TRANSACTIONTYPE)
  2  VALUES (6, 2, SYSDATE, 600, 'Deposit');
INSERT SUCCESSFUL                                                               

1 row created.

SQL> 
SQL> SELECT * FROM AUDITLOG;

     LOGID TRANSACTIONID  ACCOUNTID TRANSACTI     AMOUNT TRANSACTIO LOGTIMEST   
---------- ------------- ---------- --------- ---------- ---------- ---------   
         1             6          2 04-AUG-24        600 Deposit    04-AUG-24   

SQL> SELECT * FROM TRANSACTIONS;

TRANSACTIONID  ACCOUNTID TRANSACTI     AMOUNT TRANSACTIO                        
------------- ---------- --------- ---------- ----------                        
            1          1 04-AUG-24        200 Deposit                           
            2          2 04-AUG-24        300 Withdrawal                        
            6          2 04-AUG-24        600 Deposit                           

SQL> SPOOL OFF
