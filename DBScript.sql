DROP DATABASE `be`;
CREATE SCHEMA `be`;
USE be;

CREATE TABLE user ( 
	id 				INT(11) 		NOT NULL AUTO_INCREMENT, 
    firstname 		VARCHAR(256) 	NOT NULL, 
    lastname 		VARCHAR(256) 	NOT NULL, 
    email 			VARCHAR(256) 	NOT NULL, 
    password 		VARCHAR(2048) 	NOT NULL, 
    created 		DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    modified 		TIMESTAMP 		NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    CONSTRAINT 		PK_user 		PRIMARY KEY (id) 
);

CREATE TABLE emp (
	empid			INT			NOT NULL 	AUTO_INCREMENT,
	lastname        VARCHAR(20)	NOT NULL,
	firstname       VARCHAR(10) NOT NULL,
	title           VARCHAR(40) NOT NULL,
	titleofcourtesy VARCHAR(25) NOT NULL,
	birthdate       DATETIME	NOT NULL,
	hiredate        DATETIME	NOT NULL,
	address         VARCHAR(60) NOT NULL,
	city            VARCHAR(15) NOT NULL,
	region          VARCHAR(15) NULL,
	postalcode      VARCHAR(10) NULL,
	country         VARCHAR(15) NOT NULL,
	phone           VARCHAR(24) NOT NULL,
	mgrid           INT			NULL,
    CONSTRAINT 		PK_emp		PRIMARY KEY (empid)	
);

ALTER TABLE emp
	ADD CONSTRAINT	FK_emp_emp	FOREIGN KEY (mgrid) REFERENCES emp(empid),
	ADD CONSTRAINT	CHK_birthdate CHECK(birthdate <= CURRENT_TIMESTAMP);

INSERT INTO emp VALUES(NULL,'Blankens','John','President CEO','Mr.',"1951-10-05","2006-02-08",'200 University Ave W','Waterloo','ON','N2L 3G1','Canada','519-885-1211',NULL);
INSERT INTO emp VALUES(NUll,'Blankens','Elizabeth', 'VP Merchandising and Distribution', 'Mrs.',"1952-06-06","2006-07-06",'109 King St North','Waterloo','ON','N2J 2X5','Canada','519-884-6774',1); 
INSERT INTO emp VALUES(NUll,'Mcdougal','William','VP Marketing and Sales', 'Mr.',"1965-12-26","2006-09-25",'585 Weber St N','Waterloo','ON','N2V 1V8','Canada','519-746-3792',1);
INSERT INTO emp VALUES(NUll,'White','Joann','VP Finance and Systems','Mrs.',"1972-08-04","2008-06-10",'151 Columbia St','Waterloo','ON','N2L 3L2','Canada','519-886-8965',1); 
INSERT INTO emp VALUES(NUll,'Whitehead','Maryann','Director of International Purchasing','Mrs.',"1978-09-21","2011-08-30",'465 Phillip St','Waterloo','ON','N2L 6C7','Canada','519-884-2748',2); 
INSERT INTO emp VALUES(NUll,'Monson','Genny','AVP Retail Sales','Mrs.',"1979-01-22","2011-08-31",'65 University Ave East','Waterloo','ON','N2J 2V9','Canada','519-884-2871',3); 
INSERT INTO emp VALUES(NUll,'Sterling','April','AVP Accounting and Finance','Mrs.',"1984-05-24","2014-11-18",'50 Westmount Rd North','Waterloo','ON','N2J 2K6','Canada','519-888-8000',4); 
INSERT INTO emp VALUES(NUll,'Brunner','Nathan','AVP Production','Mr.',"1985-02-07","2015-06-05",'55 Northfield Dr E','Waterloo','ON','N2K 3T6','Canada','519-884-7226',2); 
INSERT INTO emp VALUES(NUll,'Jones','Joe','AVP Marketing / Advertising','Mr.',"1986-07-17","2016-07-20",'94 Bridgeport Rd East','Waterloo','ON','N2J 2J9','Canada','519-746-6804',3); 
INSERT INTO emp VALUES(NUll,'Preston','Mac','Chief Information Officer','Mr.',"1988-01-12","2017-08-14",'384 King St N','Waterloo','ON','N2J 2Z3','Canada','519-888-0001',4);     
    
