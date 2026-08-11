/*
What skills are required for top-paying data analyst jobs?
- use the 10 highest paying data analyst roles that are available remotely
- add specific skills required for these roles
Providing insights into which skills are needed in top-paying data analyst jobs
*/

WITH top_paying_jobs AS (
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
    LIMIT 10
)

SELECT
    top_paying_jobs.job_title,
    top_paying_jobs.company,
    top_paying_jobs.salary_year_avg,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id