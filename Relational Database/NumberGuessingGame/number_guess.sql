--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: userinfo; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.userinfo (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL,
    games_played integer,
    best_game integer
);


ALTER TABLE public.userinfo OWNER TO freecodecamp;

--
-- Name: userinfo_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.userinfo_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userinfo_user_id_seq OWNER TO freecodecamp;

--
-- Name: userinfo_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.userinfo_user_id_seq OWNED BY public.userinfo.user_id;


--
-- Name: userinfo user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.userinfo ALTER COLUMN user_id SET DEFAULT nextval('public.userinfo_user_id_seq'::regclass);


--
-- Data for Name: userinfo; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.userinfo VALUES (66, 'lino', 2, 1);
INSERT INTO public.userinfo VALUES (67, 'oreo', 2, 5);
INSERT INTO public.userinfo VALUES (77, 'user_1747216045163', 2, 126);
INSERT INTO public.userinfo VALUES (76, 'user_1747216045164', 5, 364);
INSERT INTO public.userinfo VALUES (69, 'user_1747215851334', 2, 623);
INSERT INTO public.userinfo VALUES (89, 'user_1747216169749', 2, 320);
INSERT INTO public.userinfo VALUES (68, 'user_1747215851335', 5, 54);
INSERT INTO public.userinfo VALUES (88, 'user_1747216169750', 5, 121);
INSERT INTO public.userinfo VALUES (79, 'user_1747216090030', 2, 236);
INSERT INTO public.userinfo VALUES (71, 'user_1747215951223', 2, 461);
INSERT INTO public.userinfo VALUES (78, 'user_1747216090031', 5, 215);
INSERT INTO public.userinfo VALUES (70, 'user_1747215951224', 5, 246);
INSERT INTO public.userinfo VALUES (81, 'user_1747216108361', 2, 485);
INSERT INTO public.userinfo VALUES (73, 'user_1747215985491', 2, 289);
INSERT INTO public.userinfo VALUES (91, 'user_1747216197262', 2, 104);
INSERT INTO public.userinfo VALUES (72, 'user_1747215985492', 5, 63);
INSERT INTO public.userinfo VALUES (80, 'user_1747216108362', 5, 697);
INSERT INTO public.userinfo VALUES (90, 'user_1747216197263', 5, 287);
INSERT INTO public.userinfo VALUES (75, 'user_1747216026066', 2, 624);
INSERT INTO public.userinfo VALUES (74, 'user_1747216026067', 5, 171);
INSERT INTO public.userinfo VALUES (83, 'user_1747216122235', 2, 857);
INSERT INTO public.userinfo VALUES (82, 'user_1747216122236', 5, 346);
INSERT INTO public.userinfo VALUES (85, 'user_1747216149931', 2, 183);
INSERT INTO public.userinfo VALUES (84, 'user_1747216149932', 5, 179);
INSERT INTO public.userinfo VALUES (87, 'user_1747216162725', 2, 507);
INSERT INTO public.userinfo VALUES (86, 'user_1747216162726', 5, 295);


--
-- Name: userinfo_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.userinfo_user_id_seq', 91, true);


--
-- Name: userinfo userinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.userinfo
    ADD CONSTRAINT userinfo_pkey PRIMARY KEY (user_id);


--
-- Name: userinfo userinfo_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.userinfo
    ADD CONSTRAINT userinfo_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

