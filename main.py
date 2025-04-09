# external imports
import pandas as pd
from dotenv import load_dotenv
import os
import psycopg2

# my imports
from src.top_movies import get_top_rated_movies_df
from visualizations.top_movies_bar_chart import plot_top_movies_bar_chart

# load environment variables
load_dotenv()

# set up database connection
conn = psycopg2.connect(
    dbname=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT")
)

cursor = conn.cursor()

# set movie_ids
movie_ids = [1, 2, 3, 4, 5]

# create dataframe
df = get_top_rated_movies_df(cursor, movie_ids)

# print data
print(df)

# plot data
plot_top_movies_bar_chart(df)

# close the connection
cursor.close()
conn.close()