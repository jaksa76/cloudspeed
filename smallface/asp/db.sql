USE [master]
GO
/****** Object:  Database [perf_competition]    Script Date: 12/08/2008 10:27:17 ******/
CREATE DATABASE [perf_competition] ON  PRIMARY 
( NAME = N'perf_competition', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\perf_competition.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'perf_competition_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\perf_competition_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 COLLATE Latin1_General_CI_AS
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'perf_competition', @new_cmptlevel=90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [perf_competition].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [perf_competition] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [perf_competition] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [perf_competition] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [perf_competition] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [perf_competition] SET ARITHABORT OFF 
GO
ALTER DATABASE [perf_competition] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [perf_competition] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [perf_competition] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [perf_competition] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [perf_competition] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [perf_competition] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [perf_competition] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [perf_competition] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [perf_competition] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [perf_competition] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [perf_competition] SET  ENABLE_BROKER 
GO
ALTER DATABASE [perf_competition] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [perf_competition] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [perf_competition] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [perf_competition] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [perf_competition] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [perf_competition] SET  READ_WRITE 
GO
ALTER DATABASE [perf_competition] SET RECOVERY FULL 
GO
ALTER DATABASE [perf_competition] SET  MULTI_USER 
GO
ALTER DATABASE [perf_competition] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [perf_competition] SET DB_CHAINING OFF 