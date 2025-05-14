CREATE DATABASE number_guess;
\c number_guess
CREATE TABLE userinfo (
	user_id SERIAL PRIMARY KEY NOT NULL,
	username VARCHAR(22) UNIQUE NOT NULL,
	games_played INT,
	best_game INT
);
-- Test data
INSERT INTO userinfo (username, games_played, best_game) VALUES ('lino', 5, 10);
INSERT INTO userinfo (username, games_played, best_game) VALUES ('oreo', 77, 30);

