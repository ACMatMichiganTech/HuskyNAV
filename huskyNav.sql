CREATE DATABASE IF NOT EXISTS huskyNav;
USE huskyNav;

CREATE TABLE IF NOT EXISTS Node(
	id INT PRIMARY KEY,
	x INT,
	y INT,
	z INT,
	room_num INT,
	building INT
);

CREATE TABLE IF NOT EXISTS Teacher(
	id INT PRIMARY KEY,
	name VARCHAR(25),
	office INT,
	hours VARCHAR(25)
);

CREATE TABLE IF NOT EXISTS Class(
	id INT PRIMARY KEY,
	section VARCHAR(25),
	room INT
);

CREATE TABLE IF NOT EXISTS Connection(
	id INT PRIMARY KEY,
	nodeA INT,
	nodeB INT,
	distance INT
);