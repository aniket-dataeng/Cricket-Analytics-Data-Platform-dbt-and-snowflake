with match_teams as (

    select
        match_id,
        season,
        team1_id as team_id,
        winner_id
    from {{ ref('stg_matches') }}

    union all

    select
        match_id,
        season,
        team2_id as team_id,
        winner_id
    from {{ ref('stg_matches') }}

),

team_metrics as (

    select
        team_id,
        season,
        count(*) as matches_played,
        sum(
            case
                when team_id = winner_id then 1
                else 0
            end
        ) as matches_won
    from match_teams
    group by
        team_id,
        season

)

select
    team_id,
    season,
    matches_played,
    matches_won,
    round(
        matches_won * 100.0 / nullif(matches_played, 0),
        2
    ) as win_percentage
from team_metrics