import streamlit as st
from utils.auth import authenticate_user, register_user
from utils.admin import admin_page
from connection import get_movies, get_movie_details, get_movie_cast, update_movie_rating, add_to_favorites, get_favorite_movies
from connection import get_user_stars, update_user_stars, delete_user_stars, remove_from_favorites, is_favorite, search_movies
from connection import get_actor_details, get_movie_genres, get_age_category_for_movie, add_review, get_reviews, get_user_name
from connection import get_movie_title
from contextlib import closing

if "user" not in st.session_state:
    st.session_state["user"] = None
    st.session_state["role"] = None

if "auth_page" not in st.session_state:
    st.session_state["auth_page"] = "Авторизация"

if not st.session_state["user"]:
    selected_page = st.session_state["auth_page"]
else:
    menu = ["Фильмы", "Ваш профиль", "Избранные фильмы"]
    if st.session_state["role"] == "admin":
        menu.append("Страница администратора")
    selected_page = st.sidebar.selectbox("Меню", menu)

def login_page():
    st.title("Авторизация")
    email = st.text_input("Никнейм")
    password = st.text_input("Пароль", type="password")
    if st.button("Войти"):
        user_data = authenticate_user(email, password)
        if user_data:
            st.session_state["user_id"] = user_data["user_id"]
            st.session_state["user"] = email
            st.session_state["role"] = user_data["role"]
            st.success("Успешная авторизация!")
            st.session_state["auth_page"] = None  # устанавливаем в None, пользователь авторизован
            st.rerun() 
        else:
            st.error("Неверные данные.")
    if st.button("Регистрация"):
        st.session_state["auth_page"] = "Регистрация"
        st.rerun() 

def register_page():
    st.title("Регистрация")
    email = st.text_input("Никнейм")
    password = st.text_input("Пароль", type="password")
    if st.button("Зарегистрироваться"):
        if register_user(email, password):
            st.success("Регистрация успешна!")
            st.session_state["auth_page"] = "Авторизация" 
            st.rerun() 
        else:
            st.error("Ошибка регистрации.")
    if st.button("Назад к авторизации"):
        st.session_state["auth_page"] = "Авторизация"
        st.rerun() 

