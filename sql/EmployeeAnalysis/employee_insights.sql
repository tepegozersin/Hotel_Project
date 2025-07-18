-- 1. DEMOGRAPHİC ANALYSIS
-- 1.a Department-wise Gender Distribution
SELECT
  department,
  gender,
  COUNT(*) AS count
FROM employees
GROUP BY department, gender
ORDER BY department, gender;

-- 1.b Average Age at Hire by Department
SELECT
  department,
  ROUND(AVG(EXTRACT(YEAR FROM AGE(hire_date, birth_date)))) AS avg_age_at_hire
FROM employees
GROUP BY department
ORDER BY avg_age_at_hire;

-- 1.c Employment Status Distribution
SELECT
  employment_status,
  COUNT(*) AS count
FROM employees
GROUP BY employment_status;

-- 2. SALARY & LEAVE RELATIONSHIP
-- Average Salary and Total Leave Days by Department
WITH leave_days AS (
  SELECT
    e.department,
    l.employee_id,
    SUM(l.end_date::date - l.start_date::date + 1) AS total_leave_days
  FROM employees e
  LEFT JOIN leaves l ON e.employee_id = l.employee_id
  GROUP BY e.department, l.employee_id
)
SELECT
  e.department,
  ROUND(AVG(s.total_salary)::numeric, 2) AS avg_salary,
  ROUND(AVG(ld.total_leave_days)::numeric, 2) AS avg_leave_days
FROM salaries s
JOIN employees e ON s.employee_id = e.employee_id
LEFT JOIN leave_days ld ON ld.employee_id = s.employee_id AND ld.department = e.department
GROUP BY e.department
ORDER BY e.department;

-- 3. EMPLOYEE RETENTION & TURNOVER
-- This query shows how many employees are currently active vs. terminated in each department.
SELECT
  department,
  COUNT(*) FILTER (WHERE employment_status = 'Active') AS active_employees,
  COUNT(*) FILTER (WHERE employment_status = 'Terminated') AS terminated_employees
FROM employees
GROUP BY department
ORDER BY department;

-- 4. SALARY RANGE DISTRIBUTION
-- This query groups employees based on total salary ranges to visualize salary distribution.
SELECT
  CASE
    WHEN total_salary < 20000 THEN 'Under 20K'
    WHEN total_salary BETWEEN 20000 AND 40000 THEN '20K-40K'
    WHEN total_salary BETWEEN 40001 AND 60000 THEN '40K-60K'
    ELSE 'Above 60K'
  END AS salary_range,
  COUNT(*) AS employee_count
FROM salaries
GROUP BY salary_range
ORDER BY salary_range;

-- 5. LEAVE DURATION VS APPROVAL STATUS
-- This query calculates the average leave duration based on approval status to check if longer leaves get rejected more often.
SELECT
  approval_status,
  ROUND(AVG(end_date::date - start_date::date + 1), 2) AS avg_leave_duration
FROM leaves
GROUP BY approval_status;