CREATE TABLE sup
(
  supplierid		INT			NOT NULL 	AUTO_INCREMENT,
  companyname		VARCHAR(40) NOT NULL,
  contactname		VARCHAR(30) NOT NULL,
  contacttitle		VARCHAR(30) NOT NULL,
  address			VARCHAR(60) NOT NULL,
  city				VARCHAR(15) NOT NULL,
  region			VARCHAR(15) NULL,
  postalcode		VARCHAR(10) NULL,
  country			VARCHAR(15) NOT NULL,
  phone				VARCHAR(24) NOT NULL,
  fax				VARCHAR(24) NULL,
  CONSTRAINT		PK_sup		PRIMARY KEY (supplierid)
);

INSERT INTO sup VALUES(NULL,'Samsung','Carolyn J. Locke','Sales Representative','4736 rue de la Gauchetière','Montreal','QC','H3B 2M3','Canada','514-393-8038',NULL);
INSERT INTO sup VALUES(NULL,'Bose','India D. Huggins','Sales Representative','4402 Hyde Park Road','London','ON','N6E 1A9','Canada','519-681-6601',NULL);
INSERT INTO sup VALUES(NULL,'Canon','Charles B. McDade','Sales Representative','2693 Merivale Road','Ottawa','ON','K2P 0K1','Canada','613-255-4159',NULL);
INSERT INTO sup VALUES(NULL,'Motorola','Judith A. Easter','Sales Representative','2769 Pitt St','Cornwall','ON','K6J 3R2','Canada','613-577-6735',NULL);
INSERT INTO sup VALUES(NULL,'JBL','Toney S. Crenshaw','Sales Representative','347 Nelson Street','Echo Bay','ON','P0S 1C0','Canada','705-248-0227',NULL);
INSERT INTO sup VALUES(NULL,'Beats','Conrad E. Meyers','Sales Representative','4340 Blanshard','Victoria','BC','V8W 2H9','Canada','250-213-8166',NULL);
INSERT INTO sup VALUES(NULL,'Garmin','Russell B. Smith','Sales Representative','4703 Jasper Ave','Edmonton','AB','T5J 3N6','Canada','780-905-6136',NULL);
INSERT INTO sup VALUES(NULL,'Ecobee','Robert L. Johnson','Sales Representative','2126 Nelson Street','Sioux Narrows','ON','P0X 1N0','Canada','807-226-9562',NULL);
INSERT INTO sup VALUES(NULL,'TomTom','John H. Ward','Sales Representative','3300 Côte Joyeuse','St Malo','QC','H0H 0H0','Canada','819-658-6323',NULL);
INSERT INTO sup VALUES(NULL,'Pioneer','Timothy J. Koopman','Sales Representative','1880 René-Lévesque Blvd','Montreal','QC','H3B 4W8','Canada','514-585-1138',NULL);

CREATE TABLE cat
(
  categoryid		INT			NOT NULL 	AUTO_INCREMENT,
  categoryname		VARCHAR(40)	NOT NULL,
  description		VARCHAR(200)NOT NULL,
  CONSTRAINT		PK_cat		PRIMARY KEY (categoryid)
);

