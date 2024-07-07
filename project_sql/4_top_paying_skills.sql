SELECT 
    skills_dim.skills,
    round(avg(j.salary_year_avg), 0) AS avg_salary
FROM 
    skills_job_dim
join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
JOIN job_postings_fact J ON j.job_id = skills_job_dim.job_id
where  
    job_title_short = 'Data Analyst'
    and salary_year_avg is NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

