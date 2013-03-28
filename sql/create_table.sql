-- Create Statements
-- Version: 0.1
-- Name: lostislands

SET SQL_MODE='STRICT_ALL_TABLES';

USE mcgregersql1 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS guild_role;
CREATE TABLE guild_role 
(
    id TINYINT(1) UNSIGNED NOT NULL,
    name VARCHAR(24) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (name)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ; 

-- -------------------------------------------------------------

DROP TABLE IF EXISTS guild;
CREATE TABLE guild
(
    id SMALLINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(24) NOT NULL,
    tag VARCHAR(3) NOT NULL,
    public_text TEXT DEFAULT NULL,
    intern_text TEXT DEFAULT NULL,
    max_member TINYINT(2) UNSIGNED NOT NULL DEFAULT 20,
    image_filename VARCHAR(64) DEFAULT NULL,
    board VARCHAR(256) DEFAULT NULL,
    application BOOLEAN NOT NULL DEFAULT 1,
    PRIMARY KEY (id),
    UNIQUE KEY (name),
    UNIQUE KEY (tag)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS faction;
CREATE TABLE faction
(
    id TINYINT(1) UNSIGNED NOT NULL,
    name varchar (16) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (name)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS user;
CREATE TABLE user
(
    id SMALLINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
    nickname VARCHAR(15)NOT NULL,
    password VARCHAR(30) NOT NULL,
    reg_date DATETIME NOT NULL,
    email VARCHAR(48) NOT NULL,
    ban BOOLEAN NOT NULL DEFAULT 0,
    premium BOOLEAN NOT NULL DEFAULT 0,
    active BOOLEAN NOT NULL DEFAULT 0,
    break BOOLEAN NOT NULL DEFAULT 0,
    last_login DATETIME NOT NULL,
    failed_login TINYINT(2) UNSIGNED NOT NULL,
    last_action TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (id),
    UNIQUE KEY(nickname),
    UNIQUE KEY(email)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS game_user;
CREATE TABLE game_user
(
    id SMALLINT(3) UNSIGNED NOT NULL,
    faction_id TINYINT(1) UNSIGNED NOT NULL,
    guild_id SMALLINT(3) UNSIGNED DEFAULT NULL,
    guild_role_id TINYINT(1) UNSIGNED DEFAULT NULL,
    score MEDIUMINT UNSIGNED NOT NULL DEFAULT 0,
    image_filename VARCHAR(64) DEFAULT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (faction_id) REFERENCES faction(id)
        ON DELETE RESTRICT ON UPDATE CASCADE,  
    FOREIGN KEY (guild_id) REFERENCES guild(id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (guild_role_id) REFERENCES guild_role(id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id) REFERENCES user(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS message_type;
CREATE TABLE message_type
(
    id TINYINT(1) UNSIGNED NOT NULL,
    name VARCHAR(24) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (name)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS message;
CREATE TABLE message
(
    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    sender_id SMALLINT(3) UNSIGNED DEFAULT NULL,
    receiver_id SMALLINT(3) UNSIGNED NOT NULL,
    received BOOLEAN NOT NULL,
    msg_type TINYINT(1) UNSIGNED NOT NULL,
    msg_title VARCHAR(96) DEFAULT NULL,
    msg_text VARCHAR (3000) DEFAULT NULL,
    msg_time TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (id),
    FOREIGN KEY (sender_id) REFERENCES game_user(id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES game_user(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (msg_type) REFERENCES message_type(id)
        ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;


-- -------------------------------------------------------------

DROP TABLE IF EXISTS movement_type;
CREATE TABLE movement_type
(
    id TINYINT(1) UNSIGNED NOT NULL,
    name VARCHAR(24) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (name)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS island;
CREATE TABLE island
(
    id SMALLINT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id SMALLINT(3) UNSIGNED NOT NULL,
    name VARCHAR(15) NOT NULL DEFAULT 'Kolonie',
    location VARCHAR(7) NOT NULL,
    last_activity TIMESTAMP DEFAULT NOW(),
    image_filename VARCHAR(64) DEFAULT NULL,
    res_gold INT UNSIGNED NOT NULL DEFAULT 500,
    res_lumber INT UNSIGNED NOT NULL DEFAULT 500,
    res_iron INT UNSIGNED NOT NULL DEFAULT 0,
    res_food INT UNSIGNED NOT NULL DEFAULT 500,
    island_buildings VARCHAR(48) NOT NULL DEFAULT '0:0:0:0:0:0:0',
    island_fleet VARCHAR(96) NOT NULL DEFAULT '0:0:0:0:0:0:0:0:0',
    island_def VARCHAR(32) NOT NULL DEFAULT '0:0:0:0:0',
    wreckage_lumber MEDIUMINT UNSIGNED DEFAULT NULL,
    wreckage_iron MEDIUMINT UNSIGNED DEFAULT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY(location),
    FOREIGN KEY (user_id) REFERENCES game_user(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS fleetmovement;
CREATE TABLE fleetmovement 
(
    id MEDIUMINT(6) UNSIGNED NOT NULL AUTO_INCREMENT,
    origin_id SMALLINT(4) UNSIGNED NOT NULL,
    destination_id SMALLINT(4) UNSIGNED NULL,
    type_id TINYINT(1) UNSIGNED NOT NULL,
    fleet VARCHAR(96) NOT NULL DEFAULT '0:0:0:0:0:0:0:0:0',
    arrival_time DATETIME NOT NULL,
    trans_gold INT UNSIGNED NOT NULL,
    trans_lumber INT UNSIGNED NOT NULL,
    trans_iron INT UNSIGNED NOT NULL,
    trans_food INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (origin_id) REFERENCES island(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (destination_id) REFERENCES island(id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (type_id) REFERENCES movement_type(id)
        ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS research;
CREATE TABLE research 
(
    id TINYINT UNSIGNED NOT NULL,
    name VARCHAR(24) NOT NULL,
    costs_gold INT UNSIGNED NOT NULL,
    costs_lumber INT UNSIGNED NOT NULL,
    costs_iron INT UNSIGNED NOT NULL,
    costs_food INT UNSIGNED NOT NULL,
    base_time MEDIUMINT(7) UNSIGNED NOT NULL,
    factor_time FLOAT UNSIGNED NOT NULL,
    factor_costs FLOAT UNSIGNED NOT NULL,
    image_filename VARCHAR(64) DEFAULT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY(name)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS basic_of_research;
CREATE TABLE basic_of_research
(
    research_id TINYINT UNSIGNED NOT NULL,
    basic_id TINYINT UNSIGNED NOT NULL,
    tier TINYINT(2) UNSIGNED NOT NULL,
    PRIMARY KEY(research_id, basic_id),
    FOREIGN KEY (research_id) REFERENCES research(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (basic_id) REFERENCES research(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS research_in_progress;
CREATE TABLE research_in_progress 
(
    island_id SMALLINT(4) UNSIGNED NOT NULL,
    research_id TINYINT(2) UNSIGNED NOT NULL,
    end_date DATETIME NOT NULL,
    PRIMARY KEY (island_id),
    FOREIGN KEY (island_id) REFERENCES island(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (research_id) REFERENCES research(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS building;
CREATE TABLE building
(
    id TINYINT UNSIGNED NOT NULL,
    costs_gold INT UNSIGNED NOT NULL,
    costs_lumber INT UNSIGNED NOT NULL,
    costs_iron INT UNSIGNED NOT NULL,
    costs_food INT UNSIGNED NOT NULL,
    constr_time MEDIUMINT(7) UNSIGNED NOT NULL,
    factor_time FLOAT UNSIGNED NOT NULL,
    factor_costs FLOAT UNSIGNED NOT NULL,
    PRIMARY KEY (id)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS production;
CREATE TABLE production 
(
    id TINYINT(1) UNSIGNED NOT NULL,
    production TINYINT UNSIGNED NOT NULL,
    consum TINYINT UNSIGNED NOT NULL,
    factor FLOAT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES building(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS building_bonus;
CREATE TABLE building_bonus
(
    id TINYINT(1) UNSIGNED NOT NULL,
    factor FLOAT UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES building(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS building_description;
CREATE TABLE building_description
(
    building_id TINYINT UNSIGNED NOT NULL,
    faction_id TINYINT(1) UNSIGNED NOT NULL,
    name VARCHAR(24) NOT NULL,
    description VARCHAR(1000) NOT NULL,
    image_filename VARCHAR(256) DEFAULT NULL,
    PRIMARY KEY(faction_id, building_id),
    FOREIGN KEY(faction_id) REFERENCES faction(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(building_id) REFERENCES building(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS building_in_progress;
CREATE TABLE building_in_progress
(
    island_id SMALLINT(4) UNSIGNED NOT NULL,
    building_id TINYINT UNSIGNED NOT NULL,
    end_date DATETIME NOT NULL,
    PRIMARY KEY (island_id),
    FOREIGN KEY (island_id) REFERENCES island(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (building_id) REFERENCES building(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS defense;
CREATE TABLE defense 
(
    id TINYINT(2) UNSIGNED NOT NULL,
    name VARCHAR(24) NOT NULL,
    description VARCHAR(1000) NOT NULL,
    costs_gold INT UNSIGNED NOT NULL,
    costs_lumber INT UNSIGNED NOT NULL,
    costs_iron INT UNSIGNED NOT NULL,
    costs_food INT UNSIGNED NOT NULL,
    constr_time MEDIUMINT(7) UNSIGNED NOT NULL,
    attack_damage SMALLINT UNSIGNED DEFAULT NULL,
    defense SMALLINT UNSIGNED NOT NULL,
    image_filename VARCHAR(64) DEFAULT NULL,
    PRIMARY KEY (id)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS ship;
CREATE TABLE ship 
(
    id TINYINT(2) UNSIGNED NOT NULL,
    name VARCHAR(24) NOT NULL,
    description VARCHAR(1000) NOT NULL,
    costs_gold INT UNSIGNED NOT NULL,
    costs_lumber INT UNSIGNED NOT NULL,
    costs_iron INT UNSIGNED NOT NULL,
    costs_food INT UNSIGNED NOT NULL,
    constr_time MEDIUMINT(7) UNSIGNED NOT NULL,
    attack_damage SMALLINT UNSIGNED DEFAULT NULL,
    defense SMALLINT UNSIGNED NOT NULL,
    image_filename VARCHAR(64) DEFAULT NULL,
    speed TINYINT(2) NOT NULL,
    hold SMALLINT NOT NULL,
    PRIMARY KEY (id)
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS construction_in_progress ;
CREATE TABLE construction_in_progress
(
    id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
    island_id SMALLINT(4) UNSIGNED NOT NULL,
    type_id TINYINT(1) UNSIGNED NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(island_id) REFERENCES island(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

-- -------------------------------------------------------------

DROP TABLE IF EXISTS construction_task ;
CREATE TABLE  construction_task 
(
    id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
    progress_id MEDIUMINT UNSIGNED NOT NULL,
    construction_id TINYINT(2) UNSIGNED NOT NULL,
    quantity SMALLINT UNSIGNED NOT NULL,
    end_date DATETIME NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY(progress_id) REFERENCES construction_in_progress(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(construction_id) REFERENCES defense(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(construction_id) REFERENCES ship(id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8 ;

