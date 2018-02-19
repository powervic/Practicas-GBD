CREATE TABLE equipos(
  id_equipo NUMBER(2) CONSTRAINT equipos_pk PRIMARY KEY ,
  nombre VARCHAR(50) CONSTRAINT equipos_uk1 UNIQUE
  CONSTRAINT equipos_nn1 NOT NULL ,
  estadio VARCHAR(50) CONSTRAINT equipos_uk2 UNIQUE ,
  aforo NUMBER(6),
  ano_fundacion NUMBER(4) ,
  ciudad VARCHAR(50) CONSTRAINT equipos_nn2 NOT NULL
);

CREATE TABLE jugadores(
  id_jugador NUMBER(3) CONSTRAINT jugadores_pk PRIMARY KEY ,
  nombre VARCHAR(50) CONSTRAINT jugadores_nn NOT NULL ,
  fecha_nac DATE ,
  id_equipo NUMBER(2) CONSTRAINT jugadores_fk REFERENCES equipos(id_equipo) ON DELETE SET NULL

);
CREATE TABLE partidos (
  id_equipo_casa NUMBER(2) CONSTRAINT  partidos_fk1 REFERENCES equipos(id_equipo)
    ON DELETE CASCADE,
  id_equipo_fuera NUMBER(2) CONSTRAINT partidos_fk2 REFERENCES equipos(id_equipo)
    ON DELETE CASCADE,
  fecha TIMESTAMP ,
  goles_casa NUMBER(2),
  goles_fuera NUMBER(2),
  observaciones VARCHAR(1000),
  CONSTRAINT partidos_pk PRIMARY KEY (id_equipo_casa,id_equipo_fuera),
  CONSTRAINT partidos_ck1 CHECK(id_equipo_fuera!=id_equipo_casa)
);

CREATE TABLE goles (
  id_equipo_casa NUMBER(2),
  id_equipo_fuera NUMBER(2),
  minutos INTERVAL DAY TO SECOND ,
  descripcion VARCHAR(2000) ,
  id_jugador NUMBER(3) CONSTRAINT goles_fk2 REFERENCES jugadores(id_jugador) ON DELETE CASCADE,
  CONSTRAINT goles_pk PRIMARY KEY (id_equipo_fuera,id_equipo_casa, minutos),
  CONSTRAINT goles_fk1 FOREIGN KEY (id_equipo_casa,id_equipo_fuera)
    REFERENCES partidos(id_equipo_casa,id_equipo_fuera) ON DELETE CASCADE
);

ALTER TABLE equipos MODIFY(
  aforo CONSTRAINT equipos_nn3  NOT NULL,
  estadio CONSTRAINT equipos_nn4  NOT NULL
  );
ALTER TABLE equipos MODIFY ano_fundacion DATE;

ALTER TABLE jugadores DROP CONSTRAINT jugadores_nn;

INSERT INTO equipos (id_equipo, nombre, estadio, aforo, ano_fundacion, ciudad) VALUES (1,'Cascorro F.C' ,'Arenera','4000','1/1/1961','Cascorro de Arriba');
INSERT INTO  equipos(id_equipo, nombre, estadio, aforo, ano_fundacion, ciudad) VALUES (2,'Altetico Matalasleñas', 'Cerro Gálvez','1200','12/03/1970', 'Matalasleñas' );

INSERT INTO jugadores(id_jugador, nombre, fecha_nac, id_equipo) VALUES (1,'Amoribia',to_date('20/01/1990','dd/mm/yyyy'), 1);
INSERT INTO  jugadores(id_jugador, nombre, fecha_nac, id_equipo) VALUES (2,'García del Matalasleñas','',2);
INSERT INTO jugadores (id_jugador, nombre, fecha_nac, id_equipo) VALUES (3,'Pedrosa', to_date ('12/09/1993', 'dd/mm/yyyy'), 1)

INSERT  INTO partidos(id_equipo_casa, id_equipo_fuera, fecha, goles_casa, goles_fuera, observaciones)  VALUES (1,2,'5/11/2016','2', '1', '');
INSERT INTO goles (id_equipo_casa, id_equipo_fuera, minutos, descripcion, id_jugador) VALUES  (1,2, INTERVAL '23:00' MINUTE TO SECOND, 'Falta directa',1);
INSERT INTO goles(id_equipo_casa, id_equipo_fuera, minutos, descripcion, id_jugador) VALUES (1,2, INTERVAL '40:00' MINUTE TO SECOND, 'Penalti', 2);
INSERT INTO goles(id_equipo_casa, id_equipo_fuera, minutos, descripcion, id_jugador) VALUES (1,2, INTERVAL '70:00' MINUTE TO SECOND , 'Gran jugada personal',3)

