/*
What are the top skills based on salary?
- Look at the average salary associted with each skill for data analysts positions
- Focuses on roles with specified salaries regardless of location

reveales how each skills impact salary levels for data analysts, providing insights into the value of specific skills in the job market
*/

SELECT
    ROUND (AVG (job_postings.salary_year_avg), 0) AS avg_salary,
    skills_dim.skills
FROM job_postings_fact AS job_postings
INNER JOIN skills_job_dim
    ON job_postings.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings.salary_year_avg IS NOT NULL AND
    job_postings.job_title_short = 'Data Analyst'
GROUP BY
    skills_dim.skills
ORDER BY
    avg_salary DESC
LIMIT 10;
