-- 1. Create a dedicated compute engine (Warehouse) for our dbt transformations
CREATE WAREHOUSE IF NOT EXISTS dbt_project_wh 
    WITH WAREHOUSE_SIZE = 'X-SMALL' 
    AUTO_SUSPEND = 60 
    AUTO_RESUME = TRUE;

-- 2. Create a specific database for our dbt project
CREATE DATABASE IF NOT EXISTS dbt_dev_cricket_analytics_platform;

-- 3. Create a development schema where your personal runs will live
CREATE SCHEMA IF NOT EXISTS dbt_dev_cricket_analytics_platform.dev;

-- 4. Create a specific database for our dbt project
CREATE DATABASE IF NOT EXISTS dbt_prod_cricket_analytics_platform;

-- 5. Create a development schema where your personal runs will live
CREATE SCHEMA IF NOT EXISTS dbt_prod_cricket_analytics_platform.prod;

CREATE SCHEMA IF NOT EXISTS dbt_dev_cricket_analytics_platform.raw;
CREATE SCHEMA IF NOT EXISTS dbt_dev_cricket_analytics_platform.staging;
CREATE SCHEMA IF NOT EXISTS dbt_dev_cricket_analytics_platform.intermediate;
CREATE SCHEMA IF NOT EXISTS dbt_dev_cricket_analytics_platform.marts;

USE DATABASE dbt_dev_cricket_analytics_platform;
USE SCHEMA raw;
USE WAREHOUSE dbt_project_wh;

CREATE OR REPLACE TABLE players (
    player_id       INTEGER,
    player_name     VARCHAR,
    date_of_birth   DATE,
    nationality     VARCHAR,
    role            VARCHAR
);

INSERT INTO players VALUES
(1,  'Virat Kohli',       '1988-11-05', 'India',       'Batter'),
(2,  'Rohit Sharma',      '1987-04-30', 'India',       'Batter'),
(3,  'MS Dhoni',          '1981-07-07', 'India',       'Wicketkeeper'),
(4,  'Jasprit Bumrah',    '1993-12-06', 'India',       'Bowler'),
(5,  'Ravindra Jadeja',   '1988-12-06', 'India',       'All-rounder'),
(6,  'Andre Russell',     '1988-04-29', 'West Indies', 'All-rounder'),
(7,  'Rashid Khan',       '1998-09-20', 'Afghanistan', 'Bowler'),
(8,  'Jos Buttler',       '1990-09-08', 'England',     'Wicketkeeper'),
(9,  'KL Rahul',          '1992-04-18', 'India',       'Wicketkeeper'),
(10, 'Hardik Pandya',     '1993-10-11', 'India',       'All-rounder'),
(11, 'Shubman Gill',      '1999-09-08', 'India',       'Batter'),
(12, 'Suryakumar Yadav',  '1990-09-14', 'India',       'Batter');

CREATE OR REPLACE TABLE teams (
    team_id     INTEGER,
    team_name   VARCHAR,
    city        VARCHAR
);

INSERT INTO teams VALUES
(1, 'Chennai Super Kings', 'Chennai'),
(2, 'Mumbai Indians',     'Mumbai'),
(3, 'Royal Challengers Bengaluru', 'Bengaluru'),
(4, 'Kolkata Knight Riders', 'Kolkata'),
(5, 'Rajasthan Royals',    'Jaipur'),
(6, 'Gujarat Titans',      'Ahmedabad');

CREATE OR REPLACE TABLE venues (
    venue_id     INTEGER,
    venue_name   VARCHAR,
    city         VARCHAR
);

INSERT INTO venues VALUES
(1, 'M. Chinnaswamy Stadium', 'Bengaluru'),
(2, 'Wankhede Stadium',        'Mumbai'),
(3, 'M. A. Chidambaram Stadium', 'Chennai'),
(4, 'Eden Gardens',             'Kolkata'),
(5, 'Sawai Mansingh Stadium',   'Jaipur'),
(6, 'Narendra Modi Stadium',    'Ahmedabad');

CREATE OR REPLACE TABLE player_team_history (
    player_id    INTEGER,
    team_id      INTEGER,
    season       INTEGER,
    start_date   DATE,
    end_date     DATE
);

