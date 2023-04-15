create database DBcarrito3
use DBcarrito3

CREATE TABLE USUARIO(
IdUsuario int primary key identity,
Nombres varchar(100),
Apellidos varchar(100),
Numero_de_doc varchar(100),
Telefono varchar(100),
Numero_Cuenta varchar(100),
Salario varchar(100),
Correo varchar(100),
Clave varchar(100),
Restablecer bit default 1,
Activo bit default 1,
)

create proc sp_Resgistrarusauario(
	
	@Nombre varchar(100),
	@Apellidos varchar(100),
	@Correo varchar(100),
	@Clave varchar(100),
	@Activo bit,
       @Mensaje varchar (100) output,
       @Resulatado bit output,
	@Numero_de_doc varchar(100),
	@Telefono varchar(100),
	@Numero_Cuenta varchar(100),
	@Salario varchar(100)
)
as
begin 
	set @Resulatado = 0
	
	if not EXISTS (SELECT * from USUARIO where Correo = @Correo)
	begin
		
		insert into USUARIO( Nombres, Apellidos, Correo, Clave, Activo, Numero_de_doc, Telefono, Numero_Cuenta, Salario) 
		values            ( @Nombre, @Apellidos, @Correo, @Clave, @Activo, @Numero_de_doc, @Telefono, @Numero_Cuenta, @Salario)

		SET @Resulatado = SCOPE_IDENTITY()
	end 
	else 
		SET @Mensaje = 'El correo del usuario ya existe '
end

CREATE PROCEDURE sp_EditarUsuario2
(
    @IdUsuario int,
    @Nombres varchar(100),
    @Apellidos varchar(100),
    @Numero_de_doc varchar(100),
    @Telefono varchar(12),
    @Numero_Cuenta varchar(100),
    @Salario varchar(100),
    @Correo varchar(100),
    
    @Activo bit = 1,
	@Mensaje varchar (100) output,
       @Resulatado bit output
)
AS
BEGIN
set @Resulatado = 0

if not EXISTS (SELECT * from USUARIO where Correo = @Correo and IdUsuario != @IdUsuario)

BEGIN


    UPDATE top (1)USUARIO 
    SET Nombres = @Nombres,
        Apellidos = @Apellidos,
        Correo = @Correo,
        Activo =@Activo,
        Numero_de_doc = @Numero_de_doc,
        Telefono = @Telefono,
        Numero_Cuenta = @Numero_Cuenta,
        Salario = @Salario
        
        
    WHERE IdUsuario = @IdUsuario
set @Resulatado = 1
END
else
set @Mensaje = 'El correo del usuario ya existe'
end




SELECT * FROM USUARIO