def movies_page():
    if "user_id" not in st.session_state: # мб не надо, мы же все равно зайдем
        st.error("Пожалуйста, войдите, чтобы пользоваться этим функционалом.")
        return
    
    if "selected_movie" not in st.session_state:
        st.session_state["selected_movie"] = None

    user_id = st.session_state["user_id"] 

    # search_query = st.text_input("Поиск по фильмам", "")

    # Если выбран актер, показываем страницу актера
    if "selected_actor" in st.session_state and st.session_state["selected_actor"]:
        actor_page() 
        st.rerun()
    
    if "show_reviews" in st.session_state and st.session_state["show_reviews"]:
        reviews_page()
        st.rerun()

    if st.session_state["selected_movie"] is None:
        search_query = st.text_input("Поиск по фильмам", "")
        if search_query:
            search_results = search_movies(search_query)
            if search_results:
                st.title(f"Результаты поиска: {search_query}")
                cols = st.columns(4)

                for index, movie in enumerate(search_results):
                    with cols[index % 4]:
                        st.image(f"assets/images/{movie[7]}", use_container_width=True)
                        if st.button(movie[1], key=f"movie_button_{movie[0]}"):
                            st.session_state["selected_movie"] = movie[0]
                            st.rerun()
            else:
                st.write("Ничего не найдено.")

        else:
            st.title("Фильмы")
            movies = get_movies()
            cols = st.columns(4) 

            for index, movie in enumerate(movies):
                with cols[index % 4]: 
                    st.image(f"assets/images/{movie[7]}", use_container_width=True)
                    if st.button(movie[1], key=f"movie_button_{movie[0]}"): 
                        st.session_state["selected_movie"] = movie[0]
                        st.rerun() 
    else:
        movie_id = st.session_state["selected_movie"]
        movie = get_movie_details(movie_id)
        cast = get_movie_cast(movie_id) 
        user_rating = get_user_stars(user_id, movie_id)

        if movie:
            col1, spacer, col2, col3 = st.columns([1, 0.2, 2, 1])

            with col1:
                st.image(f"assets/images/{movie[6]}", use_container_width=True)

            with col2:
                st.title(movie[0])
                st.write(f"**Год выпуска:** {movie[1]}")
                st.write(f"**Режиссер:** {movie[2]}")
                st.write("**Жанры:**")
                genres = get_movie_genres(movie_id)
                st.write(", ".join(genres))
                st.write(f"**Возрастная категория:** {get_age_category_for_movie(movie_id)}")
                st.write("**Актеры:**")
                if cast:
                    for actor in cast:
                        if st.button(actor, key=f"actor_button_{actor}"):
                            st.session_state["selected_actor"] = actor 
                            st.session_state["previous_movie"] = movie_id
                            st.rerun()
                else:
                    st.write("Нет данных")
                st.write(f"**Рейтинг:** {movie[4]} ({movie[5]} оценок)")
                st.subheader("Описание")
                st.write(movie[3])

                # проверка, оставил ли пользователь отзыв, и отображение поля для ввода отзыва
                st.subheader("Оставить отзыв")
                review_text = st.text_area("Ваш отзыв", "", max_chars=500)

                if st.button("Оставить отзыв"):
                    if review_text:
                        add_review(user_id, movie_id, review_text)
                        st.success("Ваш отзыв был добавлен!")
                        st.rerun()
                    else:
                        st.warning("Пожалуйста, напишите отзыв.")
            
            with col3:
                st.subheader("Оценить фильм")
                if user_rating is not None:
                    st.info(f"Вы оценили этот фильм на {user_rating} звезд.")
                    if st.button("Сбросить оценку"):
                        success = delete_user_stars(user_id, movie_id)
                        st.success("Ваша оценка сброшена. Вы можете поставить новую оценку.")
                        st.rerun()
                else:
                    new_rating = st.slider("Ваша оценка (1–10):", 1, 10, step=1)
                    if st.button("Оставить оценку"):
                        update_user_stars(user_id, movie_id, new_rating)
                        update_movie_rating(movie_id, movie[4], movie[5], new_rating)
                        st.success("Ваша оценка учтена!")
                        st.rerun()

                st.subheader("Избранное")
                if is_favorite(user_id, movie_id):
                    st.write("Вы добавили фильм в избранное.")
                    if st.button("Удалить из избранного"):
                        remove_from_favorites(user_id, movie_id)
                        st.success("Фильм удален из избранного.")
                        st.rerun()
                else:
                    if st.button("Добавить в избранное"):
                        add_to_favorites(user_id, movie_id)
                        st.success("Фильм добавлен в избранное!")
                        st.rerun()

                if st.button("Смотреть отзывы"):
                    st.session_state["show_reviews"] = movie_id  # запоминаем выбранный фильм для отзывов
                    st.session_state["reviews_previous_movie"] = movie_id
                    st.rerun()

            if st.button("Вернуться к списку фильмов"):
                st.session_state["selected_movie"] = None
                st.rerun()
        else:
            st.error("Фильм не найден.")
            if st.button("Вернуться к списку фильмов"):
                st.session_state["selected_movie"] = None
                st.rerun() 

def reviews_page():
    if "show_reviews" in st.session_state:
        movie_idd = st.session_state["show_reviews"]
        reviews = get_reviews(movie_idd) 

        st.title(f"Отзывы о фильме {get_movie_title(movie_idd)}")
        
        for review in reviews:
            st.write(f"**{get_user_name(review['user_id'])}:**")
            st.write(review['review_text'])
            st.write(f"*Дата: {review['date_of_writing']}*")
        
        if st.button("Вернуться к фильму"):
            movie_id = st.session_state.get("reviews_previous_movie", None) 
            if movie_id:
                st.session_state["selected_movie"] = movie_id
                st.session_state["show_reviews"] = None
                st.rerun()
            else:
                st.error("Не удалось вернуться к фильму.")
                if st.button("Вернуться к списку фильмов"):
                    st.session_state["show_reviews"] = None
                    st.session_state["selected_movie"] = None
                    st.rerun() 


def actor_page():
    if "selected_actor" in st.session_state:
        actor_name = st.session_state["selected_actor"]
        
        actor = get_actor_details(actor_name)

        if actor:
            st.title(actor["name"])
            st.subheader("Characteristic:")
            st.write(actor["biography"])
        else:
            st.error("Информация о актере не найдена.")
        
        if st.button("Вернуться к фильму"):
            movie_id = st.session_state.get("previous_movie", None) 
            if movie_id:
                st.session_state["selected_movie"] = movie_id
                st.session_state["selected_actor"] = None
                st.rerun()
            else:
                st.error("Не удалось вернуться к фильму.")


