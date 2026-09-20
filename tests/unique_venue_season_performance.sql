with src as (

    select *
    from {{ ref('int_venue_season_performance') }}

)

select
    venue_id,
    season
from src
group by
    venue_id,
    season
having count(*) > 1