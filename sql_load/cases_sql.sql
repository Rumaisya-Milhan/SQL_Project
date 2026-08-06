--january job postings
CREATE TABLE january_jobs AS
    SELECT*
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 1;

--february job postings
CREATE TABLE february_jobs AS
    SELECT*
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 2;

--march job postings
CREATE TABLE march_jobs AS
    SELECT*
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 3;

SELECT 
    COUNT (job_location) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'On-site'
        END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category
ORDER BY number_of_jobs DESC;


/*Label new column
- anywhere as remote
- New York, NY as Local
- Other as On-site
*/

/*Categorize salary into three groups
- Low: < 50,000
- Medium: 50,000 - 80,000
- High: > 80,000

*/
SELECT
job_title_short,
COUNT (job_id) AS job_count,
    CASE
        WHEN salary_year_avg < 50000 THEN 'Low'
        WHEN salary_year_avg BETWEEN 50000 AND 80000 THEN 'Medium'
        ELSE 'High'
    END AS salary_category
FROM job_postings_fact
GROUP BY salary_category, job_title_short
ORDER BY job_count DESC;

SELECT*
FROM (
    SELECT*
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date)=1
) AS january_jobs;

WITH january_jobs AS (
    SELECT*
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date)=1
)
SELECT*
FROM january_jobs;

SELECT
    name AS company_name,
    company_id 
FROM 
    company_dim
WHERE company_id IN (
    SELECT
    company_id
    FROM
    job_postings_fact
    WHERE
    job_no_degree_mention = 'TRUE'
    ORDER BY company_id
)

/* Find the companies that have the most job openings
- get the total number of job postings per company (job_postings_fact)
- return the total number of jobs with the company name (company_dim)
*/

WITH company_job_counts AS (
    SELECT
        company_id,
        COUNT (*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY company_id
    )

SELECT
    company_dim.name AS company_name,
    company_job_counts.total_jobs
FROM 
    company_dim
LEFT JOIN company_job_counts ON company_job_counts.company_id = company_dim.company_id
ORDER BY company_job_counts.total_jobs DESC

