--
-- PostgreSQL database dump
--

-- Dumped from database version 15.0
-- Dumped by pg_dump version 15.0

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
-- Name: admin; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin (
    id integer NOT NULL,
    nombre character varying NOT NULL,
    email character varying NOT NULL,
    clave character varying NOT NULL,
    activo boolean NOT NULL
);


--
-- Name: admin_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_id_seq OWNED BY public.admin.id;


--
-- Name: carro_compra; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.carro_compra (
    id integer NOT NULL,
    cliente_id integer NOT NULL,
    foto_id integer NOT NULL
);


--
-- Name: carro_compra_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.carro_compra_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: carro_compra_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.carro_compra_id_seq OWNED BY public.carro_compra.id;


--
-- Name: cliente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cliente (
    id integer NOT NULL,
    nombre character varying NOT NULL,
    email character varying NOT NULL,
    clave character varying NOT NULL,
    activo boolean NOT NULL
);


--
-- Name: cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cliente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cliente_id_seq OWNED BY public.cliente.id;


--
-- Name: deseados; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.deseados (
    id integer NOT NULL,
    cliente_id integer NOT NULL,
    foto_id integer NOT NULL
);


--
-- Name: deseados_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.deseados_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deseados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.deseados_id_seq OWNED BY public.deseados.id;


--
-- Name: foto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.foto (
    id integer NOT NULL,
    titulo character varying NOT NULL,
    descripcion character varying NOT NULL,
    ruta character varying NOT NULL,
    precio smallint NOT NULL,
    activa boolean NOT NULL
);


--
-- Name: foto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.foto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: foto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.foto_id_seq OWNED BY public.foto.id;


--
-- Name: orden; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orden (
    id integer NOT NULL,
    fecha date NOT NULL,
    cantidad integer NOT NULL,
    total smallint NOT NULL,
    cliente_id integer NOT NULL
);


--
-- Name: orden_de_compra; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orden_de_compra (
    id integer NOT NULL,
    titulo character varying NOT NULL,
    descripcion character varying NOT NULL,
    ruta character varying NOT NULL,
    activa boolean NOT NULL
);


--
-- Name: orden_de_compra_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orden_de_compra_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orden_de_compra_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orden_de_compra_id_seq OWNED BY public.orden_de_compra.id;


--
-- Name: orden_detalle; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orden_detalle (
    id integer NOT NULL,
    foto_id integer NOT NULL,
    orden_id integer NOT NULL
);


--
-- Name: orden_detalle_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orden_detalle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orden_detalle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orden_detalle_id_seq OWNED BY public.orden_detalle.id;


--
-- Name: orden_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orden_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orden_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orden_id_seq OWNED BY public.orden.id;


--
-- Name: admin id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin ALTER COLUMN id SET DEFAULT nextval('public.admin_id_seq'::regclass);


--
-- Name: carro_compra id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carro_compra ALTER COLUMN id SET DEFAULT nextval('public.carro_compra_id_seq'::regclass);


--
-- Name: cliente id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cliente ALTER COLUMN id SET DEFAULT nextval('public.cliente_id_seq'::regclass);


--
-- Name: deseados id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deseados ALTER COLUMN id SET DEFAULT nextval('public.deseados_id_seq'::regclass);


--
-- Name: foto id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.foto ALTER COLUMN id SET DEFAULT nextval('public.foto_id_seq'::regclass);


--
-- Name: orden id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orden ALTER COLUMN id SET DEFAULT nextval('public.orden_id_seq'::regclass);


--
-- Name: orden_de_compra id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orden_de_compra ALTER COLUMN id SET DEFAULT nextval('public.orden_de_compra_id_seq'::regclass);


--
-- Name: orden_detalle id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orden_detalle ALTER COLUMN id SET DEFAULT nextval('public.orden_detalle_id_seq'::regclass);


--
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin (id, nombre, email, clave, activo) FROM stdin;
2	sebastian admin 2	admin2@gmail.com	12345	t
1	sebastian admin	admin@gmail.com	123	t
\.


