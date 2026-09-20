WITH src AS (

    SELECT *
    FROM {{ source('cricket_analytics_source', 'venues') }}

)

SELECT
    venue_id,
    venue_name,
    city AS venue_city
FROM src