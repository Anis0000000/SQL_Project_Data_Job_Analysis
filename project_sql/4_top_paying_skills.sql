/*
Question: What are the top skills based on salary?
— Look at the average salary associated with each skill for Data Analyst positions.
— Focus on roles with specified salaries, regardless of location.
— Why? It reveals how different skills impact salary levels for Data Analyst and
    helps identify the most financially rewardings skills to aquire or improve.
*/

SELECT 
    skills,
    ROUND (AVG (salary_year_avg)) AS avg_salary
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
LIMIT 10;

-- Focusing on remote jobs
SELECT 
    skills,
    ROUND (AVG (salary_year_avg)) AS avg_salary
FROM 
    job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim  ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short ='Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = True
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 10;


/*
Here's the breakdown of the results of the top paying skills for Data Analyst:
— Big Data & Machine Learning – Frameworks like TensorFlow, PyTorch, Keras, MXNet, DataRobot, Kafka, Airflow show strong demand for advanced analytics and AI-driven skills.
— Software Development & Tools – High salaries are linked to skills like Golang, Perl, SVN, GitLab, Bitbucket, Atlassian which cross into programming and version control.
— Cloud & Infrastructure – Skills such as Terraform, VMware, Ansible, Couchbase, Cassandra highlight the value of cloud computing, infrastructure automation, and scalable data systems.

RESULTS:
[
  {
    "skills": "svn",
    "avg_salary": "400000.00"
  },
  {
    "skills": "solidity",
    "avg_salary": "179000.00"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515.00"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155485.50"
  },
  {
    "skills": "golang",
    "avg_salary": "155000.00"
  },
  {
    "skills": "mxnet",
    "avg_salary": "149000.00"
  },
  {
    "skills": "dplyr",
    "avg_salary": "147633.33"
  },
  {
    "skills": "vmware",
    "avg_salary": "147500.00"
  },
  {
    "skills": "terraform",
    "avg_salary": "146733.83"
  },
  {
    "skills": "twilio",
    "avg_salary": "138500.00"
  },
  {
    "skills": "gitlab",
    "avg_salary": "134126.00"
  },
  {
    "skills": "kafka",
    "avg_salary": "129999.16"
  },
  {
    "skills": "puppet",
    "avg_salary": "129820.00"
  },
  {
    "skills": "keras",
    "avg_salary": "127013.33"
  },
  {
    "skills": "pytorch",
    "avg_salary": "125226.20"
  },
  {
    "skills": "perl",
    "avg_salary": "124685.75"
  },
  {
    "skills": "ansible",
    "avg_salary": "124370.00"
  },
  {
    "skills": "hugging face",
    "avg_salary": "123950.00"
  },
  {
    "skills": "tensorflow",
    "avg_salary": "120646.83"
  },
  {
    "skills": "cassandra",
    "avg_salary": "118406.68"
  },
  {
    "skills": "notion",
    "avg_salary": "118091.67"
  },
  {
    "skills": "atlassian",
    "avg_salary": "117965.60"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "116711.75"
  },
  {
    "skills": "airflow",
    "avg_salary": "116387.26"
  },
  {
    "skills": "scala",
    "avg_salary": "115479.53"
  }
]

RESULT (remote jobs)
[
  {
    "skills": "pyspark",
    "avg_salary": "208172"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "189155"
  },
  {
    "skills": "watson",
    "avg_salary": "160515"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skills": "gitlab",
    "avg_salary": "154500"
  },
  {
    "skills": "swift",
    "avg_salary": "153750"
  },
  {
    "skills": "jupyter",
    "avg_salary": "152777"
  },
  {
    "skills": "pandas",
    "avg_salary": "151821"
  },
  {
    "skills": "elasticsearch",
    "avg_salary": "145000"
  }
]
*/