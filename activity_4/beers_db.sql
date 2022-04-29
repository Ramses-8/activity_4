CREATE DATABASE beers
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Mexico.1252'
    LC_CTYPE = 'Spanish_Mexico.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	

-- Table: public.accounts	
	
CREATE TABLE IF NOT EXISTS public.accounts
(
    account_id integer NOT NULL DEFAULT nextval('accounts_account_id_seq'::regclass),
    amount numeric(12,2) NOT NULL,
    name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT accounts_pkey PRIMARY KEY (account_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.accounts
    OWNER to postgres;
	
	
-- Table: public.beers

CREATE TABLE IF NOT EXISTS public.beers
(
    beer_id integer NOT NULL DEFAULT nextval('beers_beer_id_seq'::regclass),
    name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    price numeric(4,2) NOT NULL,
    CONSTRAINT beers_pkey PRIMARY KEY (beer_id),
    CONSTRAINT "Unq_name" UNIQUE (name)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.beers
    OWNER to postgres;


-- Table: public.bills

CREATE TABLE IF NOT EXISTS public.bills
(
    sale_id uuid NOT NULL,
    beer_id integer NOT NULL,
    CONSTRAINT fk_bills_beer_id FOREIGN KEY (beer_id)
        REFERENCES public.beers (beer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_bills_sale_id FOREIGN KEY (sale_id)
        REFERENCES public.sales (sale_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.bills
    OWNER to postgres;	



-- Table: public.notes

CREATE TABLE IF NOT EXISTS public.notes
(
    beer_id integer NOT NULL DEFAULT nextval('notes_beer_id_seq'::regclass),
    note character varying(2000) COLLATE pg_catalog."default",
    CONSTRAINT fk_notes__beer_id FOREIGN KEY (beer_id)
        REFERENCES public.beers (beer_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.notes
    OWNER to postgres;
	

-- Table: public.sales

CREATE TABLE IF NOT EXISTS public.sales
(
    sale_id uuid NOT NULL,
    sale_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT sales_pkey PRIMARY KEY (sale_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.sales
    OWNER to postgres;
	

-- Type: sale

CREATE TYPE public.sale AS
(
	sale_id uuid,
	sale_date timestamp with time zone,
	account_id integer,
	out_status character varying(50)
);

ALTER TYPE public.sale
    OWNER TO postgres;
	
	
