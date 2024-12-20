PGDMP  "    	                |            postgres    17.0 (Debian 17.0-1.pgdg120+1)     17.2 (Ubuntu 17.2-1.pgdg20.04+1) :    t           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            u           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            v           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            w           1262    5    postgres    DATABASE     s   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE postgres;
                     postgres    false            x           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                        postgres    false    3447            �            1259    33705    actors    TABLE     s   CREATE TABLE public.actors (
    actor_id integer NOT NULL,
    name character varying(255),
    biography text
);
    DROP TABLE public.actors;
       public         heap r       cat    false            �            1259    33710    actors_actor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.actors_actor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.actors_actor_id_seq;
       public               cat    false    217            y           0    0    actors_actor_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.actors_actor_id_seq OWNED BY public.actors.actor_id;
          public               cat    false    218            �            1259    33711    age_categorys    TABLE     �   CREATE TABLE public.age_categorys (
    age_id integer NOT NULL,
    age character varying(50),
    characteristic_of_category text
);
 !   DROP TABLE public.age_categorys;
       public         heap r       cat    false            �            1259    33716    age_categorys_age_id_seq    SEQUENCE     �   CREATE SEQUENCE public.age_categorys_age_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.age_categorys_age_id_seq;
       public               cat    false    219            z           0    0    age_categorys_age_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.age_categorys_age_id_seq OWNED BY public.age_categorys.age_id;
          public               cat    false    220            �            1259    33717    ages_of_films    TABLE     b   CREATE TABLE public.ages_of_films (
    movie_id integer NOT NULL,
    age_id integer NOT NULL
);
 !   DROP TABLE public.ages_of_films;
       public         heap r       cat    false            �            1259    33720    filmography_of_actors    TABLE     l   CREATE TABLE public.filmography_of_actors (
    actor_id integer NOT NULL,
    movie_id integer NOT NULL
);
 )   DROP TABLE public.filmography_of_actors;
       public         heap r       cat    false            �            1259    33723    genres    TABLE     e   CREATE TABLE public.genres (
    genre_id integer NOT NULL,
    genre_name character varying(255)
);
    DROP TABLE public.genres;
       public         heap r       cat    false            �            1259    33726    genres_genre_id_seq    SEQUENCE     �   CREATE SEQUENCE public.genres_genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.genres_genre_id_seq;
       public               cat    false    223            {           0    0    genres_genre_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.genres_genre_id_seq OWNED BY public.genres.genre_id;
          public               cat    false    224            �            1259    33727    liked_movies    TABLE     b   CREATE TABLE public.liked_movies (
    user_id integer NOT NULL,
    movie_id integer NOT NULL
);
     DROP TABLE public.liked_movies;
       public         heap r       cat    false            �            1259    33730    movie_genres    TABLE     c   CREATE TABLE public.movie_genres (
    movie_id integer NOT NULL,
    genre_id integer NOT NULL
);
     DROP TABLE public.movie_genres;
       public         heap r       cat    false            �            1259    33733    movies    TABLE       CREATE TABLE public.movies (
    movie_id integer NOT NULL,
    title character varying(255),
    year_of_release integer,
    director character varying(255),
    description text,
    star_rating numeric(3,2),
    number_of_ratings integer,
    poster character varying(255)
);
    DROP TABLE public.movies;
       public         heap r       cat    false            �            1259    33738    movies_movie_id_seq    SEQUENCE     �   CREATE SEQUENCE public.movies_movie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.movies_movie_id_seq;
       public               cat    false    227            |           0    0    movies_movie_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.movies_movie_id_seq OWNED BY public.movies.movie_id;
          public               cat    false    228            �            1259    33739    reviews    TABLE     �   CREATE TABLE public.reviews (
    movie_id integer,
    user_id integer,
    review_text text,
    date_of_writing timestamp without time zone
);
    DROP TABLE public.reviews;
       public         heap r       cat    false            �            1259    33744    stars    TABLE     x   CREATE TABLE public.stars (
    movie_id integer NOT NULL,
    user_id integer NOT NULL,
    number_of_stars integer
);
    DROP TABLE public.stars;
       public         heap r       cat    false            �            1259    33747    users    TABLE     �   CREATE TABLE public.users (
    user_id integer NOT NULL,
    email character varying(255),
    age integer,
    role character varying(50),
    password_hash text
);
    DROP TABLE public.users;
       public         heap r       cat    false            �            1259    33752    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public               cat    false    231            }           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public               cat    false    232            �           2604    33753    actors actor_id    DEFAULT     r   ALTER TABLE ONLY public.actors ALTER COLUMN actor_id SET DEFAULT nextval('public.actors_actor_id_seq'::regclass);
 >   ALTER TABLE public.actors ALTER COLUMN actor_id DROP DEFAULT;
       public               cat    false    218    217            �           2604    33754    age_categorys age_id    DEFAULT     |   ALTER TABLE ONLY public.age_categorys ALTER COLUMN age_id SET DEFAULT nextval('public.age_categorys_age_id_seq'::regclass);
 C   ALTER TABLE public.age_categorys ALTER COLUMN age_id DROP DEFAULT;
       public               cat    false    220    219            �           2604    33755    genres genre_id    DEFAULT     r   ALTER TABLE ONLY public.genres ALTER COLUMN genre_id SET DEFAULT nextval('public.genres_genre_id_seq'::regclass);
 >   ALTER TABLE public.genres ALTER COLUMN genre_id DROP DEFAULT;
       public               cat    false    224    223            �           2604    33756    movies movie_id    DEFAULT     r   ALTER TABLE ONLY public.movies ALTER COLUMN movie_id SET DEFAULT nextval('public.movies_movie_id_seq'::regclass);
 >   ALTER TABLE public.movies ALTER COLUMN movie_id DROP DEFAULT;
       public               cat    false    228    227            �           2604    33757    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public               cat    false    232    231            b          0    33705    actors 
   TABLE DATA           ;   COPY public.actors (actor_id, name, biography) FROM stdin;
    public               cat    false    217   +>       d          0    33711    age_categorys 
   TABLE DATA           P   COPY public.age_categorys (age_id, age, characteristic_of_category) FROM stdin;
    public               cat    false    219   @       f          0    33717    ages_of_films 
   TABLE DATA           9   COPY public.ages_of_films (movie_id, age_id) FROM stdin;
    public               cat    false    221   �@       g          0    33720    filmography_of_actors 
   TABLE DATA           C   COPY public.filmography_of_actors (actor_id, movie_id) FROM stdin;
    public               cat    false    222   A       h          0    33723    genres 
   TABLE DATA           6   COPY public.genres (genre_id, genre_name) FROM stdin;
    public               cat    false    223   ZA       j          0    33727    liked_movies 
   TABLE DATA           9   COPY public.liked_movies (user_id, movie_id) FROM stdin;
    public               cat    false    225   �A       k          0    33730    movie_genres 
   TABLE DATA           :   COPY public.movie_genres (movie_id, genre_id) FROM stdin;
    public               cat    false    226   �A       l          0    33733    movies 
   TABLE DATA           �   COPY public.movies (movie_id, title, year_of_release, director, description, star_rating, number_of_ratings, poster) FROM stdin;
    public               cat    false    227   %B       n          0    33739    reviews 
   TABLE DATA           R   COPY public.reviews (movie_id, user_id, review_text, date_of_writing) FROM stdin;
    public               cat    false    229   `F       o          0    33744    stars 
   TABLE DATA           C   COPY public.stars (movie_id, user_id, number_of_stars) FROM stdin;
    public               cat    false    230   &G       p          0    33747    users 
   TABLE DATA           I   COPY public.users (user_id, email, age, role, password_hash) FROM stdin;
    public               cat    false    231   zG       ~           0    0    actors_actor_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.actors_actor_id_seq', 11, true);
          public               cat    false    218                       0    0    age_categorys_age_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.age_categorys_age_id_seq', 4, true);
          public               cat    false    220            �           0    0    genres_genre_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.genres_genre_id_seq', 7, true);
          public               cat    false    224            �           0    0    movies_movie_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.movies_movie_id_seq', 10, true);
          public               cat    false    228            �           0    0    users_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_user_id_seq', 7, true);
          public               cat    false    232            �           2606    33759    actors actors_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.actors
    ADD CONSTRAINT actors_pkey PRIMARY KEY (actor_id);
 <   ALTER TABLE ONLY public.actors DROP CONSTRAINT actors_pkey;
       public                 cat    false    217            �           2606    33761     age_categorys age_categorys_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.age_categorys
    ADD CONSTRAINT age_categorys_pkey PRIMARY KEY (age_id);
 J   ALTER TABLE ONLY public.age_categorys DROP CONSTRAINT age_categorys_pkey;
       public                 cat    false    219            �           2606    33763     ages_of_films ages_of_films_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.ages_of_films
    ADD CONSTRAINT ages_of_films_pkey PRIMARY KEY (movie_id, age_id);
 J   ALTER TABLE ONLY public.ages_of_films DROP CONSTRAINT ages_of_films_pkey;
       public                 cat    false    221    221            �           2606    33765 0   filmography_of_actors filmography_of_actors_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.filmography_of_actors
    ADD CONSTRAINT filmography_of_actors_pkey PRIMARY KEY (actor_id, movie_id);
 Z   ALTER TABLE ONLY public.filmography_of_actors DROP CONSTRAINT filmography_of_actors_pkey;
       public                 cat    false    222    222            �           2606    33767    genres genres_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genre_id);
 <   ALTER TABLE ONLY public.genres DROP CONSTRAINT genres_pkey;
       public                 cat    false    223            �           2606    33769    liked_movies liked_movies_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.liked_movies
    ADD CONSTRAINT liked_movies_pkey PRIMARY KEY (user_id, movie_id);
 H   ALTER TABLE ONLY public.liked_movies DROP CONSTRAINT liked_movies_pkey;
       public                 cat    false    225    225            �           2606    33771    movie_genres movie_genres_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.movie_genres
    ADD CONSTRAINT movie_genres_pkey PRIMARY KEY (movie_id, genre_id);
 H   ALTER TABLE ONLY public.movie_genres DROP CONSTRAINT movie_genres_pkey;
       public                 cat    false    226    226            �           2606    33773    movies movies_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (movie_id);
 <   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_pkey;
       public                 cat    false    227            �           2606    33775    stars stars_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.stars
    ADD CONSTRAINT stars_pkey PRIMARY KEY (user_id, movie_id);
 :   ALTER TABLE ONLY public.stars DROP CONSTRAINT stars_pkey;
       public                 cat    false    230    230            �           2606    33777    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public                 cat    false    231            �           2606    33779    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 cat    false    231            b   �  x��R�n1>�O1@V��iA�����$&;�Ǝ��ܚ�C���X��X�������"!��*��zf�}�}3M�\[����#l��C+���"RI��:��,���<,�P	t�%:'\��@+��G>�c�U��&���%ڱ�ԣ2��-�s����������9G���5�*�V�@K���G�]2n�q?�VCk*"y[�*�c��n�Ͳ��XϮ��;���{F9�wS���rxj�v��I�\$c{�ԍ������е�9�W�w��cߣ5��+Z	tU͵��9�`k�p�#nW�;x���pO�����1�����e��d9[�$�hR��=�ŋ�����}���ʗM��K����5y<��/O�&�MС�hej��Y�i�@��L9�?F��a���G���wf�q`��ѩ�͛��܈�S�Hc��R�,���M�~������a`M����2�`
