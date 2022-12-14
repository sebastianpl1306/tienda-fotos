CREATE DATABASE tienda_virtual;

CREATE TABLE cliente(
    id SERIAL NOT NULL,
    nombre VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    clave VARCHAR NOT NULL,
    activo BOOLEAN NOT NULL,
    primary key(id)
);

INSERT INTO cliente(nombre, email, clave, activo) VALUES('pepito perez', 'cliente@gmail.com', '123', true);

CREATE TABLE admin(
    id SERIAL NOT NULL,
    nombre VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    clave VARCHAR NOT NULL,
    activo BOOLEAN NOT NULL,
    primary key(id)
);

INSERT INTO admin(nombre, email, clave, activo) VALUES('sebastian admin', 'admin@gmail.com', '123', true);
INSERT INTO admin(nombre, email, clave, activo) VALUES('sebastian admin 2', 'admin2@gmail.com', '12345', true);

CREATE TABLE foto(
    id SERIAL NOT NULL,
    titulo VARCHAR NOT NULL,
    descripcion VARCHAR NOT NULL,
    ruta VARCHAR NOT NULL,
    precio smallint NOT NULL,
    activa BOOLEAN NOT NULL,
    primary key(id)
);

INSERT INTO foto(titulo, descripcion, ruta, precio,activa) VALUES('Chica desconocida','¿pero quien es ella?','img1.jpg',3500,true);
INSERT INTO foto(titulo, descripcion, ruta, precio,activa) VALUES('Collage','Mira todo eso','img2.jpg',1500,true);

CREATE TABLE orden_de_compra(
    id SERIAL NOT NULL,
    titulo VARCHAR NOT NULL,
    descripcion VARCHAR NOT NULL,
    ruta VARCHAR NOT NULL,
    activa BOOLEAN NOT NULL,
    primary key(id)
);

CREATE TABLE carro_compra(
    id SERIAL NOT NULL,
    cliente_id INT NOT NULL,
    foto_id INT NOT NULL,
    primary key(id)
);

ALTER TABLE carro_compra ADD
	CONSTRAINT fk_carro_compra_has_foto
	FOREIGN KEY (foto_id)
	REFERENCES foto(id);

ALTER TABLE carro_compra ADD
	CONSTRAINT fk_carro_compra_has_cliente
	FOREIGN KEY (cliente_id)
	REFERENCES cliente(id);

CREATE TABLE orden(
    id SERIAL NOT NULL,
    fecha DATE NOT NULL,
    cantidad INT NOT NULL,
    total smallint NOT NULL,
    cliente_id INT NOT NULL,
    primary key(id)
);

ALTER TABLE orden ADD
	CONSTRAINT fk_orden_has_cliente
	FOREIGN KEY (cliente_id)
	REFERENCES cliente(id);

CREATE TABLE orden_detalle(
    id SERIAL NOT NULL,
    foto_id INT NOT NULL,
    orden_id INT NOT NULL,
    primary key(id)
);

ALTER TABLE orden_detalle ADD
	CONSTRAINT fk_orden_detalle_has_foto
	FOREIGN KEY (foto_id)
	REFERENCES foto(id);

ALTER TABLE orden_detalle ADD
	CONSTRAINT fk_orden_detalle_has_orden
	FOREIGN KEY (orden_id)
	REFERENCES orden(id);

CREATE TABLE deseados(
    id SERIAL NOT NULL,
    cliente_id INT NOT NULL,
    foto_id INT NOT NULL,
    primary key(id)
);

ALTER TABLE deseados ADD
	CONSTRAINT fk_deseados_has_foto
	FOREIGN KEY (foto_id)
	REFERENCES foto(id);

ALTER TABLE deseados ADD
	CONSTRAINT fk_deseados_has_cliente
	FOREIGN KEY (cliente_id)
	REFERENCES cliente(id);