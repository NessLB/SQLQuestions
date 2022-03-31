USE movielens;

-- 1) List the titles and release dates of movies released between 1983-1993 in reverse chronological order.
SELECT title, release_date FROM movies 
WHERE YEAR(release_date) > 1982 AND YEAR(release_date) < 1994
ORDER BY release_date DESC;

-- 2) Without using LIMIT, list the titles of the movies with the lowest average rating.
SELECT m.title, AVG(r.rating) AS avg_rating FROM movies AS m
JOIN ratings AS r ON r.movie_id = m.id
GROUP BY m.title
ORDER BY avg_rating;

-- 3) List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.
-- All male students age 24
CREATE VIEW m_24_student AS
	SELECT u.id, u.gender, u.age, o.name FROM users AS u
	JOIN occupations AS o ON u.occupation_id = o.id
    WHERE o.name = "Student" AND u.age = 24 AND u.gender = "M";

-- All 5 star movies rated by m-24-student
CREATE VIEW five_star_m24s AS 
	SELECT r.movie_id FROM ratings AS r
	JOIN m_24_student AS m ON r.user_id = m.id
	WHERE r.rating = 5;

-- All sci-fi movies
 CREATE VIEW all_scifi AS
	SELECT m.id AS PK_movie_ID, m.title FROM movies AS m
	JOIN genres_movies AS gm ON gm.movie_id = m.id
	JOIN genres AS g ON gm.genre_id = g.id
	WHERE g.name = "Sci-Fi";

SELECT DISTINCT(title) FROM all_scifi 
JOIN five_star_m24s ON all_scifi.pk_movie_id = five_star_m24s.movie_id
ORDER BY title;

-- 4) List the unique titles of each of the movies released on the most popular release day.
CREATE VIEW rd_count AS
	SELECT release_date, COUNT(*) AS maxcount FROM movies
	GROUP BY release_date
	ORDER BY maxcount DESC LIMIT 1;

SELECT * FROM rd_count;

SELECT title FROM movies
WHERE release_date = "1995-01-01";
 
-- 5) Find the total number of movies in each genre; list the results in ascending numeric order.
SELECT g.name, COUNT(gm.movie_id) AS counter FROM genres AS g 
LEFT JOIN genres_movies AS gm ON gm.genre_id = g.id
GROUP BY g.id, g.name
ORDER BY counter;
