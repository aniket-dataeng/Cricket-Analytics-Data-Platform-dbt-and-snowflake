with src as (
    select *
    from {{ source('cricket_analytics_source', 'players') }}
)

SELECT 
player_id,
player_name,
date_of_birth as player_dob,
nationality as player_nationality,
role as player_skill
FROM src;