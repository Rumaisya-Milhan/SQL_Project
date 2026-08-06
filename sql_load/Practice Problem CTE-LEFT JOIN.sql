/* PRACTICE PROBLEM 1
Identifying top 5 skills that are most frequently mentioned in job postings
Use a subquery to find the skills IDs with the highest counts in the skills_job_dim table
Join this results with the skills_dim table to get the skill names
*/

WITH skills_mentioned AS (
    SELECT
        skill_id,
        COUNT (*) AS skill_count
    FROM
        skills_job_dim
    GROUP BY
        skill_id
)

SELECT
    skills_mentioned.skill_count,
    skills_dim.skills
FROM
    skills_mentioned
LEFT JOIN skills_dim ON skills_dim.skill_id = skills_mentioned.skill_id
ORDER BY skills_mentioned.skill_count DESC

/* PRACTICE PROBLEM 2
Determine the size category (small, medium, large) for each company by identifying the number of job postings
Use subquery to calculate the total job postings per company
Category 
    -small 10 job postings
    -medium 10-50 job postings
    -large >50 job postings
Implement a subquery to aggregate job counts per company before classifying them 
*/

WITH total_job_postings AS (
    SELECT
        company_id,
        COUNT(job_id) AS job_count
    FROM
        job_postings_fact
    GROUP BY 
        company_id
    ORDER BY
    job_count DESC
)

SELECT
    company_dim.name AS company_name,
    total_job_postings.job_count,
    CASE
        WHEN total_job_postings.job_count < 10 THEN 'small'
        WHEN total_job_postings.job_count BETWEEN 10 AND 50 THEN 'medium'
        ELSE 'large'
    END AS company_size
FROM
    company_dim
LEFT JOIN total_job_postings ON total_job_postings.company_id = company_dim.company_id
ORDER BY total_job_postings.job_count DESC;
