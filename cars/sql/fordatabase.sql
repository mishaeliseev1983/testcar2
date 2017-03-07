



CREATE USER test_user_postrgres WITH password 'test_user_postrgres';

CREATE DATABASE carowner
  WITH OWNER = test_user_postrgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Russian_Russia.1251'
       LC_CTYPE = 'Russian_Russia.1251'
       CONNECTION LIMIT = -1;


CREATE ROLE
GRANT ALL privileges ON DATABASE carowner TO test_user_postrgres;
GRANT

\c carowner

DROP TABLE IF EXISTS public.city;
DROP TABLE IF EXISTS public.owner;
DROP TABLE IF EXISTS public.car;
DROP SEQUENCE IF EXISTS public.global_seq;

CREATE SEQUENCE  public.global_seq START 44;

CREATE TABLE public.city
(
  id integer NOT NULL DEFAULT nextval('global_seq'::regclass),
  name character varying NOT NULL,
  CONSTRAINT city_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE  public.city
  OWNER TO test_user_postrgres;
  
  
CREATE TABLE public.owner
(
  id integer NOT NULL DEFAULT nextval('global_seq'::regclass),
  name character varying NOT NULL,
  surname character varying NOT NULL,
  patronymic character varying NOT NULL,
  id_city integer NOT NULL,
  CONSTRAINT owner_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.owner
  OWNER TO test_user_postrgres;

  
CREATE TABLE public.car
(
  id integer NOT NULL DEFAULT nextval('global_seq'::regclass),
  "number" character varying NOT NULL,
  model character varying,
  id_owner integer NOT NULL,
  CONSTRAINT car_pkey PRIMARY KEY (id),
  CONSTRAINT car_id_owner_fkey FOREIGN KEY (id_owner)
      REFERENCES public.owner (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.car
  OWNER TO test_user_postrgres;
  
  

CREATE TABLE public.users
(
  id integer NOT NULL,
  username character varying NOT NULL,
  password character varying NOT NULL,
  CONSTRAINT id PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.users
  OWNER TO test_user_postrgres;



delete from city;
delete from car;
delete from owner;
delete from users;

ALTER SEQUENCE global_seq RESTART WITH 44;

INSERT INTO city (name)VALUES ('Пермь');
INSERT INTO city (name)VALUES ('Москва');
INSERT INTO city (name)VALUES ('Саратов');
INSERT INTO city (name)VALUES ('Кемеров');
INSERT INTO city (name)VALUES ('Новосибирск');
INSERT INTO city (name)VALUES ('Екатеринбург');
INSERT INTO city (name)VALUES ('Астана');
INSERT INTO city (name)VALUES ('Самара');
INSERT INTO city (name)VALUES ('Тольятти');
INSERT INTO city (name)VALUES ('Тула');
INSERT INTO city (name)VALUES ('Нижневартовск');


INSERT INTO owner (name, surname, patronymic, id_city) VALUES ('Виктор', 'Олегов', 'Романович' , 44);
INSERT INTO owner (name, surname, patronymic, id_city) VALUES ('Михаил', 'Романов', 'Семенович' , 45);
INSERT INTO owner (name, surname, patronymic, id_city) VALUES ('Кирилл', 'Жук', 'Витальевич' , 46);
INSERT INTO owner (name, surname, patronymic, id_city) VALUES ('Виктор', 'Жуков', 'Романович' , 47);
INSERT INTO owner (name, surname, patronymic, id_city) VALUES ('Виктор', 'Орлов', 'Семенович' , 48);
INSERT INTO owner (name, surname, patronymic, id_city) VALUES ('Виктор', 'Романов', 'Романович' , 49);
INSERT INTO owner (name, surname, patronymic, id_city) VALUES ('Антон', 'Орлов', 'Семенович' , 50);
INSERT INTO owner (name, surname, patronymic, id_city) VALUES ('Закир', 'Олегов', 'Витальевич' , 51);
INSERT INTO owner (name, surname, patronymic, id_city) VALUES ('Зураб', 'Комар', 'Семенович' , 51);
INSERT INTO owner (name, surname, patronymic, id_city) VALUES ('Абдурахмон', 'Рамаманов', 'Семенович' , 51);
INSERT INTO owner (name, surname, patronymic, id_city) VALUES ('Виктор', 'Жов', 'Семенович' , 51);



INSERT INTO car (number, model, id_owner) VALUES ('С136XР', 'KIA CEED', 55);
INSERT INTO car (number, model, id_owner) VALUES ('С246УУ', 'KIA RIO', 58);
INSERT INTO car (number, model, id_owner) VALUES ('О356УX', 'BMW X3', 59);
INSERT INTO car (number, model, id_owner) VALUES ('О466ОУ', 'LADA PRIORA', 57);
INSERT INTO car (number, model, id_owner) VALUES ('С576УУ', 'LADA GRANTA', 55);
INSERT INTO car (number, model, id_owner) VALUES ('T686ТУ', 'VW POLO', 56);
INSERT INTO car (number, model, id_owner) VALUES ('T496УУ', 'VW JETTA', 56);
INSERT INTO car (number, model, id_owner) VALUES ('С556TУ', 'NISSAN TEANA', 56);
INSERT INTO car (number, model, id_owner) VALUES ('С466УX', 'AUDI A6', 64);
INSERT INTO car (number, model, id_owner) VALUES ('С663XX', 'MAZDA CX-5', 62);
INSERT INTO car (number, model, id_owner) VALUES ('О116TУ', 'KIA CEED', 63);
INSERT INTO car (number, model, id_owner) VALUES ('С456XУ', 'KIA CEED', 60);


INSERT INTO users (id, username, password) VALUES (1, 'u1', 'u1');
INSERT INTO users (id, username, password) VALUES (2, 'u', 'u');
INSERT INTO users (id, username, password) VALUES (3, 'q', 'q');
INSERT INTO users (id, username, password) VALUES (4, 'u4', 'u4');
INSERT INTO users (id, username, password) VALUES (5, 'u5', 'u5');
INSERT INTO users (id, username, password) VALUES (6, 'u6', 'u6');
INSERT INTO users (id, username, password) VALUES (7, 'u7', 'u7');
INSERT INTO users (id, username, password) VALUES (8, 'u8', 'u8');
INSERT INTO users (id, username, password) VALUES (9, 'u9', 'u9');
INSERT INTO users (id, username, password) VALUES (10, 'u10', 'u10');

COMMIT;