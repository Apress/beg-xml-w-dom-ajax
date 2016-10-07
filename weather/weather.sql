CREATE TABLE continent (
  continentID int(11) NOT NULL auto_increment,
  continent varchar(20) default NULL,
  PRIMARY KEY (continentID)
) TYPE=MyISAM;

CREATE TABLE country (
  countryID int(11) NOT NULL auto_increment,
  country varchar(100) default NULL,
  countryContinentID int(11) default NULL,
  PRIMARY KEY (countryID),
  FOREIGN KEY (countryContinentID) REFERENCES continent (continentID)
) TYPE=MyISAM;

CREATE TABLE area (
  areaID int(11) NOT NULL auto_increment,
  area varchar(100) default NULL,
  areaCountryID int(11) default NULL,
  PRIMARY KEY (areaID),
  FOREIGN KEY (areaCountryID) REFERENCES country (countryID)
) TYPE=MyISAM;

CREATE TABLE city (
  cityID int(11) NOT NULL auto_increment,
  city varchar(100) default NULL,
  cityAreaID int(11) default NULL,
  PRIMARY KEY (cityID),
  FOREIGN KEY (cityAreaID) REFERENCES area (areaID)
) TYPE=MyISAM;

CREATE TABLE weather (
  weatherID int(11) NOT NULL auto_increment,
  weatherDate int(11) default NULL,
  weatherMax int(4) default NULL,
  weatherMin int(4) default NULL,
  weatherCityID int(11) default NULL,
  weatherWeatherTypeID int(11) default NULL,
  PRIMARY KEY (weatherID),
  FOREIGN KEY (weatherCityID) REFERENCES city (cityID),
  FOREIGN KEY (weatherWeatherTypeID) REFERENCES weatherType (weatherTypeID)
) TYPE=MyISAM;

CREATE TABLE weatherType (
  weatherTypeID int(11) NOT NULL auto_increment,
  weatherType varchar(40) default NULL,
  PRIMARY KEY (weatherTypeID)
) TYPE=MyISAM;

INSERT INTO weatherType VALUES (1,'hot');
INSERT INTO weatherType VALUES (2,'sunny');
INSERT INTO weatherType VALUES (3,'windy');
INSERT INTO weatherType VALUES (4,'cloudy');
INSERT INTO weatherType VALUES (5,'rain');
INSERT INTO weatherType VALUES (6,'rainstorms');
INSERT INTO weatherType VALUES (7,'snow');
INSERT INTO weatherType VALUES (8,'snowstorms');

