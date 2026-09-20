select
    p.team_id,
    p.season,
    t.team_name,
    t.team_city,
    p.matches_played,
    p.matches_won,
    p.win_percentage
from {{ ref('int_team_season_performance') }} p
left join {{ ref('stg_teams') }} t
    on p.team_id = t.team_id