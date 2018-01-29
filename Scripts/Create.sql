use master;
go

if exists (select * from sysdatabases where name = 'SecretsofAptB')
	drop database SecretsofAptB;

create database SecretsofAptB;
go