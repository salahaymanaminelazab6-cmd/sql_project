/*
 Question: What are the top-paying data analyst jobs?
 - Identify the top 10 highest-paying Data Analyst roles that are available remotely.
 - Focuses on job postings with specified salaries (remove nulls).
 - Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment.
 */
SELECT job_id,
  job_title,
  job_location,
  job_schedule_type,
  salary_year_avg,
  job_posted_date,
  name AS conpany_name
FROM job_postings_fact
  LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
  AND job_location = 'Anywere'
  AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
  /*
   The Data Analyst position at Mantys, with a salary of $650K, represents exceptional value compared to the other roles.
   The second-highest salary is $336.5K, indicating a very significant gap between the top two positions.
   Eight out of the ten positions fall roughly within the $184K to $256K range.
   This means the average salary of $264.5K is clearly skewed by the exceptional $650K figure; therefore, the median of $211K provides a more representative picture of the typical roles on this list.
   */