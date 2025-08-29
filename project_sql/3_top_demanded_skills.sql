/*
Question: What are the most in-demand skills for data analysts?
— Join job postings to inner join table similar to query 2.
— Identify the top 5 skill in-demand for a data analyst.
— Focus on all job postings.
— Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim  ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short ='Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY 
    demand_count DESC
LIMIT 5;

/*
Here's the breakdown for the 5 most demanded skills for a data analyst:
— SQL leads by far, showing that querying and managing databases is the core requirement for analysts.
— Excel is still highly valued, proving that traditional tools remain essential alongside modern ones.
— Python, Tableau, and Power BI highlight the mix of programming + data visualization as the main toolkit for today’s analysts.

RESULTS:
[
  {
    "skills": "sql",
    "demand_count": "7291"
  },
  {
    "skills": "excel",
    "demand_count": "4611"
  },
  {
    "skills": "python",
    "demand_count": "4330"
  },
  {
    "skills": "tableau",
    "demand_count": "3745"
  },
  {
    "skills": "power bi",
    "demand_count": "2609"
  }
]
*/