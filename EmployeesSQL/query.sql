-- Importing the tables:

-- Selecting data:

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM titles;

-- Data Analysis:

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
LEFT JOIN salaries AS s ON
e.emp_no = s.emp_no
ORDER BY e.emp_no;

-- 2. List employees who were hired in 1986.

SELECT emp_no, last_name, first_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = '1986';

-- 3. List the manager of each department with the following information: department number, 
--    department name, the manager's employee number, last name, first name, and start and end employment dates.

--    Based on my analysis of the question asked here and my experience working in HR I have added the 'to_date' from
--    'dept_emp' table (as end date of an employment) and 'hire_date'from 'employees' table (as start date of employment)
-- 	  The question did not specify to add the end date of the manager in a department and thus, I have excluded
--    the 'from_date' and 'to_date' columns from 'dept_manager' table

SELECT m.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name, e.hire_date, p.to_date
FROM dept_manager AS m
LEFT JOIN employees AS e ON e.emp_no = m.emp_no
LEFT JOIN departments AS d ON d.dept_no = m.dept_no
LEFT JOIN dept_emp AS p ON p.emp_no = m.emp_no
ORDER BY m.dept_no, m.emp_no;

-- 4. List the department of each employee with the following information: 
--    employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
LEFT JOIN dept_emp AS p ON p.emp_no = e.emp_no
LEFT JOIN departments AS d ON d.dept_no = p.dept_no
ORDER BY e.emp_no;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT *
FROM employees
WHERE first_name = 'Hercules' AND SUBSTRING(last_name,1,1)='B'; 

-- 6. List all employees in the Sales department, including their employee number, 
--	  last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
LEFT JOIN dept_emp AS p ON p.emp_no = e.emp_no
LEFT JOIN departments AS d ON d.dept_no = p.dept_no
WHERE d.dept_name = 'Sales'
ORDER BY e.emp_no;

-- 7. List all employees in the Sales and Development departments, 
--    including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
LEFT JOIN dept_emp AS p ON p.emp_no = e.emp_no
LEFT JOIN departments AS d ON d.dept_no = p.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
ORDER BY e.emp_no;

-- 8. In descending order, list the frequency count of employee last names, i.e., 
--	  how many employees share each last name.

SELECT last_name, Count(*) AS total_count
FROM employees
GROUP BY last_name
HAVING COUNT(*) >= 1
ORDER BY total_count DESC, last_name;