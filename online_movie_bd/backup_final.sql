PGDMP      #                |            postgres    17.0 (Debian 17.0-1.pgdg120+1)     17.2 (Ubuntu 17.2-1.pgdg20.04+1) :    t           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            u           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            v           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            w           1262    5    postgres    DATABASE     s   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE postgres;
                     postgres    false            x           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                        postgres    false    3447            �            1259    34009    actors    TABLE     s   CREATE TABLE public.actors (
    actor_id integer NOT NULL,
    name character varying(255),
    biography text
);
    DROP TABLE public.actors;
       public         heap r       cat    false            �            1259    34014    actors_actor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.actors_actor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.actors_actor_id_seq;
       public               cat    false    217            y           0    0    actors_actor_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.actors_actor_id_seq OWNED BY public.actors.actor_id;
          public               cat    false    218            �            1259    34015    age_categorys    TABLE     �   CREATE TABLE public.age_categorys (
    age_id integer NOT NULL,
    age character varying(50),
    characteristic_of_category text
);
 !   DROP TABLE public.age_categorys;
       public         heap r       cat    false            �            1259    34020    age_categorys_age_id_seq    SEQUENCE     �   CREATE SEQUENCE public.age_categorys_age_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.age_categorys_age_id_seq;
       public               cat    false    219            z           0    0    age_categorys_age_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.age_categorys_age_id_seq OWNED BY public.age_categorys.age_id;
          public               cat    false    220            �            1259    34021    ages_of_films    TABLE     b   CREATE TABLE public.ages_of_films (
    movie_id integer NOT NULL,
    age_id integer NOT NULL
);
 !   DROP TABLE public.ages_of_films;
       public         heap r       cat    false            �            1259    34024    filmography_of_actors    TABLE     l   CREATE TABLE public.filmography_of_actors (
    actor_id integer NOT NULL,
    movie_id integer NOT NULL
);
 )   DROP TABLE public.filmography_of_actors;
       public         heap r       cat    false            �            1259    34027    genres    TABLE     e   CREATE TABLE public.genres (
    genre_id integer NOT NULL,
    genre_name character varying(255)
);
    DROP TABLE public.genres;
       public         heap r       cat    false            �            1259    34030    genres_genre_id_seq    SEQUENCE     �   CREATE SEQUENCE public.genres_genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.genres_genre_id_seq;
       public               cat    false    223            {           0    0    genres_genre_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.genres_genre_id_seq OWNED BY public.genres.genre_id;
          public               cat    false    224            �            1259    34031    liked_movies    TABLE     b   CREATE TABLE public.liked_movies (
    user_id integer NOT NULL,
    movie_id integer NOT NULL
);
     DROP TABLE public.liked_movies;
       public         heap r       cat    false            �            1259    34034    movie_genres    TABLE     c   CREATE TABLE public.movie_genres (
    movie_id integer NOT NULL,
    genre_id integer NOT NULL
);
     DROP TABLE public.movie_genres;
       public         heap r       cat    false            �            1259    34037    movies    TABLE       CREATE TABLE public.movies (
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
       public         heap r       cat    false            �            1259    34042    movies_movie_id_seq    SEQUENCE     �   CREATE SEQUENCE public.movies_movie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.movies_movie_id_seq;
       public               cat    false    227            |           0    0    movies_movie_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.movies_movie_id_seq OWNED BY public.movies.movie_id;
          public               cat    false    228            �            1259    34043    reviews    TABLE     �   CREATE TABLE public.reviews (
    movie_id integer,
    user_id integer,
    review_text text,
    date_of_writing timestamp without time zone
);
    DROP TABLE public.reviews;
       public         heap r       cat    false            �            1259    34048    stars    TABLE     x   CREATE TABLE public.stars (
    movie_id integer NOT NULL,
    user_id integer NOT NULL,
    number_of_stars integer
);
    DROP TABLE public.stars;
       public         heap r       cat    false            �            1259    34051    users    TABLE     �   CREATE TABLE public.users (
    user_id integer NOT NULL,
    email character varying(255),
    age integer,
    role character varying(50),
    password_hash text
);
    DROP TABLE public.users;
       public         heap r       cat    false            �            1259    34056    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public               cat    false    231            }           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public               cat    false    232            �           2604    34057    actors actor_id    DEFAULT     r   ALTER TABLE ONLY public.actors ALTER COLUMN actor_id SET DEFAULT nextval('public.actors_actor_id_seq'::regclass);
 >   ALTER TABLE public.actors ALTER COLUMN actor_id DROP DEFAULT;
       public               cat    false    218    217            �           2604    34058    age_categorys age_id    DEFAULT     |   ALTER TABLE ONLY public.age_categorys ALTER COLUMN age_id SET DEFAULT nextval('public.age_categorys_age_id_seq'::regclass);
 C   ALTER TABLE public.age_categorys ALTER COLUMN age_id DROP DEFAULT;
       public               cat    false    220    219            �           2604    34059    genres genre_id    DEFAULT     r   ALTER TABLE ONLY public.genres ALTER COLUMN genre_id SET DEFAULT nextval('public.genres_genre_id_seq'::regclass);
 >   ALTER TABLE public.genres ALTER COLUMN genre_id DROP DEFAULT;
       public               cat    false    224    223            �           2604    34060    movies movie_id    DEFAULT     r   ALTER TABLE ONLY public.movies ALTER COLUMN movie_id SET DEFAULT nextval('public.movies_movie_id_seq'::regclass);
 >   ALTER TABLE public.movies ALTER COLUMN movie_id DROP DEFAULT;
       public               cat    false    228    227            �           2604    34061    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public               cat    false    232    231            b          0    34009    actors 
   TABLE DATA           ;   COPY public.actors (actor_id, name, biography) FROM stdin;
    public               cat    false    217   +>       d          0    34015    age_categorys 
   TABLE DATA           P   COPY public.age_categorys (age_id, age, characteristic_of_category) FROM stdin;
    public               cat    false    219   :@       f          0    34021    ages_of_films 
   TABLE DATA           9   COPY public.ages_of_films (movie_id, age_id) FROM stdin;
    public               cat    false    221   �@       g          0    34024    filmography_of_actors 
   TABLE DATA           C   COPY public.filmography_of_actors (actor_id, movie_id) FROM stdin;
    public               cat    false    222   3A       h          0    34027    genres 
   TABLE DATA           6   COPY public.genres (genre_id, genre_name) FROM stdin;
    public               cat    false    223   uA       j          0    34031    liked_movies 
   TABLE DATA           9   COPY public.liked_movies (user_id, movie_id) FROM stdin;
    public               cat    false    225   �A       k          0    34034    movie_genres 
   TABLE DATA           :   COPY public.movie_genres (movie_id, genre_id) FROM stdin;
    public               cat    false    226   �A       l          0    34037    movies 
   TABLE DATA           �   COPY public.movies (movie_id, title, year_of_release, director, description, star_rating, number_of_ratings, poster) FROM stdin;
    public               cat    false    227   ;B       n          0    34043    reviews 
   TABLE DATA           R   COPY public.reviews (movie_id, user_id, review_text, date_of_writing) FROM stdin;
    public               cat    false    229   wF       o          0    34048    stars 
   TABLE DATA           C   COPY public.stars (movie_id, user_id, number_of_stars) FROM stdin;
    public               cat    false    230   �G       p          0    34051    users 
   TABLE DATA           I   COPY public.users (user_id, email, age, role, password_hash) FROM stdin;
    public               cat    false    231   )H       ~           0    0    actors_actor_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.actors_actor_id_seq', 13, true);
          public               cat    false    218                       0    0    age_categorys_age_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.age_categorys_age_id_seq', 4, true);
          public               cat    false    220            �           0    0    genres_genre_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.genres_genre_id_seq', 7, true);
          public               cat    false    224            �           0    0    movies_movie_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.movies_movie_id_seq', 11, true);
          public               cat    false    228            �           0    0    users_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_user_id_seq', 8, true);
          public               cat    false    232            �           2606    34063    actors actors_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.actors
    ADD CONSTRAINT actors_pkey PRIMARY KEY (actor_id);
 <   ALTER TABLE ONLY public.actors DROP CONSTRAINT actors_pkey;
       public                 cat    false    217            �           2606    34065     age_categorys age_categorys_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.age_categorys
    ADD CONSTRAINT age_categorys_pkey PRIMARY KEY (age_id);
 J   ALTER TABLE ONLY public.age_categorys DROP CONSTRAINT age_categorys_pkey;
       public                 cat    false    219            �           2606    34067     ages_of_films ages_of_films_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.ages_of_films
    ADD CONSTRAINT ages_of_films_pkey PRIMARY KEY (movie_id, age_id);
 J   ALTER TABLE ONLY public.ages_of_films DROP CONSTRAINT ages_of_films_pkey;
       public                 cat    false    221    221            �           2606    34069 0   filmography_of_actors filmography_of_actors_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.filmography_of_actors
    ADD CONSTRAINT filmography_of_actors_pkey PRIMARY KEY (actor_id, movie_id);
 Z   ALTER TABLE ONLY public.filmography_of_actors DROP CONSTRAINT filmography_of_actors_pkey;
       public                 cat    false    222    222            �           2606    34071    genres genres_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genre_id);
 <   ALTER TABLE ONLY public.genres DROP CONSTRAINT genres_pkey;
       public                 cat    false    223            �           2606    34073    liked_movies liked_movies_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.liked_movies
    ADD CONSTRAINT liked_movies_pkey PRIMARY KEY (user_id, movie_id);
 H   ALTER TABLE ONLY public.liked_movies DROP CONSTRAINT liked_movies_pkey;
       public                 cat    false    225    225            �           2606    34075    movie_genres movie_genres_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.movie_genres
    ADD CONSTRAINT movie_genres_pkey PRIMARY KEY (movie_id, genre_id);
 H   ALTER TABLE ONLY public.movie_genres DROP CONSTRAINT movie_genres_pkey;
       public                 cat    false    226    226            �           2606    34077    movies movies_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (movie_id);
 <   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_pkey;
       public                 cat    false    227            �           2606    34079    stars stars_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.stars
    ADD CONSTRAINT stars_pkey PRIMARY KEY (user_id, movie_id);
 :   ALTER TABLE ONLY public.stars DROP CONSTRAINT stars_pkey;
       public                 cat    false    230    230            �           2606    34081    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public                 cat    false    231            �           2606    34083    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 cat    false    231            b   �  x��S�n1>�O1@Vl��1� ���^���d�l���ʭI�8 � ���4$}��1ނ )���e�;���f����ci��=�TS��2��w\�#,�\�)�%~�8�,�	��SB �]\a�)��svXW�+��E�Κ�U�SBîH%�A����s�_qA�S���JW�+?����E�\(n�x���׸����%2��n���9�J�TA�O�S,��
