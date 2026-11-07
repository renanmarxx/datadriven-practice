with aux as (
select
  cast(session_start as date) as session_date
  ,user_id
from
  user_sessions
)

select 
  session_date
  ,count(1) as total_sessions
  ,count(distinct user_id) as unique_users 
from 
  aux
group by
  session_date
order by 
  session_date asc
