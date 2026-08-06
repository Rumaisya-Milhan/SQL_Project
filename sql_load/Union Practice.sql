--get january jobs
SELECT
    job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION ALL

--get february jobs
SELECT
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION ALL

--get march jobs
SELECT
    job_title_short,
    company_id,
    job_location
FROM march_jobs;

/*UNION PRACTICE
Get the responding skill and skill type for each job posting in q1
Include those without any skills
Look at the skills and the type for each job in the first quarter that has a salary > $70,000
*/

WITH q1_jobs AS(
    SELECT*
    FROM january_jobs 
    WHERE salary_year_avg > 70000

    UNION ALL

    SELECT*
    FROM february_jobs 
    WHERE salary_year_avg > 70000

    UNION ALL

    SELECT*
    FROM march_jobs 
    WHERE salary_year_avg > 70000
)

SELECT
    q1_jobs.job_title_short,
    skills_dim.skills,
    skills_dim.type,
    q1_jobs.job_location,
    q1_jobs.job_posted_date ::DATE,
    q1_jobs.salary_year_avg
FROM q1_jobs
LEFT JOIN skills_job_dim
    ON q1_jobs.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE q1_jobs.job_title_short = 'Data Analyst'
ORDER BY q1_jobs.salary_year_avg DESC;