INSERT INTO player_team_history VALUES
(1, 3, 2024, '2024-03-01', '2024-12-31'),
(1, 3, 2025, '2025-03-01', '2025-12-31'),

(2, 2, 2024, '2024-03-01', '2024-12-31'),
(2, 2, 2025, '2025-03-01', '2025-12-31'),

(3, 1, 2024, '2024-03-01', '2024-12-31'),
(3, 1, 2025, '2025-03-01', '2025-12-31'),

(4, 2, 2024, '2024-03-01', '2024-12-31'),
(4, 2, 2025, '2025-03-01', '2025-12-31'),

(5, 1, 2024, '2024-03-01', '2024-12-31'),
(5, 1, 2025, '2025-03-01', '2025-12-31'),

(6, 4, 2024, '2024-03-01', '2024-12-31'),
(6, 4, 2025, '2025-03-01', '2025-12-31'),

(7, 5, 2024, '2024-03-01', '2024-12-31'),
(7, 6, 2025, '2025-03-01', '2025-12-31'),

(8, 5, 2024, '2024-03-01', '2024-12-31'),
(8, 5, 2025, '2025-03-01', '2025-12-31'),

(9, 1, 2024, '2024-03-01', '2024-12-31'),
(9, 2, 2025, '2025-03-01', '2025-12-31'),

(10, 6, 2024, '2024-03-01', '2024-12-31'),
(10, 2, 2025, '2025-03-01', '2025-12-31'),

(11, 6, 2024, '2024-03-01', '2024-12-31'),
(11, 6, 2025, '2025-03-01', '2025-12-31'),

(12, 2, 2024, '2024-03-01', '2024-12-31'),
(12, 2, 2025, '2025-03-01', '2025-12-31');

CREATE OR REPLACE TABLE matches (
    match_id          INTEGER,
    season            INTEGER,
    match_date        DATE,
    venue_id          INTEGER,
    team1_id          INTEGER,
    team2_id          INTEGER,
    toss_winner_id    INTEGER,
    toss_decision     VARCHAR,
    winner_id         INTEGER
);

INSERT INTO matches VALUES
(1001, 2024, '2024-03-22', 1, 3, 1, 3, 'BAT',   3),
(1002, 2024, '2024-03-23', 2, 2, 5, 2, 'FIELD', 2),
(1003, 2024, '2024-03-24', 3, 1, 6, 1, 'BAT',   1),
(1004, 2024, '2024-03-25', 4, 4, 2, 4, 'FIELD', 4),
(1005, 2024, '2024-03-26', 5, 5, 3, 5, 'BAT',   5),
(1006, 2024, '2024-03-27', 6, 6, 1, 6, 'FIELD', 6),

(2001, 2025, '2025-03-22', 1, 3, 2, 2, 'FIELD', 3),
(2002, 2025, '2025-03-23', 2, 2, 6, 2, 'BAT',   6),
(2003, 2025, '2025-03-24', 3, 1, 4, 4, 'FIELD', 1),
(2004, 2025, '2025-03-25', 4, 4, 5, 5, 'BAT',   4),
(2005, 2025, '2025-03-26', 5, 5, 6, 6, 'FIELD', 6),
(2006, 2025, '2025-03-27', 6, 6, 3, 3, 'BAT',   3);

CREATE OR REPLACE TABLE deliveries (
    match_id          INTEGER,
    inning            INTEGER,
    over              INTEGER,
    ball              INTEGER,
    batter_id         INTEGER,
    bowler_id         INTEGER,
    runs_batter       INTEGER,
    runs_total        INTEGER,
    extras_type       VARCHAR,
    extras_runs       INTEGER,
    wicket_flag       BOOLEAN,
    wicket_player_id  INTEGER
);

INSERT INTO deliveries VALUES
-- Match 1001
(1001,1,1,1,1,4,0,0,NULL,0,FALSE,NULL),
(1001,1,1,2,1,4,4,4,NULL,0,FALSE,NULL),
(1001,1,1,3,1,4,1,1,NULL,0,FALSE,NULL),
(1001,1,1,4,11,4,2,2,NULL,0,FALSE,NULL),
(1001,1,1,5,11,4,0,0,NULL,0,FALSE,NULL),
(1001,1,1,6,11,4,6,6,NULL,0,FALSE,NULL),

