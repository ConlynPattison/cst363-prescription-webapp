drop schema if exists drug;
create schema drug;
use drug;

create table doctor(
	id int primary key auto_increment,
	ssn varchar(9) not null,
	last_name varchar(30) not null,
	first_name varchar(30) not null,
	specialty varchar(30),
	practice_since int
);

create table patient(
	id int primary key auto_increment,
	ssn varchar(9) not null,
	last_name varchar(30) not null,
	first_name varchar(30) not null,
	street varchar(30) not null,
	city varchar(30) not null,
	state varchar(30) not null,
	zip varchar(30) not null,
	birthdate date not null,
	doctor_id int,
	foreign key(doctor_id) references doctor(id)
);

create table drug(
	drugID int not null primary key,
	name varchar(30)
);

insert into drug (drugID, name)
values 
	(10000, 'lisinopril'),
	(10010, 'mirtazapine');

create table pharmacy(
	id int not null primary key,
	name varchar(30) not null,
	address varchar(80) not null,
	phone varchar(30)
);

insert into pharmacy (id, name, address, phone)
values 
	( 1, 'CVS', '123 Main', '831-981-9207');

create table prescription(
	rxid int primary key auto_increment,
	doctor_id int not null,
	patient_id int not null,
	drug_id int not null references drugs,
	quantity int not null,
	create_date date default(curdate()),
	refills int default(0),
	foreign key(doctor_id) references doctor(id),
	foreign key(patient_id) references patient(id),
	foreign key(drug_id) references drug(drugid)
);

alter table prescription auto_increment = 10000000;

create table prescription_fill (
	rxid int not null,
	fill_no int not null,
	fill_date date default (curdate()),
	pharmacy_id int,
	cost numeric(8,2),
	primary key (rxid, fill_no),
	foreign key(rxid) references prescription(rxid),
	foreign key(pharmacy_id) references pharmacy(id)
);

create table drug_cost (
	pharmacy_id int not null,
	drug_id int not null,
	price numeric(9,2),
	primary key(pharmacy_id, drug_id),
	foreign key(pharmacy_id) references pharmacy(id),
	foreign key(drug_id) references drug(drugid)
);

insert into drug_cost 
values
	(1, 10000, 0.05);

insert into drug_cost
values
	(1, 10010, 0.10);

insert into doctor (id, ssn, last_name, first_name, specialty, practice_since)
values
	(1, '123456789', 'Smith', 'John', 'Cardiology', 2005),
	(2, '987654321', 'Johnson', 'Emily', 'Pediatrics', 2010),
	(3, '456789123', 'Garcia', 'Maria', 'Dermatology', 2008);

insert into patient (id, ssn, last_name, first_name, street, city, state, zip, birthdate, doctor_id)
values
	(1, '123321123', 'Brown', 'Taylor', '123 Oak', 'Monterey', 'CA', '93940', '2000-08-20', 1),
	(2, '951456753', 'Davis', 'Tyler', '45 Pine', 'Salinas', 'CA', '93901', '1970-10-26', 1),
	(3, '954231564', 'Martinez', 'Jessica', '983 Main', 'Salinas', 'CA', '93907', '1999-10-20', 2);

insert into prescription (rxid, doctor_id, patient_id, drug_id, quantity, create_date, refills)
values
	(10000001, 2, 1, 10010, 100, '2024-04-10', 2),
	(10000002, 3, 2, 10000, 50, '2018-08-20', 3);

insert into prescription_fill (rxid, fill_no, fill_date, pharmacy_id, cost)
values
	(10000002, 1, '2018-08-26', 1, 5);
