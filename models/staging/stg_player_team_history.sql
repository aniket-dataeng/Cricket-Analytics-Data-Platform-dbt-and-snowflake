with src as (
    select *
    from {{ source('cricket_analytics_source', 'player_team_history') }}
)

select
    player_id,
    team_id,
    season,
    start_date,
    end_date
from src