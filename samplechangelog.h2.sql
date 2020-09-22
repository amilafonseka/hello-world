--liquibase formatted sql

--changeset amila.sembunaidelage:1
create table company (
    id int primary key,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)

--changeset amila.sembunaidelage:2
drop table if exists company

--changeset amila.sembunaidelage:3
create table company (
    id int primary key,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)

--changeset amila.sembunaidelage:4
drop table if exists company



