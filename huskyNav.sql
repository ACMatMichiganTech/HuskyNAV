CREATE DATABASE IF NOT EXISTS huskyNav;
USE huskyNav;

CREATE TABLE IF NOT EXISTS Node(
	id INT PRIMARY KEY AUTO_INCREMENT,
	x INT,
	y INT,
	z INT,
	room_num TEXT,
	building TEXT
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
	id INT PRIMARY KEY AUTO_INCREMENT,
	nodeA INT,
	nodeB INT,
	distance FLOAT
);

DELIMITER //
CREATE TRIGGER setDistance BEFORE INSERT ON Connection
FOR EACH ROW BEGIN
    /* This trigger is literally just the distance formula:
     * distance = Sqrt( (x2 - x1)^2 + (y2 - y1)^2)
     */
    DECLARE a_x INT;
    DECLARE a_y INT;
    DECLARE b_x INT;
    DECLARE b_y INT;
    DECLARE diff_x INT;
    DECLARE diff_y INT;
    SET a_x = (SELECT x FROM Node WHERE id = NEW.nodeA);
    SET a_y = (SELECT y FROM Node WHERE id = NEW.nodeA);
    SET b_x = (SELECT x FROM Node WHERE id = NEW.nodeB);
    SET b_y = (SELECT y FROM Node WHERE id = NEW.nodeB);
    SET diff_x = (SELECT POW( (a_x - b_x), 2));
    SET diff_y = (SELECT POW( (a_y - b_y), 2));
    SET NEW.distance = (SELECT SQRT(diff_x + diff_y));
END//
DELIMITER ;

INSERT INTO Node (x, y, z, room_num, building) VALUES
(178, 178, 1, '101', 'Rekhi'),
(235, 250, 1, '102', 'Rekhi'),
(225, 148, 1, '102_Hallway', 'Rekhi'),
(235, 118, 1, '103', 'Rekhi'),
(223, 119, 1, '103_Hallway', 'Rekhi'),
(224, 91, 1, '104', 'Rekhi'),
(213, 95, 1, '104_Hallway', 'Rekhi'),
(201, 68, 1, '105', 'Rekhi'),
(195, 76, 1, '105_Hallway', 'Rekhi'),
(174, 57, 1, '106', 'Rekhi'),
(174, 68, 1, '106_Hallway', 'Rekhi'),
(136, 59, 1, '107', 'Rekhi'),
(139, 170, 1, '107_Hallway', 'Rekhi'),
(114, 69, 1, '108', 'Rekhi'),
(119, 76, 1, '108_Hallway', 'Rekhi'),
(94, 93, 1, '109', 'Rekhi'),
(100, 95, 1, '109_Hallway', 'Rekhi'),
(82, 120, 1, '110', 'Rekhi'),
(90, 119, 1, '110_Hallway', 'Rekhi'),
(80, 151, 1, '111', 'Rekhi'),
(93, 150, 1, '111_Hallway', 'Rekhi'),
(175, 465, 1, '112A', 'Rekhi'),
(190, 456, 1, '112A_Hallway', 'Rekhi'),
(175, 285, 1, '112', 'Rekhi'),
(190, 285, 1, '112_Hallway', 'Rekhi'),
(205, 493, 1, '113A', 'Rekhi'),
(190, 493, 1, '113A_Hallway', 'Rekhi'),
(205, 312, 1, '113', 'Rekhi'),
(190, 312, 1, '113_Hallway', 'Rekhi'),
(175, 487, 1, '114', 'Rekhi'),
(190, 487, 1, '114_Hallway', 'Rekhi'),
(215, 560, 1, '115', 'Rekhi'),
(215, 575, 1, '115_Hallway', 'Rekhi'),
(245, 560, 1, '116', 'Rekhi'),
(245, 575, 1, '116_Hallway', 'Rekhi'),
(164, 575, 1, '117', 'Rekhi'),
(164, 575, 1, '117_Hallway', 'Rekhi'),
(138, 587, 1, '118', 'Rekhi'),
(138, 575, 1, '118_Hallway', 'Rekhi'),
(205, 288, 1, 'J', 'Rekhi'),
(93, 560, 1, '1T1', 'Rekhi'),
(93, 575, 1, '1T1_Hallway', 'Rekhi'),
(125, 560, 1, '1T2', 'Rekhi'),
(125, 575, 1, '1T2_Hallway', 'Rekhi'),
(158, 560, 1, '1E1', 'Rekhi'),
(158, 575, 1, '1E1_Hallway', 'Rekhi'),
(190, 575, 1, 'Hallway_Junction', 'Rekhi'),
(190, 237, 1, 'Rotunda_Junction', 'Rekhi'),
(278, 244, 1, 'Restroom_Junction', 'Rekhi'),
(253, 190, 1, 'Entry_Junction', 'Rekhi'),
(217, 161, 1, 'Offices_Right', 'Rekhi'),
(135, 195, 1, 'Offices_Left', 'Rekhi'),
(253, 243, 1, 'Restroom_Men', 'Rekhi'),
(295, 245, 1, 'Restroom_Women', 'Rekhi'),
(316, 575, 1, 'Staircase_B', 'Rekhi'),
(275, 200, 1, 'Entry', 'Rekhi');

INSERT INTO Connection(NodeA, NodeB) VALUES
((SELECT id FROM Node WHERE z=1 AND room_num='118' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='118_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='118_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='1T2_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='118_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='1E1_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='1T2' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='1T2_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='1T2_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='1T1_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='1T1' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='1T1_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='1E1' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='1E1_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='1E1_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='117_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='117' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='117_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='117_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='Hallway_Junction' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='113A_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='Hallway_Junction' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='115_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='Hallway_Junction' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='115' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='115_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='115_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='116_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='116' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='116_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='116_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='Staircase_B' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='113A' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='113A_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='113A_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='114_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='114' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='114_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='114_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='112A_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='112A' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='112A_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='112A_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='113_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='113' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='113_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='113_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='112_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='112' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='112_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='112_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='J' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='112_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='Rotunda_Junction' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='Rotunda_Junction' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='Offices_Left' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='Rotunda_Junction' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='Offices_Right' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='Rotunda_Junction' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='101' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='Offices_Right' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='102_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='Offices_Left' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='111_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='102' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='102_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='102_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='103_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='103' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='103_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='103_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='104_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='104' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='104_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='104_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='105_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='105' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='105_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='105_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='106_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='106' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='106_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='106_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='107_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='107' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='107_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='107_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='108_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='108' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='108_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='108_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='109_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='109' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='109_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='109_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='110_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='110' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='110_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='110_Hallway' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='111_Hallway' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='Entry' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='Restroom_Junction' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='Entry' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='Entry_Junction' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='Entry_Junction' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='Rotunda_Junction' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='Restroom_Junction' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='Restroom_Men' AND building='Rekhi')),

((SELECT id FROM Node WHERE z=1 AND room_num='Restroom_Junction' AND building='Rekhi'), 
(SELECT id FROM Node WHERE z=1 AND room_num='Restroom_Women' AND building='Rekhi'));
/* TODO add the staircase */
