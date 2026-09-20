WITH src AS (

    SELECT *
    FROM {{ source('cricket_analytics_source', 'teams') }}

)

SELECT
    team_id,
    team_name,
    city AS team_city
FROM src