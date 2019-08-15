
CREATE TABLE "Titles" (
    "emp_no" int   NOT NULL,
    "title" varchar   NOT NULL,
    "from_date" varchar   NOT NULL,
    "to_date" varchar   NOT NULL
);

CREATE TABLE "Dept_Manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" varchar   NOT NULL,
    "to_date" varchar   NOT NULL,
    CONSTRAINT "pk_Dept_Manager" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "birth_date" varchar   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "gender" varchar   NOT NULL,
    "hire_date" varchar   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

-- Table documentation comment 1 (try the PDF/RTF export)
-- Table documentation comment 2
CREATE TABLE "Dept_Emp" (
    "emp_no" int   NOT NULL,
    -- Field documentation comment 3
    "dept_no" varchar   NOT NULL,
    "from_date" varchar   NOT NULL,
    "to_date" varchar   NOT NULL
);

-- Table documentation comment 2
CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    "from_date" varchar   NOT NULL,
    "to_date" varchar   NOT NULL
);

CREATE TABLE "Departments" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

CREATE INDEX "idx_Titles_title"
ON "Titles" ("title");


#1. List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Employees".gender, "Employees".hire_date, "Salaries".Salary
FROM "Employees"
INNER JOIN "Salaries"
ON "Employees".emp_no = "Salaries".emp_no;

2. List employees who were hired in 1986.

SELECT *
FROM "Employees"
WHERE "Employees".hire_date LIKE '1986%';

3. List the manager of each department with the following information: department number, department name, the managers employee number, last name, first name, and start and end employment dates.

SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Titles".from_date, "Titles".to_date, "Dept_Emp".dept_no, "Dept_Emp".emp_no, "Departments".dept_no, "Departments".dept_name
FROM "Employees"
INNER JOIN "Dept_Emp"
ON "Employees".emp_no = "Dept_Emp".emp_no
INNER JOIN "Titles"
ON "Employees".emp_no = "Titles".emp_no
INNER JOIN "Departments"
ON "Departments".dept_no = "Dept_Emp".dept_no;

4. List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Dept_Emp".dept_no, "Dept_Emp".emp_no, "Departments".dept_no, "Departments".dept_name
FROM "Employees"
INNER JOIN "Dept_Emp"
ON "Employees".emp_no = "Dept_Emp".emp_no
INNER JOIN "Departments"
ON "Departments".dept_no = "Dept_Emp".dept_no;

5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT *
FROM "Employees"
WHERE "Employees".first_name LIKE 'Hercules' AND "Employees".last_name LIKE 'B%';

6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
FROM "Employees"
INNER JOIN "Dept_Emp"
ON "Employees".emp_no = "Dept_Emp".emp_no
INNER JOIN "Departments"
ON "Departments".dept_no = "Dept_Emp".dept_no
WHERE "Departments".dept_name LIKE 'Sales';

7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
FROM "Employees"
INNER JOIN "Dept_Emp"
ON "Employees".emp_no = "Dept_Emp".emp_no
INNER JOIN "Departments"
ON "Departments".dept_no = "Dept_Emp".dept_no
WHERE "Departments".dept_name LIKE ANY (array['Sales', 'Development']);

8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT "Employees".last_name COUNT ("Employees".last_name)
FROM "Employees"
GROUP BY "Employees".last_name

#Not sure why this one is not working
