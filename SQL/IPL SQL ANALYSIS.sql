CREATE database ipl; 
USE IPL;

CREATE TABLE matches (
    id               INT PRIMARY KEY,
    season           INT,
    city             VARCHAR(50),
    date             VARCHAR(20),
    team1            VARCHAR(50),
    team2            VARCHAR(50),
    toss_winner      VARCHAR(50),
    toss_decision    VARCHAR(10),
    result           VARCHAR(20),
    dl_applied       INT,
    winner           VARCHAR(50),
    win_by_runs      INT,
    win_by_wickets   INT,
    player_of_match  VARCHAR(50),
    venue            VARCHAR(100),
    umpire1          VARCHAR(50),
    umpire2          VARCHAR(50),
    umpire3          VARCHAR(50)
);

SELECT * FROM matches;
DROP table deliveries; 
CREATE TABLE deliveries (
    match_id          INT,
    inning            INT,
    batting_team      VARCHAR(50),
    bowling_team      VARCHAR(50),
    `over`            INT,
    ball              INT,
    batsman           VARCHAR(50),
    non_striker       VARCHAR(50),
    bowler            VARCHAR(50),
    is_super_over     INT,
    wide_runs         INT,
    bye_runs          INT,
    legbye_runs       INT,
    noball_runs       INT,
    penalty_runs      INT,
    batsman_runs      INT,
    extra_runs        INT,
    total_runs        INT,
    player_dismissed  VARCHAR(50),
    dismissal_kind    VARCHAR(30),
    fielder           VARCHAR(50),
    CONSTRAINT fk_deliveries_match FOREIGN KEY (match_id) REFERENCES matches(id)
);
SELECT * FROM deliveries;

SET GLOBAL local_infile = 1;


LOAD DATA LOCAL INFILE 'D:/Suhaiv/Data_Analysis_Class/Final_Task/dataset/matches.csv'
INTO TABLE matches
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM matches;

LOAD DATA LOCAL INFILE 'D:/Suhaiv/Data_Analysis_Class/Final_Task/dataset/deliveries.csv'
INTO TABLE deliveries
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- PART A

SELECT * FROM deliveries;
SELECT count(match_id) FROM deliveries;

SELECT * FROM matches LIMIT 10;

SELECT * FROM deliveries LIMIT 10;

SELECT COUNT(*) AS total_matches FROM matches;

SELECT COUNT(*) AS total_deliveries FROM deliveries;

SELECT DISTINCT season FROM matches ORDER BY season;


SELECT DISTINCT city FROM matches;


SELECT DISTINCT team1 FROM matches;


SELECT * FROM matches WHERE season = 2017;


SELECT * FROM matches WHERE toss_decision = 'field';


SELECT * FROM matches WHERE winner = 'Mumbai Indians';


SELECT * FROM matches WHERE win_by_runs > 50;


SELECT * FROM matches WHERE win_by_wickets = 10;


SELECT * FROM matches WHERE toss_winner = winner;


SELECT * FROM matches WHERE team1 = 'Mumbai Indians' OR team2 = 'Mumbai Indians';


SELECT * FROM matches ORDER BY win_by_runs DESC LIMIT 10;


SELECT * FROM matches ORDER BY win_by_wickets DESC LIMIT 10;


-- PART B 


SELECT season, COUNT(*) AS matches_played
FROM matches
GROUP BY season
ORDER BY season;


SELECT city, COUNT(*) AS matches_played
FROM matches
GROUP BY city
ORDER BY matches_played DESC;


SELECT venue, COUNT(*) AS matches_played
FROM matches
GROUP BY venue
ORDER BY matches_played DESC;


SELECT winner, COUNT(*) AS wins
FROM matches
GROUP BY winner
ORDER BY wins DESC;


SELECT toss_winner, COUNT(*) AS toss_wins
FROM matches
GROUP BY toss_winner
ORDER BY toss_wins DESC;


SELECT toss_decision, COUNT(*) AS total
FROM matches
GROUP BY toss_decision;


SELECT player_of_match, COUNT(*) AS No_Of_awards
FROM matches
GROUP BY player_of_match
ORDER BY No_Of_awards DESC
LIMIT 10;


SELECT season, AVG(win_by_runs) AS avg_win_by_runs
FROM matches
GROUP BY season
ORDER BY season;


SELECT season, AVG(win_by_wickets) AS avg_win_by_wickets
FROM matches
GROUP BY season
ORDER BY season;


SELECT season, MAX(win_by_runs) AS max_win_by_runs
FROM matches
GROUP BY season
ORDER BY season;


