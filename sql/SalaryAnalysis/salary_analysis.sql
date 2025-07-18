-- 1. Monthly Average Salary
-- Calculates the average total salary per month. Useful for trend analysis.
SELECT
  TO_CHAR(month, 'YYYY-MM') AS salary_month,
  ROUND(AVG(total_salary)::numeric, 2) AS avg_monthly_salary
FROM salaries
GROUP BY TO_CHAR(month, 'YYYY-MM')
ORDER BY salary_month;


-- 2. Highest Paid Employee
-- Retrieves the employee(s) with the highest total salary.
SELECT *
FROM salaries
WHERE total_salary = (SELECT MAX(total_salary) FROM salaries);


-- 3. Total Salary per Employee
-- Calculates the total yearly salary for each employee. Helps in comparing individual compensation.
SELECT
  employee_id,
  SUM(total_salary) AS total_salary_year
FROM salaries
GROUP BY employee_id
ORDER BY total_salary_year DESC;


-- 4. Average Salary by Department
-- Calculates the average total salary per department. Useful for department-level cost comparison.
SELECT
  e.department,
  ROUND(AVG(s.total_salary)::numeric, 2) AS avg_total_salary
FROM salaries s
JOIN employees e ON s.employee_id = e.employee_id
GROUP BY e.department
ORDER BY avg_total_salary DESC;


-- 5. Monthly Total Bonus
-- Sums up the total bonuses paid each month. Useful for identifying bonus distribution trends.
SELECT
  TO_CHAR(month, 'YYYY-MM') AS salary_month,
  SUM(bonus) AS total_bonus
FROM salaries
GROUP BY salary_month
ORDER BY salary_month;

