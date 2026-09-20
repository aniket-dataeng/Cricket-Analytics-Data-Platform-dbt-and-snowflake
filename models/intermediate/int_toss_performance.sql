with toss_results as (

    select
        match_id,
        season,
        toss_winner_id,
        winner_id,
        toss_decision,
        case
            when toss_winner_id = winner_id then 1
            else 0
        end as toss_winner_won
    from {{ ref('stg_matches') }}

)

select
    season,
    toss_decision,
    count(distinct match_id) as matches,
    sum(toss_winner_won) as toss_winner_wins,
    round(
        sum(toss_winner_won) * 100.0
        / nullif(count(distinct match_id), 0),
        2
    ) as toss_winner_win_percentage
from toss_results
group by
    season,
    toss_decision