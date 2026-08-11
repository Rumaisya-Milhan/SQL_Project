/*
What are the top-paying data analyst jobs?
- identify the 10 highest paying data analyst roles that are available remotely
- focuses on job postings with specfied salaries (remove null)

Highlight the top-paying opportunities for data analysts, offering insights into employment
*/

SELECT
    job_postings.job_id,
    job_postings.job_title,
    company_dim.name AS company,
    job_postings.salary_year_avg
FROM
    job_postings_fact AS job_postings
LEFT JOIN company_dim
    ON job_postings.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;