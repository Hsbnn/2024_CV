# 2024_BD

## Схема базы данных онлайн-кинотеатра
## Таблицы
### 1.Movies
	
   Хранит информацию о фильмах, доступных на платформе. Включает такие данные, как название, год выпуска, описание, рейтинг, 
количество оценок, категория фильма и возрастные ограничения. Таблица связана с жанрами, актёрами и отзывами.

### 2.Users

   Содержит данные о пользователях, включая электронную почту, возраст, роль и хеш пароля. Также отвечает за разделение прав 
доступа, позволяя, например, администраторам добавлять и удалять фильмы.

### 3.Genres
	
   Содержит список жанров фильмов.

### 4.Reviews
	
  Таблица отзывов. Позволяет пользователям оставлять текстовые комментарии к фильмам. Каждый отзыв связывается с 
пользователем и фильмом, к которому он относится, и имеет дату написания.

### 5.Stars
	
   Хранит оценки фильмов (число от 1 до 10). Состоит из ID фильма, ID пользователя, количества оценок, и среднюю оценку.
Это позволяет системе рассчитывать средний рейтинг фильма.

### 6.Actors

   Содержит информацию об актёрах, таких как имя и биография. С помощью связующей таблицы (Filmography_of_actors) позволяет 
пользователям видеть, в каких фильмах снимался актёр.

### 7.Liked_movies
	
   Таблица избранных фильмов, в которой пользователи могут сохранять фильмы в свой список избранного. Это позволяет системе 
показывать пользователю его избранные фильмы.

### 8.Filmography_of_actors
	
 Связующая таблица для фильмов и актёров, обеспечивающая возможность создавать список актёров для каждого фильма.

### 9.Movie_genres
	
   Ещё одна связующая таблица, которая поддерживает связь между фильмами и жанрами. Так как у фильма может быть несколько 
жанров, таблица помогает управлять классификацией фильмов.

 
Эти таблицы обеспечивают функциональность онлайн-кинотеатра, включая управление пользователями, классификацию фильмов, 
оставление отзывов и оценок, а также формирование рекомендательного списка.

## Схема модели данных

![image](https://github.com/user-attachments/assets/389a26a4-78a9-4594-8872-bc5899c21d76)
