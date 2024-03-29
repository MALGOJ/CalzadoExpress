USE [master]
GO
/****** Object:  Database [DB_zapateria]    Script Date: 21/02/2024 12:28:38 p. m. ******/
CREATE DATABASE [DB_zapateria]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_zapateria_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\DB_zapateria.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DB_zapateria_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\DB_zapateria.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DB_zapateria] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_zapateria].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DB_zapateria] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB_zapateria] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB_zapateria] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB_zapateria] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB_zapateria] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB_zapateria] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DB_zapateria] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB_zapateria] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB_zapateria] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB_zapateria] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DB_zapateria] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB_zapateria] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB_zapateria] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB_zapateria] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB_zapateria] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DB_zapateria] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB_zapateria] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DB_zapateria] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DB_zapateria] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB_zapateria] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB_zapateria] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB_zapateria] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DB_zapateria] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DB_zapateria] SET  MULTI_USER 
GO
ALTER DATABASE [DB_zapateria] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DB_zapateria] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DB_zapateria] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DB_zapateria] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DB_zapateria] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DB_zapateria] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DB_zapateria] SET QUERY_STORE = OFF
GO
USE [DB_zapateria]
GO
/****** Object:  UserDefinedFunction [dbo].[funConcatenarNombre]    Script Date: 21/02/2024 12:28:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<UNIVERSIDAD DE CUNDINAMARCA,,MANUEL GOMEZ>
-- Create date: <28 DE ABRIL DE 2022>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[funConcatenarNombre]
(
	@IdPersona smallint
)
RETURNS varchar(85)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @NombreCompleto varchar(85)

	-- Add the T-SQL statements to compute the return value here
	SELECT @NombreCompleto = ISNULL(Personas.PrimerNombre,'')+' '+ ISNULL(Personas.SegundoNombre,'')+' '+ISNULL(Personas.PrimerApellido,'')+' '+ISNULL(Personas.SegundoApellido,'')+' - '+ISNULL(Personas.NumeroIdentificacion,'')

	FROM Personas

	WHERE Personas.IdPersona = @IdPersona

	-- Return the result of the function

	RETURN RTRIM(LTRIM(@NombreCompleto))

END
GO
/****** Object:  Table [dbo].[Personas]    Script Date: 21/02/2024 12:28:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas](
	[IdPersona] [smallint] IDENTITY(1,1) NOT NULL,
	[IdTipoIdentificacion] [tinyint] NOT NULL,
	[NumeroIdentificacion] [varchar](20) NOT NULL,
	[PrimerNombre] [varchar](20) NOT NULL,
	[SegundoNombre] [varchar](20) NULL,
	[PrimerApellido] [varchar](20) NOT NULL,
	[SegundoApellido] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ventas]    Script Date: 21/02/2024 12:28:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ventas](
	[IdVenta] [smallint] IDENTITY(1,1) NOT NULL,
	[IdColaborador] [smallint] NOT NULL,
	[IdCalzado] [smallint] NOT NULL,
	[Cantidad] [smallint] NOT NULL,
	[Fecha] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Colaboradores]    Script Date: 21/02/2024 12:28:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Colaboradores](
	[IdPersona] [smallint] NOT NULL,
	[IdTipoCargo] [tinyint] NOT NULL,
 CONSTRAINT [PK__Colabora__2EC8D2ACC10B47F3] PRIMARY KEY CLUSTERED 
(
	[IdPersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_VentasPorColaborador]    Script Date: 21/02/2024 12:28:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_VentasPorColaborador] as

SELECT	
	Ventas.IdColaborador
	,dbo.funConcatenarNombre(Personas.IdPersona) Nombre_Identificacion
	,COUNT(Ventas.IdColaborador) as cantidaVentas

	FROM Colaboradores
	inner join Personas on Colaboradores.IdPersona = Personas.IdPersona
	LEFT JOIN Ventas ON Colaboradores.IdPersona = Ventas.IdColaborador 
	GROUP BY
	Personas.IdPersona
	,Ventas.IdColaborador
GO
/****** Object:  Table [dbo].[Calzados]    Script Date: 21/02/2024 12:28:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Calzados](
	[IdCalzado] [smallint] IDENTITY(1,1) NOT NULL,
	[IdCliente] [smallint] NOT NULL,
	[IdTipoCalzado] [smallint] NOT NULL,
	[IdMarca] [smallint] NOT NULL,
	[IdTalla] [smallint] NOT NULL,
	[IdColor] [smallint] NOT NULL,
	[IdGenero] [smallint] NOT NULL,
	[Modelo] [varchar](50) NOT NULL,
	[Disponible] [nchar](25) NULL,
	[Precio] [varchar](15) NOT NULL,
 CONSTRAINT [PK__Calzados__E89AC7E9FDF6E610] PRIMARY KEY CLUSTERED 
(
	[IdCalzado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 21/02/2024 12:28:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[IdPersona] [smallint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Colores]    Script Date: 21/02/2024 12:28:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Colores](
	[IdColor] [smallint] IDENTITY(1,1) NOT NULL,
	[Color] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdColor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Generos]    Script Date: 21/02/2024 12:28:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Generos](
	[IdGenero] [smallint] IDENTITY(1,1) NOT NULL,
	[Genero] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdGenero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Marcas]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marcas](
	[IdMarca] [smallint] IDENTITY(1,1) NOT NULL,
	[NombreMarca] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMarca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MarcasXTiposCalzados]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MarcasXTiposCalzados](
	[IdMarca] [smallint] NOT NULL,
	[IdTipo] [smallint] NOT NULL,
	[DemandaComercial] [varchar](10) NOT NULL,
 CONSTRAINT [PK_MarcasXTiposCalzados] PRIMARY KEY CLUSTERED 
(
	[IdMarca] ASC,
	[IdTipo] ASC,
	[DemandaComercial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TallasCalzados]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TallasCalzados](
	[IdTalla] [smallint] NOT NULL,
	[Talla] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTalla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposCalzados]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposCalzados](
	[IdTipo] [smallint] IDENTITY(1,1) NOT NULL,
	[TipoCalzado] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposCargos]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposCargos](
	[IdTipo] [tinyint] IDENTITY(1,1) NOT NULL,
	[Cargo] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TiposIdentificacion]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TiposIdentificacion](
	[IdTipoIdentificacion] [tinyint] IDENTITY(1,1) NOT NULL,
	[NombreIdentificacion] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTipoIdentificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[IdPersona] [smallint] NOT NULL,
	[Email] [varchar](80) NOT NULL,
	[contraseña] [varchar](200) NULL,
	[FechaRegistro] [datetime] NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[IdPersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Calzados] ON 

INSERT [dbo].[Calzados] ([IdCalzado], [IdCliente], [IdTipoCalzado], [IdMarca], [IdTalla], [IdColor], [IdGenero], [Modelo], [Disponible], [Precio]) VALUES (1, 1, 1, 1, 4, 1, 2, N'Air Max 90', N'95                       ', N'450000')
INSERT [dbo].[Calzados] ([IdCalzado], [IdCliente], [IdTipoCalzado], [IdMarca], [IdTalla], [IdColor], [IdGenero], [Modelo], [Disponible], [Precio]) VALUES (2, 1, 2, 2, 4, 2, 1, N'Superstar', N'150                      ', N'300000')
INSERT [dbo].[Calzados] ([IdCalzado], [IdCliente], [IdTipoCalzado], [IdMarca], [IdTalla], [IdColor], [IdGenero], [Modelo], [Disponible], [Precio]) VALUES (3, 2, 17, 3, 3, 3, 3, N'UA HOVR Phantom 2 ', N'100                      ', N'359000')
INSERT [dbo].[Calzados] ([IdCalzado], [IdCliente], [IdTipoCalzado], [IdMarca], [IdTalla], [IdColor], [IdGenero], [Modelo], [Disponible], [Precio]) VALUES (5, 2, 2, 2, 3, 1, 1, N'CoMFyCush', N'150                      ', N'359000')
SET IDENTITY_INSERT [dbo].[Calzados] OFF
GO
INSERT [dbo].[Clientes] ([IdPersona]) VALUES (1)
INSERT [dbo].[Clientes] ([IdPersona]) VALUES (2)
INSERT [dbo].[Clientes] ([IdPersona]) VALUES (3)
INSERT [dbo].[Clientes] ([IdPersona]) VALUES (4)
INSERT [dbo].[Clientes] ([IdPersona]) VALUES (5)
GO
INSERT [dbo].[Colaboradores] ([IdPersona], [IdTipoCargo]) VALUES (1, 1)
INSERT [dbo].[Colaboradores] ([IdPersona], [IdTipoCargo]) VALUES (2, 2)
INSERT [dbo].[Colaboradores] ([IdPersona], [IdTipoCargo]) VALUES (3, 2)
INSERT [dbo].[Colaboradores] ([IdPersona], [IdTipoCargo]) VALUES (4, 3)
INSERT [dbo].[Colaboradores] ([IdPersona], [IdTipoCargo]) VALUES (5, 4)
GO
SET IDENTITY_INSERT [dbo].[Colores] ON 

INSERT [dbo].[Colores] ([IdColor], [Color]) VALUES (1, N'Negro')
INSERT [dbo].[Colores] ([IdColor], [Color]) VALUES (2, N'Blanco')
INSERT [dbo].[Colores] ([IdColor], [Color]) VALUES (3, N'Café')
INSERT [dbo].[Colores] ([IdColor], [Color]) VALUES (4, N'Gris')
INSERT [dbo].[Colores] ([IdColor], [Color]) VALUES (5, N'Azul')
INSERT [dbo].[Colores] ([IdColor], [Color]) VALUES (6, N'Rosado')
SET IDENTITY_INSERT [dbo].[Colores] OFF
GO
SET IDENTITY_INSERT [dbo].[Generos] ON 

INSERT [dbo].[Generos] ([IdGenero], [Genero]) VALUES (1, N'Mujer')
INSERT [dbo].[Generos] ([IdGenero], [Genero]) VALUES (2, N'Hombre')
INSERT [dbo].[Generos] ([IdGenero], [Genero]) VALUES (3, N'Unisex')
SET IDENTITY_INSERT [dbo].[Generos] OFF
GO
SET IDENTITY_INSERT [dbo].[Marcas] ON 

INSERT [dbo].[Marcas] ([IdMarca], [NombreMarca]) VALUES (1, N'Nike')
INSERT [dbo].[Marcas] ([IdMarca], [NombreMarca]) VALUES (2, N'Adidas')
INSERT [dbo].[Marcas] ([IdMarca], [NombreMarca]) VALUES (3, N'Under Armour')
INSERT [dbo].[Marcas] ([IdMarca], [NombreMarca]) VALUES (4, N'Skechers')
INSERT [dbo].[Marcas] ([IdMarca], [NombreMarca]) VALUES (5, N'New Balance')
INSERT [dbo].[Marcas] ([IdMarca], [NombreMarca]) VALUES (6, N'ASICS')
INSERT [dbo].[Marcas] ([IdMarca], [NombreMarca]) VALUES (7, N'Puma')
INSERT [dbo].[Marcas] ([IdMarca], [NombreMarca]) VALUES (8, N'Reebok')
INSERT [dbo].[Marcas] ([IdMarca], [NombreMarca]) VALUES (9, N'Vans')
INSERT [dbo].[Marcas] ([IdMarca], [NombreMarca]) VALUES (10, N'Rockport')
INSERT [dbo].[Marcas] ([IdMarca], [NombreMarca]) VALUES (11, N'Hey Dude')
INSERT [dbo].[Marcas] ([IdMarca], [NombreMarca]) VALUES (12, N'Pikolinos')
INSERT [dbo].[Marcas] ([IdMarca], [NombreMarca]) VALUES (13, N'Martinelli')
INSERT [dbo].[Marcas] ([IdMarca], [NombreMarca]) VALUES (14, N'Christian Louboutin')
INSERT [dbo].[Marcas] ([IdMarca], [NombreMarca]) VALUES (15, N'Aquazzura')
INSERT [dbo].[Marcas] ([IdMarca], [NombreMarca]) VALUES (16, N'Timberland')
SET IDENTITY_INSERT [dbo].[Marcas] OFF
GO
INSERT [dbo].[MarcasXTiposCalzados] ([IdMarca], [IdTipo], [DemandaComercial]) VALUES (1, 1, N'3.90%')
INSERT [dbo].[MarcasXTiposCalzados] ([IdMarca], [IdTipo], [DemandaComercial]) VALUES (2, 1, N'6.20%')
INSERT [dbo].[MarcasXTiposCalzados] ([IdMarca], [IdTipo], [DemandaComercial]) VALUES (3, 1, N'9.50%')
GO
SET IDENTITY_INSERT [dbo].[Personas] ON 

INSERT [dbo].[Personas] ([IdPersona], [IdTipoIdentificacion], [NumeroIdentificacion], [PrimerNombre], [SegundoNombre], [PrimerApellido], [SegundoApellido]) VALUES (1, 1, N'83863822', N'Vivian ', N'Carolina', N'Gomez ', N'Duarte')
INSERT [dbo].[Personas] ([IdPersona], [IdTipoIdentificacion], [NumeroIdentificacion], [PrimerNombre], [SegundoNombre], [PrimerApellido], [SegundoApellido]) VALUES (2, 1, N'1000121313', N'Paulina', NULL, N'Gomez', N'Duarte')
INSERT [dbo].[Personas] ([IdPersona], [IdTipoIdentificacion], [NumeroIdentificacion], [PrimerNombre], [SegundoNombre], [PrimerApellido], [SegundoApellido]) VALUES (3, 1, N'1145121112', N'Isabell', NULL, N'Gomez', N'Duarte')
INSERT [dbo].[Personas] ([IdPersona], [IdTipoIdentificacion], [NumeroIdentificacion], [PrimerNombre], [SegundoNombre], [PrimerApellido], [SegundoApellido]) VALUES (4, 1, N'765765787', N'Felipe', NULL, N'Gonzales', N'Rojas')
INSERT [dbo].[Personas] ([IdPersona], [IdTipoIdentificacion], [NumeroIdentificacion], [PrimerNombre], [SegundoNombre], [PrimerApellido], [SegundoApellido]) VALUES (5, 1, N'123456789', N'Manuel', N'Alejandro', N'Gomez', N'Jimenez')
INSERT [dbo].[Personas] ([IdPersona], [IdTipoIdentificacion], [NumeroIdentificacion], [PrimerNombre], [SegundoNombre], [PrimerApellido], [SegundoApellido]) VALUES (6, 1, N'78945612', N'Mario', N'Andres', N'Castiblanco', N'Vargas')
SET IDENTITY_INSERT [dbo].[Personas] OFF
GO
INSERT [dbo].[TallasCalzados] ([IdTalla], [Talla]) VALUES (1, 37)
INSERT [dbo].[TallasCalzados] ([IdTalla], [Talla]) VALUES (2, 38)
INSERT [dbo].[TallasCalzados] ([IdTalla], [Talla]) VALUES (3, 39)
INSERT [dbo].[TallasCalzados] ([IdTalla], [Talla]) VALUES (4, 40)
INSERT [dbo].[TallasCalzados] ([IdTalla], [Talla]) VALUES (5, 41)
INSERT [dbo].[TallasCalzados] ([IdTalla], [Talla]) VALUES (6, 42)
INSERT [dbo].[TallasCalzados] ([IdTalla], [Talla]) VALUES (7, 43)
INSERT [dbo].[TallasCalzados] ([IdTalla], [Talla]) VALUES (8, 44)
GO
SET IDENTITY_INSERT [dbo].[TiposCalzados] ON 

INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (1, N'Sneakers')
INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (2, N'Slip-0n')
INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (3, N'Dockside')
INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (4, N'Desert')
INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (5, N'Chelsea')
INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (6, N'Derby')
INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (7, N'Mocasín')
INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (8, N'Botas')
INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (9, N'Guayos')
INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (10, N'Bota Cuissard')
INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (11, N'slippers')
INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (12, N'Brogues Dama')
INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (13, N'Tacon Stiletto')
INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (14, N'Tacon High heels')
INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (15, N'Escarpines(playa)')
INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (16, N'Sandalias')
INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (17, N'Zapatillas')
INSERT [dbo].[TiposCalzados] ([IdTipo], [TipoCalzado]) VALUES (18, N'Zapatos ciclismo')
SET IDENTITY_INSERT [dbo].[TiposCalzados] OFF
GO
SET IDENTITY_INSERT [dbo].[TiposCargos] ON 

INSERT [dbo].[TiposCargos] ([IdTipo], [Cargo]) VALUES (1, N'Administrador')
INSERT [dbo].[TiposCargos] ([IdTipo], [Cargo]) VALUES (2, N'Vendedor')
INSERT [dbo].[TiposCargos] ([IdTipo], [Cargo]) VALUES (3, N'Gerente')
INSERT [dbo].[TiposCargos] ([IdTipo], [Cargo]) VALUES (4, N'marketing')
SET IDENTITY_INSERT [dbo].[TiposCargos] OFF
GO
SET IDENTITY_INSERT [dbo].[TiposIdentificacion] ON 

INSERT [dbo].[TiposIdentificacion] ([IdTipoIdentificacion], [NombreIdentificacion]) VALUES (1, N'Cedula de Ciudadania')
INSERT [dbo].[TiposIdentificacion] ([IdTipoIdentificacion], [NombreIdentificacion]) VALUES (2, N'Cedula extranjería')
INSERT [dbo].[TiposIdentificacion] ([IdTipoIdentificacion], [NombreIdentificacion]) VALUES (3, N'Pasaporte')
SET IDENTITY_INSERT [dbo].[TiposIdentificacion] OFF
GO
INSERT [dbo].[Usuarios] ([IdPersona], [Email], [contraseña], [FechaRegistro]) VALUES (5, N'manuelagomez@ucundinamarca.edu.co', N'manuel12345', CAST(N'2024-02-21T12:20:53.707' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Ventas] ON 

INSERT [dbo].[Ventas] ([IdVenta], [IdColaborador], [IdCalzado], [Cantidad], [Fecha]) VALUES (1, 2, 1, 3, CAST(N'2022-07-19' AS Date))
INSERT [dbo].[Ventas] ([IdVenta], [IdColaborador], [IdCalzado], [Cantidad], [Fecha]) VALUES (2, 3, 2, 2, CAST(N'2022-06-30' AS Date))
INSERT [dbo].[Ventas] ([IdVenta], [IdColaborador], [IdCalzado], [Cantidad], [Fecha]) VALUES (3, 2, 3, 1, CAST(N'2022-04-30' AS Date))
INSERT [dbo].[Ventas] ([IdVenta], [IdColaborador], [IdCalzado], [Cantidad], [Fecha]) VALUES (7, 2, 1, 4, CAST(N'2022-08-20' AS Date))
INSERT [dbo].[Ventas] ([IdVenta], [IdColaborador], [IdCalzado], [Cantidad], [Fecha]) VALUES (8, 3, 1, 1, CAST(N'2022-05-30' AS Date))
SET IDENTITY_INSERT [dbo].[Ventas] OFF
GO
ALTER TABLE [dbo].[Usuarios] ADD  CONSTRAINT [DF_Usuarios_FechaRegistro]  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[Ventas] ADD  CONSTRAINT [DF_Ventas_Fecha]  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Calzados]  WITH CHECK ADD  CONSTRAINT [FK_Calzados_Clientes] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clientes] ([IdPersona])
GO
ALTER TABLE [dbo].[Calzados] CHECK CONSTRAINT [FK_Calzados_Clientes]
GO
ALTER TABLE [dbo].[Calzados]  WITH CHECK ADD  CONSTRAINT [FK_Calzados_Colores] FOREIGN KEY([IdColor])
REFERENCES [dbo].[Colores] ([IdColor])
GO
ALTER TABLE [dbo].[Calzados] CHECK CONSTRAINT [FK_Calzados_Colores]
GO
ALTER TABLE [dbo].[Calzados]  WITH CHECK ADD  CONSTRAINT [FK_Calzados_Generos] FOREIGN KEY([IdGenero])
REFERENCES [dbo].[Generos] ([IdGenero])
GO
ALTER TABLE [dbo].[Calzados] CHECK CONSTRAINT [FK_Calzados_Generos]
GO
ALTER TABLE [dbo].[Calzados]  WITH CHECK ADD  CONSTRAINT [FK_Calzados_Marcas] FOREIGN KEY([IdMarca])
REFERENCES [dbo].[Marcas] ([IdMarca])
GO
ALTER TABLE [dbo].[Calzados] CHECK CONSTRAINT [FK_Calzados_Marcas]
GO
ALTER TABLE [dbo].[Calzados]  WITH CHECK ADD  CONSTRAINT [FK_Calzados_TallasCalzados] FOREIGN KEY([IdTalla])
REFERENCES [dbo].[TallasCalzados] ([IdTalla])
GO
ALTER TABLE [dbo].[Calzados] CHECK CONSTRAINT [FK_Calzados_TallasCalzados]
GO
ALTER TABLE [dbo].[Calzados]  WITH CHECK ADD  CONSTRAINT [FK_Calzados_TiposCalzados] FOREIGN KEY([IdTipoCalzado])
REFERENCES [dbo].[TiposCalzados] ([IdTipo])
GO
ALTER TABLE [dbo].[Calzados] CHECK CONSTRAINT [FK_Calzados_TiposCalzados]
GO
ALTER TABLE [dbo].[Clientes]  WITH CHECK ADD  CONSTRAINT [FK_Clientes_Personas] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[Personas] ([IdPersona])
GO
ALTER TABLE [dbo].[Clientes] CHECK CONSTRAINT [FK_Clientes_Personas]
GO
ALTER TABLE [dbo].[Colaboradores]  WITH CHECK ADD  CONSTRAINT [FK_Colaboradores_Personas] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[Personas] ([IdPersona])
GO
ALTER TABLE [dbo].[Colaboradores] CHECK CONSTRAINT [FK_Colaboradores_Personas]
GO
ALTER TABLE [dbo].[Colaboradores]  WITH CHECK ADD  CONSTRAINT [FK_Colaboradores_TiposCargos] FOREIGN KEY([IdTipoCargo])
REFERENCES [dbo].[TiposCargos] ([IdTipo])
GO
ALTER TABLE [dbo].[Colaboradores] CHECK CONSTRAINT [FK_Colaboradores_TiposCargos]
GO
ALTER TABLE [dbo].[MarcasXTiposCalzados]  WITH CHECK ADD  CONSTRAINT [FK_MarcasXTiposCalzados_Marcas] FOREIGN KEY([IdMarca])
REFERENCES [dbo].[Marcas] ([IdMarca])
GO
ALTER TABLE [dbo].[MarcasXTiposCalzados] CHECK CONSTRAINT [FK_MarcasXTiposCalzados_Marcas]
GO
ALTER TABLE [dbo].[MarcasXTiposCalzados]  WITH CHECK ADD  CONSTRAINT [FK_MarcasXTiposCalzados_TiposCalzados] FOREIGN KEY([IdTipo])
REFERENCES [dbo].[TiposCalzados] ([IdTipo])
GO
ALTER TABLE [dbo].[MarcasXTiposCalzados] CHECK CONSTRAINT [FK_MarcasXTiposCalzados_TiposCalzados]
GO
ALTER TABLE [dbo].[Personas]  WITH CHECK ADD  CONSTRAINT [FK_Personas_TiposIdentificacion] FOREIGN KEY([IdTipoIdentificacion])
REFERENCES [dbo].[TiposIdentificacion] ([IdTipoIdentificacion])
GO
ALTER TABLE [dbo].[Personas] CHECK CONSTRAINT [FK_Personas_TiposIdentificacion]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_Personas] FOREIGN KEY([IdPersona])
REFERENCES [dbo].[Personas] ([IdPersona])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_Personas]
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD  CONSTRAINT [FK_Ventas_Colaboradores] FOREIGN KEY([IdColaborador])
REFERENCES [dbo].[Colaboradores] ([IdPersona])
GO
ALTER TABLE [dbo].[Ventas] CHECK CONSTRAINT [FK_Ventas_Colaboradores]
GO
/****** Object:  StoredProcedure [dbo].[proCalzadosActualizar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Actualizar un registro en la tabla calzados,>
-- =============================================

CREATE PROCEDURE [dbo].[proCalzadosActualizar]
(
	@IdCalzado smallint
	,@IdTipoCalzado smallint
	,@IdTalla smallint
	,@IdColor smallint
	,@IdGenero smallint 
	,@Modelo varchar(50)
	,@Precio varchar(15)
)
AS
BEGIN
	UPDATE Calzados set
	
	
	Calzados.IdTipoCalzado = @IdTipoCalzado
	,Calzados.IdTalla = @IdTalla
	,Calzados.IdColor = @IdColor
	,Calzados.IdGenero = @IdGenero
	,Calzados.Modelo = @Modelo
	,Calzados.Precio = @Precio
	WHERE Calzados.IdCalzado = @IdCalzado
END
GO
/****** Object:  StoredProcedure [dbo].[proCalzadosConsultar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la consulta de los registros en la tabla calzados,>
-- =============================================

CREATE PROCEDURE [dbo].[proCalzadosConsultar]
AS
BEGIN
	SELECT

	Calzados.IdCalzado
	,Calzados.IdTipoCalzado
	,Calzados.IdColor 
	,Calzados.IdGenero
	,TiposCalzados.TipoCalzado
	,Marcas.NombreMarca
	,Calzados.Modelo
	,Colores.Color
	,Generos.Genero
	,Calzados.Precio

	from Calzados
	inner join Marcas on Calzados.IdMarca = Marcas.IdMarca
	inner join TiposCalzados on Calzados.IdTipoCalzado = TiposCalzados.IdTipo
	inner join Colores on Calzados.IdColor = Colores.IdColor
	inner join Generos on Calzados.IdGenero = Generos.IdGenero
	
END
GO
/****** Object:  StoredProcedure [dbo].[proCalzadosConsultarId]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la consulta de un registro en la tabla calzados,>
-- =============================================

CREATE PROCEDURE [dbo].[proCalzadosConsultarId]
(
	@IdCalzado smallint

)
AS
BEGIN
	select 

	Calzados.IdCalzado
	,Calzados.IdTipoCalzado
	,Calzados.IdTalla
	,Calzados.IdColor 
	,Calzados.IdGenero
	,TiposCalzados.TipoCalzado
	,Marcas.NombreMarca
	,Calzados.Modelo
	,Colores.Color
	,Generos.Genero
	,TallasCalzados.Talla
	,Calzados.Precio

	from Calzados 
	inner join Marcas on Calzados.IdMarca = Marcas.IdMarca
	inner join TiposCalzados on Calzados.IdTipoCalzado = TiposCalzados.IdTipo
	inner join Colores on Calzados.IdColor = Colores.IdColor
	inner join Generos on Calzados.IdGenero = Generos.IdGenero
	inner join TallasCalzados on calzados.IdTalla = TallasCalzados.IdTalla
	where Calzados.IdCalzado = @IdCalzado
END
GO
/****** Object:  StoredProcedure [dbo].[proCalzadosEliminar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Eliminar un registro en la tabla calzados,>
-- =============================================

CREATE PROCEDURE [dbo].[proCalzadosEliminar]
(
	@IdCalzado smallint

)
AS
BEGIN
	delete
	from Calzados 
	where IdCalzado = @IdCalzado
END
GO
/****** Object:  StoredProcedure [dbo].[proCalzadosInsertar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Insertar un registro en la tabla calzados,>
-- =============================================

CREATE PROCEDURE [dbo].[proCalzadosInsertar]
(
	@IdCalzado smallint out
	,@IdCliente smallint 	
	,@IdTipoCalzado smallint
	,@IdTalla smallint
	,@IdColor smallint
	,@IdGenero smallint 
	,@Modelo varchar(50)
	,@Precio varchar(15)

)

AS
BEGIN
	insert into Calzados
	(
		IdCliente	
		,IdTipoCalzado
		,IdTalla
		,IdColor
		,IdGenero
		,Modelo
		,Precio
	)
	values
	(
		@IdCliente
		,@IdTipoCalzado
		,@IdTalla
		,@IdColor
		,@IdGenero
		,@Modelo
		,@Precio
	)
	Set @IdCalzado = @@IDENTITY
END
GO
/****** Object:  StoredProcedure [dbo].[proClientesActualizar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la actualizar  un registro en la tabla CLIENTES,>
-- =============================================

CREATE PROCEDURE [dbo].[proClientesActualizar]
(
	@IdPersona smallint
)
AS
BEGIN
	update Clientes set
	Clientes.IdPersona= @IdPersona
	where Clientes.IdPersona= @IdPersona

END
GO
/****** Object:  StoredProcedure [dbo].[proClientesConsultar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la consulta de los registros en la tabla CLIENTES,>
-- =============================================

CREATE PROCEDURE [dbo].[proClientesConsultar]
AS
BEGIN
	SELECT

	Personas.IdPersona
	,Personas.IdTipoIdentificacion
	,dbo.funConcatenarNombre(Personas.IdPersona) Nombre_Identificacion
	,ISNULL(Emails.Email,'No Regristra') AS EMAIL

	FROM Clientes
	inner join Personas on Clientes.IdPersona = Personas.IdPersona
	inner join TiposIdentificacion on Personas.IdTipoIdentificacion = TiposIdentificacion.IdTipoIdentificacion
	left join Emails on Personas.IdPersona = Emails.IdPersona

END
GO
/****** Object:  StoredProcedure [dbo].[proClientesConsultarId]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la consulta de un registro en la tabla CLIENTES,>
-- =============================================

CREATE PROCEDURE [dbo].[proClientesConsultarId]
(
	@IdPersona smallint
)
AS
BEGIN
	SELECT

	Personas.IdPersona
	,Personas.IdTipoIdentificacion
	,dbo.funConcatenarNombre(Personas.IdPersona) Nombre_Identificacion
	,ISNULL(Emails.Email,'No Regristra') AS EMAIL

	FROM Clientes
	inner join Personas on Clientes.IdPersona = Personas.IdPersona
	inner join TiposIdentificacion on Personas.IdTipoIdentificacion = TiposIdentificacion.IdTipoIdentificacion
	left join Emails on Personas.IdPersona = Emails.IdPersona
	WHERE Clientes.IdPersona = @IdPersona

END
GO
/****** Object:  StoredProcedure [dbo].[proClientesEliminar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite ELIMINAR un registro en la tabla CLIENTES,>
-- =============================================

CREATE PROCEDURE [dbo].[proClientesEliminar]
(
	@IdPersona smallint
)
AS
BEGIN
	Delete 
	from Clientes
	Where IdPersona = @IdPersona
END
GO
/****** Object:  StoredProcedure [dbo].[proClientesInsertar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la insert de un registro en la tabla CLIENTES,>
-- =============================================

CREATE PROCEDURE [dbo].[proClientesInsertar]
(
	@IdPersona smallint
)
AS
BEGIN
insert into Clientes
	(
		IdPersona
	)
	values
	(
		@IdPersona
	)

END
GO
/****** Object:  StoredProcedure [dbo].[proColaboradoresActualizar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la Actualizar de un registro en la tabla COLABORADORES,>
-- =============================================

CREATE PROCEDURE [dbo].[proColaboradoresActualizar]
(
	@IdPersona smallint
	,@IdTipoCargo tinyint
	
)
AS
BEGIN
	UPDATE Colaboradores SET 
	Colaboradores.IdTipoCargo = @IdTipoCargo
	where IdPersona = @IdPersona
END
GO
/****** Object:  StoredProcedure [dbo].[proColaboradoresConsultar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la consulta de los registros en la tabla COLABORADORES,>
-- =============================================

CREATE PROCEDURE [dbo].[proColaboradoresConsultar]
AS
BEGIN
	SELECT

	Personas.IdPersona
	,Personas.IdTipoIdentificacion
	,TiposCargos.IdTipo
	,dbo.funConcatenarNombre(Personas.IdPersona) Nombre_Identificacion
	,TiposCargos.Cargo
	,ISNULL(Emails.Email,'No Regristra') AS EMAIL

	FROM Colaboradores
	inner join Personas on Colaboradores.IdPersona = Personas.IdPersona
	inner join TiposIdentificacion on Personas.IdTipoIdentificacion = TiposIdentificacion.IdTipoIdentificacion
	right join TiposCargos on Colaboradores.IdTipoCargo = TiposCargos.IdTipo
	left join Emails on Personas.IdPersona = Emails.IdPersona

END
GO
/****** Object:  StoredProcedure [dbo].[proColaboradoresConsultarId]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la consulta de un registro en la tabla COLABORADORES,>
-- =============================================

CREATE PROCEDURE [dbo].[proColaboradoresConsultarId]
(
	@IdPersona smallint
)
AS
BEGIN
	SELECT

	Personas.IdPersona
	,Personas.IdTipoIdentificacion
	,TiposCargos.IdTipo
	,dbo.funConcatenarNombre(Personas.IdPersona) Nombre_Identificacion
	,TiposCargos.Cargo
	,ISNULL(Emails.Email,'No Regristra') AS EMAIL

	FROM Colaboradores
	inner join Personas on Colaboradores.IdPersona = Personas.IdPersona
	inner join TiposIdentificacion on Personas.IdTipoIdentificacion = TiposIdentificacion.IdTipoIdentificacion
	right join TiposCargos on Colaboradores.IdTipoCargo = TiposCargos.IdTipo
	left join Emails on Personas.IdPersona = Emails.IdPersona
	WHERE Colaboradores.IdPersona = @IdPersona
END
GO
/****** Object:  StoredProcedure [dbo].[proColaboradoresEliminar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la eliminar de un registro en la tabla COLABORADORES,>
-- =============================================

CREATE PROCEDURE [dbo].[proColaboradoresEliminar]
(
	@IdPersona smallint
	 
)
AS
BEGIN
	delete 
	from 
	Colaboradores
	where IdPersona = @IdPersona
END
GO
/****** Object:  StoredProcedure [dbo].[proColaboradoresInsertar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la insertar de un registro en la tabla COLABORADORES,>
-- =============================================

CREATE PROCEDURE [dbo].[proColaboradoresInsertar]
(
	@IdPersona smallint
	,@IdTipoCargo tinyint 
)
AS
BEGIN
	insert into Colaboradores
	(
		IdTipoCargo
	)
	values 
	(
		@IdTipoCargo
	)
END
GO
/****** Object:  StoredProcedure [dbo].[proColoresActualizar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Actualizar un registro en la tabla colores>
-- =============================================

CREATE PROCEDURE [dbo].[proColoresActualizar]
(
	@IdColor smallint 
	,@Color varchar(20)
)
AS
BEGIN
	update Colores set
	Colores.Color= @Color 
	where Colores.IdColor = @IdColor 
END
GO
/****** Object:  StoredProcedure [dbo].[proColoresConsultar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la consulta de los registros en la tabla colores>
-- =============================================

CREATE PROCEDURE [dbo].[proColoresConsultar]
AS
BEGIN
	select 
	Colores.IdColor
	,Colores.Color
	from Colores 
END
GO
/****** Object:  StoredProcedure [dbo].[proColoresConsultarId]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la consulta de un registro en la tabla colores>
-- =============================================

CREATE PROCEDURE [dbo].[proColoresConsultarId]
(
	@IdColor smallint  
)
AS
BEGIN
	select 
	Colores.IdColor
	,Colores.Color
	from Colores 
	where Colores.IdColor = @IdColor 
END
GO
/****** Object:  StoredProcedure [dbo].[proColoresEliminar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Eliminar un registro en la tabla colores>
-- =============================================

CREATE PROCEDURE [dbo].[proColoresEliminar]
(
	@IdColor smallint 
)
AS
BEGIN
	Delete 
	from Colores
	where IdColor= @IdColor
END
GO
/****** Object:  StoredProcedure [dbo].[proColoresInsertar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Insertar un registro en la tabla colores>
-- =============================================

CREATE PROCEDURE [dbo].[proColoresInsertar]
(
	@IdColor smallint out
	,@Color varchar(20)
)
AS
BEGIN
	insert into Colores
	(
		Color
	)
	values
	(
		@Color
	)
	set @IdColor = @@IDENTITY
END
GO
/****** Object:  StoredProcedure [dbo].[proEmailsActualizar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Actualizar un registro en la tabla Emails>
-- =============================================

CREATE PROCEDURE [dbo].[proEmailsActualizar]
(
	@IdEmail smallint out
	,@IdPersona smallint
	,@Email varchar(50)
)
AS
BEGIN
	update Emails set
	Emails.Email= @Email 
	where Emails.IdEmail= @IdEmail
END
GO
/****** Object:  StoredProcedure [dbo].[proEmailsConsultar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite consultar los registros en la tabla Emails>
-- =============================================

CREATE PROCEDURE [dbo].[proEmailsConsultar]
AS
BEGIN
	SELECT
		Emails.IdEmail
		,Emails.IdPersona
		,Emails.Email

	FROM Emails	
END
GO
/****** Object:  StoredProcedure [dbo].[proEmailsConsultarId]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite consultar un registro en la tabla Emails>
-- =============================================

CREATE PROCEDURE [dbo].[proEmailsConsultarId]
(
	@IdEmail smallint
)
AS
BEGIN
	SELECT
		Emails.IdEmail
		,Emails.IdPersona
		,Emails.Email

	FROM Emails	
	where Emails.IdEmail= @IdEmail
END
GO
/****** Object:  StoredProcedure [dbo].[proEmailsEliminar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Manuel Gomez,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Eliminar un registro en la tabla Emails>
-- =============================================
CREATE PROCEDURE [dbo].[proEmailsEliminar]
(
	@IdEmail smallint 
)
AS
BEGIN
	Delete 
	from Emails
	where IdEmail = @IdEmail
END
GO
/****** Object:  StoredProcedure [dbo].[proEmailsInsertar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Insertar un registro en la tabla Emails>
-- =============================================

CREATE PROCEDURE [dbo].[proEmailsInsertar]
(
	@IdEmail smallint out
	,@IdPersona smallint
	,@Email varchar(50)
)
AS
BEGIN
	insert into Emails
	(
		IdPersona
		,Email
	)
	values
	(
		@IdPersona
		,@Email

	)
	set @IdEmail = @@IDENTITY
END
GO
/****** Object:  StoredProcedure [dbo].[proGenerosActualizar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Actualizar los registros en la tabla Generos>
-- =============================================

CREATE PROCEDURE [dbo].[proGenerosActualizar]
(
	@IdGenero smallint
	,@Genero varchar(10)
)
AS
BEGIN
	UPDATE Generos set
	Generos.Genero = @Genero
	where Generos.IdGenero = @IdGenero
END
GO
/****** Object:  StoredProcedure [dbo].[proGenerosConsultar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Manuel Gomez,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite consulta de los registros en la tabla Generos>
-- =============================================
CREATE PROCEDURE [dbo].[proGenerosConsultar]
(
	@IdEmail smallint 
)
AS
BEGIN

	SELECT 
	Generos.IdGenero
	,Generos.Genero
	FROM Generos
END
GO
/****** Object:  StoredProcedure [dbo].[proGenerosConsultarId]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite consulta de un registro en la tabla Generos>
-- =============================================

CREATE PROCEDURE [dbo].[proGenerosConsultarId]
(
	@IdGenero smallint 
)
AS
BEGIN
	SELECT 
	Generos.IdGenero
	,Generos.Genero
	FROM Generos
	WHERE Generos.IdGenero = @IdGenero
END
GO
/****** Object:  StoredProcedure [dbo].[proGenerosEliminar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Eliminar un registro en la tabla Generos>
-- =============================================

CREATE PROCEDURE [dbo].[proGenerosEliminar]
(
	@IdGenero smallint
)
AS
BEGIN
	DELETE
	FROM Generos 
	WHERE IdGenero = @IdGenero
END
GO
/****** Object:  StoredProcedure [dbo].[proGenerosInsertar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Insertar los registros en la tabla Generos>
-- =============================================

CREATE PROCEDURE [dbo].[proGenerosInsertar]
(
	@IdGenero smallint out
	,@Genero varchar(10)
)
AS
BEGIN
	insert into Generos
	(
		Genero
	)
	values
	(	
		@Genero
	)
	set @IdGenero = @@IDENTITY
END
GO
/****** Object:  StoredProcedure [dbo].[proMarcasActualizar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Actualizar los registros en la tabla Marcas>
-- =============================================

CREATE PROCEDURE [dbo].[proMarcasActualizar]
(
	@IdMarca smallint
	,@NombreMarca varchar(50)
)
AS
BEGIN
	UPDATE Marcas SET
	Marcas.NombreMarca = @NombreMarca
	WHERE Marcas.IdMarca = @IdMarca
END
GO
/****** Object:  StoredProcedure [dbo].[proMarcasConsultar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite consulta los registros en la tabla Marcas>
-- =============================================

CREATE PROCEDURE [dbo].[proMarcasConsultar]

AS
BEGIN
	SELECT 
	Marcas.IdMarca
	,Marcas.NombreMarca
	FROM Marcas
END
GO
/****** Object:  StoredProcedure [dbo].[proMarcasConsultarId]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite consulta de un registro en la tabla Marcas>
-- =============================================

CREATE PROCEDURE [dbo].[proMarcasConsultarId]
(
	@IdMarca smallint 
)
AS
BEGIN
	SELECT 
	Marcas.IdMarca
	,Marcas.NombreMarca
	FROM Marcas
	WHERE Marcas.IdMarca = @IdMarca
END
GO
/****** Object:  StoredProcedure [dbo].[proMarcasEliminar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Eliminar un registro en la tabla Marcas>
-- =============================================

CREATE PROCEDURE [dbo].[proMarcasEliminar]
(
	@IdMarca smallint
)
AS
BEGIN
	DELETE 
	FROM Marcas
	WHERE IdMarca = @IdMarca
END
GO
/****** Object:  StoredProcedure [dbo].[proMarcasInsertar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Insertar los registros en la tabla Marcas>
-- =============================================

CREATE PROCEDURE [dbo].[proMarcasInsertar]
(
	@IdMarca smallint out
	,@NombreMarca varchar(50)
)
AS
BEGIN

insert into Marcas
	(
		NombreMarca
	)
	values
	(
		@NombreMarca
	)
	set @IdMarca = @@IDENTITY
END
GO
/****** Object:  StoredProcedure [dbo].[proMarcasXTiposCalzadosActualizar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Manuel Gomez,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Actualizar un registro en la tabla MarcasXTiposCalzados>
-- =============================================
CREATE PROCEDURE [dbo].[proMarcasXTiposCalzadosActualizar]
(
	@IdMarca smallint 
	,@IdTipo smallint
	,@DemandaComercial varchar(10)
)

AS
BEGIN

	UPDATE MarcasXTiposCalzados SET
	MarcasXTiposCalzados.DemandaComercial = @DemandaComercial
	WHERE MarcasXTiposCalzados.IdMarca = @IdMarca And MarcasXTiposCalzados.IdTipo = @IdTipo
END
GO
/****** Object:  StoredProcedure [dbo].[proMarcasXTiposCalzadosConsultar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Manuel Gomez,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite consultar los registro en la tabla MarcasXTiposCalzados>
-- =============================================
CREATE PROCEDURE [dbo].[proMarcasXTiposCalzadosConsultar]
AS
BEGIN

	SELECT 
	MarcasXTiposCalzados.IdMarca
	,MarcasXTiposCalzados.IdTipo
	,Marcas.NombreMarca
	,TiposCalzados.TipoCalzado
	,MarcasXTiposCalzados.DemandaComercial
	
	FROM MarcasXTiposCalzados

	inner join Marcas on MarcasXTiposCalzados.IdMarca = Marcas.IdMarca
	inner join TiposCalzados on MarcasXTiposCalzados.IdTipo = TiposCalzados.IdTipo

END
GO
/****** Object:  StoredProcedure [dbo].[proMarcasXTiposCalzadosConsultarId]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Manuel Gomez,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite consultar un registro en la tabla MarcasXTiposCalzados>
-- =============================================
CREATE PROCEDURE [dbo].[proMarcasXTiposCalzadosConsultarId]
(
	@IdMarca smallint 
	,@IdTipo smallint
	,@DemandaComercial varchar(10)
)

AS
BEGIN

	SELECT 
	MarcasXTiposCalzados.IdMarca
	,MarcasXTiposCalzados.IdTipo
	,Marcas.NombreMarca
	,TiposCalzados.TipoCalzado
	,MarcasXTiposCalzados.DemandaComercial
	
	FROM MarcasXTiposCalzados
	inner join Marcas on MarcasXTiposCalzados.IdMarca = Marcas.IdMarca
	inner join TiposCalzados on MarcasXTiposCalzados.IdTipo = TiposCalzados.IdTipo
	WHERE MarcasXTiposCalzados.IdMarca = @IdMarca And MarcasXTiposCalzados.IdTipo = @IdTipo 
END
GO
/****** Object:  StoredProcedure [dbo].[proMarcasXTiposCalzadosEliminar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Manuel Gomez,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Eliminar los registro en la tabla MarcasXTiposCalzados>
-- =============================================
CREATE PROCEDURE [dbo].[proMarcasXTiposCalzadosEliminar]
(
	@IdMarca smallint 
	,@IdTipo smallint
	,@DemandaComercial varchar(10)
)

AS
BEGIN

	DELETE
	FROM  MarcasXTiposCalzados
	WHERE MarcasXTiposCalzados.IdMarca = @IdMarca And MarcasXTiposCalzados.IdTipo = @IdTipo
END
GO
/****** Object:  StoredProcedure [dbo].[proMarcasXTiposCalzadosInsertar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Manuel Gomez,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite INSERT los registro en la tabla MarcasXTiposCalzados>
-- =============================================
CREATE PROCEDURE [dbo].[proMarcasXTiposCalzadosInsertar]
(
	@IdMarca smallint 
	,@IdTipo smallint
	,@DemandaComercial varchar(10)
)

AS
BEGIN

insert into MarcasXTiposCalzados
	(
		IdMarca
		,IdTipo
		,DemandaComercial
	)
	values
	(
		@IdMarca
		,@IdTipo
		,@DemandaComercial
	)
END
GO
/****** Object:  StoredProcedure [dbo].[proPersonasActualizar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Manuel Gomez,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Actualizar un registro en la tabla Personas>
-- =============================================
CREATE PROCEDURE [dbo].[proPersonasActualizar]
(
	@IdPersona smallint 
	,@NumeroIdentificacion varchar(20)
	,@PrimerNombre varchar(20)
	,@SegundoNombre varchar(20)
	,@PrimerApellido varchar(20)
	,@SegundoApellido varchar(20)
)

AS
BEGIN

	UPDATE Personas SET
	Personas.NumeroIdentificacion = @NumeroIdentificacion
	,Personas.PrimerNombre = @PrimerNombre
	,Personas.SegundoNombre = @SegundoNombre
	,Personas.PrimerApellido = @PrimerApellido
	,Personas.SegundoApellido = @SegundoApellido
	WHERE Personas.IdPersona = @IdPersona
END
GO
/****** Object:  StoredProcedure [dbo].[proPersonasConsultar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Manuel Gomez,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite consulta de los registros en la tabla Personas>
-- =============================================
CREATE PROCEDURE [dbo].[proPersonasConsultar]

AS
BEGIN
	SELECT 
	Personas.IdPersona
	,Personas.IdTipoIdentificacion
	,dbo.funConcatenarNombre(Personas.IdPersona) Nombre_Identificacion

	FROM Personas
END
GO
/****** Object:  StoredProcedure [dbo].[proPersonasConsultarId]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Consultar un registro en la tabla Personas>
-- =============================================

CREATE PROCEDURE [dbo].[proPersonasConsultarId]
(
	@IdPersona smallint
	
)
AS
BEGIN
	SELECT 
	Personas.IdPersona
	,Personas.IdTipoIdentificacion
	,dbo.funConcatenarNombre(Personas.IdPersona) Nombre_Identificacion

	FROM Personas
	WHERE Personas.IdPersona = @IdPersona
END
GO
/****** Object:  StoredProcedure [dbo].[proPersonasEliminar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Eliminar un registro en la tabla Personas>
-- =============================================

CREATE PROCEDURE [dbo].[proPersonasEliminar]
(
	@IdPersona smallint
	
)
AS
BEGIN
	DELETE 
	FROM Personas
	WHERE IdPersona = @IdPersona
END
GO
/****** Object:  StoredProcedure [dbo].[proPersonasInsertar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Manuel Gomez,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Insertar un registro en la tabla Personas>
-- =============================================
CREATE PROCEDURE [dbo].[proPersonasInsertar]
(
	@IdPersona smallint out
	,@NumeroIdentificacion varchar(20)
	,@PrimerNombre varchar(20)
	,@SegundoNombre varchar(20)
	,@PrimerApellido varchar(20)
	,@SegundoApellido varchar(20)
)

AS
BEGIN
	insert into Personas
	(
		NumeroIdentificacion
		,PrimerNombre
		,SegundoNombre
		,PrimerApellido
		,SegundoApellido
	)
	values
	(
		@NumeroIdentificacion
		,@PrimerNombre
		,@SegundoNombre
		,@PrimerApellido
		,@SegundoApellido
	)
	set @IdPersona = @@IDENTITY
END
GO
/****** Object:  StoredProcedure [dbo].[proTallasCalzadosActualizar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite actualizar LOS registros en la tabla TallasCalzados>
-- =============================================

CREATE PROCEDURE [dbo].[proTallasCalzadosActualizar]
(
	@IdTalla smallint
	,@Talla tinyint
	
)
AS
BEGIN
	UPDATE TallasCalzados SET
	TallasCalzados.Talla = @Talla
	WHERE TallasCalzados.IdTalla = @IdTalla
END
GO
/****** Object:  StoredProcedure [dbo].[proTallasCalzadosConsultar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Consultar LOS registros en la tabla TallasCalzados>
-- =============================================

CREATE PROCEDURE [dbo].[proTallasCalzadosConsultar]
AS
BEGIN
	SELECT
	TallasCalzados.IdTalla
	,TallasCalzados.Talla

	FROM TallasCalzados

END
GO
/****** Object:  StoredProcedure [dbo].[proTallasCalzadosConsultarId]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Consultar un registro en la tabla TallasCalzados>
-- =============================================

CREATE PROCEDURE [dbo].[proTallasCalzadosConsultarId]
(
	@IdTalla smallint
	
)
AS
BEGIN
	SELECT
	TallasCalzados.IdTalla
	,TallasCalzados.Talla

	FROM TallasCalzados
	WHERE TallasCalzados.IdTalla = @IdTalla
END
GO
/****** Object:  StoredProcedure [dbo].[proTallasCalzadosEliminar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Eliminar un registro en la tabla TallasCalzados>
-- =============================================

CREATE PROCEDURE [dbo].[proTallasCalzadosEliminar]
(
	@IdTalla smallint
	
)
AS
BEGIN
	DELETE 
	FROM TallasCalzados
	WHERE IdTalla = @IdTalla
END
GO
/****** Object:  StoredProcedure [dbo].[proTallasCalzadosInsertar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Insertar LOS registros en la tabla TallasCalzados>
-- =============================================

CREATE PROCEDURE [dbo].[proTallasCalzadosInsertar]
(
	@IdTalla smallint
	,@Talla tinyint
	
)
AS
BEGIN
	insert into TallasCalzados
	(
		Talla
	)
	values
	(
		@Talla
	)
END
GO
/****** Object:  StoredProcedure [dbo].[proTiposCalzadosActualizar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite actualizar LOS registros en la tabla TiposCalzados>
-- =============================================

CREATE PROCEDURE [dbo].[proTiposCalzadosActualizar]
(
	@IdTipo smallint
	,@TipoCalzado varchar(20)
	
)
AS
BEGIN
	UPDATE TiposCalzados SET
	TiposCalzados.TipoCalzado = @TipoCalzado
	WHERE TiposCalzados.IdTipo = @IdTipo
END
GO
/****** Object:  StoredProcedure [dbo].[proTiposCalzadosConsultar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la consulta de los registros en la tabla TiposCalzados>
-- =============================================

CREATE PROCEDURE [dbo].[proTiposCalzadosConsultar]
AS
BEGIN

	SELECT 
	TiposCalzados.IdTipo
	,TiposCalzados.TipoCalzado
	FROM TiposCalzados
END
GO
/****** Object:  StoredProcedure [dbo].[proTiposCalzadosConsultarId]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la consulta de un registro en la tabla TiposCalzados>
-- =============================================

CREATE PROCEDURE [dbo].[proTiposCalzadosConsultarId]
(
	@IdTipo smallint

)
AS
BEGIN

	SELECT 
	TiposCalzados.IdTipo
	,TiposCalzados.TipoCalzado
	FROM TiposCalzados
	WHERE TiposCalzados.IdTipo = @IdTipo

END
GO
/****** Object:  StoredProcedure [dbo].[proTiposCalzadosEliminar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la ELIMINAR de los registros en la tabla TiposCalzados>
-- =============================================

CREATE PROCEDURE [dbo].[proTiposCalzadosEliminar]
(
	@IdTipo smallint

)
AS
BEGIN

	DELETE 
	FROM TiposCalzados
	WHERE IdTipo = @IdTipo

END
GO
/****** Object:  StoredProcedure [dbo].[proTiposCalzadosInsertar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite insertar LOS registros en la tabla TiposCalzados>
-- =============================================

CREATE PROCEDURE [dbo].[proTiposCalzadosInsertar]
(
	@IdTipo smallint out
	,@TipoCalzado varchar(20)
	
)
AS
BEGIN
		insert into TiposCalzados
	(
		TipoCalzado
	)
	values
	(
		@TipoCalzado
	)
	set @IdTipo = @@IDENTITY

END
GO
/****** Object:  StoredProcedure [dbo].[proTiposCargosActualiza]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la UPDATE de los registros en la tabla TiposCargos>
-- =============================================

CREATE PROCEDURE [dbo].[proTiposCargosActualiza]
(
	@IdTipo Tinyint out
	,@Cargo varchar(20)

)
AS
BEGIN

	update TiposCargos set
	TiposCargos.Cargo = @Cargo
	where TiposCargos.IdTipo = @IdTipo

END
GO
/****** Object:  StoredProcedure [dbo].[proTiposCargosConsultar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la CONSULTA de LOS registros en la tabla TiposCargos>
-- =============================================

CREATE PROCEDURE [dbo].[proTiposCargosConsultar]
AS
BEGIN

	SELECT 
		TiposCargos.IdTipo
		,TiposCargos.Cargo

	FROM TiposCargos
END
GO
/****** Object:  StoredProcedure [dbo].[proTiposCargosConsultarId]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la CONSULTA de UN registros en la tabla TiposCargos>
-- =============================================

CREATE PROCEDURE [dbo].[proTiposCargosConsultarId]
(
	@IdTipo Tinyint 
)
AS
BEGIN

	SELECT 
		TiposCargos.IdTipo
		,TiposCargos.Cargo

	FROM TiposCargos
	WHERE TiposCargos.IdTipo = @IdTipo
END
GO
/****** Object:  StoredProcedure [dbo].[proTiposCargosEliminar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la ELIMINAR de los registros en la tabla TiposCargos>
-- =============================================

CREATE PROCEDURE [dbo].[proTiposCargosEliminar]
(
	@IdTipo Tinyint

)
AS
BEGIN

	DELETE 
	FROM TiposCargos
	WHERE IdTipo = @IdTipo

END
GO
/****** Object:  StoredProcedure [dbo].[proTiposCargosInsertar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la INSERT de los registros en la tabla TiposCargos>
-- =============================================

CREATE PROCEDURE [dbo].[proTiposCargosInsertar]
(
	@IdTipo Tinyint out
	,@Cargo varchar(20)

)
AS
BEGIN

	insert into TiposCargos
	(
		Cargo
	)
	values
	(
		@Cargo
	)
	set @IdTipo = @@IDENTITY

END
GO
/****** Object:  StoredProcedure [dbo].[proTiposIdentificacionActualizar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la UPDATE de LOS registros en la tabla TiposIdentificacion>
-- =============================================

CREATE PROCEDURE [dbo].[proTiposIdentificacionActualizar]
(
	@IdTipoIdentificacion Tinyint OUT
	,@NombreIdentificacion varchar(20)
)
AS
BEGIN
	UPDATE TiposIdentificacion SET
	TiposIdentificacion.NombreIdentificacion = @NombreIdentificacion
	WHERE TiposIdentificacion.IdTipoIdentificacion = @IdTipoIdentificacion
END
GO
/****** Object:  StoredProcedure [dbo].[proTiposIdentificacionConsultar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la CONSULTA de LOS registros en la tabla TiposIdentificacion>
-- =============================================

CREATE PROCEDURE [dbo].[proTiposIdentificacionConsultar]
AS
BEGIN

	SELECT 
	 TiposIdentificacion.IdTipoIdentificacion
		,TiposIdentificacion.NombreIdentificacion

	FROM  TiposIdentificacion
END
GO
/****** Object:  StoredProcedure [dbo].[proTiposIdentificacionConsultarId]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la CONSULTA de un registros en la tabla TiposIdentificacion>
-- =============================================

CREATE PROCEDURE [dbo].[proTiposIdentificacionConsultarId]
(
	@IdTipoIdentificacion Tinyint 
)
AS
BEGIN

	SELECT 
	 TiposIdentificacion.IdTipoIdentificacion
		,TiposIdentificacion.NombreIdentificacion

	FROM  TiposIdentificacion
	WHERE  TiposIdentificacion.IdTipoIdentificacion = @IdTipoIdentificacion
END
GO
/****** Object:  StoredProcedure [dbo].[proTiposIdentificacionEliminar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la ELIMINAR de LOS registros en la tabla TiposIdentificacion>
-- =============================================

CREATE PROCEDURE [dbo].[proTiposIdentificacionEliminar]
(
	@IdTipoIdentificacion Tinyint 
	
)
AS
BEGIN
	delete
	from TiposIdentificacion
	where IdTipoIdentificacion = @IdTipoIdentificacion

END
GO
/****** Object:  StoredProcedure [dbo].[proTiposIdentificacionInsertar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la INSERT de LOS registros en la tabla TiposIdentificacion>
-- =============================================

CREATE PROCEDURE [dbo].[proTiposIdentificacionInsertar]
(
	@IdTipoIdentificacion Tinyint OUT
	,@NombreIdentificacion varchar(20)
)
AS
BEGIN
	insert into TiposIdentificacion
	(
		NombreIdentificacion
	)
	values
	(
		@NombreIdentificacion
	)
	set @IdTipoIdentificacion = @@IDENTITY

END
GO
/****** Object:  StoredProcedure [dbo].[proVentasActualizar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Actualizar de los registros en la tabla ventas,>
-- =============================================

CREATE PROCEDURE [dbo].[proVentasActualizar]
(
	@IdVenta smallint
	,@IdColaborador smallint
	,@IdCalzado smallint
	,@Cantidad smallint
	,@Fecha date
	,@Total varchar(50)
	
)
AS
BEGIN
	UPDATE Ventas SET 
	Ventas.IdColaborador = @IdColaborador
	,Ventas.IdCalzado = @IdCalzado
	,Ventas.Cantidad = @Cantidad
	,Ventas.Fecha = @Fecha
	,Ventas.Total = @Total
	where Ventas.IdVenta = @IdVenta
END
GO
/****** Object:  StoredProcedure [dbo].[proVentasConsultar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite Consultar de los registros en la tabla ventas,>
-- =============================================

CREATE PROCEDURE [dbo].[proVentasConsultar]
AS
BEGIN
	SELECT
		
		Ventas.IdVenta
		,Colaboradores.IdPersona AS IdColaborador
		,Calzados.IdCalzado
		,Marcas.IdMarca
		,Calzados.IdTalla
		,dbo.funConcatenarNombre(Personas.IdPersona) NombreColaborador_Identificacion
		,Marcas.NombreMarca
		,Calzados.Modelo
		,TallasCalzados.Talla
		,Calzados.Precio
		,Ventas.Cantidad
		,Ventas.Fecha
		,(Convert (int, Ventas.Cantidad))*(Convert(int, Calzados.Precio)) AS TOTAL

	FROM Ventas
	
	inner join Personas on Ventas.IdColaborador = Personas.IdPersona
	inner join Colaboradores on Ventas.IdColaborador = Colaboradores.IdPersona
	inner join Calzados on ventas.IdCalzado = Calzados.IdCalzado
	inner join TallasCalzados on Calzados.IdTalla = TallasCalzados.IdTalla
	inner join Marcas on Calzados.IdMarca= Marcas.IdMarca
END
GO
/****** Object:  StoredProcedure [dbo].[proVentasConsultarId]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite ConsultarID de un registros en la tabla ventas,>
-- =============================================

CREATE PROCEDURE [dbo].[proVentasConsultarId]
(
	@IdVenta smallint
)
AS
BEGIN
	SELECT

		Ventas.IdVenta
		,Colaboradores.IdPersona AS IdColaborador
		,Calzados.IdCalzado
		,Marcas.IdMarca
		,Calzados.IdTalla
		,dbo.funConcatenarNombre(Personas.IdPersona) NombreColaborador_Identificacion
		,Marcas.NombreMarca
		,Calzados.Modelo
		,TallasCalzados.Talla
		,Calzados.Precio
		,Ventas.Cantidad
		,Ventas.Fecha
		,(Convert (int, Ventas.Cantidad))*(Convert(int, Calzados.Precio)) AS TOTAL

	FROM Ventas
	inner join Personas on Ventas.IdColaborador = Personas.IdPersona
	inner join Colaboradores on Ventas.IdColaborador = Colaboradores.IdPersona
	inner join Calzados on ventas.IdCalzado = Calzados.IdCalzado
	inner join TallasCalzados on Calzados.IdTalla = TallasCalzados.IdTalla
	inner join Marcas on Calzados.IdMarca= Marcas.IdMarca
	WHERE Ventas.IdVenta = @IdVenta

END
GO
/****** Object:  StoredProcedure [dbo].[proVentasEliminar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la ELIMINAR de LOS registros en la tabla Ventas>
-- =============================================

CREATE PROCEDURE [dbo].[proVentasEliminar]
(
	@IdVenta smallint 
	
)
AS
BEGIN
	delete
	from Ventas
	where IdVenta = @IdVenta

END
GO
/****** Object:  StoredProcedure [dbo].[proVentasInsertar]    Script Date: 21/02/2024 12:28:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,UNIVERSIDAD DE CUNDINAMARCA>
-- Create date: <28 DE ABRIL DE 2022,>
-- Create update: <1 DE MAYO DE 2022>
-- Description:	<Permite la insert de LOS registros en la tabla Ventas>
-- =============================================

CREATE PROCEDURE [dbo].[proVentasInsertar]
(
	@IdVenta smallint
	,@IdColaborador smallint
	,@IdCalzado smallint
	,@Cantidad smallint
	,@Fecha date
	,@Total varchar(50)
)
AS
BEGIN
	insert into Ventas
	(
		IdColaborador
		,IdCalzado
		,Cantidad
		,Fecha
		,Total
	)
	values
	(
		@IdColaborador
		,@IdCalzado
		,@Cantidad
		,@Fecha
		,@Total
	)
	set @IdVenta= @@IDENTITY
END
GO
USE [master]
GO
ALTER DATABASE [DB_zapateria] SET  READ_WRITE 
GO
