CREATE TABLE empresas(
  cif CHAR(9) CONSTRAINT cif_pk PRIMARY KEY ,
  nombre VARCHAR(25) CONSTRAINT nombre_uk1 UNIQUE,
  telefono CHAR(9),
  direccion VARCHAR(50)
 );
DROP TABLE empresas;

CREATE TABLE empresas(
  cif CHAR(9) CONSTRAINT cif_pk PRIMARY KEY ,
  nombre VARCHAR(25) CONSTRAINT nombre_uk1 UNIQUE
  CONSTRAINT nombre_nn NOT NULL,
  telefono CHAR(9),
  direccion VARCHAR(50)
 );


CREATE TABLE alumnos(
  dni CHAR(9) CONSTRAINT dni_pk PRIMARY KEY ,
  nombre VARCHAR(50) CONSTRAINT nombre_nn1 NOT NULL ,
  apellido1 VARCHAR(50) CONSTRAINT apellido1_nn2 NOT NULL ,
  apellido2 VARCHAR(50) CONSTRAINT  apellido2_nn3 NOT NULL ,
  direccion VARCHAR(50),
  telefono CHAR(9),
  edad NUMBER(2),
  cif CHAR(9) CONSTRAINT cif_fk REFERENCES empresas (cif)
  );


CREATE TABLE tipos_curso(
  cod_curso CHAR(8) CONSTRAINT cod_curso_pk PRIMARY KEY ,
  titulo VARCHAR(50) CONSTRAINT titulo_uk UNIQUE ,
  duracion NUMBER(3),
  temario CLOB
);

CREATE TABLE profesores(
  dni CHAR(9) CONSTRAINT profesores_pk PRIMARY KEY ,
  nombre VARCHAR(50) CONSTRAINT profesores_nn1 NOT NULL ,
  apellido1 VARCHAR(50) CONSTRAINT profesores_nn2 NOT NULL,
  apellido2 VARCHAR(50) CONSTRAINT profesores_nn3 NOT NULL
);

CREATE TABLE cursos (
  n_cursos NUMBER(3) CONSTRAINT cursos_pk PRIMARY KEY ,
  fecha_inicio TIMESTAMP,
  fecha_fin TIMESTAMP,
  cod_curso CHAR(8) CONSTRAINT curso_fk1 REFERENCES tipos_curso(cod_curso),
    dni_profesor CHAR (9) CONSTRAINT cursos_fk2 REFERENCES  profesores(dni)
);

CREATE TABLE asistir (
  dni CHAR(9) CONSTRAINT asistir_fk1 REFERENCES alumnos(dni),
  n_curso NUMBER(3) CONSTRAINT asistir_fk2 REFERENCES cursos(n_cursos),
  CONSTRAINT asistir_pk PRIMARY KEY (dni, n_curso)
);