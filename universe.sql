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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(100) NOT NULL,
    age integer NOT NULL,
    size integer NOT NULL,
    discovered boolean NOT NULL,
    description text
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: mission; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.mission (
    mission_id integer NOT NULL,
    name character varying(255) NOT NULL,
    target_type text NOT NULL,
    successful boolean NOT NULL,
    budget numeric(12,2),
    duration_days integer NOT NULL,
    planet_id integer,
    moon_id integer,
    CONSTRAINT chk_target CHECK ((((target_type = 'planet'::text) AND (planet_id IS NOT NULL) AND (moon_id IS NULL)) OR ((target_type = 'moon'::text) AND (moon_id IS NOT NULL) AND (planet_id IS NULL))))
);


ALTER TABLE public.mission OWNER TO freecodecamp;

--
-- Name: mission_mission_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.mission_mission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mission_mission_id_seq OWNER TO freecodecamp;

--
-- Name: mission_mission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.mission_mission_id_seq OWNED BY public.mission.mission_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(100) NOT NULL,
    radius integer NOT NULL,
    is_spherical boolean NOT NULL,
    composition text,
    planet_id integer NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(100) NOT NULL,
    population integer,
    has_life boolean NOT NULL,
    distance_from_star numeric(10,2),
    star_id integer NOT NULL
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(100) NOT NULL,
    mass integer NOT NULL,
    is_active boolean NOT NULL,
    age integer,
    galaxy_id integer NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: mission mission_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.mission ALTER COLUMN mission_id SET DEFAULT nextval('public.mission_mission_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 13, 100000, true, 'A large barred spiral galaxy that contains the Solar System.');
INSERT INTO public.galaxy VALUES (2, 'Small Magellanic Cloud', 10, 7000, true, 'A dwarf irregular galaxy located near the Milky Way.');
INSERT INTO public.galaxy VALUES (3, 'Andromeda', 11, 220000, true, 'The largest galaxy in the Local Group, known for its spiral arms.');
INSERT INTO public.galaxy VALUES (4, 'Sombrero Galaxy', 12, 150000, false, 'A lenticular galaxy famous for its bright core and halo.');
INSERT INTO public.galaxy VALUES (5, 'Messier 87', 13, 300000, true, 'An elliptical galaxy mostly made up of old stars.');
INSERT INTO public.galaxy VALUES (6, 'Cartwheel Galaxy', 12, 400000, false, 'A peculiar galaxy known for its active nucleus and starburst regions.');
INSERT INTO public.galaxy VALUES (7, 'Phoenix Galaxy', 13, 300000, true, 'A recently observed irregular galaxy with intense star formation activity.');


--
-- Data for Name: mission; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.mission VALUES (1, 'Voyager I', 'planet', true, 2500.00, 7200, 4, NULL);
INSERT INTO public.mission VALUES (2, 'Mars Pathfinder', 'planet', true, 280.50, 360, 2, NULL);
INSERT INTO public.mission VALUES (3, 'Kepler ExoMission', 'planet', false, 320.00, 1800, 9, NULL);
INSERT INTO public.mission VALUES (4, 'Lunar Recon Orbiter', 'moon', true, 504.20, 365, NULL, 1);
INSERT INTO public.mission VALUES (5, 'Europa Clipper', 'moon', false, 1200.75, 2500, NULL, 4);
INSERT INTO public.mission VALUES (6, 'Titan Explorer', 'moon', true, 980.00, 4000, NULL, 7);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', 1737, true, 'Rocky', 1);
INSERT INTO public.moon VALUES (2, 'Phobos', 11, false, 'Rocky', 2);
INSERT INTO public.moon VALUES (3, 'Deimos', 6, false, 'Rocky', 2);
INSERT INTO public.moon VALUES (4, 'Europa', 1560, true, 'Ice', 4);
INSERT INTO public.moon VALUES (5, 'Ganymede', 2634, true, 'Ice', 4);
INSERT INTO public.moon VALUES (6, 'Callisto', 2410, true, 'Ice', 4);
INSERT INTO public.moon VALUES (7, 'Titan', 2575, true, 'Ice', 9);
INSERT INTO public.moon VALUES (8, 'Rhea', 764, true, 'Ice', 9);
INSERT INTO public.moon VALUES (9, 'Iapetus', 734, true, 'Ice', 9);
INSERT INTO public.moon VALUES (10, 'Dione', 561, true, 'Ice', 9);
INSERT INTO public.moon VALUES (11, 'Tethys', 531, true, 'Ice', 9);
INSERT INTO public.moon VALUES (12, 'Enceladus', 252, true, 'Ice', 9);
INSERT INTO public.moon VALUES (13, 'Mimas', 198, true, 'Ice', 9);
INSERT INTO public.moon VALUES (14, 'Oberon', 761, true, 'Ice', 6);
INSERT INTO public.moon VALUES (15, 'Titania', 789, true, 'Ice', 6);
INSERT INTO public.moon VALUES (16, 'Ariel', 578, true, 'Ice', 6);
INSERT INTO public.moon VALUES (17, 'Umbriel', 584, true, 'Ice', 6);
INSERT INTO public.moon VALUES (18, 'Miranda', 235, true, 'Ice', 6);
INSERT INTO public.moon VALUES (19, 'Nereid', 170, false, 'Rocky', 8);
INSERT INTO public.moon VALUES (20, 'Triton', 1353, true, 'Ice', 8);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Earth', 80, true, 1.00, 1);
INSERT INTO public.planet VALUES (2, 'Mars', 0, false, 1.52, 1);
INSERT INTO public.planet VALUES (3, 'Venus', 0, false, 0.72, 1);
INSERT INTO public.planet VALUES (4, 'Kepler-22b', 0, false, 600.00, 2);
INSERT INTO public.planet VALUES (5, 'Gliese 581g', 0, false, 20.30, 3);
INSERT INTO public.planet VALUES (6, 'HD 209458b', 0, false, 150.00, 3);
INSERT INTO public.planet VALUES (7, 'Tau Ceti e', 0, false, 11.00, 4);
INSERT INTO public.planet VALUES (8, 'Luyten b', 0, false, 12.20, 4);
INSERT INTO public.planet VALUES (9, 'TRAPPIST-1e', 0, false, 40.00, 5);
INSERT INTO public.planet VALUES (10, 'TRAPPIST-1f', 0, false, 41.00, 5);
INSERT INTO public.planet VALUES (11, 'TRAPPIST-1g', 0, false, 42.00, 5);
INSERT INTO public.planet VALUES (12, 'TRAPPIST-1h', 0, false, 43.00, 5);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 1000, true, 5, 1);
INSERT INTO public.star VALUES (2, 'Alpha Centauri', 950, true, 6, 1);
INSERT INTO public.star VALUES (3, 'Betelgeuse', 800, false, 8, 3);
INSERT INTO public.star VALUES (4, 'Proxima Centauri', 670, true, 4, 2);
INSERT INTO public.star VALUES (5, 'Vega', 900, true, 3, 4);
INSERT INTO public.star VALUES (6, 'Rigel', 850, false, 7, 5);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 7, true);


--
-- Name: mission_mission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.mission_mission_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: mission mission_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.mission
    ADD CONSTRAINT mission_name_key UNIQUE (name);


--
-- Name: mission mission_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.mission
    ADD CONSTRAINT mission_pkey PRIMARY KEY (mission_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: mission fk_mission_moon; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.mission
    ADD CONSTRAINT fk_mission_moon FOREIGN KEY (moon_id) REFERENCES public.moon(moon_id);


--
-- Name: mission fk_mission_planet; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.mission
    ADD CONSTRAINT fk_mission_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: moon fk_moon_planet; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fk_moon_planet FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet fk_planet_star; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_planet_star FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star fk_star_galaxy; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT fk_star_galaxy FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

