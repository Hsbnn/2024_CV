PGDMP  )    '                 |            postgres    17.0 (Debian 17.0-1.pgdg120+1)     17.2 (Ubuntu 17.2-1.pgdg20.04+1) :    t           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            u           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            v           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            w           1262    5    postgres    DATABASE     s   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE postgres;
                     postgres    false            x           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                        postgres    false    3447            �            1259    34085    actors    TABLE     s   CREATE TABLE public.actors (
    actor_id integer NOT NULL,
    name character varying(255),
    biography text
);
    DROP TABLE public.actors;
       public         heap r       cat    false            �            1259    34090    actors_actor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.actors_actor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.actors_actor_id_seq;
       public               cat    false    217            y           0    0    actors_actor_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.actors_actor_id_seq OWNED BY public.actors.actor_id;
          public               cat    false    218            �            1259    34091    age_categorys    TABLE     �   CREATE TABLE public.age_categorys (
    age_id integer NOT NULL,
    age character varying(50),
    characteristic_of_category text
);
 !   DROP TABLE public.age_categorys;
       public         heap r       cat    false            �            1259    34096    age_categorys_age_id_seq    SEQUENCE     �   CREATE SEQUENCE public.age_categorys_age_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.age_categorys_age_id_seq;
       public               cat    false    219            z           0    0    age_categorys_age_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.age_categorys_age_id_seq OWNED BY public.age_categorys.age_id;
          public               cat    false    220            �            1259    34097    ages_of_films    TABLE     b   CREATE TABLE public.ages_of_films (
    movie_id integer NOT NULL,
    age_id integer NOT NULL
);
 !   DROP TABLE public.ages_of_films;
       public         heap r       cat    false            �            1259    34100    filmography_of_actors    TABLE     l   CREATE TABLE public.filmography_of_actors (
    actor_id integer NOT NULL,
    movie_id integer NOT NULL
);
 )   DROP TABLE public.filmography_of_actors;
       public         heap r       cat    false            �            1259    34103    genres    TABLE     e   CREATE TABLE public.genres (
    genre_id integer NOT NULL,
    genre_name character varying(255)
);
    DROP TABLE public.genres;
       public         heap r       cat    false            �            1259    34106    genres_genre_id_seq    SEQUENCE     �   CREATE SEQUENCE public.genres_genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.genres_genre_id_seq;
       public               cat    false    223            {           0    0    genres_genre_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.genres_genre_id_seq OWNED BY public.genres.genre_id;
          public               cat    false    224            �            1259    34107    liked_movies    TABLE     b   CREATE TABLE public.liked_movies (
    user_id integer NOT NULL,
    movie_id integer NOT NULL
);
     DROP TABLE public.liked_movies;
       public         heap r       cat    false            �            1259    34110    movie_genres    TABLE     c   CREATE TABLE public.movie_genres (
    movie_id integer NOT NULL,
    genre_id integer NOT NULL
);
     DROP TABLE public.movie_genres;
       public         heap r       cat    false            �            1259    34113    movies    TABLE       CREATE TABLE public.movies (
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
       public         heap r       cat    false            �            1259    34118    movies_movie_id_seq    SEQUENCE     �   CREATE SEQUENCE public.movies_movie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.movies_movie_id_seq;
       public               cat    false    227            |           0    0    movies_movie_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.movies_movie_id_seq OWNED BY public.movies.movie_id;
          public               cat    false    228            �            1259    34119    reviews    TABLE     �   CREATE TABLE public.reviews (
    movie_id integer,
    user_id integer,
    review_text text,
    date_of_writing timestamp without time zone
);
    DROP TABLE public.reviews;
       public         heap r       cat    false            �            1259    34124    stars    TABLE     x   CREATE TABLE public.stars (
    movie_id integer NOT NULL,
    user_id integer NOT NULL,
    number_of_stars integer
);
    DROP TABLE public.stars;
       public         heap r       cat    false            �            1259    34127    users    TABLE     �   CREATE TABLE public.users (
    user_id integer NOT NULL,
    email character varying(255),
    age integer,
    role character varying(50),
    password_hash text
);
    DROP TABLE public.users;
       public         heap r       cat    false            �            1259    34132    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public               cat    false    231            }           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public               cat    false    232            �           2604    34133    actors actor_id    DEFAULT     r   ALTER TABLE ONLY public.actors ALTER COLUMN actor_id SET DEFAULT nextval('public.actors_actor_id_seq'::regclass);
 >   ALTER TABLE public.actors ALTER COLUMN actor_id DROP DEFAULT;
       public               cat    false    218    217            �           2604    34134    age_categorys age_id    DEFAULT     |   ALTER TABLE ONLY public.age_categorys ALTER COLUMN age_id SET DEFAULT nextval('public.age_categorys_age_id_seq'::regclass);
 C   ALTER TABLE public.age_categorys ALTER COLUMN age_id DROP DEFAULT;
       public               cat    false    220    219            �           2604    34135    genres genre_id    DEFAULT     r   ALTER TABLE ONLY public.genres ALTER COLUMN genre_id SET DEFAULT nextval('public.genres_genre_id_seq'::regclass);
 >   ALTER TABLE public.genres ALTER COLUMN genre_id DROP DEFAULT;
       public               cat    false    224    223            �           2604    34136    movies movie_id    DEFAULT     r   ALTER TABLE ONLY public.movies ALTER COLUMN movie_id SET DEFAULT nextval('public.movies_movie_id_seq'::regclass);
 >   ALTER TABLE public.movies ALTER COLUMN movie_id DROP DEFAULT;
       public               cat    false    228    227            �           2604    34137    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public               cat    false    232    231            b          0    34085    actors 
   TABLE DATA           ;   COPY public.actors (actor_id, name, biography) FROM stdin;
    public               cat    false    217   +>       d          0    34091    age_categorys 
   TABLE DATA           P   COPY public.age_categorys (age_id, age, characteristic_of_category) FROM stdin;
    public               cat    false    219   B       f          0    34097    ages_of_films 
   TABLE DATA           9   COPY public.ages_of_films (movie_id, age_id) FROM stdin;
    public               cat    false    221   �B       g          0    34100    filmography_of_actors 
   TABLE DATA           C   COPY public.filmography_of_actors (actor_id, movie_id) FROM stdin;
    public               cat    false    222   C       h          0    34103    genres 
   TABLE DATA           6   COPY public.genres (genre_id, genre_name) FROM stdin;
    public               cat    false    223   RC       j          0    34107    liked_movies 
   TABLE DATA           9   COPY public.liked_movies (user_id, movie_id) FROM stdin;
    public               cat    false    225   �C       k          0    34110    movie_genres 
   TABLE DATA           :   COPY public.movie_genres (movie_id, genre_id) FROM stdin;
    public               cat    false    226   �C       l          0    34113    movies 
   TABLE DATA           �   COPY public.movies (movie_id, title, year_of_release, director, description, star_rating, number_of_ratings, poster) FROM stdin;
    public               cat    false    227   $D       n          0    34119    reviews 
   TABLE DATA           R   COPY public.reviews (movie_id, user_id, review_text, date_of_writing) FROM stdin;
    public               cat    false    229   �J       o          0    34124    stars 
   TABLE DATA           C   COPY public.stars (movie_id, user_id, number_of_stars) FROM stdin;
    public               cat    false    230   L       p          0    34127    users 
   TABLE DATA           I   COPY public.users (user_id, email, age, role, password_hash) FROM stdin;
    public               cat    false    231   `L       ~           0    0    actors_actor_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.actors_actor_id_seq', 18, true);
          public               cat    false    218                       0    0    age_categorys_age_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.age_categorys_age_id_seq', 4, true);
          public               cat    false    220            �           0    0    genres_genre_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.genres_genre_id_seq', 7, true);
          public               cat    false    224            �           0    0    movies_movie_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.movies_movie_id_seq', 15, true);
          public               cat    false    228            �           0    0    users_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_user_id_seq', 8, true);
          public               cat    false    232            �           2606    34139    actors actors_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.actors
    ADD CONSTRAINT actors_pkey PRIMARY KEY (actor_id);
 <   ALTER TABLE ONLY public.actors DROP CONSTRAINT actors_pkey;
       public                 cat    false    217            �           2606    34141     age_categorys age_categorys_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.age_categorys
    ADD CONSTRAINT age_categorys_pkey PRIMARY KEY (age_id);
 J   ALTER TABLE ONLY public.age_categorys DROP CONSTRAINT age_categorys_pkey;
       public                 cat    false    219            �           2606    34143     ages_of_films ages_of_films_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.ages_of_films
    ADD CONSTRAINT ages_of_films_pkey PRIMARY KEY (movie_id, age_id);
 J   ALTER TABLE ONLY public.ages_of_films DROP CONSTRAINT ages_of_films_pkey;
       public                 cat    false    221    221            �           2606    34145 0   filmography_of_actors filmography_of_actors_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.filmography_of_actors
    ADD CONSTRAINT filmography_of_actors_pkey PRIMARY KEY (actor_id, movie_id);
 Z   ALTER TABLE ONLY public.filmography_of_actors DROP CONSTRAINT filmography_of_actors_pkey;
       public                 cat    false    222    222            �           2606    34147    genres genres_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genre_id);
 <   ALTER TABLE ONLY public.genres DROP CONSTRAINT genres_pkey;
       public                 cat    false    223            �           2606    34149    liked_movies liked_movies_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.liked_movies
    ADD CONSTRAINT liked_movies_pkey PRIMARY KEY (user_id, movie_id);
 H   ALTER TABLE ONLY public.liked_movies DROP CONSTRAINT liked_movies_pkey;
       public                 cat    false    225    225            �           2606    34151    movie_genres movie_genres_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.movie_genres
    ADD CONSTRAINT movie_genres_pkey PRIMARY KEY (movie_id, genre_id);
 H   ALTER TABLE ONLY public.movie_genres DROP CONSTRAINT movie_genres_pkey;
       public                 cat    false    226    226            �           2606    34153    movies movies_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (movie_id);
 <   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_pkey;
       public                 cat    false    227            �           2606    34155    stars stars_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.stars
    ADD CONSTRAINT stars_pkey PRIMARY KEY (user_id, movie_id);
 :   ALTER TABLE ONLY public.stars DROP CONSTRAINT stars_pkey;
       public                 cat    false    230    230            �           2606    34157    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public                 cat    false    231            �           2606    34159    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 cat    false    231            b   �  x��T�nE?�>ŧ��*�4uztR%nKD�Sz�e�;�ޝ�ffc|sRn�$ġB���j0M���+�$�f�@�,T$.��7���|6>�J2�*z ��@�o�[7��n�޸���N��	�Tg��܌�;�������ܕ�T���y�H�k��a&�8
��v����I�b9ܷ�Ыـ<s��K��"r]=�qM~U�{|r�T�Պ��e�8'�~�p��4
׃=fmƇ��l�v����C�BA͏��nB՗���
�&�PZ���y�t����RL���T�K�������~�hG$V(�A;�}��A}ZY9�����z��vUz�Px�tYAO����=�j�d�$��H�f}y6�Ǿ�\R��!���(��P䢗�(�ׂ}�����a2�G��"آ#nl�=k���SN��K}��4ĉ0$����nf=��0W޾g���x�vJse�F���wF Sh�K?����N�A��7	�s�As��/üJ�
OT�q�j�{��w~�|������%��M_�)�U�
���f�P�1���+���zN��z���:�����Bt?#p�h�K/
���}ݭ1���W��xZߔۯ8�$�����(�.JW�6��Js�E^�)a���0�xb��ܘ���!���X��J�r�R�)i�#E�ݾ�`��Н�֝0����GJ�����2@	d��P)�#�`L�Qiy��kk�1ҥ��2+l�������D������x^u�4ǃ�Z/�qR�d��&�r��%�ɲ�Z��U�-,7�{����P�/�m��t���e��D��;�_z��@hὴ!H��3��)�þsi�0)L�h�N$7���V�>1�_�l�w�$U���:r�J���Uy�M����I�&�¨��XΨ�� m�?�<C�5O�8�ܢ̭��d�r����I��*j'#�L��V�hna��?euFx�a�'��x      d   �   x�m�M
�0��/��^H�=���� ��ލj���9ü9	�W�%��L�e�y/�!�-����N�-0j�g���@h�
oB�z%::��;���3�<�1���oG����	s&N�Z�\b^ЂTpf)���
�T*sR�����ӯę����q��i�_qf�1{X��      f   3   x�ɱ  ��?��2��i��rM6��͑���Z8��7�����      g   ?   x���� ��m1�^��|F��LWgh
�&K�T�����3�rˁ����Y~��3=      h   L   x�3�tL.����2�t)J�M�2�N��u��2�tK�+I,��2�t���M+3���M�KN�2�t.��M����� �S      j      x�3�4�2cK 64 F\1z\\\ 1�}      k   ;   x�%���0�L1Q���b�a�0BE*(g+Y�Vs��׃-�\k�~j������ S	N      l   b  x�mV�n�8}f�b���6,����M��Y�͢�
�4�XS�����O����%{���.P�H%Q�9�̙]������[�Z�X�Z���]e"��PӍ�{o��8�������`:���tL�y$��P�S0:T-%D�[�*�R���Z���v5�dw�	L���v��v��w�^��ju�\��n�o�V�;�ݙ�Mj�\^��6��|���=�:��eG�u�tŴs~t�c~��wx�;G��e�!&�\b�^�]�V�}E OU�}$?�����ݽO��80���ȯ�2C�VO��?aάD�7:ԣ�v�6�x��K �ܼ�pH�H<
���[mm$���=@�Ԓ��Β.ԥ�W\,��)�n��2�+��뤃�X��A���!}����T�Ngp��(lբ�(UVԃ�#��A��g�p`b4xPr�%l�An�N����QH�԰��C�O\%9�����B1��[\�W�k�/�9���P����� �����c`���Nr�w��*�F*%�'1�<J���\��x�͖g��:&�Ok��C��
xBC,#<�@I�)��x��� �k�^ .��b���8�d��K����=�X���h��y�@�u�Z����jx��� 4�IF�����9���9�����(.~�6!�����AJ�^߳~hą(`ׂ���T�B�_J�^\�.h�v�0P������W��u���hf���?8�W�ڴ��^aZQ�Vі��?{΁��"��ff�`(ZL�������kT��3���vC]�����K��J�V�A�̺��2BҀ O?|W�[�CV�'<u@"�Kǘ�<8����w�E�R��<�`�u�G�:����c��c�S|�.68�)g2�D���!�ܱ
��q�܍�M<%D�,q���&�#n�:{�{��b��S���G��Z�$].E,���  ����gPf�~I�邲�L���1��!�z$-��m�u��c�Ɉ����;�/c�ZS`��r	�fBw�>bz�16�>H���A{zg�����A]}�Z��J�k��ƣ� nR��6AI7[�����1�VR���@[��\u���(i��K��5���?0sv$�i�t�����H�Z�8z�u��M`������c����d�c�[/�:�F��qo����>|����άh�P`��r�K�� A3j+~ԝ���T�����O+xod� �I�n ��idtH�[?
�`d]�g�G�ӡ{�3.�:���.��P\.��eq�>W�X�����2�Kudj��~'v�V�,����,��w�7�|�
�A���7���:���(��vP�4N�r��NӨX_-�>�JT&�kΜ��{zya�S�	/eA�7��p�=���WGe�2�.�j��ɻ�o�m�7��������ʔ؃3ټ���D�_H�$_~�|y|�As� BQShR%-@ޞ�-��%���߿�Wc�@0KG_H�dϢ��A"��P'Ǔr���Dֱ�	9 �?(��!>��9<�6^`�o�$�����*��	�㩍���&%[�ۘج���
���&�=M���?ŪX�V����ܡU�ߵk�	{����8;;����      n   _  x�]QKN�0];���ȟ8m�+HH�8@7nj��ĉ�V@ ��*R�P�`߈��DAkl��fFό02)Ս��PVK��ʴpmgm��4�S�NyrD�QF)F�	'g6o���
�n.��T6�0���Ec\k��cU���N�d�r�nj�Q�fUׂ�U�shMy���^����wE�&oMe�8P�6���PΙ�`����%��]��[�	�3<�7w�5���_�-����.�!k�XX���Z�[��<����3�����
%���f�o�d&d���(���`��k�&��㌦ƒ���I.�j��Ç�Lc)�È%���34l�+��Y&�ǒ��4�hGQ�x'�[      o   K   x�%��� ��w�T� �t�9�ҏe9��B�nw5�\NuJ��AYpぇ��R����~�������l�1�1      p   =  x���Io�@ ����;<�0,�M���X��4#ʾ��mzФ��/o�|�
�sڒ(�R�$@,����������h��eн~���b��/�½^�E@�(����i������p��!�|E��잕4S;���٥Quuٹ��%뭢��rc2�5�cr�D$�¼���o��c�h�H����{�m�,h唡.�V[��c�ߑ�gg�]�3f��Y��kq����I����㏞�d�ͩ�`��uUU[���I���edp�ᳵ�LknWs����l6N%���/�a��h�U8J䫧'\�N��0G�0�uO��     