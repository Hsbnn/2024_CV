import psycopg2
from contextlib import closing
from dotenv import load_dotenv
import os

load_dotenv()

def connect_to_db():
    try:
        connection = psycopg2.connect(
            host=os.getenv("DB_HOST"),
            database=os.getenv("DB_NAME"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD")
        )
        return connection
    except Exception as e:
        print(f"Ошибка подключения: {e}")
        return None

def get_movies():
    connection = connect_to_db()
    if connection:
        try:
            cursor = connection.cursor()
            cursor.execute("SELECT * FROM movies;")
            movies = cursor.fetchall()
            cursor.close()
            return movies
        except Exception as e:
            print(f"Ошибка запроса: {e}")
        finally:
            connection.close()
    return []

def get_movie_details(movie_id):
    with closing(connect_to_db()) as connection:
        cursor = connection.cursor()
        cursor.execute(
            """
            SELECT title, year_of_release, director, description, star_rating, number_of_ratings, poster
            FROM movies
            WHERE movie_id = %s
            """,
            (movie_id,)
        )
        movie = cursor.fetchone()
    return movie

def get_movie_cast(movie_id):
    with closing(connect_to_db()) as connection:
        cursor = connection.cursor()
        cursor.execute(
            """
            SELECT actors.name
            FROM filmography_of_actors
            RIGHT JOIN actors ON filmography_of_actors.actor_id = actors.actor_id
            WHERE filmography_of_actors.movie_id = %s
            """,
            (movie_id,)
        )
        cast = cursor.fetchall()
    return [actor[0] for actor in cast] 


def update_movie_rating(movie_id, old_average, count, new_rating):
    new_average = (old_average * count + new_rating) / (count + 1)
    with closing(connect_to_db()) as connection:
        cursor = connection.cursor()
        cursor.execute(
            """
            UPDATE movies
            SET star_rating = %s, number_of_ratings = %s
            WHERE movie_id = %s
            """,
            (new_average, count + 1, movie_id)
        )
        connection.commit()

def add_to_favorites(user_id, movie_id):
    with closing(connect_to_db()) as connection:
        cursor = connection.cursor()
        cursor.execute(
            """
            INSERT INTO liked_movies (user_id, movie_id)
            VALUES (%s, %s)
            ON CONFLICT DO NOTHING
            """,
            (user_id, movie_id)
        )
        connection.commit()

# есть ли у пользователя оценка для данного фильма
def get_user_stars(user_id, movie_id):
    with closing(connect_to_db()) as connection:
        cursor = connection.cursor()
        cursor.execute(
            """
            SELECT number_of_stars
            FROM stars
            WHERE user_id = %s AND movie_id = %s
            """,
            (user_id, movie_id)
        )
        result = cursor.fetchone()
    return result[0] if result else None

def update_user_stars(user_id, movie_id, number_of_stars):
    with closing(connect_to_db()) as connection:
        cursor = connection.cursor()
        cursor.execute(
            """
            INSERT INTO stars (user_id, movie_id, number_of_stars)
            VALUES (%s, %s, %s)
            ON CONFLICT (user_id, movie_id) DO UPDATE
            SET number_of_stars = EXCLUDED.number_of_stars
            """,
            (user_id, movie_id, number_of_stars)
        )
        connection.commit()

def delete_user_stars(user_id, movie_id):
    with closing(connect_to_db()) as connection:
        cursor = connection.cursor()
        cursor.execute(
            """
            SELECT number_of_stars FROM stars
            WHERE user_id = %s AND movie_id = %s
            """,
            (user_id, movie_id)
        )
        user_rating = cursor.fetchone()

        if user_rating:
            user_rating = user_rating[0] 
            
            cursor.execute(
                """
                DELETE FROM stars
                WHERE user_id = %s AND movie_id = %s
                """,
                (user_id, movie_id)
            )

            # получение текущего количества оценок и средней оценки фильма
            cursor.execute(
                """
                SELECT star_rating, number_of_ratings
                FROM movies
                WHERE movie_id = %s
                """,
                (movie_id,)
            )
            movie_data = cursor.fetchone()

            if movie_data:
                old_average, count = movie_data
                if count > 1:
                    new_average = (old_average * count - user_rating) / (count - 1)
                    new_count = count - 1
                else:
                    new_average = 0
                    new_count = 0

                cursor.execute(
                    """
                    UPDATE movies
                    SET star_rating = %s, number_of_ratings = %s
                    WHERE movie_id = %s
                    """,
                    (new_average, new_count, movie_id)
                )

            connection.commit()
            return True  
        
        return False  # не нашли оценку


def remove_from_favorites(user_id, movie_id):
    with closing(connect_to_db()) as connection:
        cursor = connection.cursor()
        cursor.execute(
            """
            DELETE FROM liked_movies
            WHERE user_id = %s AND movie_id = %s
            """,
            (user_id, movie_id)
        )
        connection.commit()

def is_favorite(user_id, movie_id):
    with closing(connect_to_db()) as connection:
        cursor = connection.cursor()
        cursor.execute(
            """
            SELECT 1
            FROM liked_movies
            WHERE user_id = %s AND movie_id = %s
            """,
            (user_id, movie_id)
        )
        return cursor.fetchone() is not None

def get_favorite_movies(user_id):
    with closing(connect_to_db()) as connection:
        cursor = connection.cursor()
        cursor.execute(
            """
            SELECT m.movie_id, m.title, m.year_of_release, m.director, m.description, m.star_rating, m.number_of_ratings, m.poster
            FROM movies m
            JOIN liked_movies ON m.movie_id = liked_movies.movie_id
            WHERE liked_movies.user_id = %s
            """,
            (user_id,)
        )
        return cursor.fetchall()

def search_movies(query):
    with closing(connect_to_db()) as connection:
        cursor = connection.cursor()
        
        cursor.execute(
            """
            SELECT * FROM movies
            WHERE title LIKE %s
            """,
            (f"%{query}%",)
        )
        return cursor.fetchall()


def get_actor_details(actor_name):
    with closing(connect_to_db()) as connection:
        cursor = connection.cursor()
        cursor.execute("SELECT name, biography FROM actors WHERE name = %s", (actor_name,))
        result = cursor.fetchone()
        if result:
            return {"name": result[0], "biography": result[1]}
        return None


def get_movie_genres(movie_id):
    conn = connect_to_db()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT genre_name FROM genres
        JOIN movie_genres ON genres.genre_id = movie_genres.genre_id
        WHERE movie_genres.movie_id = %s
    """, (movie_id,))
    genres = cursor.fetchall()
    cursor.close()
    conn.close()
    return [genre[0] for genre in genres]

def get_age_category_for_movie(movie_id):
    conn = connect_to_db()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT age_categorys.age FROM age_categorys
        JOIN ages_of_films ON age_categorys.age_id = ages_of_films.age_id
        WHERE ages_of_films.movie_id = %s
    """, (movie_id,))
    age_category = cursor.fetchone()
    cursor.close()
    conn.close()
    return age_category[0] if age_category else "Не указано"

