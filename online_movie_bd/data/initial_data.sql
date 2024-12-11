CREATE TABLE IF NOT EXISTS movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    year_of_release INT,
    director VARCHAR(255),
    description TEXT,
    star_rating DECIMAL(3, 2),
    number_of_ratings INT,
    poster VARCHAR(255)
);

INSERT INTO movies (title, year_of_release, director, description, star_rating, number_of_ratings, poster)
VALUES
('Inception', 2010, 'Christopher Nolan', 'A mind-bending thriller about dreams within dreams.', 8.8, 2000, 'inception_film.jpg'),
('The Dark Knight', 2008, 'Christopher Nolan', 'When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.', 9.0, 2300, 'dark_knight.jpg'),
('Interstellar', 2014, 'Christopher Nolan', 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity-s survival.', 8.6, 1800, 'interstellar.jpg'),
('Pulp Fiction', 1994, 'Quentin Tarantino', 'The lives of two mob hit men, a boxer, a gangster-s wife, and a pair of diner bandits intertwine in four tales of violence and redemption.', 8.9, 2100, 'pulp_fiction.jpg'),
('The Godfather', 1972, 'Francis Ford Coppola', 'An organized crime dynasty-s aging patriarch transfers control of his clandestine empire to his reluctant son.', 9.2, 2600, 'godfather.jpg'),
('Avatar', 2009, 'James Cameron', 'A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.', 7.8, 1500, 'avatar_film.jpg'),
('Spirited Away', 2001, 'Hayao Miyazaki', 'During her family-s move to the suburbs, a 10-year-old girl wanders into a world ruled by gods, witches, and spirits, and where humans are changed into beasts.', 8.6, 1800, 'spirited_away_film.jpg'),
('Twilight', 2008, 'Catherine Hardwicke', 'A teenage girl risks everything when she falls in love with a vampire.', 5.2, 1400, 'twilight_film.jpg');


CREATE TABLE IF NOT EXISTS movie_logs (
    log_id SERIAL PRIMARY KEY,
    action TEXT NOT NULL,
    movie_id INTEGER NOT NULL,
    action_time TIMESTAMP NOT NULL
);

CREATE OR REPLACE FUNCTION log_movie_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO movie_logs(action, movie_id, action_time)
        VALUES ('Добавление', NEW.movie_id, NOW());
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO movie_logs(action, movie_id, action_time)
        VALUES ('Удаление', OLD.movie_id, NOW());
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER movie_changes_trigger
AFTER INSERT OR DELETE ON movies
FOR EACH ROW
EXECUTE FUNCTION log_movie_changes();


CREATE TABLE IF NOT EXISTS users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE,
    age INT,
    role VARCHAR(50),
    password_hash TEXT
);

INSERT INTO users (email, age, role, password_hash)
VALUES
('user1@example.com', 20, 'viewer', 'hashed_password'),
('user@example.com', 25, 'viewer', 'hashed_password'),
('user3@example.com', 20, 'viewer', 'hashed_password'),
('user4@example.com', 25, 'viewer', 'hashed_password');


CREATE TABLE IF NOT EXISTS age_categorys (
    age_id SERIAL PRIMARY KEY,
    age VARCHAR(50), -- возрасной диапазон
    characteristic_of_category TEXT
);

INSERT INTO age_categorys (age, characteristic_of_category)
VALUES
('6-11', 'Категория для самых маленьких зрителей.'),
('12-15', 'Фильмы для детей школьного возраста.'),
('16-17', 'Подростковые фильмы.'),
('18+', 'Фильмы для взрослых.');

