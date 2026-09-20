Project Problem Statement — Cricket Analytics Data Platform
Business Context

A cricket analytics company wants to build a centralized data platform to analyze IPL matches, players, teams, and player performance across seasons.

Currently, match data arrives from multiple sources as raw files. The company wants to load this data into Snowflake and build a reliable analytics layer using dbt.

The platform should support both historical analysis and the continuous arrival of new match data.

Business users want to answer questions such as:
How has a player's performance changed across seasons?
Which players are currently associated with each team?
What was a player's team at a particular point in time?
Which teams perform best at particular venues?
How do batting and bowling performances vary by season?
What is the team's win percentage?
How does toss decision relate to match outcomes?
Which players consistently perform well?
Can analysts compare current player performance with historical performance?
Can the platform reliably incorporate newly arriving match data without rebuilding everything?
Data available

You will receive raw data representing:

Players
Teams
Venues
Player-team associations
Matches
Ball-by-ball deliveries

You can use the synthetic dataset I gave you above as your initial source data.

Engineering requirements

The company expects you to build a production-style data platform that:

Stores the raw data in Snowflake
Separates raw data from transformed/analytics data
Creates reusable and maintainable transformations
Handles new/changed data efficiently
Preserves relevant historical information
Provides reliable data-quality validation
Makes dependencies and lineage understandable
Supports development and production environments
Produces analytics-ready tables for downstream consumers