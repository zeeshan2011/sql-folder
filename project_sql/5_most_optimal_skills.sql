with skills_demand as(
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_dim.skill_id) AS demand_count
FROM 
    skills_job_dim
join 
    skills_dim
on skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    skills_job_dim.job_id IN (
        select job_id 
        from 
            job_postings_fact
        where  
            job_title_short = 'Data Analyst'
            and salary_year_avg is NOT NULL
    )
GROUP BY
    skills_dim.skill_id
) ,  average_salary as (
    SELECT 
    skills_dim.skill_id,
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
    skills_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
JOIN
    average_salary
on skills_demand.skill_id = average_salary.skill_id
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 25