��HJ�>��      d   �   x�m�M
�0��/��^H�=���� ��ލj���9ü9	�W�%��L�e�y/�!�-����N�-0j�g���@h�
oB�z%::��;���3�<�1���oG����	s&N�Z�\b^ЂTpf)���
�T*sR�����ӯę����q��i�_qf�1{X��      f   .   x�ı  ��?�!���spQ!���v��R^\%%'�
� >���      g   2   x�Ĺ�0 İZ&���.�� a�+�F��'��r�=������/���      h   L   x�3�tL.����2�t)J�M�2�N��u��2�tK�+I,��2�t���M+3���M�KN�2�t.��M����� �S      j      x�3�4�2� bC �-Al�=... ;��      k   1   x���  ���0� �ø�b���i�2V7�dS
����fϖw ��t      l   +  x�mU�n�6�f��<@lX��ؗA�$mѭC��t,��H���*O��PvӋ�!����\������{�Z��ݮ�cЮ2�}������Z�9��μqMU0S=9Ӵ����u
F�����C�ʻ�%��[VV��c2�������J`;TI�Dѻ��-�+��Y�Ts���7W�K�8��:���ب�6��|�w�`u��N����� H��ȖR�д�i��k�e2�b��|���%�.���g��?���K�]ެT�]���QY d�}2�	��ov�Ջ�]-������C�: ~�Ѥ��;���&�<�����.ϼU_!�Ip�nԓ�W�g=iO�ͤ�����!�0A�ם�B�����re��8�j1�okjL�4�q�d�,V�`1��&�3�Z��]I��f�̓�H.�V����JF�⻤O\^5���\�>�p�O�4m�����O�.S�؉��G8������p�}�]N`7��`���.������G_e"��#�y�}�� fO>����"��+�� �z� 3��2؞M�cQ�v���U�����gz����Þ���[J���\����]HJ�<������a倦QJ�i{?J��C�@���k���n�;P)@�px��g.[�2���������h��
B����� ��G�d��D�v����
D��D�<xu>��Z΁b�,����4ܨ��N�X��G݁�=~��~��4���:��j.	�ρ�<���>h1U����L�`�dV^�M>�M�	Z���$����B��O�r�����,c~�ņKu+].��Kg�p\<뾟�f�Bݵ���]�^�H�(*jK��H���
A��	���0sPq
# 4�
O�����â�A&��3��ɑ����	�p�3�%Tt���D�k�%`e�����*���4��怩(Vx'ΦӞK�wp����$ϐ��b�Jn�{���<�Q�p5������RG>���y��VT\1J%�U��[�ٍ���1E�K��+O�49Ap�չ�l��j�ڳ[پ��? r�      n   �   x�M��j�0D�믘~@���!��
��zY+j� �F+��_	�ax�驧c��?H�U~�^`��|߮jM��;w�_����ܚ���#��:ŀ%��$�>`���RԪJƛİ�6�@��j(���in�Ƚ�3��gv �Ǝ4�g���W�3� ���(f�^��a��]�� ��E�      o   D   x���	�0ѳTL`m�ǽ��:2���B���뭥��qj��[�e��Ao�ʁ��J�'������ -��      p     x���[o�0 ����wxݕp����6b��)"�E��~�e.Y��'o>T%�ʔ�,;9���7\�J��+˦�1$������ޙV���� ��$���s~V0"�H!#[^���l���/��km{��x�T]}��7'=�~�=�)A�ɜ�ӌ%G$�k���7��xIƑnǹ[i���m�Ꜵ��IW��+ʴI^����Ǡ38u���4�<�{k~*��ۺ�{�9/�+ɝ�.�0�iZsS����r�C�oᴐ�     