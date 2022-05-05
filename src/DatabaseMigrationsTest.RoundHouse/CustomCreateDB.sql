USE [master]
GO

IF db_id('Migrations_RoundHouse') is NULL
BEGIN
	CREATE DATABASE [Migrations_RoundHouse]
	CONTAINMENT = NONE
	ON  PRIMARY 
	( NAME = N'Migrations_RoundHouse', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2017\MSSQL\DATA\Migrations_RoundHouse.mdf' , SIZE = 1000KB , MAXSIZE = 1GB, FILEGROWTH = 65536KB )
	LOG ON 
	( NAME = N'Migrations_RoundHouse_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2017\MSSQL\DATA\Migrations_RoundHouse_log.ldf' , SIZE = 1000KB , MAXSIZE = 1GB , FILEGROWTH = 65536KB )
	;
END;



