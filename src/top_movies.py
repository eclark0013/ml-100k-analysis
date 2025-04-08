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

# Get database credentials from environment variables
conn = psycopg2.connect(
    dbname=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT")
)

cur = conn.cursor()


cur.execute("SELECT AVG(rating) FROM ratings WHERE movie_id = 512 GROUP BY movie_id;")
results = cur.fetchall()
print(results[0])


# Close the connection
cur.close()
conn.close()