with src as (
    select *
    from {{ ref('int_match_innings') }}
)

select match_id, inning
from src
group by 1,2
having count(1)>1