INSERT INTO cat VALUES(NULL,'TV & Video','Television and Video Equipment and Accessories');
INSERT INTO cat VALUES(NULL,'Home Audio & Theatre','Home Audio and Theatre Equipment and Accessories');
INSERT INTO cat VALUES(NULL,'Camera, Photo & Video','Camera, Photography and Video Equipment and Accessories');
INSERT INTO cat VALUES(NULL,'Cell Phones & Accessories','Cell Phones and Accessories');
INSERT INTO cat VALUES(NULL,'Bluetooth & Wireless Speakers','Bluetooth and Wireless Speakers and Accessories');
INSERT INTO cat VALUES(NULL,'Headphones','Headphones and Accessories');
INSERT INTO cat VALUES(NULL,'Wearable Technology','Wearable Technology and Accessories');
INSERT INTO cat VALUES(NULL,'Smart Home','Smart Home Equipment and Accessories');
INSERT INTO cat VALUES(NULL,'Car Electronics','Car Electronics and Accessories');
INSERT INTO cat VALUES(NULL,'Musical Instruments','Musical Instruments and Accessories');

CREATE TABLE prod
(
  productid			INT			NOT NULL 	AUTO_INCREMENT,
  productname		VARCHAR(40)	NOT NULL,
  supplierid		INT			NOT NULL,
  categoryid		INT			NOT NULL,
  unitprice			DOUBLE		NOT NULL	DEFAULT 0.0,
  discontinued		BIT			NOT NULL	DEFAULT 0,
  CONSTRAINT		PK_prod		PRIMARY KEY (productid)
);

ALTER TABLE prod
	ADD CONSTRAINT	FK_prod_cat	FOREIGN KEY (categoryid)	REFERENCES cat (categoryid),
    ADD CONSTRAINT	FK_prod_sup FOREIGN KEY (supplierid)	REFERENCES sup (supplierid),
    ADD CONSTRAINT	CHK_prod_unitprice CHECK(unitprice >= 0);
    
INSERT INTO prod VALUES(NULL,'Samsung 40" 4K Ultra HD Smart LED TV',1,1,499.00,0);
INSERT INTO prod VALUES(NULL,'Bose SoundTouch 300 SoundBar',2,2,1798.95,0);
INSERT INTO prod VALUES(NULL,'Canon Eos Rebel SL2 DSLR Camera',3,3,679.97,0);
INSERT INTO prod VALUES(NULL,'Motorola Moto E4',4,4,134.73,0);
INSERT INTO prod VALUES(NULL,'JBL Boombox Portable Bluetooth Speaker',5,5,449.00,0);
INSERT INTO prod VALUES(NULL,'Beats Solo3 Wireless On-Ear Headphones',6,6,225.99,0);
INSERT INTO prod VALUES(NULL,'Garmin Forerunner 235 GPS Watch',7,7,322.94,0);
INSERT INTO prod VALUES(NULL,'ecobee3 lite Smart Thermostat',8,8,199.99,0);
INSERT INTO prod VALUES(NULL,'TomTom VIA 1515TM 5" GPS',9,9,169.68,0);
INSERT INTO prod VALUES(NULL,'Pioneer DJ DDJ-SB3 DJ Controller',10,10,349.00,0);

CREATE TABLE cust
(
  custid			INT			NOT NULL	AUTO_INCREMENT,
  companyname		VARCHAR(40) NOT NULL,
  contactname		VARCHAR(30) NOT NULL,
  contacttitle		VARCHAR(30) NOT NULL,
  address			VARCHAR(60) NOT NULL,
  city				VARCHAR(15) NOT NULL,
  region			VARCHAR(15) NULL,
  postalcode		VARCHAR(10) NULL,
  country			VARCHAR(15) NOT NULL,
  phone				VARCHAR(24) NOT NULL,
  fax				VARCHAR(24) NULL,
  CONSTRAINT		PK_cust		PRIMARY KEY (custid)
);

