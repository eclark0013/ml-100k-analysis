import matplotlib.pyplot as plt

def plot_top_movies_bar_chart(df):

    plt.figure(figsize=(12, 6))
    plt.bar(df['title'], df['avg_rating'], color='skyblue')

    plt.title('Top Rated Movies')
    plt.xlabel('Movie')
    plt.ylabel('Average Rating')
    plt.xticks(df['title'])  # Show all movie titles on x-axis
    plt.grid(axis='y', linestyle='--', alpha=0.9)

    plt.show()