CREATE  TABLE puestos(
  cod_puesto NUMBER(2) CONSTRAINT puestos_pk1 PRIMARY KEY ,
  titulo_puesto VARCHAR(25) CONSTRAINT puestos_uk1 UNIQUE
  CONSTRAINT puestos_nn1 NOT NULL,
  salario_min NUMBER(11,2),
  salario_max NUMBER(11,2)
);

CREATE TABLE localizaciones(
  cod_localizacion NUMBER(3) CONSTRAINT localizaciones_pk1 PRIMARY KEY,
  localidad VARCHAR(50) CONSTRAINT localizaciones_nn1 NOT NULL,
  direccion VARCHAR(50),
  cp CHAR(5),
  provincia VARCHAR(25)
);

CREATE TABLE empleados(
  cod_emp NUMBER(4) CONSTRAINT empleados_pk1 PRIMARY KEY ,
  nombre VARCHAR(50) CONSTRAINT empleados_nn1 NOT NULL ,
  apellido1 VARCHAR(50) CONSTRAINT  empleados_nn2 NOT NULL ,
  apellido2 VARCHAR(50) CONSTRAINT  empleados_nn3 NOT NULL ,
  telefono CHAR(9) ,
  direccion VARCHAR(50) ,
  email VARCHAR(50) CONSTRAINT empleados_uk UNIQUE ,
  cod_jefe NUMBER(4) CONSTRAINT empleados_fk1 REFERENCES empleados(cod_emp),
  cod_dep NUMBER(3)
);

CREATE TABLE departamentos (
  cod_dep NUMBER(2) CONSTRAINT departamentos_pk PRIMARY KEY ,
  nombre_dep VARCHAR(25) CONSTRAINT departamentos_uk1 UNIQUE
  CONSTRAINT departamentos_nn1 NOT NULL,
  cod_resp NUMBER(4) CONSTRAINT departamentos_fk1 REFERENCES  empleados(cod_emp),
  cod_loc NUMBER(3) CONSTRAINT departamentos_fk2 REFERENCES localizaciones(cod_localizacion)
);

ALTER TABLE empleados ADD (CONSTRAINT empleados_fk2 FOREIGN KEY (cod_dep) REFERENCES  departamentos(cod_dep));

CREATE TABLE historial(
  cod_puesto NUMBER(2) CONSTRAINT historial_fk1 REFERENCES puestos(cod_puesto),
  cod_emp NUMBER(4) CONSTRAINT historial_fk2 REFERENCES empleados(cod_emp),
  fecha_inicio DATE CONSTRAINT historial_nn1 NOT NULL ,
  fecha_fin DATE ,
  cod_dep NUMBER(3) CONSTRAINT historial_fk3 REFERENCES departamentos(cod_dep),
  salario NUMBER(11,2),
  CONSTRAINT historial_pk PRIMARY KEY (cod_puesto, cod_emp)
);

ALTER TABLE empleados ADD (NIF CHAR(10) CONSTRAINT empleados_nn4 NOT NULL
  CONSTRAINT  empleados_uk2 UNIQUE
  );

ALTER TABLE departamentos DROP UNIQUE (nombre_dep);

ALTER TABLE localizaciones RENAME TO locations;


