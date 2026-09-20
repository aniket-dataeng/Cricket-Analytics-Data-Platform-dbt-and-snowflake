with match_innings as (

    select
        m.match_id,
        m.season,
        d.inning,
        case
            when d.inning = 1 then m.team1_id
            when d.inning = 2 then m.team2_id
        end as batting_team_id,
        m.winner_id
    from {{ ref('stg_matches') }} m
    inner join {{ ref('stg_deliveries') }} d
        on m.match_id = d.match_id
    group by
        m.match_id,
        m.season,
        d.inning,
        m.team1_id,
        m.team2_id,
        m.winner_id

),

innings_runs as (

    select
        match_id,
        inning,
        sum(runs_total) as total_runs_scored
    from {{ ref('stg_deliveries') }}
    group by
        match_id,
        inning

)

select
    mi.match_id,
    mi.season,
    mi.inning,
    mi.batting_team_id,
    t.team_name as batting_team_name,
    ir.total_runs_scored,
    mi.winner_id,
    w.team_name as winner_name

from match_innings mi

inner join innings_runs ir
    on mi.match_id = ir.match_id
    and mi.inning = ir.inning

left join {{ ref('stg_teams') }} t
    on mi.batting_team_id = t.team_id

left join {{ ref('stg_teams') }} w
    on mi.winner_id = w.team_id