J�-�+�v�fN�������'c;z;u��?����X\F��#���N񛬑B[t��Ҝ�:��d�oL�Jx`z/yC=�b1�c]�tߙ��E` ��,&�4��R�`�m�d<T�Rʊ�b�)s�/��IK����x4�e5��n��-�)���A#���a�¦I'sa���~�R�O\���pk"k�ư]�9_gma�Z��M,3@���*��r���fzF���!���@�*����?S��a�?��Ο��6ȳ�s�Ύ5�      d   �   x�m�M
�0��/��^H�=���� ��ލj���9ü9	�W�%��L�e�y/�!�-����N�-0j�g���@h�
oB�z%::��;���3�<�1���oG����	s&N�Z�\b^ЂTpf)���
�T*sR�����ӯę����q��i�_qf�1{X��      f   .   x�ı  ��?�!���spQ!���v��R^\%%'�
� >���      g   2   x�Ĺ�0 İZ&���.�� a�+�F��'��r�=������/���      h   L   x�3�tL.����2�t)J�M�2�N��u��2�tK�+I,��2�t���M+3���M�KN�2�t.��M����� �S      j      x�3�4�2cK 64������ !��      k   1   x���  ���0� �ø�b���i�2V7�dS
����fϖw ��t      l   ,  x�mU�n�F}^�|�%H�|ѣa�NR�M�E�Ɛ�[-w�ݥ��{fi�}`$��9�_��N�)4{ΝD���l�cd_�D�!6t�!86w�Bl��Wi���jN�S>-qk}K�h9�eTH{����s�:���FR�^H��F��I7֙}���얛��\�V�=�[�3�7��� �&>��j�6�ā�������1*|B{�S�}8�V(Di��X�KbZ�'����FG��n��2�"N��Я:������7�
���	=���}b\��ߖr�@��4���Y߮�&�qyapy�[��������m�e�yk�hS���x�g'�P��s-t�a�ĩ<�xQz��$�����S�mK�:���:>���(��	���)�{u�l>�ȗCY�ߚ�ɺ�a.֩�96��b�(�2KR�-G��ܩq��Jh�g��
r�d�`ɑKn��J#�������]�ksw��QA��g��=~c�h?pd0jmM_��klBz�jsI��+��U���Gؔ,TR-�Cԛ<��sa*�Ԙ͒
:Đ��z���\)E����
.��������wV[�ut=Z��n�5���Q���I/BɎ�G@�cy
�R�|֐h��]�^`�[��c�{�#�P�F���0�*<D�5�!4Ĳ�s����M�68�ȟ��`��&}���Ae p)�����/�{0i��I�o� A�-Z�p�U35�l�J* h�ӎ�o�=���z�8;W�����mF-�%��Z��v���v�b�;�V1��\0�rV��"�i<o[�$����}(�wD�0+�a8yI	7ks�yz�n���LIG���J�������EP��<���0Z̙��������X��6^o�˷��F�;a�?&�¨x��i�`�E�p 飮�<bʎ{}ee��]�	Nd��8&��j.���7YT��,b�*��PV�{,��\��nF�����uOə��⸴�ԅ�*D���Nu�9?�C�nC�!��)Ѻ����	�R���)3�ݮLwv��������?��      n   I  x�]�KN�0���)�4�#NKv	���MMk)q��)*��.@b�U*$�B���}#�y�������4,Ž�S(���p���m����ʴ�0g�b��0	d�a"���k�7r�ƅ�Z6�US
�K/�r�(c��p!
�T�@�C��ʦV2�b\�L-����U�o��'6A	�i��TnU�A`�VB^cT�k�(;q#���?����G���;��{�K�u���C���*��A�kw���y<��m���ܧ���
{��[ڵ&<c<K�x����fZ���<�i��1'iX�{8�V�䟇�3�Ɯ1J��(���증�      o   I   x���� ��TL&l���_G>;�<�B������S�R8=5(7;ء����b/��;�㽏����D      p   =  x���Io�@ ����;<�0,�M���X��4#ʾ��mzФ��/o�|�
�sڒ(�R�$@,����������h��eн~���b��/�½^�E@�(����i������p��!�|E��잕4S;���٥Quuٹ��%뭢��rc2�5�cr�D$�¼���o��c�h�H����{�m�,h唡.�V[��c�ߑ�gg�]�3f��Y��kq����I����㏞�d�ͩ�`��uUU[���I���edp�ᳵ�LknWs����l6N%���/�a��h�U8J䫧'\�N��0G�0�uO��     