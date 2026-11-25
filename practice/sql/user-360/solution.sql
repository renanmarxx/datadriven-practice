with transactions_count as 
(
select
  user_id
  ,count(transaction_id) as transaction_count
  ,sum(total_amount) as total_spent
from
  transactions
group by
  user_id
),

sessions_duration as
(
select
  user_id
  ,sum(session_duration_sec) as total_session_seconds
from
  user_sessions
group by
  user_id
),

calc_avg_spend_per_active_user as
(
select 
  avg(f.avg_spend_per_active_user) as avg_spend_per_active_user
from(
    select
      user_id
      ,sum(total_amount) as avg_spend_per_active_user
    from
      transactions  
    group by
      user_id
    ) as f
)

select 
  a.username
  ,coalesce(b.transaction_count, 0) as transaction_count
  ,coalesce(b.total_spent, 0) as total_spent
  ,coalesce(c.total_session_seconds, 0) as total_session_seconds
  ,coalesce(d.avg_spend_per_active_user, 0) as avg_spend_per_active_user
from 
  users as a
left join
  transactions_count as b
on
  a.user_id = b.user_id
left join
  sessions_duration as c
on
  a.user_id = c.user_id
left join
  calc_avg_spend_per_active_user as d
