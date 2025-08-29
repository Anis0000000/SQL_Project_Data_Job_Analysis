/*
Question: What skills are required for the top_paying data analyst jobs?
— Using the top 10 highest_paying Data Analyst jobs from first query.
— Adding the specific skills required for this roles.
— Why? It provied a detailed look at which highest_paying jobs demand certain skills,
    helping job seekers understand which skills to develop that align with top salaries.
*/

WITH top_paying_jobs AS (
    SELECT 
        job_postings_fact.job_id,
        job_postings_fact.job_title,
        job_postings_fact.salary_year_avg,
        job_postings_fact.job_posted_date,
        company_dim.name AS company_name
    FROM 
        job_postings_fact 
        LEFT JOIN company_dim  ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst'
        AND job_postings_fact.job_location = 'Anywhere'
        AND job_postings_fact.salary_year_avg IS NOT NULL
    ORDER BY job_postings_fact.salary_year_avg DESC
    LIMIT 10
)
SELECT 
    top_paying_jobs.* ,
    STRING_AGG (skills_dim.skills, ', ') AS skills
FROM 
    top_paying_jobs 
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = top_paying_jobs.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY
    top_paying_jobs.job_id,
    top_paying_jobs.job_title,
    top_paying_jobs.salary_year_avg, 
    top_paying_jobs.job_posted_date, 
    top_paying_jobs.company_name
ORDER BY 
    top_paying_jobs.salary_year_avg DESC;

/*
Here is the breakdown of the most demanded skills for data analysts, based on job postings:

— SQL & Python dominate → They are almost universal across the top-paying roles.
— Visualization tools matter → Tableau and Power BI both appear, confirming BI dashboards are key.
— Cloud & Big Data skills → Azure, Snowflake, Databricks, Hadoop highlight the importance of cloud and data platforms.
— Statistical & Data Science tools → R, Pandas, NumPy show up — employers value analytical depth.
— Collaboration & workflow tools → Jira, Bitbucket, Confluence appear, meaning top analysts often work in cross-functional teams with software engineers.
— Excel still relevant → Despite modern tools, Excel remains in-demand even in top-paying positions.

RESULTS:
[
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "salary_year_avg": "255829.5",
    "job_posted_date": "2023-06-18 16:03:12",
    "company_name": "AT&T",
    "skills": "sql, python, r, azure, databricks, aws, pandas, pyspark, jupyter, excel, tableau, power bi, powerpoint"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "salary_year_avg": "232423.0",
    "job_posted_date": "2023-12-05 20:00:40",
    "company_name": "Pinterest Job Advertisements",
    "skills": "sql, python, r, hadoop, tableau"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "salary_year_avg": "217000.0",
    "job_posted_date": "2023-01-17 00:17:23",
    "company_name": "Uclahealthcareers",
    "skills": "sql, crystal, oracle, tableau, flow"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "salary_year_avg": "205000.0",
    "job_posted_date": "2023-08-09 11:00:01",
    "company_name": "SmartAsset",
    "skills": "sql, python, go, snowflake, pandas, numpy, excel, tableau, gitlab"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "salary_year_avg": "189309.0",
    "job_posted_date": "2023-12-07 15:00:13",
    "company_name": "Inclusively",
    "skills": "sql, python, azure, aws, oracle, snowflake, tableau, power bi, sap, jenkins, bitbucket, atlassian, jira, confluence"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "salary_year_avg": "189000.0",
    "job_posted_date": "2023-01-05 00:00:25",
    "company_name": "Motional",
    "skills": "sql, python, r, git, bitbucket, atlassian, jira, confluence"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "salary_year_avg": "186000.0",
    "job_posted_date": "2023-07-11 16:00:05",
    "company_name": "SmartAsset",
    "skills": "sql, python, go, snowflake, pandas, numpy, excel, tableau, gitlab"
  },
  {
    "job_id": 387860,
    "job_title": "ERM Data Analyst",
    "salary_year_avg": "184000.0",
    "job_posted_date": "2023-06-09 08:01:04",
    "company_name": "Get It Recruit - Information Technology",
    "skills": "sql, python, r"
  }
]

*/