PGDMP      0                |            postgres    17.0 (Debian 17.0-1.pgdg120+1)     17.2 (Ubuntu 17.2-1.pgdg20.04+1) :    t           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            u           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            v           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            w           1262    5    postgres    DATABASE     s   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE postgres;
                     postgres    false            x           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                        postgres    false    3447            �            1259    24952    actors    TABLE     s   CREATE TABLE public.actors (
    actor_id integer NOT NULL,
    name character varying(255),
    biography text
);
    DROP TABLE public.actors;
       public         heap r       cat    false            �            1259    24951    actors_actor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.actors_actor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.actors_actor_id_seq;
       public               cat    false    231            y           0    0    actors_actor_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.actors_actor_id_seq OWNED BY public.actors.actor_id;
          public               cat    false    230            �            1259    24911    age_categorys    TABLE     �   CREATE TABLE public.age_categorys (
    age_id integer NOT NULL,
    age character varying(50),
    characteristic_of_category text
);
 !   DROP TABLE public.age_categorys;
       public         heap r       cat    false            �            1259    24910    age_categorys_age_id_seq    SEQUENCE     �   CREATE SEQUENCE public.age_categorys_age_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.age_categorys_age_id_seq;
       public               cat    false    222            z           0    0    age_categorys_age_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.age_categorys_age_id_seq OWNED BY public.age_categorys.age_id;
          public               cat    false    221            �            1259    24919    ages_of_films    TABLE     b   CREATE TABLE public.ages_of_films (
    movie_id integer NOT NULL,
    age_id integer NOT NULL
);
 !   DROP TABLE public.ages_of_films;
       public         heap r       cat    false            �            1259    24960    filmography_of_actors    TABLE     l   CREATE TABLE public.filmography_of_actors (
    actor_id integer NOT NULL,
    movie_id integer NOT NULL
);
 )   DROP TABLE public.filmography_of_actors;
       public         heap r       cat    false            �            1259    24945    genres    TABLE     e   CREATE TABLE public.genres (
    genre_id integer NOT NULL,
    genre_name character varying(255)
);
    DROP TABLE public.genres;
       public         heap r       cat    false            �            1259    24944    genres_genre_id_seq    SEQUENCE     �   CREATE SEQUENCE public.genres_genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.genres_genre_id_seq;
       public               cat    false    229            {           0    0    genres_genre_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.genres_genre_id_seq OWNED BY public.genres.genre_id;
          public               cat    false    228            �            1259    24929    liked_movies    TABLE     b   CREATE TABLE public.liked_movies (
    user_id integer NOT NULL,
    movie_id integer NOT NULL
);
     DROP TABLE public.liked_movies;
       public         heap r       cat    false            �            1259    24939    movie_genres    TABLE     c   CREATE TABLE public.movie_genres (
    movie_id integer NOT NULL,
    genre_id integer NOT NULL
);
     DROP TABLE public.movie_genres;
       public         heap r       cat    false            �            1259    24891    movies    TABLE       CREATE TABLE public.movies (
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
       public         heap r       cat    false            �            1259    24890    movies_movie_id_seq    SEQUENCE     �   CREATE SEQUENCE public.movies_movie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.movies_movie_id_seq;
       public               cat    false    218            |           0    0    movies_movie_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.movies_movie_id_seq OWNED BY public.movies.movie_id;
          public               cat    false    217            �            1259    24934    reviews    TABLE     �   CREATE TABLE public.reviews (
    movie_id integer,
    user_id integer,
    review_text text,
    date_of_writing timestamp without time zone
);
    DROP TABLE public.reviews;
       public         heap r       cat    false            �            1259    24924    stars    TABLE     x   CREATE TABLE public.stars (
    movie_id integer NOT NULL,
    user_id integer NOT NULL,
    number_of_stars integer
);
    DROP TABLE public.stars;
       public         heap r       cat    false            �            1259    24900    users    TABLE     �   CREATE TABLE public.users (
    user_id integer NOT NULL,
    email character varying(255),
    age integer,
    role character varying(50),
    password_hash text
);
    DROP TABLE public.users;
       public         heap r       cat    false            �            1259    24899    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public               cat    false    220            }           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public               cat    false    219            �           2604    24955    actors actor_id    DEFAULT     r   ALTER TABLE ONLY public.actors ALTER COLUMN actor_id SET DEFAULT nextval('public.actors_actor_id_seq'::regclass);
 >   ALTER TABLE public.actors ALTER COLUMN actor_id DROP DEFAULT;
       public               cat    false    231    230    231            �           2604    24914    age_categorys age_id    DEFAULT     |   ALTER TABLE ONLY public.age_categorys ALTER COLUMN age_id SET DEFAULT nextval('public.age_categorys_age_id_seq'::regclass);
 C   ALTER TABLE public.age_categorys ALTER COLUMN age_id DROP DEFAULT;
       public               cat    false    222    221    222            �           2604    24948    genres genre_id    DEFAULT     r   ALTER TABLE ONLY public.genres ALTER COLUMN genre_id SET DEFAULT nextval('public.genres_genre_id_seq'::regclass);
 >   ALTER TABLE public.genres ALTER COLUMN genre_id DROP DEFAULT;
       public               cat    false    229    228    229            �           2604    24894    movies movie_id    DEFAULT     r   ALTER TABLE ONLY public.movies ALTER COLUMN movie_id SET DEFAULT nextval('public.movies_movie_id_seq'::regclass);
 >   ALTER TABLE public.movies ALTER COLUMN movie_id DROP DEFAULT;
       public               cat    false    217    218    218            �           2604    24903    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public               cat    false    220    219    220            p          0    24952    actors 
   TABLE DATA           ;   COPY public.actors (actor_id, name, biography) FROM stdin;
    public               cat    false    231   Q>       g          0    24911    age_categorys 
   TABLE DATA           P   COPY public.age_categorys (age_id, age, characteristic_of_category) FROM stdin;
    public               cat    false    222   @       h          0    24919    ages_of_films 
   TABLE DATA           9   COPY public.ages_of_films (movie_id, age_id) FROM stdin;
    public               cat    false    223   �@       q          0    24960    filmography_of_actors 
   TABLE DATA           C   COPY public.filmography_of_actors (actor_id, movie_id) FROM stdin;
    public               cat    false    232   �@       n          0    24945    genres 
   TABLE DATA           6   COPY public.genres (genre_id, genre_name) FROM stdin;
    public               cat    false    229   0A       j          0    24929    liked_movies 
   TABLE DATA           9   COPY public.liked_movies (user_id, movie_id) FROM stdin;
    public               cat    false    225   �A       l          0    24939    movie_genres 
   TABLE DATA           :   COPY public.movie_genres (movie_id, genre_id) FROM stdin;
    public               cat    false    227   �A       c          0    24891    movies 
   TABLE DATA           �   COPY public.movies (movie_id, title, year_of_release, director, description, star_rating, number_of_ratings, poster) FROM stdin;
    public               cat    false    218   �A       k          0    24934    reviews 
   TABLE DATA           R   COPY public.reviews (movie_id, user_id, review_text, date_of_writing) FROM stdin;
    public               cat    false    226   DE       i          0    24924    stars 
   TABLE DATA           C   COPY public.stars (movie_id, user_id, number_of_stars) FROM stdin;
    public               cat    false    224   
F       e          0    24900    users 
   TABLE DATA           I   COPY public.users (user_id, email, age, role, password_hash) FROM stdin;
    public               cat    false    220   ^F       ~           0    0    actors_actor_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.actors_actor_id_seq', 8, true);
          public               cat    false    230                       0    0    age_categorys_age_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.age_categorys_age_id_seq', 4, true);
          public               cat    false    221            �           0    0    genres_genre_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.genres_genre_id_seq', 7, true);
          public               cat    false    228            �           0    0    movies_movie_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.movies_movie_id_seq', 8, true);
          public               cat    false    217            �           0    0    users_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_user_id_seq', 7, true);
          public               cat    false    219            �           2606    24959    actors actors_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.actors
    ADD CONSTRAINT actors_pkey PRIMARY KEY (actor_id);
 <   ALTER TABLE ONLY public.actors DROP CONSTRAINT actors_pkey;
       public                 cat    false    231            �           2606    24918     age_categorys age_categorys_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.age_categorys
    ADD CONSTRAINT age_categorys_pkey PRIMARY KEY (age_id);
 J   ALTER TABLE ONLY public.age_categorys DROP CONSTRAINT age_categorys_pkey;
       public                 cat    false    222            �           2606    24923     ages_of_films ages_of_films_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.ages_of_films
    ADD CONSTRAINT ages_of_films_pkey PRIMARY KEY (movie_id, age_id);
 J   ALTER TABLE ONLY public.ages_of_films DROP CONSTRAINT ages_of_films_pkey;
       public                 cat    false    223    223            �           2606    24964 0   filmography_of_actors filmography_of_actors_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.filmography_of_actors
    ADD CONSTRAINT filmography_of_actors_pkey PRIMARY KEY (actor_id, movie_id);
 Z   ALTER TABLE ONLY public.filmography_of_actors DROP CONSTRAINT filmography_of_actors_pkey;
       public                 cat    false    232    232            �           2606    24950    genres genres_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genre_id);
 <   ALTER TABLE ONLY public.genres DROP CONSTRAINT genres_pkey;
       public                 cat    false    229            �           2606    24933    liked_movies liked_movies_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.liked_movies
    ADD CONSTRAINT liked_movies_pkey PRIMARY KEY (user_id, movie_id);
 H   ALTER TABLE ONLY public.liked_movies DROP CONSTRAINT liked_movies_pkey;
       public                 cat    false    225    225            �           2606    24943    movie_genres movie_genres_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.movie_genres
    ADD CONSTRAINT movie_genres_pkey PRIMARY KEY (movie_id, genre_id);
 H   ALTER TABLE ONLY public.movie_genres DROP CONSTRAINT movie_genres_pkey;
       public                 cat    false    227    227            �           2606    24898    movies movies_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (movie_id);
 <   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_pkey;
       public                 cat    false    218            �           2606    24928    stars stars_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.stars
    ADD CONSTRAINT stars_pkey PRIMARY KEY (user_id, movie_id);
 :   ALTER TABLE ONLY public.stars DROP CONSTRAINT stars_pkey;
       public                 cat    false    224    224            �           2606    24909    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public                 cat    false    220            �           2606    24907    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 cat    false    220            p   �  x����J1���S�Ȃ�^k�T[��%���Z��V����
��ŵ��+L���*�PD��f3���3��,ۑI,t5�5U������;�hq�ڴf�
���?� '�2ƾ���� Ѻ.ESZ;	)�2���c�;�+�Z�%bX�d���=]���`����+:�Ň���{�:y�C�>(���7t�����g�P�`�R����P���_� קo-���鞅��H}bd	�vPP��.��h��>�y�m�?���Q�UŨ$�"+D�'**�՜�:���K�u�\	I�X�7��+�:&ڄ*��$��	$f�b��I�Sa�=�l�YW���5����/cϤGuI�^.n��������w�RCied
-q���_���ddKh�#)�T�j�	�Q�9��N      g   �   x�m�M
�0��/��^H�=���� ��ލj���9ü9	�W�%��L�e�y/�!�-����N�-0j�g���@h�
oB�z%::��;���3�<�1���oG����	s&N�Z�\b^ЂTpf)���
�T*sR�����ӯę����q��i�_qf�1{X��      h   *   x�3�4��2� �D��3NC#.sN3.NC3�=... ���      q   *   x���  ��w;�w�ø�&�m&��X��k��[�V5�      n   L   x�3�tL.����2�t)J�M�2�N��u��2�tK�+I,��2�t���M+3���M�KN�2�t.��M����� �S      j      x�3�4�2� bC 6����� '�      l   *   x�3�4�2�4�2�&�F\�@l�i�e�i�e�i����� U�      c   D  x�mT�n�8|f�b?�6$�I�� E��E�����DK<S\IIu��������aP"�;3;�[��[z/�so�����94.ѓĖeųy$���~ؖ��K�9p��U"�\�h�Ǧ��
�hc�FB��I�ԣd�9�6e,�at�R������!S��6���2���2�/p������+d��{�fS�[��G���8C��5�ʖmj��^�"��z�}���i�8��-�@i�,��-+0���4�xa������f���L��6��������cva�G����`C�����|�)S?��rL�'���&U�x-�rt~(=��7��2���Y����Y�;�>9�n��LQyp^	2�@a�;L��@��Z�-Ǖ��:=-:8��r;q��w8��π��~ZH�p�z^u�[�lz�-�>J��nM�ryapy%�)v}��D��Yi�� �?���`�N�d�dSy�QN8h;��e(Θat2%89�7ЉHJ��,M!ܒH.�G+#�����󠶅c7o���˩�,з���GzrM�E��o���D��y�B
=�f�BѼ�s ��<t,�n�.��N��%G{Q��E���^bT��e���_����J�h[�����{P�Aep̠ /\v�yq�7�K>����⚓-�������v�������{�H^�������6�z�[x9_[����<̜�-P��G���Q4_#D�t:��'.�Z���C�_����Y��4������h�,Q�N�{YJ�`\���o��-d*��׌(Ek�b*�{\�{�r}^\8���w}ss����      k   �   x�M��j�0D�믘~@���!��
��zY+j� �F+��_	�ax�驧c��?H�U~�^`��|߮jM��;w�_����ܚ���#��:ŀ%��$�>`���RԪJƛİ�6�@��j(���in�Ƚ�3��gv �Ǝ4�g���W�3� ���(f�^��a��]�� ��E�      i   D   x���	�0ѳTL`m�ǽ��:2���B���뭥��qj��[�e��Ao�ʁ��J�'������ -��      e     x���[o�0 ����wxݕp����6b��)"�E��~�e.Y��'o>T%�ʔ�,;9���7\�J��+˦�1$������ޙV���� ��$���s~V0"�H!#[^���l���/��km{��x�T]}��7'=�~�=�)A�ɜ�ӌ%G$�k���7��xIƑnǹ[i���m�Ꜵ��IW��+ʴI^����Ǡ38u���4�<�{k~*��ۺ�{�9/�+ɝ�.�0�iZsS����r�C�oᴐ�     