REM   Script: Homework2 (13.12.2019 )
REM   Homework2 (SQL for Novice)

SELECT DEPARTMENT_ID 
FROM HR.EMPLOYEES 
GROUP BY DEPARTMENT_ID 
HAVING (COUNT (DISTINCT JOB_ID) = COUNT (JOB_ID));

