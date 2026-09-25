/*
 Question: what are the most in-demand skills for the data analyst?
 - join the postings to inner join tablesimilar to query 2
 - Identify the top 5 in-demand skills for a data analyst.
 - Focus in all job postings.
 -Why? Retrieves the top 5 skills with the highest demand in the job market,
 providing Insights into the most valuable skills for job seekers.
 */
SELECT skills,
  count(skills_dim.skills) AS demand_count
FROM job_postings_fact
  INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
  AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5
  /*
   -SQL is the most dominant skill by a wide margin, appearing in 7,291 postings
   -Traditional data handling with Excel and programming via Python follow closely as crucial core skills.
   -Visualization tools (Tableau and Power BI) complete the top 5, 
   showing a strong market need for data reporting and dashboard creation.
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