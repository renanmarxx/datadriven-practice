select 
    distinct content_type 
from 
    content_items
where 
    1 = 1
    and creator_id <= 300 
    and creator_id is not null