INSERT INTO cust VALUES(NULL,'Air Canada','Calin Rovinescu','President and CEO','7373 Boulevard de la Côte-Vertu','Saint Laurent','QC','H4S 1Z3','Canada','888-247-2262',NULL);
INSERT INTO cust VALUES(NULL,'Best Buy Canada Ltd.','Ron Wilson','President and CEO','8800 Glenlyon Parkway','Burnaby','BC','V5J 5K3','Canada','866-237-8289',NULL);
INSERT INTO cust VALUES(NULL,'Canadian Tire Corporation, Limited','Stephen Wetmore','President and CEO','2180 Yonge Street','Toronto','ON','M4P 2V8','Canada','416-480-3000',NULL);
INSERT INTO cust VALUES(NULL,'Ford Motor Company of Canada, Limited','Barry Engle','President and CEO','1 The Canadian Road','Oakville','ON','L6J 5E4','Canada','905-845-2511','905-845-5759');
INSERT INTO cust VALUES(NULL,'Mars Canada Inc','Chris Hamilton','President','37 Holland Dr','Bolton','ON','L7E 5S4','Canada','905-857-5780',NULL);
INSERT INTO cust VALUES(NULL,'Procter & Gamble Inc.','David S. Taylor','President and CEO','4711 Yonge St','North York','ON','M2N 6K8','Canada','416-730-4711',NULL);
INSERT INTO cust VALUES(NULL,'Royal Bank of Canada','David I. McKay','President and CEO','200 Bay Street','Toronto','ON','M5J 2J5','Canada','416-974-5151',NULL);
INSERT INTO cust VALUES(NULL,'SAP Canada Inc.','Andy Canham','Managing Director','855 2nd Street, S.W Bankers Hall – Suite 3900','Calgary','AB','T2P 4J8','Canada','403-269-5222','403-234-8082');
INSERT INTO cust VALUES(NULL,'Thomson Reuters Canada Limited','James C. Smith','President and CEO','333 Bay Street','Toronto','ON','M5H 4G3','Canada','416-609-3800',NULL);
INSERT INTO cust VALUES(NULL,'University of Waterloo','Feridun Hamdullahpur','President and Vice-Chancellor','200 University Ave W','Waterloo','ON','N2L 3G1','Canada','519-888-4567',NULL);

CREATE TABLE ship
(
  shipperid			INT			NOT NULL	AUTO_INCREMENT,
  companyname		VARCHAR(40)	NOT NULL,
  phone				VARCHAR(24)	NOT NULL,
  CONSTRAINT		PK_ship		PRIMARY KEY (shipperid)
);

INSERT INTO ship VALUES(NULL,'Purolator','578-481-7003');
INSERT INTO ship VALUES(NULL,'FedEx','464-904-2287');
INSERT INTO ship VALUES(NULL,'UPS','827-296-9063');
INSERT INTO ship VALUES(NULL,'DHL','647-222-6469');
INSERT INTO ship VALUES(NULL,'Canada Post','401-412-7958');

CREATE TABLE ord
(
  orderid			INT			NOT NULL	AUTO_INCREMENT,
  custid			INT			NULL,
  empid				INT			NOT NULL,
  orderdate			DATETIME	NOT NULL,
  requireddate		DATETIME	NOT NULL,
  shippeddate		DATETIME	NULL,
  shipperid			INT			NOT NULL,
  freight			DOUBLE		NOT NULL	DEFAULT 0.0,
  shipname			VARCHAR(40) NOT NULL,
  shipaddress		VARCHAR(60) NOT NULL,
  shipcity			VARCHAR(15) NOT NULL,
  shipregion		VARCHAR(15) NULL,
  shippostalcode	VARCHAR(10) NULL,
  shipcountry		VARCHAR(15) NOT NULL,
  CONSTRAINT		PK_ord		PRIMARY KEY (orderid)
);

ALTER TABLE ord 
	ADD CONSTRAINT	FK_ord_cust	FOREIGN KEY (custid)	REFERENCES cust (custid),
    ADD CONSTRAINT	FK_ord_emp	FOREIGN KEY (empid)		REFERENCES emp (empid),
    ADD CONSTRAINT	FK_ord_ship FOREIGN KEY (shipperid)	REFERENCES ship (shipperid);

