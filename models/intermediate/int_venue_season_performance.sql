with match_runs as (

    select
        match_id,
        sum(runs_total) as total_match_runs
    from {{ ref('stg_deliveries') }}
    group by match_id

),

venue_season as (

    select
        m.venue_id,
        m.season,
        m.match_id,
        mr.total_match_runs
    from {{ ref('stg_matches') }} m
    inner join match_runs mr
        on m.match_id = mr.match_id

)

select
    venue_id,
    season,
    count(distinct match_id) as matches_played,
    sum(total_match_runs) as total_runs_scored,
    round(
        sum(total_match_runs) / nullif(count(distinct match_id), 0),
        2
    ) as avg_runs_per_match
from venue_season
group by
    venue_id,
    season