(1001,1,2,1,1,7,4,4,NULL,0,FALSE,NULL),
(1001,1,2,2,1,7,1,1,NULL,0,FALSE,NULL),
(1001,1,2,3,11,7,0,0,NULL,0,FALSE,NULL),
(1001,1,2,4,11,7,4,4,NULL,0,FALSE,NULL),
(1001,1,2,5,11,7,1,1,NULL,0,FALSE,NULL),
(1001,1,2,6,1,7,2,2,NULL,0,FALSE,NULL),

-- Match 1002
(1002,1,1,1,2,7,4,4,NULL,0,FALSE,NULL),
(1002,1,1,2,2,7,1,1,NULL,0,FALSE,NULL),
(1002,1,1,3,8,7,6,6,NULL,0,FALSE,NULL),
(1002,1,1,4,8,7,0,0,NULL,0,FALSE,NULL),
(1002,1,1,5,8,7,4,4,NULL,0,FALSE,NULL),
(1002,1,1,6,8,7,1,1,NULL,0,FALSE,NULL),

(1002,2,1,1,7,4,0,0,NULL,0,FALSE,NULL),
(1002,2,1,2,7,4,1,1,NULL,0,FALSE,NULL),
(1002,2,1,3,6,4,6,6,NULL,0,FALSE,NULL),
(1002,2,1,4,6,4,4,4,NULL,0,FALSE,NULL),
(1002,2,1,5,6,4,0,0,NULL,0,FALSE,NULL),
(1002,2,1,6,6,4,2,2,NULL,0,FALSE,NULL),

-- Match 1003
(1003,1,1,1,5,4,1,1,NULL,0,FALSE,NULL),
(1003,1,1,2,5,4,4,4,NULL,0,FALSE,NULL),
(1003,1,1,3,9,4,2,2,NULL,0,FALSE,NULL),
(1003,1,1,4,9,4,0,0,NULL,0,FALSE,NULL),
(1003,1,1,5,9,4,6,6,NULL,0,FALSE,NULL),
(1003,1,1,6,9,4,1,1,NULL,0,FALSE,NULL),

(1003,2,1,1,10,7,6,6,NULL,0,FALSE,NULL),
(1003,2,1,2,10,7,1,1,NULL,0,FALSE,NULL),
(1003,2,1,3,11,7,4,4,NULL,0,FALSE,NULL),
(1003,2,1,4,11,7,0,0,NULL,0,FALSE,NULL),
(1003,2,1,5,11,7,1,1,NULL,0,FALSE,NULL),
(1003,2,1,6,10,7,2,2,NULL,0,FALSE,NULL),

-- Match 1004
(1004,1,1,1,6,4,6,6,NULL,0,FALSE,NULL),
(1004,1,1,2,6,4,4,4,NULL,0,FALSE,NULL),
(1004,1,1,3,6,4,1,1,NULL,0,FALSE,NULL),
(1004,1,1,4,6,4,0,0,NULL,0,FALSE,NULL),
(1004,1,1,5,6,4,6,6,NULL,0,FALSE,NULL),
(1004,1,1,6,6,4,2,2,NULL,0,FALSE,NULL),

(1004,2,1,1,2,7,4,4,NULL,0,FALSE,NULL),
(1004,2,1,2,2,7,0,0,NULL,0,FALSE,NULL),
(1004,2,1,3,2,7,1,1,NULL,0,FALSE,NULL),
(1004,2,1,4,8,7,6,6,NULL,0,FALSE,NULL),
(1004,2,1,5,8,7,4,4,NULL,0,FALSE,NULL),
(1004,2,1,6,8,7,1,1,NULL,0,FALSE,NULL),

-- Match 1005
(1005,1,1,1,8,4,4,4,NULL,0,FALSE,NULL),
(1005,1,1,2,8,4,1,1,NULL,0,FALSE,NULL),
(1005,1,1,3,7,4,6,6,NULL,0,FALSE,NULL),
(1005,1,1,4,7,4,0,0,NULL,0,FALSE,NULL),
(1005,1,1,5,7,4,4,4,NULL,0,FALSE,NULL),
(1005,1,1,6,7,4,2,2,NULL,0,FALSE,NULL),