CREATE TABLE IF NOT EXISTS ages_of_films (
    movie_id INT,
    age_id INT,
    PRIMARY KEY (movie_id, age_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE, 
    FOREIGN KEY (age_id) REFERENCES age_categorys(age_id) ON DELETE CASCADE
);

INSERT INTO ages_of_films (movie_id, age_id)
SELECT 1, age_id FROM age_categorys WHERE age = '18+'; -- Inception
INSERT INTO ages_of_films (movie_id, age_id)
SELECT 2, age_id FROM age_categorys WHERE age = '18+'; -- The Dark Knight
INSERT INTO ages_of_films (movie_id, age_id)
SELECT 3, age_id FROM age_categorys WHERE age = '18+'; -- Interstellar

CREATE TABLE IF NOT EXISTS stars (
    movie_id INT,
    user_id INT,
    number_of_stars	INT,
    -- date_stars_were_given TIMESTAMP,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

INSERT INTO stars (movie_id, user_id, number_of_stars)
VALUES
(1, 1, 7),
(2, 1, 9),
(3, 2, 5),
(4, 2, 8),
(5, 3, 9),
(6, 3, 7),
(7, 4, 8),
(8, 4, 9),
(7, 1, 8)
ON CONFLICT (movie_id, user_id) DO NOTHING;

CREATE TABLE IF NOT EXISTS liked_movies (
    user_id	INT,
    movie_id INT,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS reviews (
    movie_id INT,
    user_id	INT,
    review_text	TEXT,	
    date_of_writing	TIMESTAMP	
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE 
);

INSERT INTO reviews (movie_id, user_id, review_text, date_of_writing)
VALUES
(1, 1, 'Amazing movie with stunning visuals!', '2024-01-01 18:00:00'),
(2, 2, 'Incredible performance by Christian Bale.', '2024-01-02 20:00:00'),
(3, 3, 'A masterpiece about space and time.', '2024-01-03 22:00:00'),
(4, 4, 'Pulp Fiction is a true classic!', '2024-01-04 23:00:00')
ON CONFLICT (movie_id, user_id) DO NOTHING;


CREATE TABLE IF NOT EXISTS genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(255)	
);

INSERT INTO genres (genre_name)
VALUES
('Action'),
('Drama'),
('Sci-Fi'),
('Fantasy'),
('Animation'),
('Romance'),
('Crime');

CREATE TABLE IF NOT EXISTS movie_genres (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE
);


INSERT INTO movie_genres (movie_id, genre_id)
VALUES
(1, 3), -- Inception - Sci-Fi
(2, 1), -- The Dark Knight - Action
(3, 3), -- Interstellar - Sci-Fi
(4, 2), -- Pulp Fiction - Drama
(5, 2), -- The Godfather - Drama
(6, 4), -- Avatar - Fantasy
(7, 5), -- Spirited Away - Animation
(8, 6) -- Twilight - Romance
ON CONFLICT (movie_id, genre_id) DO NOTHING;

CREATE TABLE IF NOT EXISTS actors (
    actor_id SERIAL PRIMARY KEY,
    name VARCHAR(255), 
    biography TEXT 
);

INSERT INTO actors (name, biography)
VALUES
('Leonardo DiCaprio', 'Американский актер и продюсер, лауреат премии Оскар.'),
('Christian Bale', 'Британский актер, известный ролями в трилогии о Бэтмене.'),
('Matthew McConaughey', 'Американский актер, звезда фильма Interstellar.'),
('Uma Thurman', 'Американская актриса, звезда фильма Pulp Fiction.'),
('Al Pacino', 'Американский актер, известный по фильму The Godfather.'),
('Sam Worthington', 'Австралийский актер, звезда фильма Avatar.'),
('Rumi Hiiragi', 'Японская актриса, озвучивала героиню фильма Spirited Away.'),
('Kristen Stewart', 'Американская актриса, звезда фильма Twilight.');

CREATE TABLE IF NOT EXISTS filmography_of_actors (
    actor_id INT,
    movie_id INT,
    PRIMARY KEY (actor_id, movie_id),
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id) ON DELETE CASCADE, -- внешний ключ на actors
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

INSERT INTO filmography_of_actors (actor_id, movie_id)
VALUES
(1, 1), -- Leonardo DiCaprio - Inception
(2, 2), -- Christian Bale - The Dark Knight
(3, 3), -- Matthew McConaughey - Interstellar
(4, 4), -- Uma Thurman - Pulp Fiction
(5, 5), -- Al Pacino - The Godfather
(6, 6), -- Sam Worthington - Avatar
(7, 7), -- Rumi Hiiragi - Spirited Away
(8, 8) -- Kristen Stewart - Twilight
ON CONFLICT (actor_id, movie_id) DO NOTHING;