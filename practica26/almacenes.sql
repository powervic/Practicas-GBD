CREATE TABLE tipos_pieza(
  tipo CHAR(2) CONSTRAINT tipos_pieza_pk PRIMARY KEY ,
  descripcion VARCHAR(25) CONSTRAINT tipos_pieza_nn NOT NULL
);

CREATE TABLE empresas(
  cif CHAR(9) CONSTRAINT cif_empresas_pk PRIMARY KEY ,
  nombre VARCHAR(50) CONSTRAINT empresas_uk UNIQUE ,
  telefono CHAR(9) ,
  direccion VARCHAR(50),
  localidad VARCHAR(50),
  provincia VARCHAR(50)
);

CREATE TABLE pedidos (
  n_pedido NUMBER(4) CONSTRAINT pedidos_pk PRIMARY KEY ,
  cif CHAR(9) CONSTRAINT pedidos_nn1 NOT NULL
  CONSTRAINT pedidos_fk REFERENCES empresas(cif),
  fecha TIMESTAMP
);

CREATE TABLE almacenes(
  n_almacen NUMBER(2) CONSTRAINT almacenes_pk PRIMARY KEY ,
  descripcion VARCHAR(1000) CONSTRAINT almacenes_nn NOT NULL ,
  direccion VARCHAR(100)
);

CREATE TABLE piezas (
  tipo CHAR(2) CONSTRAINT piezas_fk REFERENCES tipos_pieza (tipo),
  precio_venta NUMBER(11,4),
  modelo NUMBER(2),
  CONSTRAINT piezas_pk PRIMARY KEY  (tipo, modelo)

);

CREATE TABLE suministros (
  tipo CHAR(2),
  modelo NUMBER(2),
  cif CHAR(9) CONSTRAINT  suministros_fk3 REFERENCES empresas(cif),
  CONSTRAINT suministros_pk PRIMARY KEY (tipo,modelo,cif),
  CONSTRAINT suministros_fk1 FOREIGN KEY (tipo,modelo) REFERENCES piezas (tipo,modelo)
);

CREATE TABLE lineas_pedido(
  tipo CHAR(2) CONSTRAINT lineas_pedido_nn1 NOT NULL ,
  modelo NUMBER(2) CONSTRAINT lineas_pedido_nn2 NOT NULL ,
  n_pedido NUMBER(2) CONSTRAINT lineas_pedido_fk1 REFERENCES pedidos(n_pedido),
  n_linea NUMBER(2),
  cantidad NUMBER(5),
  precio NUMBER(11,4),
  CONSTRAINT lineas_pedido_fk2 FOREIGN KEY (tipo, modelo) REFERENCES piezas(tipo,modelo),
  CONSTRAINT lineas_pedido_pk PRIMARY KEY (n_pedido,n_linea)
);

CREATE TABLE existencias(
  tipo CHAR(2),
  modelo NUMBER(2),
  n_almacen NUMBER(2)  CONSTRAINT existencias_fk2 REFERENCES almacenes(n_almacen),
  cantidad NUMBER(9) CONSTRAINT existencias_nn NOT NULL
  CONSTRAINT existencias_ck CHECK (cantidad>0),
  CONSTRAINT existencias_pk PRIMARY KEY (tipo,modelo,n_almacen),
  CONSTRAINT existencias_fk   FOREIGN KEY (tipo,modelo) REFERENCES piezas(tipo,modelo)
);