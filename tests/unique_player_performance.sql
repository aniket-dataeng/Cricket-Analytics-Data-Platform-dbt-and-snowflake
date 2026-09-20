with src as (

    select *
    from {{ ref('fct_player_performance') }}

)

select
    player_id,
    season
from src
group by
    player_id,
    season
having count(*) > 1