(1005,2,1,1,1,7,4,4,NULL,0,FALSE,NULL),
(1005,2,1,2,1,7,6,6,NULL,0,FALSE,NULL),
(1005,2,1,3,1,7,1,1,NULL,0,FALSE,NULL),
(1005,2,1,4,11,7,2,2,NULL,0,FALSE,NULL),
(1005,2,1,5,11,7,0,0,NULL,0,FALSE,NULL),
(1005,2,1,6,11,7,1,1,NULL,0,FALSE,NULL),

-- Match 1006
(1006,1,1,1,10,4,6,6,NULL,0,FALSE,NULL),
(1006,1,1,2,10,4,4,4,NULL,0,FALSE,NULL),
(1006,1,1,3,10,4,1,1,NULL,0,FALSE,NULL),
(1006,1,1,4,10,4,0,0,NULL,0,FALSE,NULL),
(1006,1,1,5,10,4,2,2,NULL,0,FALSE,NULL),
(1006,1,1,6,10,4,4,4,NULL,0,FALSE,NULL),

(1006,2,1,1,5,7,1,1,NULL,0,FALSE,NULL),
(1006,2,1,2,5,7,4,4,NULL,0,FALSE,NULL),
(1006,2,1,3,9,7,6,6,NULL,0,FALSE,NULL),
(1006,2,1,4,9,7,0,0,NULL,0,FALSE,NULL),
(1006,2,1,5,9,7,1,1,NULL,0,FALSE,NULL),
(1006,2,1,6,5,7,2,2,NULL,0,FALSE,NULL),

-- Match 2001
(2001,1,1,1,1,4,4,4,NULL,0,FALSE,NULL),
(2001,1,1,2,1,4,1,1,NULL,0,FALSE,NULL),
(2001,1,1,3,1,4,6,6,NULL,0,FALSE,NULL),
(2001,1,1,4,1,4,0,0,NULL,0,FALSE,NULL),
(2001,1,1,5,1,4,2,2,NULL,0,FALSE,NULL),
(2001,1,1,6,1,4,4,4,NULL,0,FALSE,NULL),

(2001,2,1,1,2,4,1,1,NULL,0,FALSE,NULL),
(2001,2,1,2,2,4,4,4,NULL,0,FALSE,NULL),
(2001,2,1,3,2,4,0,0,NULL,0,FALSE,NULL),
(2001,2,1,4,2,4,1,1,NULL,0,FALSE,NULL),
(2001,2,1,5,9,4,2,2,NULL,0,FALSE,NULL),
(2001,2,1,6,9,4,6,6,NULL,0,FALSE,NULL),

-- Match 2002
(2002,1,1,1,2,7,4,4,NULL,0,FALSE,NULL),
(2002,1,1,2,2,7,6,6,NULL,0,FALSE,NULL),
(2002,1,1,3,2,7,1,1,NULL,0,FALSE,NULL),
(2002,1,1,4,2,7,0,0,NULL,0,FALSE,NULL),
(2002,1,1,5,10,7,4,4,NULL,0,FALSE,NULL),
(2002,1,1,6,10,7,2,2,NULL,0,FALSE,NULL),

(2002,2,1,1,11,4,1,1,NULL,0,FALSE,NULL),
(2002,2,1,2,11,4,4,4,NULL,0,FALSE,NULL),
(2002,2,1,3,11,4,6,6,NULL,0,FALSE,NULL),
(2002,2,1,4,11,4,0,0,NULL,0,FALSE,NULL),
(2002,2,1,5,11,4,1,1,NULL,0,FALSE,NULL),
(2002,2,1,6,11,4,2,2,NULL,0,FALSE,NULL),

-- Match 2003
(2003,1,1,1,6,7,6,6,NULL,0,FALSE,NULL),
(2003,1,1,2,6,7,4,4,NULL,0,FALSE,NULL),
(2003,1,1,3,6,7,1,1,NULL,0,FALSE,NULL),
(2003,1,1,4,6,7,2,2,NULL,0,FALSE,NULL),
(2003,1,1,5,6,7,0,0,NULL,0,FALSE,NULL),
(2003,1,1,6,6,7,4,4,NULL,0,FALSE,NULL),

