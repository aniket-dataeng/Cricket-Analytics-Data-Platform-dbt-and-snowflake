with player_deliveries as (

    select
        d.match_id,
        d.bowler_id as player_id,
        d.runs_total,
        d.wicket_flag,
        m.season
    from {{ ref('stg_deliveries') }} d
    inner join {{ ref('stg_matches') }} m
        on d.match_id = m.match_id

),

player_season_metrics as (

    select
        player_id,
        season,
        count(distinct match_id) as matches_bowled,
        sum(
            case
                when wicket_flag = true then 1
                else 0
            end
        ) as wickets,
        sum(runs_total) as runs_conceded
    from player_deliveries
    group by
        player_id,
        season

)

select
    player_id,
    season,
    matches_bowled,
    wickets,
    runs_conceded,
    runs_conceded / nullif(matches_bowled, 0) as runs_conceded_per_match
from player_season_metrics