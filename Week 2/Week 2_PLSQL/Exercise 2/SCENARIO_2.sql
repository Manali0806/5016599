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
Manager                                                 70000                   
HR                                                 15-JUN-15                    
                                                                                

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
Developer                                               60000                   
IT                                                 20-MAR-17                    
                                                                                

SQL> 
SQL> SET SERVEROUTPUT ON;
SQL> CREATE OR REPLACE PROCEDURE UPDATESALARY(
  2      P_EMPLOYEE_ID IN EMPLOYEES.EMPLOYEEID%TYPE,
  3      P_PERCENTAGE IN NUMBER
  4  ) AS
  5      V_OLD_SALARY EMPLOYEES.SALARY%TYPE;
  6  BEGIN
  7      -- Fetch the current salary
  8      SELECT SALARY INTO V_OLD_SALARY
  9      FROM EMPLOYEES
 10      WHERE EMPLOYEEID = P_EMPLOYEE_ID;
 11  
 12      -- Update the salary
 13      UPDATE EMPLOYEES
 14      SET SALARY = SALARY * (1 + P_PERCENTAGE / 100),
 15          HIREDATE = SYSDATE
 16      WHERE EMPLOYEEID = P_EMPLOYEE_ID;
 17  
 18      COMMIT;
 19      DBMS_OUTPUT.PUT_LINE('Salary updated successfully.');
 20  EXCEPTION
 21      WHEN NO_DATA_FOUND THEN
 22          DBMS_OUTPUT.PUT_LINE('Error: Employee ID ' || P_EMPLOYEE_ID || ' does not exist.');
 23      WHEN OTHERS THEN
 24          ROLLBACK;
 25          DBMS_OUTPUT.PUT_LINE('Salary update failed: ' || SQLERRM);
 26  END UPDATESALARY;
 27  /

Procedure created.

SQL> 
SQL> EXEC UPDATESALARY(1,5);
Salary updated successfully.                                                    

PL/SQL procedure successfully completed.

SQL> EXEC UPDATESALARY(2,3);
Salary updated successfully.                                                    

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
                                                                                

SQL> SPOOL OFF
