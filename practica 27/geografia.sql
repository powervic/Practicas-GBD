CREATE TABLE localidades (
  id_localidad NUMBER(5) CONSTRAINT localidades_pk PRIMARY KEY,
  nombre       VARCHAR(50) CONSTRAINT localidades_nn1 NOT NULL,
  poblacion    NUMBER(8),
  n_provincia  NUMBER(2)   CONSTRAINT localidades_nn2 NOT NULL
);

CREATE TABLE provincias (
  n_provincia NUMBER(2) CONSTRAINT provincias_pk PRIMARY KEY ,
  nombre VARCHAR(25) CONSTRAINT provincias_uk1 UNIQUE
  CONSTRAINT provincias_nn1 NOT NULL ,
  id_capital NUMBER(5) CONSTRAINT provincias_uk2 UNIQUE
  CONSTRAINT provincias_nn2 NOT NULL,
  id_comunidad NUMBER(2) CONSTRAINT provincias_nn3 NOT NULL
);

CREATE TABLE comunidades(
  id_comunidad NUMBER(2) CONSTRAINT comunidades_pk PRIMARY KEY ,
  nombre VARCHAR(25) CONSTRAINT comunidades_uk1 UNIQUE
  CONSTRAINT comunidades_nn1 NOT NULL ,
  id_capital NUMBER(5) CONSTRAINT comunidades_uk2 UNIQUE
  CONSTRAINT comunidades_nn2 NOT NULL ,
  max_provincias NUMBER(1)
);

ALTER TABLE localidades
  ADD CONSTRAINT localidades_fk1 FOREIGN KEY (n_provincia) REFERENCES provincias (n_provincia);

ALTER TABLE provincias
ADD CONSTRAINT provincias_fk1 FOREIGN KEY (id_capital) REFERENCES  localidades(id_localidad);

ALTER TABLE provincias
ADD CONSTRAINT provincias_fk2 FOREIGN KEY (id_comunidad) REFERENCES comunidades(id_comunidad);

ALTER TABLE comunidades
ADD CONSTRAINT comunidades_fk1 FOREIGN KEY  (id_capital) REFERENCES  localidades (id_localidad);