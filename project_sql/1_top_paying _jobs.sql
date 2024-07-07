SELECT 
    c.name as company_name,
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
from 
    job_postings_fact as j
LEFT JOIN
    company_dim as c
    on j.company_id = c .company_id
where 
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere'AND
    salary_year_avg is not NULL
ORDER BY
    salary_year_avg DESC
limit 10;