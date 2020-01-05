REM   Script: LESSON 3
REM   JOIN

CREATE TABLE T1 AS 
SELECT 1 AS ID FROM dual 
UNION ALL 
SELECT 2 FROM dual 
UNION ALL 
SELECT 4 FROM dual;

CREATE TABLE T2 AS 
SELECT 1 AS ID FROM dual 
UNION ALL 
SELECT 2 FROM dual 
UNION ALL 
SELECT 3 FROM dual;

SELECT * 
FROM t1 CROSS JOIN t2;

SELECT e.first_name||' '||e.last_name AS fi, 
       e.department_id, d.department_id  
FROM employees e CROSS JOIN departments d;

SELECT COUNT(*) FROM employees;

SELECT COUNT(*) FROM departments;

SELECT 108*30 FROM dual;

SELECT e.first_name||' '||e.last_name AS fi, 
       e.department_id, d.department_id  
FROM employees e, departments d;

SELECT department_name,last_name 
FROM employees, departments;

SELECT department_name,last_name,department_id 
FROM employees, departments;

SELECT department_name,last_name,employees.department_id, departments.department_id 
FROM employees, departments;

SELECT department_name,last_name, e.department_id, d.department_id 
FROM employees e, departments d;

SELECT department_name,last_name, e.department_id, departments.department_id 
FROM employees e, departments d;

SELECT department_name,employees.last_name,employees.department_id, departments.department_id 
FROM employees, departments,employees e1 
 
--Using cross join to build a report 
 
SELECT EXTRACT(YEAR FROM hire_date) AS y, COUNT(*) AS qty 
FROM employees 
GROUP BY EXTRACT(YEAR FROM hire_date) 
ORDER BY y 
 
--list of years 
 
 
 
/*CREATE OR REPLACE VIEW V_YEARS AS 
SELECT (SELECT MIN (EXTRACT(YEAR FROM hire_date)) FROM employees) + LEVEL - 1 AS YEAR 
FROM dual 
CONNECT BY LEVEL <= (SELECT MAX (EXTRACT(YEAR FROM hire_date))- MIN (EXTRACT(YEAR FROM hire_date)) FROM employees)+1;*/ 
 
SELECT YEAR FROM v_years;

SELECT EXTRACT(YEAR FROM hire_date) AS y--, COUNT(*) AS qty 
       ,v.YEAR 
       , CASE 
           WHEN EXTRACT(YEAR FROM hire_date) = v.YEAR THEN 1 
           ELSE 0 
         END s1 
       , DECODE(EXTRACT(YEAR FROM hire_date), v.YEAR, 1,0) AS s2 
FROM employees CROSS JOIN v_years v 
--GROUP BY EXTRACT(YEAR FROM hire_date) 
ORDER BY y 
 
--s.2 
SELECT v.YEAR 
       , sum(CASE 
           WHEN EXTRACT(YEAR FROM hire_date) = v.YEAR THEN 1 
           ELSE 0 
         END) s1 
       --, DECODE(EXTRACT(YEAR FROM hire_date), v.YEAR, 1,0) AS s2 
FROM employees CROSS JOIN v_years v 
GROUP BY v.YEAR 
ORDER BY v.YEAR 
 
 
 
-- how many employees were hired in each year 
SELECT v.YEAR, SUM(decode(EXTRACT(YEAR FROM hire_date),v.YEAR,1,0)) AS qty 
FROM employees e CROSS JOIN v_years v   
GROUP BY v.YEAR 
ORDER BY v.year 
 
/*-------------------------------- 
              INNER JOIN 
---------------------------------*/ 
--#1 
SELECT * 
FROM t1 INNER JOIN t2 ON t1.id = t2.id;

SELECT e.first_name||' '||e.last_name AS fi, 
       e.department_id, d.department_id, d.department_name  
FROM employees e  
     INNER JOIN departments d ON e.department_id = d.department_id;

SELECT e.first_name||' '||e.last_name AS fi, 
       e.department_id, d.department_id, d.department_name 
FROM employees e, departments d 
WHERE e.department_id = d.department_id ;

SELECT e.first_name||' '||e.last_name AS fi, 
       e.department_id, d.department_id, d.department_name 
FROM employees e, departments d 
WHERE e.employee_id = d.manager_id ;

SELECT e.first_name||' '||e.last_name AS fi, 
       e.department_id, d.department_id, d.department_name 
FROM employees e, departments d 
WHERE e.manager_id = d.manager_id ;

SELECT e.first_name||' '||e.last_name AS fi, 
       e.department_id, d.department_id, d.department_name  
FROM employees e  
     INNER JOIN departments d ON e.manager_id = d.manager_id;

SELECT e.first_name||' '||e.last_name AS fi, 
       e.department_id, d.department_id, d.department_name  
FROM employees e  
     INNER JOIN departments d ON e.job_id = d.department_name;

SELECT e.last_name, e.first_name,   
       j.job_title 
FROM employees e 
     JOIN jobs j ON e.job_id = j.job_id;

SELECT d.department_name 
      , l.city 
FROM  departments d  
      JOIN locations l ON d.location_id = l.location_id 
      JOIN countries c ON l.country_id = c.country_id 
      JOIN regions r ON c.region_id = r.region_id 
WHERE  region_name LIKE 'Americas'     
   
--#2 - Nooooo! 
SELECT d.department_name 
      , l.city 
FROM  departments d  
      JOIN locations l ON d.location_id = l.location_id 
      JOIN countries c ON l.country_id = c.country_id 
      JOIN regions r ON c.region_id = r.region_id AND region_name LIKE 'Americas'  
 
--#3 + 
SELECT d.department_name 
      , l.city 