(2003,2,1,1,3,4,1,1,NULL,0,FALSE,NULL),
(2003,2,1,2,3,4,4,4,NULL,0,FALSE,NULL),
(2003,2,1,3,3,4,0,0,NULL,0,FALSE,NULL),
(2003,2,1,4,3,4,6,6,NULL,0,FALSE,NULL),
(2003,2,1,5,3,4,1,1,NULL,0,FALSE,NULL),
(2003,2,1,6,3,4,2,2,NULL,0,FALSE,NULL),

-- Match 2004
(2004,1,1,1,6,7,4,4,NULL,0,FALSE,NULL),
(2004,1,1,2,6,7,6,6,NULL,0,FALSE,NULL),
(2004,1,1,3,6,7,0,0,NULL,0,FALSE,NULL),
(2004,1,1,4,6,7,1,1,NULL,0,FALSE,NULL),
(2004,1,1,5,8,7,4,4,NULL,0,FALSE,NULL),
(2004,1,1,6,8,7,2,2,NULL,0,FALSE,NULL),

(2004,2,1,1,7,4,1,1,NULL,0,FALSE,NULL),
(2004,2,1,2,7,4,4,4,NULL,0,FALSE,NULL),
(2004,2,1,3,7,4,6,6,NULL,0,FALSE,NULL),
(2004,2,1,4,7,4,0,0,NULL,0,FALSE,NULL),
(2004,2,1,5,7,4,1,1,NULL,0,FALSE,NULL),
(2004,2,1,6,7,4,2,2,NULL,0,FALSE,NULL),

-- Match 2005
(2005,1,1,1,11,4,4,4,NULL,0,FALSE,NULL),
(2005,1,1,2,11,4,1,1,NULL,0,FALSE,NULL),
(2005,1,1,3,11,4,6,6,NULL,0,FALSE,NULL),
(2005,1,1,4,11,4,4,4,NULL,0,FALSE,NULL),
(2005,1,1,5,11,4,0,0,NULL,0,FALSE,NULL),
(2005,1,1,6,11,4,2,2,NULL,0,FALSE,NULL),

(2005,2,1,1,10,7,6,6,NULL,0,FALSE,NULL),
(2005,2,1,2,10,7,1,1,NULL,0,FALSE,NULL),
(2005,2,1,3,10,7,4,4,NULL,0,FALSE,NULL),
(2005,2,1,4,10,7,0,0,NULL,0,FALSE,NULL),
(2005,2,1,5,10,7,1,1,NULL,0,FALSE,NULL),
(2005,2,1,6,10,7,2,2,NULL,0,FALSE,NULL),

-- Match 2006
(2006,1,1,1,1,7,6,6,NULL,0,FALSE,NULL),
(2006,1,1,2,1,7,4,4,NULL,0,FALSE,NULL),
(2006,1,1,3,1,7,1,1,NULL,0,FALSE,NULL),
(2006,1,1,4,1,7,0,0,NULL,0,FALSE,NULL),
(2006,1,1,5,1,7,2,2,NULL,0,FALSE,NULL),
(2006,1,1,6,1,7,4,4,NULL,0,FALSE,NULL),

(2006,2,1,1,6,4,4,4,NULL,0,FALSE,NULL),
(2006,2,1,2,6,4,6,6,NULL,0,FALSE,NULL),
(2006,2,1,3,6,4,0,0,NULL,0,FALSE,NULL),
(2006,2,1,4,6,4,1,1,NULL,0,FALSE,NULL),
(2006,2,1,5,6,4,4,4,NULL,0,FALSE,NULL),
(2006,2,1,6,6,4,2,2,NULL,0,FALSE,NULL);

SELECT COUNT(*) FROM players;
SELECT COUNT(*) FROM teams;
SELECT COUNT(*) FROM venues;
SELECT COUNT(*) FROM player_team_history;
SELECT COUNT(*) FROM matches;
SELECT COUNT(*) FROM deliveries;

alter table dbt_dev_cricket_analytics_platform.raw.matches
add column created_at timestamp_ntz,
add column updated_at timestamp_ntz;

update dbt_dev_cricket_analytics_platform.raw.matches
set
    created_at = match_date::timestamp_ntz,
    updated_at = match_date::timestamp_ntz;