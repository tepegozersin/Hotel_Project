-- 1. Total staff needed by department
SELECT
  department,
  SUM(needed_staff_count) AS total_needed_staff
FROM staffing_needs
GROUP BY department
ORDER BY total_needed_staff DESC;

-- 2. Monthly staffing needs trend by departments
SELECT 
  TO_CHAR(month, 'YYYY-MM') AS month,
  department,
  SUM(needed_staff_count) AS total_needed_staff
FROM staffing_needs
GROUP BY month, department
ORDER BY month, department;

-- 3. Departments with the highest average staffing needs
SELECT
  department,
  AVG(needed_staff_count) AS avg_needed_staff
FROM staffing_needs
GROUP BY department
ORDER BY avg_needed_staff DESC;

-- 4. Departments with Consistent Staffing Needs
-- Shows departments that frequently have staffing needs, with count of months and average needed staff
SELECT
  department,
  COUNT(*) AS months_with_need,
  AVG(needed_staff_count) AS avg_needed_staff
FROM staffing_needs
WHERE needed_staff_count > 0
GROUP BY department
ORDER BY months_with_need DESC, avg_needed_staff DESC;

-- 5. Peak Staffing Need Months
-- Identifies top 5 months with the highest total staffing needs across all departments
SELECT
  TO_CHAR(month, 'YYYY-MM') AS month,
  SUM(needed_staff_count) AS total_needed_staff
FROM staffing_needs
GROUP BY month
ORDER BY total_needed_staff DESC
LIMIT 5;

-- 6. Gap Analysis: Needed vs Available Staff
-- Calculates the difference between needed staff and currently available employees per department each month
SELECT
  TO_CHAR(month, 'YYYY-MM') AS month,
  department,
  employee_count,
  needed_staff_count,
  (needed_staff_count - employee_count) AS gap
FROM staffing_needs
ORDER BY month, department;

-- 7. Trend Analysis per Department
-- Shows monthly staffing needs for each department to observe trends over time
SELECT
  department,
  TO_CHAR(month, 'YYYY-MM') AS month,
  needed_staff_count
FROM staffing_needs
ORDER BY department, month;

