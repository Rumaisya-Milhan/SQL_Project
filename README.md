# Introduction
📍Dive into the data job market, focusing on data analyst roles. Exploring top-paying jobs💰, in-demand skills✒️, and where high demands meets high salary in data analytics.

🔍 SQL queries chech out here: [Practice_SQL](Practice_Sql/)

# Tools I used
For this project I used several tools:
- **SQL**: the backbone of my analysis, allowing me to query the database and unearth critical insights
- **PostgreSQL**: the chosen database management system.
- **Visual Studio Code**: database management and executing SQL queries
- **Git & Github**: essential version control and sharing my SQL scripts and analysis. 

# The Analysis
### 1. Top paying data analysts jobs
To identify the highest-paying roles i filtered data analyst positions by average yearly salary and location, focusing on remote jobs. Highlighting the high paying opportunities in the field.

``` SQL
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

```
![Top Paying Roles](Assets\1_Top_Paying_Job.png)

# What I learned

# Conclusions