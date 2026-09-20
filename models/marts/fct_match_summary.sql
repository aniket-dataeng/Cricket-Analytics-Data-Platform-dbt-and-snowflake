with innings as (

    select
        match_id,

        max(
            case
                when inning = 1 then batting_team_id
            end
        ) as innings_1_team_id,

        max(
            case
                when inning = 1 then total_runs_scored
            end
        ) as innings_1_runs,

        max(
            case
                when inning = 2 then batting_team_id
            end
        ) as innings_2_team_id,

        max(
            case
                when inning = 2 then total_runs_scored
            end
        ) as innings_2_runs

    from {{ ref('int_match_innings') }}

    group by match_id

)

select
    m.match_id,
    m.season,
    m.match_date,

    v.venue_name,
    v.venue_city,

    t1.team_name as team1_name,
    t2.team_name as team2_name,

    tw.team_name as toss_winner_name,
    m.toss_decision,

    w.team_name as winner_name,

    i.innings_1_team_id,
    i.innings_1_runs,

    i.innings_2_team_id,
    i.innings_2_runs

from {{ ref('stg_matches') }} m

left join {{ ref('stg_venues') }} v
    on m.venue_id = v.venue_id

left join {{ ref('stg_teams') }} t1
    on m.team1_id = t1.team_id

left join {{ ref('stg_teams') }} t2
    on m.team2_id = t2.team_id

left join {{ ref('stg_teams') }} tw
    on m.toss_winner_id = tw.team_id

left join {{ ref('stg_teams') }} w
    on m.winner_id = w.team_id

left join innings i
    on m.match_id = i.match_id