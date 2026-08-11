/*
What are the most in-demand skills for data analysts?
- Join job postings to skill job dim and skill dim
- identify top 5 in-demand skills for data analysts based on the number of job postings requiring each skill
- focus on all job postings

*/

SELECT
    skills_dim.skills,
    COUNT (*) AS skill_count
FROM job_postings_fact AS job_postings
LEFT JOIN skills_job_dim
    ON job_postings.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings.job_title_short = 'Data Analyst' 
GROUP BY
    skills_dim.skills
ORDER BY
    skill_count DESC
LIMIT 5;