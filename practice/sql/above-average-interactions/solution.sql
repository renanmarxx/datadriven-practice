with average_session as
(
select avg(a.qtd) as average 
from
(select user_id, count(1) as qtd
from user_sessions
group by user_id) as a
)

select user_id, count(1) 
from user_sessions
group by user_id
having count(1) > (select average from average_session)
order by count(1) desc, user_id asc


--select * from user_sessions
