{% snapshot snap_player_team_history %}

{{
    config(
        target_database='dbt_dev_cricket_analytics_platform',
        target_schema='dbt_ad',
        unique_key="concat(player_id, '-', season)",
        strategy='check',
        check_cols=[
            'team_id',
            'start_date',
            'end_date'
        ]
    )
}}

select
    player_id,
    team_id,
    season,
    start_date,
    end_date

from {{ source('cricket_analytics_source', 'player_team_history') }}

{% endsnapshot %}