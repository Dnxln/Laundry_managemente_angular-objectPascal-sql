

/****** Object:  Database [Lavanderia2]    Script Date: 21/07/2023 12:49:33 ******/
CREATE DATABASE [Lavanderia2]
 CONTAINMENT = NONE
 ON  PRIMARY 

( NAME = N'Lavanderia2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Lavanderia2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Lavanderia2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Lavanderia2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Lavanderia2] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Lavanderia2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Lavanderia2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Lavanderia2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Lavanderia2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Lavanderia2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Lavanderia2] SET ARITHABORT OFF 
GO
ALTER DATABASE [Lavanderia2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Lavanderia2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Lavanderia2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Lavanderia2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Lavanderia2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Lavanderia2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Lavanderia2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Lavanderia2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Lavanderia2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Lavanderia2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Lavanderia2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Lavanderia2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Lavanderia2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Lavanderia2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Lavanderia2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Lavanderia2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Lavanderia2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Lavanderia2] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Lavanderia2] SET  MULTI_USER 
GO
ALTER DATABASE [Lavanderia2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Lavanderia2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Lavanderia2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Lavanderia2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Lavanderia2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Lavanderia2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Lavanderia2] SET QUERY_STORE = OFF
GO
USE [Lavanderia2]
GO
USE [Lavanderia2]
GO
/****** Object:  Sequence [dbo].[CapiID]    Script Date: 21/07/2023 12:49:33 ******/
CREATE SEQUENCE [dbo].[CapiID] 
 AS [bigint]
 START WITH 0
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
USE [Lavanderia2]
GO
/****** Object:  Sequence [dbo].[ClientiID]    Script Date: 21/07/2023 12:49:33 ******/
CREATE SEQUENCE [dbo].[ClientiID] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO
USE [Lavanderia2]
GO
/****** Object:  Sequence [dbo].[LavorazioniID]    Script Date: 21/07/2023 12:49:33 ******/
CREATE SEQUENCE [dbo].[LavorazioniID] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO
USE [Lavanderia2]
GO
/****** Object:  Sequence [dbo].[OrdineID]    Script Date: 21/07/2023 12:49:33 ******/
CREATE SEQUENCE [dbo].[OrdineID] 
 AS [bigint]
 START WITH 0
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
USE [Lavanderia2]
GO
/****** Object:  Sequence [dbo].[RigaOrdineID]    Script Date: 21/07/2023 12:49:33 ******/
CREATE SEQUENCE [dbo].[RigaOrdineID] 
 AS [bigint]
 START WITH -9223372036854775808
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
/****** Object:  Table [dbo].[Capi]    Script Date: 21/07/2023 12:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Capi](
	[ID] [int] NOT NULL,
	[Descrizione] [nvarchar](50) NOT NULL,
	[VersionID] [int] NULL,
 CONSTRAINT [PK_Capi] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CapiLavorazioni]    Script Date: 21/07/2023 12:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CapiLavorazioni](
	[CapoID] [int] NOT NULL,
	[LavorazioneID] [int] NOT NULL,
	[Prezzo] [float] NULL,
 CONSTRAINT [PK_CapiLavorazioni] PRIMARY KEY CLUSTERED 
(
	[CapoID] ASC,
	[LavorazioneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clienti]    Script Date: 21/07/2023 12:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clienti](
	[ID] [int] NOT NULL,
	[Nome] [nvarchar](50) NULL,
	[Cognome] [nvarchar](50) NULL,
	[Indirizzo] [nvarchar](80) NULL,
	[Telefono] [nvarchar](20) NULL,
	[Giorno] [tinyint] NULL,
	[Mese] [tinyint] NULL,
	[VersionID] [int] NULL,
 CONSTRAINT [PK_Clienti] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lavorazioni]    Script Date: 21/07/2023 12:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lavorazioni](
	[ID] [int] NOT NULL,
	[Descrizione] [nvarchar](50) NULL,
	[VersionID] [int] NULL,
 CONSTRAINT [PK_Lavorazioni] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ordini]    Script Date: 21/07/2023 12:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ordini](
	[ID] [int] NOT NULL,
	[ClienteID] [int] NULL,
	[Data] [datetime] NULL,
	[Riferimento] [nvarchar](10) NULL,
	[Incassato] [tinyint] NULL,
	[VersionID] [int] NULL,
 CONSTRAINT [PK_Ordini] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RigheOrdine]    Script Date: 21/07/2023 12:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RigheOrdine](
	[ID] [int] NOT NULL,
	[OrdineID] [int] NULL,
	[CapoID] [int] NULL,
	[Quantita] [int] NULL,
	[Consegnato] [datetime] NULL,
	[Incassato] [datetime] NULL,
	[VersionID] [int] NULL,
 CONSTRAINT [PK_RigheOrdine] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RigheOrdineLavorazioni]    Script Date: 21/07/2023 12:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RigheOrdineLavorazioni](
	[RigaOrdineID] [int] NOT NULL,
	[LavorazioneID] [int] NOT NULL,
	[Lavorato] [datetime] NULL,
 CONSTRAINT [PK_RigheOrdineLavorazioni] PRIMARY KEY CLUSTERED 
(
	[RigaOrdineID] ASC,
	[LavorazioneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (3, N'piumino', 4)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (5, N'Lenzuola', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (7, N'T-Shirt', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (8, N'Pantaloni', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (9, N'Gilet', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (11, N'felpa', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (53, N'Gonna', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (68, N'', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (69, N'bon', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (70, N'ez', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (71, N'Camicia', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (72, N'ez2', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (73, N'iy', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (74, N'Cappotto autunnale', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (75, N'ez3', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (78, N'ez3', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (79, N'ez3', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (80, N'ez3', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (81, N'ez3', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (82, N'ez3', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (83, N'ez3', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (84, N'Nuova descrizione del capo', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (85, N'Ndnkf', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (86, N'Ndnkf', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (87, N'ez3', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (89, N'asdfsdf', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (90, N'sdfsdfsfsfdsff', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (91, N'123', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (92, N'123213213213132', 0)
INSERT [dbo].[Capi] ([ID], [Descrizione], [VersionID]) VALUES (93, N'prova4321', 0)
GO
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (1, 1, 2.5)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (1, 2, 3.5)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (1, 3, 1)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (2, 1, 6)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (2, 2, 6.5)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (3, 1, 4.5)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (3, 2, 5)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (3, 3, 2)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (4, 1, 15)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (4, 2, 16)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (5, 1, 8)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (5, 2, 9)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (6, 1, 12)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (6, 2, 15)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (7, 1, 2)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (7, 2, 2)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (8, 1, 3.5)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (8, 2, 4.5)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (9, 1, 6)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (9, 2, 7)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (53, 1, 5)
INSERT [dbo].[CapiLavorazioni] ([CapoID], [LavorazioneID], [Prezzo]) VALUES (53, 2, 7)
GO
INSERT [dbo].[Clienti] ([ID], [Nome], [Cognome], [Indirizzo], [Telefono], [Giorno], [Mese], [VersionID]) VALUES (0, N'', N'', N'', N'', 0, 0, NULL)
INSERT [dbo].[Clienti] ([ID], [Nome], [Cognome], [Indirizzo], [Telefono], [Giorno], [Mese], [VersionID]) VALUES (1, N'daniele', N'orsucci', N'via', N'1234', 2, 2, 0)
GO
INSERT [dbo].[Lavorazioni] ([ID], [Descrizione], [VersionID]) VALUES (1, N'ez3', 0)
GO
/****** Object:  Index [RighrOrdine_Index1]    Script Date: 21/07/2023 12:49:33 ******/
CREATE UNIQUE NONCLUSTERED INDEX [RighrOrdine_Index1] ON [dbo].[RigheOrdine]
(
	[OrdineID] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Capi] ADD  CONSTRAINT [DF_Capi_ID]  DEFAULT ((0)) FOR [ID]
