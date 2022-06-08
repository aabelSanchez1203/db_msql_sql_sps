CREATE DATABASE pruebas_dp


USE pruebas_dp

CREATE TABLE addresses(
calle varchar(30),
numero varchar(8),
colonia varchar(30),
id varchar(8)
);

CREATE TABLE distributors(
id varchar(8),
fecharegistro date
);

CREATE TABLE persons(
nombre varchar(30),
appaterno varchar(30),
apmaterno varchar(30),
id varchar(8)
);

CREATE PROCEDURE PROC_AGREGARDISTRIBUIDOR (  @id VARCHAR(8),@fecharegistro date, @nombre varchar(30), @appaterno varchar(30), @apmaterno varchar(30),
@calle varchar(50),  @numero varchar(7), @colonia varchar(50))

AS

	
BEGIN

	INSERT INTO addresses(calle, numero, colonia,id)
	VALUES(@calle,@numero, @colonia, @id );

	INSERT INTO distributors(id, fecharegistro)
	VALUES(@id,@fecharegistro);

	INSERT INTO persons(nombre,appaterno, apmaterno, id)
	VALUES(@nombre, @appaterno, @apmaterno, @id);
	

END