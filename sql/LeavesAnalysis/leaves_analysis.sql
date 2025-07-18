-- 1. Leave Type Frequency
-- Counts how many leaves were taken for each leave type.
SELECT
  leave_type,
  COUNT(*) AS leave_count
FROM leaves
GROUP BY leave_type
ORDER BY leave_count DESC;


-- 2. Monthly Leave Trend
-- Shows the number of leaves starting each month to identify busy leave periods.
SELECT
  TO_CHAR(start_date, 'YYYY-MM') AS leave_month,
  COUNT(*) AS leaves_started
FROM leaves
GROUP BY leave_month
ORDER BY leave_month;

-- 3. Approval Status Distribution
-- Counts leaves by approval status to see how many are approved, pending, or rejected.
SELECT
  approval_status,
  COUNT(*) AS status_count
FROM leaves
GROUP BY approval_status;


-- 4. Leave Count per Employee
-- Counts total leaves taken by each employee.
SELECT
  employee_id,
  COUNT(*) AS total_leaves_taken
FROM leaves
GROUP BY employee_id
ORDER BY total_leaves_taken DESC
LIMIT 10;


-- 5. Average Leave Duration by Leave Type
-- Calculates average leave length (days) for each leave type.
SELECT
  leave_type,
  AVG(end_date - start_date + 1) AS avg_leave_days
FROM leaves
GROUP BY leave_type
ORDER BY avg_leave_days DESC;
