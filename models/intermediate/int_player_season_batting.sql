with player_deliveries as (

    select
        d.match_id,
        d.batter_id as player_id,
        d.runs_batter,
        m.season
    from {{ ref('stg_deliveries') }} d
    inner join {{ ref('stg_matches') }} m
        on d.match_id = m.match_id

),

player_season_metrics as (

    select
        player_id,
        season,
        sum(runs_batter) as total_batting_runs,
        count(distinct match_id) as matches_played
    from player_deliveries
    group by
        player_id,
        season

)

select
    player_id,
    season,
    total_batting_runs,
    matches_played,
    total_batting_runs / nullif(matches_played, 0) as avg_runs_per_match
from player_season_metrics