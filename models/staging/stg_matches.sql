with src as (
    select *
    from {{ source('cricket_analytics_source', 'matches') }}
)

select *
from src