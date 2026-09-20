WITH src AS (

    SELECT *
    FROM {{ source('cricket_analytics_source', 'deliveries') }}

)

SELECT
    match_id,
    inning,
    over,
    ball,
    batter_id,
    bowler_id,
    runs_batter,
    runs_total,
    extras_type,
    extras_runs,
    wicket_flag,
    wicket_player_id
FROM src