FROM  departments d, locations l, countries c , regions r 
WHERE  region_name LIKE 'Americas'  
       AND d.location_id = l.location_id 
       AND l.country_id = c.country_id 
       AND c.region_id = r.region_id 
	 
--#2 
/*Find out the amount of employees in each department. Print: 
 - department name, 
 - the amount of employees 
*/	 
 
SELECT department_name, COUNT(*) AS qty 
FROM departments d 
     JOIN employees e ON e.department_id = d.department_id 
GROUP BY department_name, d.department_id 
 
SELECT * FROM departments 
 
--#3 
/*List all employees having the same manager as Sarah Bell (do not list Sarah Bell).*/ 
 
SELECT e.manager_id, e1.last_name, e1.first_name 
FROM employees e , employees e1 
WHERE e.first_name = 'Sarah' 
      AND e.last_name = 'Bell' 
      AND e.manager_id = e1.manager_id 
     --- AND ( e1.first_name <> 'Sarah' AND e1.last_name <> 'Bell')  
   -- AND e1.First_Name||e1.last_name <>'SarahBell' 
     AND e1.employee_id <> e.employee_id 
 
 
--#4 
/*Find out the amount of employees in each department on each job. Print: 
- department name, 
- job title, 
- the amount of employees. 
*/ 
 
 
/*-------------------------------- 
              LEFT OUTER JOIN 
---------------------------------*/ 
--MS SQL oriented	  
SELECT d.department_id, d.department_name,  
       e.employee_id, e.first_name||' '||e.last_name AS fi 
FROM departments d 
     LEFT JOIN employees e  ON e.department_id = d.department_id;

SELECT d.department_id, d.department_name,  
       e.employee_id, e.first_name||' '||e.last_name AS fi 
FROM departments d , employees e  
WHERE e.department_id (+) = d.department_id 
 
 
--all emps 
 
SELECT d.department_id, d.department_name,  
       e.employee_id, e.first_name||' '||e.last_name AS fi 
FROM departments d , employees e  
WHERE e.department_id = d.department_id (+)  
 
 
 
/*Find out the amount of employees in each department. Print: 
 - department name, 
 - the amount of employees (zero, if department hasn't employees) 
*/	 
 
SELECT d.department_name, COUNT(e.employee_id) AS qty,COUNT(*) AS qty2 
FROM departments d 
     LEFT JOIN employees e ON d.department_id = e.department_id 
GROUP BY d.department_id, d.department_name 
ORDER BY qty;

SELECT d.department_name, COUNT(e.employee_id) AS qty,COUNT(*) AS qty2 
FROM departments d, employees e 
WHERE d.department_id  = e.department_id (+) 
GROUP BY d.department_id, d.department_name 
ORDER BY qty;

SELECT d.department_id, d.department_name 
FROM departments d 
     LEFT JOIN employees e  ON e.department_id = d.department_id 
WHERE e.employee_id IS NULL  
ORDER BY d.department_name ;

SELECT * 
FROM employees e  
     LEFT JOIN  departments d ON e.department_id = d.department_id 
WHERE  d.department_id IS NULL  
ORDER BY d.department_name ;

SELECT * 
FROM employees e  
     --LEFT JOIN  departments d ON e.department_id = d.department_id 
WHERE  department_id IS NULL  ;

SELECT d.department_name,  
       first_name||' '||last_name AS Full_name 
FROM departments d 
     RIGHT JOIN employees e  ON e.department_id = d.department_id;

SELECT d.department_name,  
       first_name||' '||last_name AS Full_name 
FROM departments d 
     RIGHT JOIN employees e  ON e.department_id = d.department_id;

SELECT d.department_name,  
       first_name||' '||last_name AS Full_name 
FROM employees e  
     LEFT JOIN departments d  ON e.department_id = d.department_id;

SELECT ee.first_name||' '||ee.last_name AS emp_name 
       ,em.first_name||' '||em.last_name AS man_name 
       ,CASE 
         WHEN em.employee_id IS NULL THEN 'BigBoss' 
         ELSE em.first_name||' '||em.last_name 
        END full_man_name 
FROM employees ee 
     LEFT JOIN employees em ON em.employee_id = ee.manager_id 
 
 
/*-------------------------------- 
      FULL OUTER JOIN 
---------------------------------*/ 
 
SELECT t1.id AS id1, t2.id AS id2 
FROM t1 FULL OUTER JOIN t2 ON t1.id = t2.id;

SELECT d.department_name, e.first_name||' '|| e.last_name AS Full_Name 
FROM departments d 
     FULL JOIN employees e ON d.department_id = e.department_id 
WHERE d.department_id IS NULL 
      OR e.employee_id IS NULL;

 SELECT d.department_name||e.first_name||' '|| e.last_name AS Full_Name 
FROM departments d 
     FULL JOIN employees e ON d.department_id = e.department_id 
WHERE d.department_id IS NULL 
      OR e.employee_id IS NULL;

  SELECT nvl(d.department_name,e.first_name||' '|| e.last_name) AS Full_Name 
FROM departments d 
     FULL JOIN employees e ON d.department_id = e.department_id 
WHERE d.department_id IS NULL 
      OR e.employee_id IS NULL;

 SELECT COALESCE(d.department_name,e.first_name||' '|| e.last_name) AS Full_Name 
FROM departments d 
     FULL JOIN employees e ON d.department_id = e.department_id 
WHERE d.department_id IS NULL 
      OR e.employee_id IS NULL;

 SELECT CASE 
         WHEN d.department_name IS NULL AND e.hire_date ,e.first_name||' '|| e.last_name) AS Full_Name 
FROM departments d 
     FULL JOIN employees e ON d.department_id = e.department_id 
WHERE d.department_id IS NULL 
      OR e.employee_id IS NULL;