GO
ALTER TABLE [dbo].[Capi] ADD  CONSTRAINT [DF_Capi_Descrizione]  DEFAULT (N'') FOR [Descrizione]
GO
ALTER TABLE [dbo].[Capi] ADD  CONSTRAINT [DF_Capi_VersionID]  DEFAULT ((0)) FOR [VersionID]
GO
ALTER TABLE [dbo].[CapiLavorazioni] ADD  CONSTRAINT [DF_CapiLavorazioni_CapoID]  DEFAULT ((0)) FOR [CapoID]
GO
ALTER TABLE [dbo].[CapiLavorazioni] ADD  CONSTRAINT [DF_CapiLavorazioni_LavorazioneID]  DEFAULT ((0)) FOR [LavorazioneID]
GO
ALTER TABLE [dbo].[CapiLavorazioni] ADD  CONSTRAINT [DF_CapiLavorazioni_Prezzo]  DEFAULT ((0)) FOR [Prezzo]
GO
ALTER TABLE [dbo].[Clienti] ADD  CONSTRAINT [DF_Clienti_ID]  DEFAULT ((0)) FOR [ID]
GO
ALTER TABLE [dbo].[Clienti] ADD  CONSTRAINT [DF_Clienti_Nome]  DEFAULT (N'') FOR [Nome]
GO
ALTER TABLE [dbo].[Clienti] ADD  CONSTRAINT [DF_Clienti_Cognome]  DEFAULT (N'') FOR [Cognome]
GO
ALTER TABLE [dbo].[Clienti] ADD  CONSTRAINT [DF_Clienti_Indirizzo]  DEFAULT (N'') FOR [Indirizzo]
GO
ALTER TABLE [dbo].[Clienti] ADD  CONSTRAINT [DF_Clienti_Telefono]  DEFAULT (N'') FOR [Telefono]
GO
ALTER TABLE [dbo].[Clienti] ADD  CONSTRAINT [DF_Clienti_Giorno]  DEFAULT ((0)) FOR [Giorno]
GO
ALTER TABLE [dbo].[Clienti] ADD  CONSTRAINT [DF_Clienti_Mese]  DEFAULT ((0)) FOR [Mese]
GO
ALTER TABLE [dbo].[Clienti] ADD  CONSTRAINT [DF_Clienti_VersionID]  DEFAULT ((0)) FOR [VersionID]
GO
ALTER TABLE [dbo].[Lavorazioni] ADD  CONSTRAINT [DF_Lavorazioni_ID]  DEFAULT ((0)) FOR [ID]
GO
ALTER TABLE [dbo].[Lavorazioni] ADD  CONSTRAINT [DF_Lavorazioni_Descrizione]  DEFAULT (N'') FOR [Descrizione]
GO
ALTER TABLE [dbo].[Lavorazioni] ADD  CONSTRAINT [DF_Lavorazioni_VersionID]  DEFAULT ((0)) FOR [VersionID]
GO
ALTER TABLE [dbo].[Ordini] ADD  CONSTRAINT [DF_Ordini_ID]  DEFAULT ((0)) FOR [ID]
GO
ALTER TABLE [dbo].[Ordini] ADD  CONSTRAINT [DF_Ordini_ClienteID]  DEFAULT ((0)) FOR [ClienteID]
GO
ALTER TABLE [dbo].[Ordini] ADD  CONSTRAINT [DF_Ordini_Data]  DEFAULT (getdate()) FOR [Data]
GO
ALTER TABLE [dbo].[Ordini] ADD  CONSTRAINT [DF_Ordini_Riferimento]  DEFAULT (N'') FOR [Riferimento]
GO
ALTER TABLE [dbo].[Ordini] ADD  CONSTRAINT [DF_Ordini_Incassato]  DEFAULT ((0)) FOR [Incassato]
GO
ALTER TABLE [dbo].[Ordini] ADD  CONSTRAINT [DF_Ordini_VersionID]  DEFAULT ((0)) FOR [VersionID]
GO
ALTER TABLE [dbo].[RigheOrdine] ADD  CONSTRAINT [DF_RigheOrdine_ID]  DEFAULT ((0)) FOR [ID]
GO
ALTER TABLE [dbo].[RigheOrdine] ADD  CONSTRAINT [DF_RigheOrdine_OrdineID]  DEFAULT ((0)) FOR [OrdineID]
GO
ALTER TABLE [dbo].[RigheOrdine] ADD  CONSTRAINT [DF_RigheOrdine_CapoID]  DEFAULT ((0)) FOR [CapoID]
GO
ALTER TABLE [dbo].[RigheOrdine] ADD  CONSTRAINT [DF_RigheOrdine_Quantita]  DEFAULT ((0)) FOR [Quantita]
GO
ALTER TABLE [dbo].[RigheOrdine] ADD  CONSTRAINT [DF_RigheOrdine_VersionID]  DEFAULT ((0)) FOR [VersionID]
GO
ALTER TABLE [dbo].[RigheOrdineLavorazioni] ADD  CONSTRAINT [DF_RigheOrdineLavorazioni_RigaOrdineID]  DEFAULT ((0)) FOR [RigaOrdineID]
GO
ALTER TABLE [dbo].[RigheOrdineLavorazioni] ADD  CONSTRAINT [DF_RigheOrdineLavorazioni_LavorazioneID]  DEFAULT ((0)) FOR [LavorazioneID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Capi', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Capi', @level2type=N'COLUMN',@level2name=N'VersionID'
GO
USE [master]
GO
ALTER DATABASE [Lavanderia2] SET  READ_WRITE 
GO
