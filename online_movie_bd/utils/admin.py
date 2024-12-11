import streamlit as st
import subprocess
import os
from utils.helpers import check_folder, add_new_film, view_logs
from utils.helpers import get_movies_by_title, delete_one_movie

def admin_page():
    st.title("**Панель администратора**")

    if st.checkbox("Показать логи изменений фильмов"):
        view_logs()
    
    st.subheader("Резервное копирование")
    backup_file = st.text_input("Укажите путь для сохранения резервной копии", "backup.sql")
    if st.button("Создать резервную копию"):
        result = backup_database(backup_file)
        st.info(result)

    st.subheader("Восстановление базы данных")
    restore_file = st.text_input("Укажите путь к файлу резервной копии для восстановления", "backup.sql")
    if st.button("Восстановить базу данных"):
        result = restore_database(restore_file)
        st.info(result)

    action = st.radio("Выберите действие", ["Добавить фильм", "Удалить фильм"], horizontal=True)
    
    if action == "Добавить фильм":
        add_movie()
    elif action == "Удалить фильм":
        delete_movie()


def backup_database(output_file):
    try:
        result = subprocess.run(
            [
                "pg_dump",
                "-U", "cat", 
                "-h", "localhost", 
                "-d", "postgres",
                "-F", "c",  
                "-b",  
                "-v",  
                "-f", output_file  
            ],
            env={"PGPASSWORD": "mysecretpassword"}, 
            check=True,
            text=True,
            capture_output=True
        )
        return f"Резервная копия успешно создана. {result.stdout}"
    except subprocess.CalledProcessError as e:
        return f"Ошибка создания резервной копии: {e.stderr}"

def add_movie():
    st.subheader("Добавить фильм")
    title = st.text_input("Название фильма")
    year_of_release = st.number_input("Год выпуска", min_value=1895, max_value=2050, step=1)
    director = st.text_input("Режиссер")
    description = st.text_area("Описание фильма")
    star_rating = st.number_input("Рейтинг фильма", min_value=0.0, max_value=10.0, step=0.1)
    number_of_ratings = st.number_input("Количество оценок", min_value=0, max_value=1000000000, step=1)
    poster = st.file_uploader("Загрузите постер фильма", type=["jpg"])

    age_category = st.selectbox("Возрастная категория", ["6-11", "12-15", "16-17", "18+"])
    genres = st.multiselect("Выберите жанры", ["Action", "Drama", "Sci-Fi", "Fantasy", "Animation", "Romance", "Crime"])

    actor_input = st.text_area("Введите актеров с их характеристиками (например, 'Актер 1: характеристика $ Актер 2: характеристика')")


    if st.button("Добавить фильм"):
        if title and year_of_release and director and description and poster and star_rating and number_of_ratings:
           
            check_folder()

            poster_path = os.path.join('./assets/images', poster.name)
            with open(poster_path, "wb") as f:
                f.write(poster.read())
            
            # добавление фильма в базу данных
            add_new_film(title, year_of_release, director, description, star_rating, number_of_ratings, poster.name, age_category, genres, actor_input)
        else:
            st.error("Пожалуйста, заполните все поля и загрузите постер.")

def delete_movie():
    st.subheader("Удалить фильм")

    search_query = st.text_input("Введите название фильма для поиска")

    movies = get_movies_by_title(search_query)

    if not movies:
        st.info("Нет фильмов, соответствующих запросу.")
        return

    movie_options = {f"{movie[1]} (ID: {movie[0]})": movie[0] for movie in movies}
    selected_movie = st.selectbox("Выберите фильм для удаления", list(movie_options.keys()))

    if st.button("Удалить фильм"):
        if selected_movie:
            movie_id = movie_options[selected_movie]
            delete_one_movie(movie_id)
        else:
            st.info("Выберите фильм.")


def restore_database(input_file):
    try:
        result = subprocess.run(
            [
                "pg_restore",
                "-U", "cat", 
                "-h", "localhost", 
                "-d", "postgres", 
                "-c",  
                "-v", 
                input_file  
            ],
            env={"PGPASSWORD": "mysecretpassword"},
            check=True,
            text=True,
            capture_output=True
        )
        if "error" not in result.stderr.lower(): 
            return f"Восстановление успешно завершено."
        else:
            return f"Восстановление выполнено с предупреждениями: {result.stderr}"
    except subprocess.CalledProcessError as e:
        return f"Ошибка восстановления базы данных: {e.stderr}"
