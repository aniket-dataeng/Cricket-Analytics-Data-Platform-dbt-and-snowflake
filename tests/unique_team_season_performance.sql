with src as (

    select *
    from {{ ref('int_team_season_performance') }}

)

select
    team_id,
    season
from src
group by
    team_id,
    season
having count(*) > 1