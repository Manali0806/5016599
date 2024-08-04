SQL> SELECT * FROM EMPLOYEES;

EMPLOYEEID                                                                      
----------                                                                      
NAME                                                                            
--------------------------------------------------------------------------------
POSITION                                               SALARY                   
-------------------------------------------------- ----------                   
DEPARTMENT                                         HIREDATE                     
-------------------------------------------------- ---------                    
         1                                                                      
Alice Johnson                                                                   
Manager                                                 73500                   
HR                                                 04-AUG-24                    
                                                                                

EMPLOYEEID                                                                      
----------                                                                      
NAME                                                                            
--------------------------------------------------------------------------------
POSITION                                               SALARY                   
-------------------------------------------------- ----------                   
DEPARTMENT                                         HIREDATE                     
-------------------------------------------------- ---------                    
         2                                                                      
Bob Brown                                                                       
Developer                                               61800                   
IT                                                 04-AUG-24                    
                                                                                

SQL> 
SQL> SET SERVEROUTPUT ON;
SQL> CREATE OR REPLACE PROCEDURE UPDATEEMPLOYEEBONUS(
  2      P_DEPARTMENT IN EMPLOYEES.DEPARTMENT%TYPE,
  3      P_BONUS_PERCENTAGE IN NUMBER
  4  ) AS
  5  BEGIN
  6      UPDATE EMPLOYEES
  7      SET SALARY = SALARY * (1 + P_BONUS_PERCENTAGE / 100),
  8          HIREDATE = SYSDATE
  9      WHERE DEPARTMENT = P_DEPARTMENT;
 10  
 11      COMMIT;
 12      DBMS_OUTPUT.PUT_LINE('Bonus applied to employees in the ' || P_DEPARTMENT || ' department.');
 13  EXCEPTION
 14      WHEN OTHERS THEN
 15          ROLLBACK;
 16          DBMS_OUTPUT.PUT_LINE('Error updating employee bonuses: ' || SQLERRM);
 17  END UPDATEEMPLOYEEBONUS;
 18  /

Procedure created.

SQL> 
SQL> EXEC UPDATEEMPLOYEEBONUS('IT',5);
Bonus applied to employees in the IT department.                                

PL/SQL procedure successfully completed.

SQL> EXEC UPDATEEMPLOYEEBONUS('HR',3);
Bonus applied to employees in the HR department.                                

PL/SQL procedure successfully completed.

SQL> 
SQL> SELECT * FROM EMPLOYEES;

EMPLOYEEID                                                                      
----------                                                                      
NAME                                                                            
--------------------------------------------------------------------------------
POSITION                                               SALARY                   
-------------------------------------------------- ----------                   
DEPARTMENT                                         HIREDATE                     
-------------------------------------------------- ---------                    
         1                                                                      
Alice Johnson                                                                   
Manager                                                 75705                   
HR                                                 04-AUG-24                    
                                                                                

EMPLOYEEID                                                                      
----------                                                                      
NAME                                                                            
--------------------------------------------------------------------------------
POSITION                                               SALARY                   
-------------------------------------------------- ----------                   
DEPARTMENT                                         HIREDATE                     
-------------------------------------------------- ---------                    
         2                                                                      
Bob Brown                                                                       
Developer                                               64890                   
IT                                                 04-AUG-24                    
                                                                                

SQL> SPOOL OFF
