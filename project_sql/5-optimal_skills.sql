/*
 Answer?: what are the most optimal skills to learn(aka it's in high demand and a high_paying_skills)?
 - Identify skills in high demand and associated with high average salaries for data analyst roles
 - Concentrates on remote positions with specified salaries
 Why? Targets skills that offer job security (high demand) financial benefits(high salaries),
 offering strategic insights for career development in data analysis
 */
WITH skills_demand AS (
  SELECT skills_dim.skill_id,
    skills_dim.skills,
    count(skills_dim.skills) AS demand_count
  FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
  WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
  GROUP BY skills_dim.skill_id
),
average_salary AS (
  SELECT skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
  FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
  WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
  GROUP BY skills_job_dim.skill_id
)
SELECT skills_demand.skill_id,
  skills_demand.skills,
  demand_count,
  avg_salary
FROM skills_demand
  INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 10
ORDER BY demand_count DESC,
  average_salary DESC
LIMIT 25 -- rewriting this same query more con concisely
SELECT skills_dim.skill_id,
  skills_dim.skills,
  count(skills_dim.skills) AS demand_count,
  ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS average_salary
FROM job_postings_fact
  INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
  AND salary_year_avg IS NOT NULL
  AND job_work_from_home = TRUE
GROUP by skills_dim.skill_id
HAVING count(skills_job_dim.job_id) > 10
ORDER BY demand_count DESC,
  average_salary DESC
LIMIT 25
  /*
   SQL is by far the most demanded skill, appearing in 398 job postings, followed by Excel (256), Python (236), and Tableau (230).
   Python has a strong combination of demand and salary, with 236 postings and an average salary of $101,397.
   Go has the highest average salary in this dataset at $115,320, followed by Hadoop ($113,193), Snowflake ($112,948), and Azure ($111,225).
   Excel has very high demand but a comparatively lower average salary of $87,288, showing that high demand does not necessarily correspond to higher compensation.
   SQL has the highest demand but an average salary of $97,237, which is below several less frequently requested technical skills.
   The relationship between skill demand and salary is weakly negative in this dataset (correlation ≈ -0.12), meaning that being more frequently requested does not automatically translate into a higher average salary.
   Cloud and engineering-oriented technologies such as AWS, Azure, Snowflake, Hadoop, and Go appear less frequently than core analyst tools but are associated with relatively high average salaries.
   Important data-quality note
   
   There are two separate rows for SAS with different skill_id values, both having the same demand and salary. This appears to be a duplicate representation of the same skill and should ideally be cleaned before using the data for a final dashboard or statistical analysis.
   
   Overall conclusion
   
   The remote Data Analyst market shows a clear distinction between high-demand foundational skills and higher-paid specialized technologies. SQL, Excel, Python, and Tableau dominate demand, while skills such as Go, Hadoop, Snowflake, and Azure are associated with higher average salaries despite lower demand
   [
   {
   "skill_id": 0,
   "skills": "sql",
   "demand_count": "398",
   "avg_salary": "97237"
   },
   {
   "skill_id": 181,
   "skills": "excel",
   "demand_count": "256",
   "avg_salary": "87288"
   },
   {
   "skill_id": 1,
   "skills": "python",
   "demand_count": "236",
   "avg_salary": "101397"
   },
   {
   "skill_id": 182,
   "skills": "tableau",
   "demand_count": "230",
   "avg_salary": "99288"
   },
   {
   "skill_id": 5,
   "skills": "r",
   "demand_count": "148",
   "avg_salary": "100499"
   },
   {
   "skill_id": 183,
   "skills": "power bi",
   "demand_count": "110",
   "avg_salary": "97431"
   },
   {
   "skill_id": 186,
   "skills": "sas",
   "demand_count": "63",
   "avg_salary": "98902"
   },
   {
   "skill_id": 7,
   "skills": "sas",
   "demand_count": "63",
   "avg_salary": "98902"
   },
   {
   "skill_id": 196,
   "skills": "powerpoint",
   "demand_count": "58",
   "avg_salary": "88701"
   },
   {
   "skill_id": 185,
   "skills": "looker",
   "demand_count": "49",
   "avg_salary": "103795"
   },
   {
   "skill_id": 188,
   "skills": "word",
   "demand_count": "48",
   "avg_salary": "82576"
   },
   {
   "skill_id": 80,
   "skills": "snowflake",
   "demand_count": "37",
   "avg_salary": "112948"
   },
   {
   "skill_id": 79,
   "skills": "oracle",
   "demand_count": "37",
   "avg_salary": "104534"
   },
   {
   "skill_id": 61,
   "skills": "sql server",
   "demand_count": "35",
   "avg_salary": "97786"
   },
   {
   "skill_id": 74,
   "skills": "azure",
   "demand_count": "34",
   "avg_salary": "111225"
   },
   {
   "skill_id": 192,
   "skills": "sheets",
   "demand_count": "32",
   "avg_salary": "86088"
   },
   {
   "skill_id": 76,
   "skills": "aws",
   "demand_count": "32",
   "avg_salary": "108317"
   },
   {
   "skill_id": 215,
   "skills": "flow",
   "demand_count": "28",
   "avg_salary": "97200"
   },
   {
   "skill_id": 8,
   "skills": "go",
   "demand_count": "27",
   "avg_salary": "115320"
   },
   {
   "skill_id": 199,
   "skills": "spss",
   "demand_count": "24",
   "avg_salary": "92170"
   },
   {
   "skill_id": 22,
   "skills": "vba",
   "demand_count": "24",
   "avg_salary": "88783"
   },
   {
   "skill_id": 97,
   "skills": "hadoop",
   "demand_count": "22",
   "avg_salary": "113193"
   },
   {
   "skill_id": 233,
   "skills": "jira",
   "demand_count": "20",
   "avg_salary": "104918"
   },
   {
   "skill_id": 9,
   "skills": "javascript",
   "demand_count": "20",
   "avg_salary": "97587"
   },
   {
   "skill_id": 195,
   "skills": "sharepoint",
   "demand_count": "18",
   "avg_salary": "81634"
   }
   ]
   */