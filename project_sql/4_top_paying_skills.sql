/*
 Answer:  what are the top skills based on salary?
 - Look at the average salary associated with each skill for Data Analyst positions 
 - Focuses on roles with specified salaries, regardless  of location
 - Why? It reveals how different skills impact salary levels for Data Analysts and
 helps identify the most financially rewarding skills of acquire or improve 
 */
SELECT skills AS skill_name,
  ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
  INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
  AND salary_year_avg IS NOT NULL
GROUP BY skill_name
ORDER BY avg_salary DESC
LIMIT 25
  /*
   -SVN stands out as a major salary outlier, with an average annual salary of $400,000, substantially higher than every other skill in the dataset.
   -Solidity ranks second at $179,000, followed by Couchbase ($160,515) and DataRobot ($155,486).
   -The top 5 skills all have average salaries above $155K, indicating a strong salary premium for specialized technical skills.
   -A large portion of the remaining skills fall within the $115K–$150K range, including technologies such as Golang, Terraform, Kafka, PyTorch, TensorFlow, and Airflow.
   -The results suggest that specialized technologies and advanced technical tooling can be associated with substantially higher salaries among Data Analyst job postings.
   -However, these figures represent average salaries for job postings containing each skill and should not be interpreted as the salary premium caused by the skill itself. Experience, seniority, location, company, and job responsibilities may also influence compensation.
   Main takeaway
   
   -The data shows a substantial salary gap between the highest-paying skills and the rest of the top 25. SVN is particularly unusual at $400K, while most of the other high-paying skills cluster between roughly $115K and $180K.
   [
   {
   "skill_name": "svn",
   "avg_salary": "400000"
   },
   {
   "skill_name": "solidity",
   "avg_salary": "179000"
   },
   {
   "skill_name": "couchbase",
   "avg_salary": "160515"
   },
   {
   "skill_name": "datarobot",
   "avg_salary": "155486"
   },
   {
   "skill_name": "golang",
   "avg_salary": "155000"
   },
   {
   "skill_name": "mxnet",
   "avg_salary": "149000"
   },
   {
   "skill_name": "dplyr",
   "avg_salary": "147633"
   },
   {
   "skill_name": "vmware",
   "avg_salary": "147500"
   },
   {
   "skill_name": "terraform",
   "avg_salary": "146734"
   },
   {
   "skill_name": "twilio",
   "avg_salary": "138500"
   },
   {
   "skill_name": "gitlab",
   "avg_salary": "134126"
   },
   {
   "skill_name": "kafka",
   "avg_salary": "129999"
   },
   {
   "skill_name": "puppet",
   "avg_salary": "129820"
   },
   {
   "skill_name": "keras",
   "avg_salary": "127013"
   },
   {
   "skill_name": "pytorch",
   "avg_salary": "125226"
   },
   {
   "skill_name": "perl",
   "avg_salary": "124686"
   },
   {
   "skill_name": "ansible",
   "avg_salary": "124370"
   },
   {
   "skill_name": "hugging face",
   "avg_salary": "123950"
   },
   {
   "skill_name": "tensorflow",
   "avg_salary": "120647"
   },
   {
   "skill_name": "cassandra",
   "avg_salary": "118407"
   },
   {
   "skill_name": "notion",
   "avg_salary": "118092"
   },
   {
   "skill_name": "atlassian",
   "avg_salary": "117966"
   },
   {
   "skill_name": "bitbucket",
   "avg_salary": "116712"
   },
   {
   "skill_name": "airflow",
   "avg_salary": "116387"
   },
   {
   "skill_name": "scala",
   "avg_salary": "115480"
   }
   ]
   */