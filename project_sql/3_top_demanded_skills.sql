SELECT 
    skills_dim.skills,
    count(skills_dim.skill_id) AS skill_count
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
    )
GROUP BY
    skills
ORDER BY
    skill_count DESC
LIMIT 5;

