with src as (

    select *
    from {{ ref('int_toss_performance') }}

)

select
    season,
    toss_decision
from src
group by
    season,
    toss_decision
having count(*) > 1