def favorite_actor_page():
    if "favorite_selected_actor" in st.session_state:
        actor_name = st.session_state["favorite_selected_actor"]
        
        actor = get_actor_details(actor_name)

        if actor:
            st.title(actor["name"])
            st.subheader("Characteristic:")
            st.write(actor["biography"])
        else:
            st.error("Информация о актере не найдена.")
        
        if st.button("Вернуться к фильму"):
            movie_id = st.session_state.get("favorite_previous_movie", None)
            if movie_id:
                st.session_state["favorite_selected_movie"] = movie_id
                st.session_state["favorite_selected_actor"] = None
                st.rerun()
            else:
                st.error("Не удалось вернуться к фильму.")


def user_profile():
    st.markdown(
        """
        <h1 style="color: #607D8B;">Ваш чудесный профиль</h1>
        """, 
        unsafe_allow_html=True
    )
    
    st.markdown("---")

    st.markdown(
        f"""
        <div style="text-align: center; font-size: 1.5em; font-weight: bold; margin-top: 20px;">
            <span style="color: #FFFFFF;">Добро пожаловать, </span>
            <span style="color: #B0BEC6;">{st.session_state['user']} !
            </span>
            </span>

        </div>

        """, 
        unsafe_allow_html=True
    )

    if st.button("Выйти"):
        st.session_state["user"] = None
        st.session_state["role"] = None
        st.session_state["auth_page"] = "Авторизация" 
        st.rerun()
    
    st.markdown("---")

    st.image(
        "./assets/images/pashalka.jpg", 
        use_container_width=True  
    )

    st.markdown("---")

    st.markdown(
        """
        <div style="text-align: center; font-size: 0.9em; color: gray;">
            🛡️ Ваши данные защищены и используются только для работы приложения.<br>
            Спасибо, что выбрали катеныша!
        </div>
        """, 
        unsafe_allow_html=True
    )



def favorites_page():
    user_id = st.session_state["user_id"]

    if "favorite_selected_movie" not in st.session_state:
        st.session_state["favorite_selected_movie"] = None

    if "favorite_selected_actor" in st.session_state and st.session_state["favorite_selected_actor"]:
        favorite_actor_page() 
        st.rerun()

    if st.session_state["favorite_selected_movie"] is None:
        st.title("Избранные фильмы")
        favorite_movies = get_favorite_movies(user_id)
        if favorite_movies:
            cols = st.columns(4)

            for index, movie in enumerate(favorite_movies):
                with cols[index % 4]:  
                    st.image(f"assets/images/{movie[7]}", use_container_width=True)
                    if st.button(movie[1], key=f"movie_button1_{movie[0]}"): 
                        st.session_state["favorite_selected_movie"] = movie[0]
                        st.rerun() 
        else:
            st.write("**У вас нет избранных фильмов.**")
            st.write("Добавляйте фильмы в избранное, чтобы они появились здесь.")
    else:
        movie_id = st.session_state["favorite_selected_movie"]
        movie = get_movie_details(movie_id)
        cast = get_movie_cast(movie_id)  

        if movie:
            col1, spacer, col2, col3 = st.columns([1, 0.2, 2, 1])

            with col1:
                st.image(f"assets/images/{movie[6]}", use_container_width=True)

            with col2:
                st.title(movie[0])
                st.write(f"**Год выпуска:** {movie[1]}")
                st.write(f"**Режиссер:** {movie[2]}")
                st.write("**Жанры:**")
                genres = get_movie_genres(movie_id)
                st.write(", ".join(genres))
                st.write(f"**Возрастная категория:** {get_age_category_for_movie(movie_id)}")
                st.write("**Актеры:**")
                if cast:
                    for actor in cast:
                        if st.button(actor, key=f"actor_button_{actor}"):
                            st.session_state["favorite_selected_actor"] = actor 
                            st.session_state["favorite_previous_movie"] = movie_id
                            st.rerun()
                else:
                    st.write("Нет данных")
                st.write(f"**Рейтинг:** {movie[4]} ({movie[5]} оценок)")
                st.subheader("Описание")
                st.write(movie[3])
            
            with col3:
                if st.button("Удалить из избранного"):
                    remove_from_favorites(user_id, movie_id)
                    st.success("Фильм удален из избранного.")
                    st.rerun()

            # Кнопка для возврата
            if st.button("Вернуться к списку избранных фильмов"):
                st.session_state["favorite_selected_movie"] = None
                st.rerun()
        else:
            st.error("Фильм не найден.")


if selected_page == "Авторизация":
    login_page()
elif selected_page == "Регистрация":
    register_page()
elif selected_page == "Фильмы":
    movies_page()
elif selected_page == "Ваш профиль":
    user_profile()
elif selected_page == "Страница администратора":
    admin_page()
elif selected_page == "Избранные фильмы":
    favorites_page()