def add_review(user_id, movie_id, review_text):
    query = """
    INSERT INTO reviews (movie_id, user_id, review_text, date_of_writing)
    VALUES (%s, %s, %s, CURRENT_TIMESTAMP)
    """
    with closing(connect_to_db()) as connection:
        cursor = connection.cursor()
        cursor.execute(query, (movie_id, user_id, review_text))
        connection.commit()

def get_reviews(movie_id):
    query = """
    SELECT user_id, review_text, date_of_writing
    FROM reviews
    WHERE movie_id = %s
    ORDER BY date_of_writing DESC
    """
    
    connection = connect_to_db()
    if connection:
        cursor = connection.cursor()
        cursor.execute(query, (movie_id,))
        result = cursor.fetchall()
        
        reviews = []
        for row in result:
            review = {
                "user_id": row[0],
                "review_text": row[1],
                "date_of_writing": row[2]
            }
            reviews.append(review)
        
        cursor.close()
        connection.close()
        return reviews
    return []

def get_user_name(user_id):
    query = """
    SELECT email FROM users WHERE user_id = %s
    """
    with closing(connect_to_db()) as connection:
        cursor = connection.cursor()
        cursor.execute(query, (user_id,))
        result = cursor.fetchone()  
    return result[0] if result else "Неизвестный пользователь"

def get_movie_title(movie_id):
    query = """
    SELECT title FROM movies WHERE movie_id = %s
    """
    with closing(connect_to_db()) as connection:
        cursor = connection.cursor()
        cursor.execute(query, (movie_id,))
        result = cursor.fetchone()  
    return result[0] if result else "Неизвестный фильм"