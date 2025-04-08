""" 
Create a function that finds the movies with the top 
average ratings of any given set of movies. This could 
be used in conjunction with the similar_users function
to make a recommendation to a user based off of the top
rated movies by users similar to a given user. (May want
to modify the similar_users function to also be able to give
the top n similar users to have a larger sample for finding
top movies.)
 """

import pandas as pd
from dotenv import load_dotenv
import os
import psycopg2

# Load .env file
load_dotenv()

def execute_in_query(cursor, base_query, values):
    if not values:
        return values
    placeholders = ", ".join(['%s']*len(values))
    query = base_query.format(placeholders)
    cursor.execute(query, values)
    return cursor.fetchall()

def get_top_rated_movies(cursor, movie_ids):
    base_query = """ 
    SELECT 
        movie_id,
        AVG(rating) 
    FROM ratings WHERE movie_id IN ({})
    GROUP BY movie_id
    ORDER BY AVG(rating) DESC; """
    return execute_in_query(cursor, base_query, movie_ids)

# Get database credentials from environment variables
conn = psycopg2.connect(
    dbname=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT")
)

cursor = conn.cursor()

movie_ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

top_rated_movies = get_top_rated_movies(cursor, movie_ids)

for row in top_rated_movies:
    print(row)

# Close the connection
cursor.close()
conn.close()