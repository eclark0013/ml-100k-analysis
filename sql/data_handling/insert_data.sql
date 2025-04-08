COPY users
FROM '/Users/ericclark/DataScience/Projects/ml-100k-analysis/data/raw/ml-100k/u.user' 
WITH (FORMAT TEXT, DELIMITER E'|');

COPY staging_movies_3
FROM '/Users/ericclark/DataScience/Projects/ml-100k-analysis/data/raw/ml-100k/u.item.cleaned'
WITH (FORMAT TEXT, DELIMITER '|');

COPY movies
FROM '/Users/ericclark/DataScience/Projects/ml-100k-analysis/data/raw/ml-100k/u.item.cleaned' 
WITH (FORMAT TEXT, DELIMITER E'|');


COPY ratings (user_id, movie_id, rating, timestamp)
FROM '/Users/ericclark/DataScience/Projects/ml-100k-analysis/data/raw/ml-100k/u.data'
WITH (FORMAT text, DELIMITER E'\t');

SELECT COUNT(*) FROM staging_movies_3 


SELECT * FROM ratings

SELECT MAX(movie_id), COUNT(*) FROM movies;

SELECT column_name FROM information_schema.columns WHERE table_name = 'movies' ORDER BY column_name; 

