--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

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

--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: appointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointments (
    appointment_date date NOT NULL,
    end_time time(6) without time zone NOT NULL,
    is_follow_up boolean,
    start_time time(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    doctor_id bigint NOT NULL,
    id bigint NOT NULL,
    patient_id bigint NOT NULL,
    updated_at timestamp(6) without time zone,
    notes character varying(255),
    reason_for_visit character varying(255),
    status character varying(255) NOT NULL,
    CONSTRAINT appointments_status_check CHECK (((status)::text = ANY (ARRAY[('SCHEDULED'::character varying)::text, ('COMPLETED'::character varying)::text, ('CANCELLED'::character varying)::text, ('NO_SHOW'::character varying)::text, ('RESCHEDULED'::character varying)::text])))
);


ALTER TABLE public.appointments OWNER TO postgres;

--
-- Name: appointments_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointments_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.appointments_seq OWNER TO postgres;

--
-- Name: availability; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.availability (
    date date,
    day_of_week integer NOT NULL,
    end_time time(6) without time zone NOT NULL,
    is_available boolean NOT NULL,
    start_time time(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    doctor_id bigint NOT NULL,
    id bigint NOT NULL,
    updated_at timestamp(6) without time zone
);


ALTER TABLE public.availability OWNER TO postgres;

--
-- Name: availability_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.availability_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.availability_seq OWNER TO postgres;

--
-- Name: tbl_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_users (
    id bigint NOT NULL,
    email character varying(255),
    name character varying(255)
);


ALTER TABLE public.tbl_users OWNER TO postgres;

--
-- Name: tbl_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.tbl_users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tbl_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    active boolean,
    years_of_experience integer,
    created_at timestamp(6) without time zone,
    date_of_birth timestamp(6) without time zone,
    id bigint NOT NULL,
    updated_at timestamp(6) without time zone,
    emergency_contact character varying(100),
    address character varying(255),
    availability character varying(255),
    department character varying(255),
    email character varying(255) NOT NULL,
    first_name character varying(255) NOT NULL,
    gender character varying(255),
    last_name character varying(255) NOT NULL,
    license_number character varying(255),
    medical_history text,
    password character varying(255) NOT NULL,
    phone character varying(255),
    photo character varying(255),
    qualification character varying(255),
    role character varying(255) NOT NULL,
    specialization character varying(255),
    status character varying(255),
    CONSTRAINT users_role_check CHECK (((role)::text = ANY (ARRAY[('RECEPTION'::character varying)::text, ('ADMIN'::character varying)::text, ('DOCTOR'::character varying)::text, ('PATIENT'::character varying)::text])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_seq OWNER TO postgres;

--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointments (appointment_date, end_time, is_follow_up, start_time, created_at, doctor_id, id, patient_id, updated_at, notes, reason_for_visit, status) FROM stdin;
2024-10-07	11:00:00	f	10:00:00	2024-09-21 01:52:55.479404	2	1	52	\N	\N	\N	SCHEDULED
2024-10-01	11:00:00	f	10:00:00	2024-09-21 02:05:44.001983	3	3	53	\N	\N	\N	SCHEDULED
2024-09-24	15:00:00	f	14:00:00	2024-09-21 15:23:14.107746	3	52	52	\N	\N	\N	SCHEDULED
2024-10-14	12:00:00	f	11:00:00	2024-09-21 02:01:57.824004	2	2	52	2024-09-21 22:47:36.122269	\N	\N	COMPLETED
\.


--
-- Data for Name: availability; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.availability (date, day_of_week, end_time, is_available, start_time, created_at, doctor_id, id, updated_at) FROM stdin;
\N	1	12:00:00	t	09:00:00	2024-09-21 01:47:08.568541	2	1	\N
\N	2	15:00:00	t	10:00:00	2024-09-21 01:47:26.733953	3	2	\N
\N	3	17:00:00	t	10:00:00	2024-09-21 01:47:43.24601	4	3	\N
2024-10-07	1	11:00:00	f	10:00:00	2024-09-21 01:52:55.491481	2	52	\N
2024-10-14	1	12:00:00	f	11:00:00	2024-09-21 02:01:57.829747	2	53	\N
2024-10-01	2	11:00:00	f	10:00:00	2024-09-21 02:05:44.010193	3	54	\N
2024-09-24	2	15:00:00	f	14:00:00	2024-09-21 15:23:14.129694	3	102	\N
\.


--
-- Data for Name: tbl_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_users (id, email, name) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (active, years_of_experience, created_at, date_of_birth, id, updated_at, emergency_contact, address, availability, department, email, first_name, gender, last_name, license_number, medical_history, password, phone, photo, qualification, role, specialization, status) FROM stdin;
t	\N	2024-09-21 01:43:12.307966	\N	1	2024-09-21 01:43:12.308033	\N	\N	\N	\N	admin@clinic.com	Admin	\N	User	\N	\N	$2a$10$6PA1uS/aITrVWK6Oxdp8UusQ9KfWFfGvBoHdqPXgy12TKvvHgDDw2	\N	\N	\N	ADMIN	\N	\N
t	\N	2024-09-21 01:45:17.696756	\N	3	2024-09-21 01:45:17.696792	\N	\N	\N	\N	heditoshi@yahoo.jp	Heditoshi	MALE	Nakata	\N	\N	$2a$10$JPigQC52BU3Fau37c0p0uOtDTJ7XoZxxyDEPmrnehNmWsN.wmTiAO	234567890	\N	\N	DOCTOR	BACK	\N
t	\N	2024-09-21 01:46:43.019377	\N	4	2024-09-21 01:46:43.0194	\N	\N	\N	\N	daizen@yahoo.jp	Daizen	MALE	Maeda	\N	\N	$2a$10$i8PHJ1fyMju/.Jv5hwgSE./mVmJLwEGQoKjRsqHQ2NXMeNYr5Q0lC	345678901	\N	\N	DOCTOR	FEET	\N
t	\N	2024-09-21 01:44:24.949028	\N	2	2024-09-21 01:44:24.949065	\N	\N	\N	\N	junichi@yahoo.jp	Junichi	MALE	Inamoto	\N	\N	$2a$10$grXRml5LMpssyFA74cDAzurK4n5a5uIZRzG6whKsOuxLNN6kXGGgG	1234567890	\N	\N	DOCTOR	NOSE	\N
t	\N	2024-09-21 01:52:05.222725	\N	53	2024-09-23 14:44:39.466867	\N	\N	\N	\N	joseph@gmail.com	Joseph	MALE	Biden	\N	\N	$2a$10$er9tsGEb6qa9JnfMVMLK4OUct14n/npobIzTrbW/AnxOwSVuaENB2	1942	\N	\N	PATIENT	\N	\N
t	\N	2024-09-21 01:51:14.242916	\N	52	2024-09-23 15:03:30.548871	\N	\N	\N	\N	donald@gmail.com	Donald	MALE	Trump	\N	Patient_1727101644.png	$2a$10$KOkYR5Bi55JTb4EtgeFs2.d2/wcU0uII0IbZD/QUCCh6Ntaf/ZdEe	1946	IMG_1727103807.png	\N	PATIENT	\N	\N
t	\N	2024-09-23 16:28:19.757256	\N	152	2024-09-23 16:28:19.757292	\N	\N	\N	\N	hd@hdcola.org	Danny	\N	Huang	\N	\N	$2a$10$qClZm2wbmsoJBx3gtfa/reVFRkyzE9Jd8GcRft8R/dbUpiEyI7mb.	\N	\N	\N	PATIENT	\N	\N
t	\N	2024-09-23 16:30:40.90307	\N	153	2024-09-23 16:30:40.903092	\N	\N	\N	\N	zidane@gmail.com	Zinedin	\N	Zidane	\N	\N	$2a$10$oXJHXTE.KPY1cK4.ZK3H.utAOImdzMsCwToVLMvdbiaaQu6Lg5Hi6	\N	\N	\N	PATIENT	\N	\N
t	\N	2024-09-23 16:46:55.119367	\N	202	2024-09-23 16:46:55.119431	\N	\N	\N	\N	figo@gmail.com	Louis	\N	Figo	\N	\N	$2a$10$f9kiUkawSfxiJQ5pO6IAwOXJmeu.P7.xMOziR3qQMrEhZ4ihyjREi	\N	\N	\N	PATIENT	\N	\N
t	\N	2024-09-23 17:01:25.382884	\N	252	2024-09-23 17:01:25.382936	\N	\N	\N	\N	david@gmail.com	David	\N	Bechham	\N	\N	$2a$10$7juqEFfbsT1br4f0id0uv.PIDIDR0YUsP0b8IVbrTF9R95BbiYk1O	\N	\N	\N	PATIENT	\N	\N
t	\N	2024-09-23 17:04:18.437627	\N	302	2024-09-23 17:04:18.437692	\N	\N	\N	\N	robert@gmail.com	Robert	\N	Carlos	\N	\N	$2a$10$QqmqLDSyqSgZqz633D3lSOc3V1UH11Fh5gKCCv...nnTIE421wR9G	\N	\N	\N	PATIENT	\N	\N
\.


--
-- Name: appointments_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointments_seq', 1601, true);


--
-- Name: availability_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.availability_seq', 1601, true);


--
-- Name: tbl_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_users_id_seq', 1, false);


--
-- Name: users_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_seq', 351, true);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- Name: availability availability_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.availability
    ADD CONSTRAINT availability_pkey PRIMARY KEY (id);


--
-- Name: tbl_users tbl_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_users
    ADD CONSTRAINT tbl_users_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: appointments fk6u6s6egu60m2cbdjno44jbipa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT fk6u6s6egu60m2cbdjno44jbipa FOREIGN KEY (doctor_id) REFERENCES public.users(id);


--
-- Name: availability fk7kgtxivaxon39g1t44msth2vb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.availability
    ADD CONSTRAINT fk7kgtxivaxon39g1t44msth2vb FOREIGN KEY (doctor_id) REFERENCES public.users(id);


--
-- Name: appointments fkopb2h9yhin1rb4dqote8bws6w; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT fkopb2h9yhin1rb4dqote8bws6w FOREIGN KEY (patient_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

