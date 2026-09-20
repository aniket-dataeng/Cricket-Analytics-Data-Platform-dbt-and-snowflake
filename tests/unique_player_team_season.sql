with src as (
    select *
    from {{ ref('stg_player_team_history') }}
)

select player_id, team_id, season
from src
group by player_id, team_id, season
having count(1) > 1