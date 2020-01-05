REM   Script: Homework4 (19.12.2019) - 3 (departments without employees - NOT IN, EXISTS)
REM   SQL for Novice (part 4 task 3)
I didn't find decision with using "ANY"

SELECT D.DEPARTMENT_ID 
FROM HR.DEPARTMENTS D 
WHERE D.DEPARTMENT_ID NOT IN (SELECT E.DEPARTMENT_ID 
                                FROM HR.EMPLOYEES E 
                                WHERE E.DEPARTMENT_ID IS NOT NULL);

SELECT D.DEPARTMENT_ID  
FROM HR.DEPARTMENTS D 
WHERE NOT EXISTS (SELECT 1 
                FROM HR.EMPLOYEES E 
                WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID 
                AND ROWNUM<2);

