with src as (

    select *
    from {{ ref('int_player_season_bowling') }}

)

select
    player_id,
    season
from src
group by
    player_id,
    season
having count(*) > 1