DROP DATABASE PI_1_ETL;

CREATE DATABASE IF NOT EXISTS PI_1_ETL;
USE PI_1_ETL;

SELECT @@global.secure_file_priv; -- Para ver la ruta de origen donde poner los csv.

/*Catalogo de funciones y procedimientos*/
SET GLOBAL log_bin_trust_function_creators = 1;
DROP FUNCTION IF EXISTS `UC_Words`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `UC_Words`( str VARCHAR(255) ) RETURNS varchar(255) CHARSET utf8
BEGIN  
  DECLARE c CHAR(1);  
  DECLARE s VARCHAR(255);  
  DECLARE i INT DEFAULT 1;  
  DECLARE bool INT DEFAULT 1;  
  DECLARE punct CHAR(17) DEFAULT ' ()[]{},.-_!@;:?/';  
  SET s = LCASE( str );  
  WHILE i < LENGTH( str ) DO  
     BEGIN  
       SET c = SUBSTRING( s, i, 1 );  
       IF LOCATE( c, punct ) > 0 THEN  
        SET bool = 1;  
      ELSEIF bool=1 THEN  
        BEGIN  
          IF c >= 'a' AND c <= 'z' THEN  
             BEGIN  
               SET s = CONCAT(LEFT(s,i-1),UCASE(c),SUBSTRING(s,i+1));  
               SET bool = 0;  
             END;  
           ELSEIF c >= '0' AND c <= '9' THEN  
            SET bool = 0;  
          END IF;  
        END;  
      END IF;  
      SET i = i+1;  
    END;  
  END WHILE;  
  RETURN s;  
END$$
DELIMITER ;

drop table if exists producto;
create table if not exists producto(
idProducto		varchar(300),
marca			varchar(300),
nombre			varchar(300),
presentacion	varchar(300)
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_spanish_ci;
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\pi_1_producto.csv' 
into table producto 
fields terminated by ',' enclosed by '' escaped by '' 
lines terminated by '\r\n' ignore 1 lines;

drop table if exists sucursal;
create table if not exists sucursal(
idSucursal			varchar(300),
idComercio			varchar(300),
idBandera			varchar(300),
banderaDescripcion	varchar(300),
comercioRazonSocial	varchar(300),
provincia			varchar(300),
localidad			varchar(300),
direccion			varchar(300),
lat					varchar(300),
lng					varchar(300),
sucursalNombre		varchar(300),
sucursalTipo		varchar(300)
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_spanish_ci;
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\pi_1_sucursal2.csv' 
into table sucursal
fields terminated by ',' enclosed by '' escaped by '' 
lines terminated by '\r\n' ignore 1 lines;

drop tables if exists p_semana_20200413;
create table if not exists p_semana_20200413(
precio			varchar(300),
idProducto		varchar(300),
idSucursal		varchar(300),
semana			varchar(300)
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_spanish_ci;
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\pi_1_ps_20200413.csv' 
into table p_semana_20200413
fields terminated by ',' enclosed by '' escaped by '' 
lines terminated by '\r\n' ignore 1 lines;

drop tables if exists p_semana_20200419;
create table if not exists p_semana_20200419(
precio			varchar(300),
idProducto		varchar(300),
idSucursal		varchar(300),
semana			varchar(300)
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_spanish_ci;
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\pi_1_ps_20200419.csv' 
into table p_semana_20200419
fields terminated by ',' enclosed by '' escaped by '' 
lines terminated by '\r\n' ignore 1 lines;

drop tables if exists p_semana_20200426;
create table if not exists p_semana_20200426(
precio			varchar(300),
idProducto		varchar(300),
idSucursal		varchar(300),
semana			varchar(300)
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_spanish_ci;
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\pi_1_ps_20200426.csv' 
into table p_semana_20200426
fields terminated by ',' enclosed by '' escaped by '' 
lines terminated by '\r\n' ignore 1 lines;

drop tables if exists p_semana_20200503;
create table if not exists p_semana_20200503(
precio			varchar(300),
idProducto		varchar(300),
idSucursal		varchar(300),
semana			varchar(300)
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_spanish_ci;
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\pi_1_ps_20200503.csv' 
into table p_semana_20200503
fields terminated by ',' enclosed by '' escaped by '' 
lines terminated by '\r\n' ignore 1 lines;

drop tables if exists p_semana_20200518;
create table if not exists p_semana_20200518(
precio			varchar(300),
idProducto		varchar(300),
idSucursal		varchar(300),
semana			varchar(300)
) engine=InnoDB default charset=utf8mb4 collate=utf8mb4_spanish_ci;
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\pi_1_ps_20200518.csv' 
into table p_semana_20200518
fields terminated by ',' enclosed by '' escaped by '' 
lines terminated by '\r\n' ignore 1 lines;

drop tables if exists precios;


Select AVG(precio) 
	from precios_semanas p 
    where idSucursal = '9-1-688';