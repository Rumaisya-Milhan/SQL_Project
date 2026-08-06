/* ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
Database Load Issues (follow if receiving permission denied when running SQL code below)

Possible Errors: 
- ERROR >>  duplicate key value violates unique constraint "company_dim_pkey"
- ERROR >> could not open file "C:\Users\...\company_dim.csv" for reading: Permission denied

1. Drop the Database 
            DROP DATABASE IF EXISTS sql_course;
2. Repeat steps to create database and load table schemas
            - 1_create_database.sql
            - 2_create_tables.sql
3. Open pgAdmin
4. In Object Explorer (left-hand pane), navigate to `sql_course` database
5. Right-click `sql_course` and select `PSQL Tool`
            - This opens a terminal window to write the following code
6. Get the absolute file path of your csv files
            1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
7. Paste the following into `PSQL Tool`, (with the CORRECT file path)

\copy company_dim FROM 'C:\Temp\csv_files\company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM 'C:\Temp\csv_files\skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact FROM 'C:\Temp\csv_files\job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim FROM 'C:\Temp\csv_files\skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

*/

-- NOTE: This has been updated from the video to fix issues with encoding
COPY company_dim
FROM 'C:\Temp\csv_files\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM 'C:\Temp\csv_files\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM 'C:\Temp\csv_files\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM 'C:\Temp\csv_files\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST'AS date_time,
    EXTRACT (MONTH FROM job_posted_date) AS month,
    EXTRACT (YEAR FROM job_posted_date) AS year
FROM job_postings_fact
LIMIT 10;

SELECT
    COUNT (job_id) AS total_jobs,
    EXTRACT (MONTH FROM job_posted_date) AS month
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY month
ORDER BY total_jobs DESC;

SELECT
    job_schedule_type AS schedule_type,
    COUNT(*) AS total_jobs, 
    AVG (salary_year_avg) AS yearly_salary,
    AVG (salary_hour_avg) AS hourly_salary
FROM job_postings_fact
WHERE job_posted_date > '2023-01-06'
GROUP BY job_schedule_type
ORDER BY total_jobs DESC;

