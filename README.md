# Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries: Check them out here: [project_sql folder](/project_sql/)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others' work to find optimal jobs.

Data hails from [SQL Course](https://lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for this top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Excel:** Used for quick visualization of SQL query results, creating clear charts and graphs to highlight key findings.
- **Git & Github:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query in this project aimed at investigating specific aspects of the data analyst job market. Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM 
    job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10;
```
Here’s the breakdown for the top data analyst jobs:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

![Top Paying Roles](assets/1_top_paying_jobs.png)
*Bar graph visualizing the salaries for the top 10 highest-paying data analyst roles.* 

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skill data, providing insights into what employers value for high-compensation roles.

```sql
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
```
Here's the breakdown for the most demanded skills for the top 10 highest paying data analyst jobs:
- **SQL** is leading by a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **Tableau** is also highly sought after, with a bold count of 6. Other skills like **R**, **Snowflake**, **Pandas**, and **Excel** show varying degrees of demand.

![Skills for Top Paying Jobs](assets/2_top_paying_job_skills.png)
*Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts.*

### 3. In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
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
``` 
Here's the breakdown of the most demanded skills for data analysts
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skill     | Demand Count |
|-----------|--------------|
| SQL       | 7291         |
| Excel     | 4611         |
| Python    | 4330         |
| Tableau   | 3745         |
| Power BI  | 2609         |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
SELECT 
    skills,
    ROUND (AVG (job_postings_fact.salary_year_avg),2) AS avg_salary
FROM 
    job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim  ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short ='Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25;
```
Here's the breakdown of the results for top paying skills for Data Analysts:
- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and python libraries (Pandas, NumPy), reflecting the industry's high valuation for data processing and predictive modeling capabilities.
- **Software Developmnt & Deployment Proficiency:** Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.
- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environment, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

| Skill         | Average Salary ($) |
|---------------|---------------------|
| PySpark       | 208,172             |
| Bitbucket     | 189,155             |
| Watson        | 160,515             |
| Couchbase     | 160,515             |
| DataRobot     | 155,486             |
| GitLab        | 154,500             |
| Swift         | 153,750             |
| Jupyter       | 152,777             |
| Pandas        | 151,821             |
| Elasticsearch | 145,000             |

*Table for the average salary for the top 10 paying skills for data analysts*

### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.
```sql
SELECT 
    skills_dim.skill_id ,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND (AVG (job_postings_fact.salary_year_avg),2) AS avg_salary
FROM 
    job_postings_fact
        INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
        INNER JOIN skills_dim  ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL 
    AND job_work_from_home = TRUE
GROUP BY 
    skills_dim.skill_id
HAVING 
    COUNT(skills_job_dim.job_id) >10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
| Skill ID | Skills      | Demand Count | Average Salary ($) |
|----------|-------------|--------------|---------------------|
| 8        | Go          | 27           | 115,320             |
| 234      | Confluence  | 11           | 114,210             |
| 97       | Hadoop      | 22           | 113,193             |
| 80       | Snowflake   | 37           | 112,948             |
| 74       | Azure       | 34           | 111,225             |
| 77       | BigQuery    | 13           | 109,654             |
| 76       | AWS         | 32           | 108,317             |
| 4        | Java        | 17           | 106,906             |
| 194      | SSIS        | 12           | 106,683             |
| 233      | Jira        | 20           | 104,918             |
| 79       | Oracle      | 37           | 104,534             |
| 185      | Looker      | 49           | 103,795             |
| 2        | NoSQL       | 13           | 101,414             |
| 1        | Python      | 236          | 101,397             |
| 5        | R           | 148          | 100,499             |
| 78       | Redshift    | 16           | 99,936              |
| 187      | Qlik        | 13           | 99,631              |
| 182      | Tableau     | 230          | 99,288              |
| 197      | SSRS        | 14           | 99,171              |
| 92       | Spark       | 13           | 99,077              |
| 13       | C++         | 11           | 98,958              |
| 186      | SAS         | 63           | 98,902              |
| 61       | SQL Server  | 35           | 97,786              |
| 9        | JavaScript  | 20           | 97,587              |


*Table of the most optimal skills for data analyst sorted by salary*

Here's the breakdown of the most optimal skills for data analysts:
- **High-Demand Programming Languages:** Python and R stand out for their high demand, with demand count of 236 and 148 respectively, Despite their high demand, their average salaries are around $101,397 for python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing toward the growing importance of cloud platforms and big data technologies in data analysis.
- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand count of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- **Database Technologies:** The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 and $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

# What I Learned
Throughout this adventure I've turbocharged my SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data summarizing sidekicks.
- **💡 Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusion
### Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs required advanced proficiency in SQL, suggesting it's a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, this making it essential for job seekers.
4. **Skills With Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.