--
-- Data for Name: carro_compra; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.carro_compra (id, cliente_id, foto_id) FROM stdin;
\.


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cliente (id, nombre, email, clave, activo) FROM stdin;
1	pepito perez	cliente@gmail.com	123	t
\.


--
-- Data for Name: deseados; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.deseados (id, cliente_id, foto_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: foto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.foto (id, titulo, descripcion, ruta, precio, activa) FROM stdin;
1	Chica desconocida	¿pero quien es ella?	img1.jpg	3500	t
2	Collage	Mira todo eso	img2.jpg	1500	t
\.


--
-- Data for Name: orden; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orden (id, fecha, cantidad, total, cliente_id) FROM stdin;
1	2022-11-15	1	3500	1
\.


--
-- Data for Name: orden_de_compra; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orden_de_compra (id, titulo, descripcion, ruta, activa) FROM stdin;
\.


--
-- Data for Name: orden_detalle; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orden_detalle (id, foto_id, orden_id) FROM stdin;
1	1	1
\.


--
-- Name: admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_id_seq', 3, true);


--
-- Name: carro_compra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.carro_compra_id_seq', 1, true);


--
-- Name: cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cliente_id_seq', 1, true);


--
-- Name: deseados_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.deseados_id_seq', 1, true);


--
-- Name: foto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.foto_id_seq', 2, true);


--
-- Name: orden_de_compra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orden_de_compra_id_seq', 1, false);


--
-- Name: orden_detalle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orden_detalle_id_seq', 1, true);


--
-- Name: orden_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orden_id_seq', 1, true);


--
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id);


--
-- Name: carro_compra carro_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carro_compra
    ADD CONSTRAINT carro_compra_pkey PRIMARY KEY (id);


--
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);


--
-- Name: deseados deseados_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deseados
    ADD CONSTRAINT deseados_pkey PRIMARY KEY (id);


--
-- Name: foto foto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.foto
    ADD CONSTRAINT foto_pkey PRIMARY KEY (id);


--
-- Name: orden_de_compra orden_de_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orden_de_compra
    ADD CONSTRAINT orden_de_compra_pkey PRIMARY KEY (id);


--
-- Name: orden_detalle orden_detalle_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orden_detalle
    ADD CONSTRAINT orden_detalle_pkey PRIMARY KEY (id);


--
-- Name: orden orden_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orden
    ADD CONSTRAINT orden_pkey PRIMARY KEY (id);


--
-- Name: carro_compra fk_carro_compra_has_cliente; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carro_compra
    ADD CONSTRAINT fk_carro_compra_has_cliente FOREIGN KEY (cliente_id) REFERENCES public.cliente(id);


--
-- Name: carro_compra fk_carro_compra_has_foto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carro_compra
    ADD CONSTRAINT fk_carro_compra_has_foto FOREIGN KEY (foto_id) REFERENCES public.foto(id);


--
-- Name: deseados fk_deseados_has_cliente; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deseados
    ADD CONSTRAINT fk_deseados_has_cliente FOREIGN KEY (cliente_id) REFERENCES public.cliente(id);


--
-- Name: deseados fk_deseados_has_foto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deseados
    ADD CONSTRAINT fk_deseados_has_foto FOREIGN KEY (foto_id) REFERENCES public.foto(id);


--
-- Name: orden_detalle fk_orden_detalle_has_foto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orden_detalle
    ADD CONSTRAINT fk_orden_detalle_has_foto FOREIGN KEY (foto_id) REFERENCES public.foto(id);


--
-- Name: orden_detalle fk_orden_detalle_has_orden; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orden_detalle
    ADD CONSTRAINT fk_orden_detalle_has_orden FOREIGN KEY (orden_id) REFERENCES public.orden(id);


--
-- Name: orden fk_orden_has_cliente; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orden
    ADD CONSTRAINT fk_orden_has_cliente FOREIGN KEY (cliente_id) REFERENCES public.cliente(id);


--
-- PostgreSQL database dump complete
--