INSERT INTO ord VALUES(NULL,1,3,"2018-01-08","2018-01-30","2018-01-24",1,9.99,'Calin Rovinescu','7373 Boulevard de la Côte-Vertu','Saint Laurent','QC','H4S 1Z3','Canada');
INSERT INTO ord VALUES(NULL,2,3,"2018-01-24","2018-02-02","2018-01-29",2,9.99,'Ron Wilson','8800 Glenlyon Parkway','Burnaby','BC','V5J 5K3','Canada');
INSERT INTO ord VALUES(NULL,3,3,"2018-01-29","2018-02-13","2018-02-06",3,0.00,'Stephen Wetmore','2180 Yonge Street','Toronto','ON','M4P 2V8','Canada');
INSERT INTO ord VALUES(NULL,4,3,"2018-02-27","2018-03-16","2018-03-02",4,0.00,'Barry Engle','1 The Canadian Road','Oakville','ON','L6J 5E4','Canada');
INSERT INTO ord VALUES(NULL,5,3,"2018-03-14","2018-04-06","2018-03-20",5,19.99,'Chris Hamilton','37 Holland Dr','Bolton','ON','L7E 5S4','Canada');
INSERT INTO ord VALUES(NULL,6,6,"2018-04-02","2018-04-13","2018-04-06",1,9.99,'David S. Taylor','4711 Yonge St','North York','ON','M2N 6K8','Canada');
INSERT INTO ord VALUES(NULL,7,6,"2018-05-04","2018-05-28","2018-05-07",2,0.00,'David I. McKay','200 Bay Street','Toronto','ON','M5J 2J5','Canada');
INSERT INTO ord VALUES(NULL,8,6,"2018-06-12","2018-06-29","2018-06-20",3,0.00,'Andy Canham','855 2nd Street, S.W Bankers Hall – Suite 3900','Calgary','AB','T2P 4J8','Canada');
INSERT INTO ord VALUES(NULL,9,6,"2018-07-13","2018-08-15","2018-07-31",4,9.99,'James C. Smith','333 Bay Street','Toronto','ON','M5H 4G3','Canada');
INSERT INTO ord VALUES(NULL,10,6,"2018-07-19","2018-08-22","2018-08-20",5,9.99,'Feridun Hamdullahpur','200 University Ave W','Waterloo','ON','N2L 3G1','Canada');


CREATE TABLE ordd
(
  orderid			INT				NOT NULL,
  productid			INT				NOT NULL,
  unitprice			DOUBLE			NOT NULL	DEFAULT 0.0,
  qty				SMALLINT		NOT NULL	DEFAULT 1,
  discount			NUMERIC(4, 3)	NOT NULL	DEFAULT 0,
  CONSTRAINT		PK_ordd			PRIMARY KEY (orderid, productid)
);

ALTER TABLE ordd
	ADD CONSTRAINT FK_ordd_ord		FOREIGN KEY(orderid)	REFERENCES ord(orderid),
    ADD CONSTRAINT FK_ordd_prod		FOREIGN KEY(productid)	REFERENCES prod(productid),
    ADD CONSTRAINT CHK_discount		CHECK (discount BETWEEN 0 AND 1),
	ADD CONSTRAINT CHK_qty			CHECK (qty > 0),
	ADD CONSTRAINT CHK_unitprice	CHECK (unitprice >= 0);

INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 1, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 1;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 1, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 2;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 1, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 3;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 2, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 4;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 2, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 5;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 2, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 6;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 3, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 7;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 3, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 8;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 3, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 9;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 4, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 10;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 4, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 1;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 4, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 2;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 5, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 3;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 5, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 4;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 5, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 5;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 6, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 6;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 6, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 7;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 6, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 8;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 7, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 9;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 7, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 10;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 7, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 1;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 8, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 2;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 8, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 3;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 8, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 4;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 9, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 5;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 9, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 6;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 9, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 7;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 10, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 8;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 10, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 9;
INSERT INTO ordd (orderid, productid, unitprice, qty, discount) SELECT 10, productid, unitprice, (FLOOR(RAND() * 5) + 1), 0.0 FROM prod WHERE productid = 10;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(256) NOT NULL,
  `lastname` varchar(256) NOT NULL,
  `email` varchar(256) NOT NULL,
  `password` varchar(2048) NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
