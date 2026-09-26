# Introduction

📊 Dive into the data job market! Focusing on data
analyst roles, this project explores 💰 top-paying
jobs, 💡 in-demand skills, and 🤝 where high
demand meets high salary in data analytics.

🔍 SQL queries? Check them out here : [project_sql folder](/project_sql/).

# Background

Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.
Data hails from my [sql_course](https://www.linkedin.com/company/amit-learning/home/). It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used

For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- PostgreSQL: The chosen database management system, ideal for handling the job posting data.
- Visual Studio Code: My go-to for database management and executing SQL queries.
- Git & GitHub: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I approached each question:

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
FROM job_postings_fact
  LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
  AND job_location = 'Anywere'
  AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
```

Here's the breakdown of the top data analyst jobs in 2023:

- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

![Top_Paying_Roles](assets\Top_Paying_Jobs.png)

Bar graph visualizing the salary for the top 10
salaries for data analysts; ChatGPT generated this
graph from my SQL query results

### 2. Top Paying Job Skills

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles

```sql
WITH top_paying_jobs AS(
  SELECT job_id,
    job_title,
    salary_year_avg,
    name AS company_name
  FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
  WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
  ORDER BY salary_year_avg DESC
  LIMIT 10
)
SELECT top_paying_jobs.*,
  skills,
  type
FROM top_paying_jobs
  INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
```

- **SQL** is the most common skill, appearing in 8 out of 8 jobs (100%).
- **Python** appears in 7 out of 8 jobs (87.5%).
- **Tableau** appears in 6 out of 8 jobs (75%).
- **R** is required in 4 out of 8 jobs (50%).
- **Excel**, **Pandas**, and **Snowflake** each appear in 3 jobs (37.5%).
- **Power BI** appears in 2 jobs (25%).
- **Cloud** technologies such as Azure, AWS, and Oracle appear in 2 jobs each (25%).

![Top_Paying_Job_Skills](assets\2_top_paying_job_skills.png)

High-paying Data Analyst roles tend to combine strong foundational analytical skills such as SQL and Python with BI, cloud, and programming technologies. SQL and Python have the broadest presence, while specialized cloud and data-engineering skills appear less frequently but are associated with higher salaries in this particular sample. However, the sample contains only 8 jobs, so these salary associations should be treated as descriptive rather than causal.

| Skill   | Jobs | Avg. Salary |
| ------- | ---: | ----------: |
| SQL     |    8 |    $207,320 |
| Python  |    7 |    $205,937 |
| Tableau |    6 |    $214,260 |
| R       |    4 |    $215,313 |
| Excel   |    3 |    $215,610 |
| AWS     |    2 |    $222,569 |
| Azure   |    2 |    $222,569 |

### 3. In_Demand Skills For Data Analysts

Retrieves the top 5 skills with the highest demand in the job market,
providing Insights into the most valuable skills for job seekers.

```sql
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
```

- **SQL** is the most demanded skill by a significant margin, appearing in 7,291 job postings.
- **Excel** ranks second with 4,611 postings, followed by **Python** (4,330).
- **Tableau** appears in 3,745 job postings, making it the fourth most demanded skill.
- **Power BI** ranks fifth with 2,609 job postings.
- **SQL** demand is approximately 1.6× higher than **Excel** and 2.8× higher than **Power BI**, highlighting the strong importance of **SQL** in Data Analyst roles.
- The top five skills are dominated by data querying, spreadsheet analysis, programming, and business intelligence tools, indicating that employers commonly seek a combination of technical and analytical capabilities.

![In_Demand Skills For Data Analysts](assets\3_In_Demand_Skills_For_Data_Analysts.png)

SQL is the core skill in the Data Analyst job market, with demand substantially exceeding every other skill. Excel and Python follow closely, while Tableau and Power BI represent important Business Intelligence and visualization capabilities.
| Rank | Skill | Job Postings |
| ---: | -------- | -----------: |
| 1 | SQL | 7,291 |
| 2 | Excel | 4,611 |
| 3 | Python | 4,330 |
| 4 | Tableau | 3,745 |
| 5 | Power BI | 2,609 |

### 4. Skills Based On Salary

It reveals how different skills impact salary levels for Data Analysts and
helps identify the most financially rewarding skills of acquire or improve

```sql
 SELECT
      skills AS skill_name,
      ROUND(AVG(salary_year_avg), 0) AS avg_salary
  FROM
      job_postings_fact
  INNER JOIN skills_job_dim
  ON job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN skills_dim
  ON skills_job_dim.skill_id = skills_dim.skill_id
  WHERE
     job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
  GROUP BY
     skill_name
  ORDER BY
     avg_salary DESC
  LIMIT 25
```

- **SVN** stands out as a major salary outlier, with an average annual salary of $400000, substantially higher than every other skill in the dataset.
- **Solidity** ranks second at $179,000, followed by Couchbase ($160,515) and DataRobot ($155,486).
- The top 5 skills all have average salaries above $155K, indicating a strong salary premium for specialized technical skills.
- A large portion of the remaining skills fall within the $115K–$150K range, including technologies such as **Golang**, **Terraform**, **Kafka**, **PyTorch**, **TensorFlow**, and **Airflow**.
- The results suggest that specialized technologies and advanced technical tooling can be associated with substantially higher salaries among Data Analyst job postings.
- However, these figures represent average salaries for job postings containing each
  skill and should not be interpreted as the salary premium caused by the skill itself. Experience, seniority, location, company, and job responsibilities may also influence compensation.

![top_paying_skills](assets\4.png)
The data shows a substantial salary gap between the highest-paying skills and the rest of the top 25. SVN is particularly unusual at $400K, while most of the other high-paying skills cluster between roughly $115K and $180K.
| Rank | Skill | Average Annual Salary |
| ---: | ------------ | --------------------: |
| 1 | SVN | $400,000 |
| 2 | Solidity | $178,500 |
| 3 | Couchbase | $160,200 |
| 4 | DataRobot | $155,300 |
| 5 | Golang | $154,800 |
| 6 | MXNet | $148,800 |
| 7 | dplyr | $147,300 |
| 8 | VMware | $147,300 |
| 9 | Terraform | $146,400 |
| 10 | Twilio | $137,900 |
| 11 | GitLab | $134,000 |
| 12 | Kafka | $129,500 |
| 13 | Puppet | $129,500 |
| 14 | Keras | $126,600 |
| 15 | PyTorch | $125,100 |
| 16 | Perl | $124,100 |
| 17 | Ansible | $124,100 |
| 18 | Hugging Face | $123,600 |
| 19 | TensorFlow | $120,100 |
| 20 | Cassandra | $118,200 |
| 21 | Notion | $117,700 |
| 22 | Atlassian | $117,700 |
| 23 | Bitbucket | $116,200 |
| 24 | Airflow | $116,200 |
| 25 | Scala | $115,200 |

### 5. Most Optimal skills to learn

Targets skills that offer job security (high demand) financial benefits(high salaries),
offering strategic insights for career development in data analysis

```sql
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
LIMIT 25
```

-- rewriting this same query more con concisely

```sql
SELECT
  skills_dim.skill_id,
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
```

- SQL is by far the most demanded skill, appearing in 398 job postings, followed by Excel (256), Python (236), and Tableau (230).
- Python has a strong combination of demand and salary, with 236 postings and an average salary of $101,397.
- Go has the highest average salary in this dataset at $115,320, followed by Hadoop ($113,193), Snowflake ($112,948), and Azure ($111,225).
- Excel has very high demand but a comparatively lower average salary of $87,288, showing that high demand does not necessarily correspond to higher compensation.
- SQL has the highest demand but an average salary of $97,237, which is below several less frequently requested technical skills.
- The relationship between skill demand and salary is weakly negative in this dataset (correlation ≈ -0.12), meaning that being more frequently requested does not automatically translate into a higher average salary.
- Cloud and engineering-oriented technologies such as AWS, Azure, Snowflake, Hadoop, and Go appear less frequently than core analyst tools but are associated with relatively high average salaries.

![Most Optimal skills to learn](assets\5.png)
![Most Optimal skills to learn](assets\5_5.png)

The remote Data Analyst market shows a clear distinction between high-demand foundational skills and higher-paid specialized technologies. SQL, Excel, Python, and Tableau dominate demand, while skills such as Go, Hadoop, Snowflake, and Azure are associated with higher average salaries despite lower demand.

| Rank | Skill      | Number of Job Postings |
| ---: | ---------- | ---------------------: |
|    1 | SQL        |                    398 |
|    2 | Excel      |                    256 |
|    3 | Python     |                    236 |
|    4 | Tableau    |                    230 |
|    5 | R          |                    148 |
|    6 | Power BI   |                    110 |
|    7 | SAS        |                     63 |
|    8 | PowerPoint |                     58 |
|    9 | Looker     |                     49 |
|   10 | Word       |                     48 |
|   11 | Snowflake  |                     37 |
|   12 | Oracle     |                     37 |
|   13 | SQL Server |                     35 |
|   14 | Azure      |                     34 |
|   15 | AWS        |                     32 |
|   16 | Sheets     |                     32 |
|   17 | Flow       |                     28 |
|   18 | Go         |                     26 |
|   19 | VBA        |                     23 |
|   20 | SPSS       |                     23 |
|   21 | Hadoop     |                     21 |
|   22 | JavaScript |                     19 |
|   23 | Jira       |                     19 |
|   24 | SharePoint |                     17 |

# What I Learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- ⚔️ **Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **🔮Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions

### Insights

From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it's a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.|

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.
