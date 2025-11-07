-- Drop Tables
DROP TABLE IF EXISTS [customer_satisfaction];
DROP TABLE IF EXISTS [salary];
DROP TABLE IF EXISTS [employee];
DROP TABLE IF EXISTS [employment_type];
DROP TABLE IF EXISTS [department];
DROP TABLE IF EXISTS [customers];
DROP TABLE IF EXISTS [train_station];
DROP TABLE IF EXISTS [ticket];
DROP TABLE IF EXISTS [station];
DROP TABLE IF EXISTS [train];

-- Create Tables
CREATE TABLE [train](
	[id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[name] nvarchar(50) NOT NULL,
)
GO

CREATE TABLE [station](
	[id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[location] nvarchar(200) NOT NULL,
)
GO

CREATE TABLE [ticket](
	[id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[type] nvarchar(50) NOT NULL,
	[price] [decimal] NOT NULL,
)
GO

CREATE TABLE [train_station](
	[id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[fk_train] [int] NOT NULL,
	[fk_station] [int] NOT NULL,
	CONSTRAINT UQ_trainStation_trainId_stationId UNIQUE (fk_train, fk_station),
	CONSTRAINT fk_trainStation_train FOREIGN KEY (fk_train) REFERENCES train (id),
	CONSTRAINT fk_trainStation_station FOREIGN KEY (fk_station) REFERENCES station (id)
)
GO

CREATE TABLE [customers](
	[id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[first_name] nvarchar(100) NOT NULL,
	[last_name] nvarchar(100) NOT NULL,
	[email] nvarchar(50) NOT NULL,
	[fk_ticket] [int] NOT NULL,
	[pet] bit NOT NULL,
	[baggage] bit NOT NULL,
	[fk_train_station] [int] NOT NULL
	CONSTRAINT fk_customers_ticket FOREIGN KEY (fk_ticket) REFERENCES ticket (id),
	CONSTRAINT fk_customers_trainStation FOREIGN KEY (fk_train_station) REFERENCES train_station (id),
) 
GO

CREATE TABLE [department](
	[id] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[name] nvarchar(100) NOT NULL
	
)
GO

CREATE TABLE [employment_type](
	[id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[type] nvarchar(50) NOT NULL 
)
GO

CREATE TABLE [employee](
	[id] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[employee_id] [int] NOT NULL,
	[first_name] nvarchar(100) NOT NULL,
	[last_name] nvarchar(100) NOT NULL,
	[email] nvarchar(50) NOT NULL,
	[address] nvarchar(200) NOT NULL,
	[fk_department] [int] NOT NULL,
	[fk_employment_type] [int] NOT NULL,
	CONSTRAINT UQ_employeeId UNIQUE (employee_id),
	CONSTRAINT fk_employee_department FOREIGN KEY (fk_department) REFERENCES department (id),
	CONSTRAINT fk_employee_employmentType FOREIGN KEY (fk_employment_type) REFERENCES employment_type (id)
)
GO

CREATE TABLE [salary](
	[id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[fk_employee] [int] NOT NULL,
	[start_date] [date] NOT NULL,
	[pay] [money] NOT NULL,
	CONSTRAINT UQ_salary UNIQUE (id, fk_employee),
	CONSTRAINT fk_salary_employee FOREIGN KEY (fk_employee) REFERENCES employee (id),
)
GO

CREATE TABLE [customer_satisfaction](
	[id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[fk_customer] [int] NOT NULL,
	[rating] [int] NOT NULL,
	[notes] nvarchar(500) NOT NULL,
	CONSTRAINT fk_customerSatisfaction_customer FOREIGN KEY (fk_customer) REFERENCES customers (id),
)
GO

-- Populate Data

--Train table
insert into train (name) values ('Virgin train');
--station table
insert into station (location) values ('Birmingham New Street, London')
insert into station (location) values ('Liverpool Lime Street, London')
insert into station (location) values ('Manchester Piccadilly, London')
insert into station (location) values ('Glasgow Central, London')
--Ticket table
insert into ticket (type, price) values ('Economy',80)
insert into ticket (type, price) values ('Business Class', 300)
insert into ticket (type, price) values ('First Class / Cabin', 800)

--Train station table
insert into train_station (fk_train, fk_station) values (1,1)
insert into train_station (fk_train, fk_station) values (1,2)
insert into train_station (fk_train, fk_station) values (1,3)
insert into train_station (fk_train, fk_station) values (1,4)

--Customers table
insert into customers (first_name, last_name,email,fk_ticket,pet,baggage,fk_train_station)
values
('Lilly', 'Scarlet','lillyscarlet@gmail.com', 2, 1, 1, 3)
insert into customers (first_name, last_name,email,fk_ticket,pet,baggage,fk_train_station)
values
('Dave', 'Johnson','davejohnson@gmail.com', 1, 0, 0, 1)
insert into customers (first_name, last_name,email,fk_ticket,pet,baggage,fk_train_station)
values
('Kent', 'Wellington','kentwellington@gmail.com', 1, 0, 1, 4)
insert into customers (first_name, last_name,email,fk_ticket,pet,baggage,fk_train_station)
values
('Sherry', 'Thompson','sherrythompson@gmail.com', 2, 0, 1, 3)
insert into customers (first_name, last_name,email,fk_ticket,pet,baggage,fk_train_station)
values
('Diva', 'Golden','divagolden@gmail.com', 3, 1, 1, 4)
insert into customers (first_name, last_name,email,fk_ticket,pet,baggage,fk_train_station)
values
('Sherlock', 'Holmes','sherlockholmes@gmail.com', 1, 0, 0, 2)
insert into customers (first_name, last_name,email,fk_ticket,pet,baggage,fk_train_station)
values
('John', 'Watson','johnwatson@gmail.com', 1, 0, 0, 2)
--Department table
insert into department (name) values ('Cafeteria')
insert into department (name) values ('Security')
insert into department (name) values ('Cabin Crew')
insert into department (name) values ('Bar')
insert into department (name) values ('House Keeping')
insert into department (name) values ('Gift Shop')
--Employee type table
insert into employment_type(type) values ('full-time')
insert into employment_type(type) values ('part-time')
--Employee table
insert into employee (employee_id, first_name, last_name, email, address, fk_department,fk_employment_type)
values 
(13579, 'Lana', 'Sanchez', 'lanasanchez@virginrails.com', '159 North Road Western Central London WC33 7PE', 6, 2)
insert into employee (employee_id, first_name, last_name, email, address, fk_department,fk_employment_type)
values 
(24680, 'Cayden', 'Franco', 'caydenfrancoz@virginrails.com', '2 Main Road East London E54 3YT', 2, 1)
insert into employee (employee_id, first_name, last_name, email, address, fk_department,fk_employment_type)
values 
(12458, 'Paula', 'Morrison', 'paulamorrison@virginrails.com', '98 Main Road East Central London EC14 4JM', 1, 2)
insert into employee (employee_id, first_name, last_name, email, address, fk_department,fk_employment_type)
values 
(23568, 'Castiel', 'Joseph', 'castieljoseph@virginrails.com', '8420 Grove Road Western Central London WC30 5GD', 4, 2)
insert into employee (employee_id, first_name, last_name, email, address, fk_department,fk_employment_type)
values 
(96385, 'Amy', 'Lee', 'amylee@virginrails.com', '303 Kings Road North West London NW82 8NI', 3, 1)
insert into employee (employee_id, first_name, last_name, email, address, fk_department,fk_employment_type)
values 
(74185, 'John', 'Smith', 'johnsmith@virginrails.com', '83 Manor Road South West London SW26 7PV', 5, 1)
--Salary table
insert into salary (fk_employee,start_date,pay) values (1, '2023-01-13', 22)
insert into salary (fk_employee,start_date,pay) values (2, '2022-03-22', 30)
insert into salary (fk_employee,start_date,pay) values (3, '2024-05-18', 25)
insert into salary (fk_employee,start_date,pay) values (4, '2023-01-13', 25)
insert into salary (fk_employee,start_date,pay) values (5, '2022-03-22', 30)
insert into salary (fk_employee,start_date,pay) values (6, '2024-05-18', 22)
--Customer satisfaction table
insert into customer_satisfaction (fk_customer, rating,notes) values (1, 8, 'The seats in economy are not great for long trips. Overall great experience!')
insert into customer_satisfaction (fk_customer, rating,notes) values (2, 9, 'N/A')
insert into customer_satisfaction (fk_customer, rating,notes) values (3, 8, 'N/A')
insert into customer_satisfaction (fk_customer, rating,notes) values (4, 10, 'Great experience, good food and service')
insert into customer_satisfaction (fk_customer, rating,notes) values (5, 10, 'Amazing luxurious cabin service')
insert into customer_satisfaction (fk_customer, rating,notes) values (6, 9, 'N/A')
insert into customer_satisfaction (fk_customer, rating,notes) values (7, 9, 'N/A')