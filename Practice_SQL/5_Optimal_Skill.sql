/*
What are the most optimal skills to learn?
- Focus on high paying and high demand skills
*/


SELECT
    skills_dim.skills,
    COUNT (skills_job_dim.skill_id) AS skill_count,
    ROUND (AVG (job_postings.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact AS job_postings
INNER JOIN skills_job_dim
    ON job_postings.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings.salary_year_avg IS NOT NULL AND
    job_postings.job_title_short = 'Data Analyst' AND
    job_postings.job_work_from_home = 'TRUE'
GROUP BY
    skills_dim.skills
HAVING
    COUNT (skills_job_dim.skill_id) > 10
ORDER BY
    --skill_count DESC,
    avg_salary DESC


-- WITH DOUBLE CTE
WITH skills_demand AS (
    SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT (skills_job_dim.job_id) AS skill_count
    FROM job_postings_fact AS job_postings
    LEFT JOIN skills_job_dim
        ON job_postings.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings.job_title_short = 'Data Analyst' AND
        job_postings.salary_year_avg IS NOT NULL AND
        job_postings.job_work_from_home = 'TRUE'
    GROUP BY
        skills_dim.skill_id
    ORDER BY
        skill_count DESC
),
skills_salary AS (
    SELECT
        skills_dim.skill_id,
        ROUND (AVG (job_postings.salary_year_avg), 0) AS avg_salary,
        skills_dim.skills
    FROM job_postings_fact AS job_postings
    INNER JOIN skills_job_dim
        ON job_postings.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings.job_title_short = 'Data Analyst' AND
        job_postings.salary_year_avg IS NOT NULL AND
        job_postings.job_work_from_home = 'TRUE'    
    GROUP BY
        skills_dim.skill_id
    ORDER BY
        avg_salary DESC
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.skill_count,
    skills_salary.avg_salary
FROM skills_demand
INNER JOIN skills_salary
    ON skills_demand.skill_id = skills_salary.skill_id
WHERE
    skills_demand.skill_count > 10
ORDER BY
    --skills_demand.skill_count DESC,
    skills_salary.avg_salary DESC


--