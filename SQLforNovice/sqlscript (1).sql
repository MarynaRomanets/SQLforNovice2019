REM   Script: Homework4 (19.12.2019) - 1 (Shelly Higging - JOIN)
REM   SQL for Novice (part4) 

SELECT E1.FIRST_NAME, E1.LAST_NAME 
FROM HR.EMPLOYEES E1 
WHERE E1.HIRE_DATE IN (SELECT HIRE_DATE 
                        FROM HR.EMPLOYEES E 
                        WHERE E.FIRST_NAME = 'Shelley' 
                        AND E.LAST_NAME = 'Higgins' 
                        AND E.EMPLOYEE_ID <> E1.EMPLOYEE_ID);

SELECT E1.FIRST_NAME, E1.LAST_NAME 
FROM HR.EMPLOYEES E1 
INNER JOIN HR.EMPLOYEES E 
ON E1.HIRE_DATE = E.HIRE_DATE 
WHERE E.FIRST_NAME = 'Shelley' 
    AND E.LAST_NAME = 'Higgins' 
    AND E.EMPLOYEE_ID <> E1.EMPLOYEE_ID;

