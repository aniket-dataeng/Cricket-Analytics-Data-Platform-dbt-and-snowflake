select
    coalesce(b.player_id, bw.player_id) as player_id,
    coalesce(b.season, bw.season) as season,

    b.total_batting_runs,
    b.matches_played as batting_matches,
    b.avg_runs_per_match,

    bw.matches_bowled,
    bw.wickets,
    bw.runs_conceded,
    bw.runs_conceded_per_match

from {{ ref('int_player_season_batting') }} b

full outer join {{ ref('int_player_season_bowling') }} bw
    on b.player_id = bw.player_id
    and b.season = bw.season