SELECT season, MAX(win_by_wickets) AS max_win_by_wickets
FROM matches
GROUP BY season
ORDER BY season;



-- PART C 



SELECT COUNT(*) AS total_sixes FROM deliveries WHERE batsman_runs = 6;


SELECT COUNT(*) AS total_fours FROM deliveries WHERE batsman_runs = 4;


SELECT SUM(wide_runs) AS total_wide_runs FROM deliveries;


SELECT SUM(noball_runs) AS total_noball_runs FROM deliveries;


SELECT batsman, SUM(batsman_runs) AS total_runs
FROM deliveries
GROUP BY batsman
ORDER BY total_runs DESC
LIMIT 10;


SELECT batsman, COUNT(*) AS sixes
FROM deliveries
WHERE batsman_runs = 6
GROUP BY batsman
ORDER BY sixes DESC
LIMIT 10;


SELECT batsman, COUNT(*) AS fours
FROM deliveries
WHERE batsman_runs = 4
GROUP BY batsman
ORDER BY fours DESC
LIMIT 10;


SELECT batting_team, SUM(total_runs) AS total_runs
FROM deliveries
GROUP BY batting_team
ORDER BY total_runs DESC;


SELECT batting_team, SUM(extra_runs) AS total_extras
FROM deliveries
GROUP BY batting_team
ORDER BY total_extras DESC;


SELECT bowler, COUNT(*) AS deliveries_bowled
FROM deliveries
GROUP BY bowler
ORDER BY deliveries_bowled DESC
LIMIT 10;


SELECT bowler, SUM(total_runs) AS runs_conceded
FROM deliveries
GROUP BY bowler
ORDER BY runs_conceded DESC
LIMIT 10;


SELECT bowler, COUNT(*) AS dismissals
FROM deliveries
WHERE player_dismissed IS NOT NULL
  AND dismissal_kind <> 'run out'
GROUP BY bowler
ORDER BY dismissals DESC
LIMIT 10;


SELECT dismissal_kind, COUNT(*) AS total
FROM deliveries
WHERE dismissal_kind IS NOT NULL
  AND dismissal_kind <> ''
GROUP BY dismissal_kind
ORDER BY total DESC;


-- PART D


SELECT m.id, m.season, m.venue, m.winner,
       d.inning, d.batting_team, d.bowling_team, d.`over`, d.ball,
       d.batsman, d.bowler, d.total_runs
FROM matches m
JOIN deliveries d ON m.id = d.match_id
LIMIT 20;


SELECT m.season, SUM(d.total_runs) AS total_runs
FROM matches m
JOIN deliveries d ON m.id = d.match_id
GROUP BY m.season
ORDER BY m.season;


SELECT m.season, COUNT(*) AS sixes
FROM matches m
JOIN deliveries d ON m.id = d.match_id
WHERE d.batsman_runs = 6
GROUP BY m.season
ORDER BY m.season;


SELECT m.season, COUNT(*) AS fours
FROM matches m
JOIN deliveries d ON m.id = d.match_id
WHERE d.batsman_runs = 4
GROUP BY m.season
ORDER BY m.season;


SELECT m.season, SUM(d.extra_runs) AS total_extras
FROM matches m
JOIN deliveries d ON m.id = d.match_id
GROUP BY m.season
ORDER BY m.season;


SELECT m.season, d.batting_team, SUM(d.total_runs) AS total_runs
FROM matches m
JOIN deliveries d ON m.id = d.match_id
GROUP BY m.season, d.batting_team
ORDER BY m.season DESC;


SELECT d.batsman, SUM(d.batsman_runs) AS runs
FROM matches m
JOIN deliveries d ON m.id = d.match_id
WHERE m.season = 2017
GROUP BY d.batsman
ORDER BY runs DESC
LIMIT 10;


SELECT m.venue, SUM(d.total_runs) AS total_runs
FROM matches m
JOIN deliveries d ON m.id = d.match_id
GROUP BY m.venue
ORDER BY total_runs DESC
LIMIT 10;


SELECT m.season, COUNT(d.player_dismissed) AS dismissals
FROM matches m
JOIN deliveries d ON m.id = d.match_id
GROUP BY m.season
ORDER BY m.season;


SELECT m.id AS match_id, m.season, m.winner, SUM(d.total_runs) AS match_total_runs
FROM matches m
JOIN deliveries d ON m.id = d.match_id
GROUP BY m.id, m.season, m.winner
ORDER BY match_total_runs DESC;

SELECT @@hostname;
SELECT USER();
SHOW VARIABLES LIKE 'port';
SHOW DATABASES;

