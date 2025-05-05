drop table if exists Sales, Service, Finance, Car, Truck, Motorcycle, Van_SUV, Employee, Customer, Vehicle, Department;
drop VIEW if exists top_sellers, need_service;
create table Department (
		id int primary key,
        phone_number varchar(25),
		name varchar(30)
);

create table Employee (
		ssn char(9) primary key,
        name varchar(30),
        phone_number varchar (20),
        pay int,
        tenure int,
        manager_ssn char(9),
        dept_id int,
        foreign key(manager_ssn) references Employee(ssn),
        foreign key(dept_id) references Department(id),
        check (pay > 16) -- added constraint to make sure eveery employee is getting california minimum wage
);
create table Vehicle (
		vin char(17) primary key,
        mileage int,
        mpg int,
        year int,
        make varchar(30),
        model varchar(30),
        trim varchar(30),
        price int,
        color varchar(30),
        availability_status varchar(30),
        horsepower int,
        known_damage varchar(50),
        seating_capacity int,
        used_or_new varchar(10),
        licesne_plate varchar(10),
        date_of_service date,
        service_type varchar(30),
        drive_train varchar(30),
        is_salvage bool,
        is_rebuilt bool,
        registration_up_to_date bool,
        smog_needed bool,
        sold_by char(9),
        commission_amount float,
        date_of_sale date,
        date_added_to_lot date, -- for the assertion to see how long its been here
        foreign key(sold_by) references Employee(ssn),
        check (commission_amount is null or commission_amount <= price/10) -- makes sure commision ammount is always 10% of sale price (we can change the amount if needed)
);
create table Car(
		vin char(17) primary key,
        body_type varchar(10),
        drive_type varchar(10),
        foreign key (vin) references Vehicle(vin)
);
create table Truck(
		vin char(17) primary key,
        bed_dimensions varchar(30),
        towing_capacity int,
        crew_or_single_cab varchar(10),
		foreign key (vin) references Vehicle(vin)
);
create table Motorcycle(
		vin char(17) primary key,
        ccs int,
        motorcycle_type varchar(15),
		foreign key (vin) references Vehicle(vin)
);
create table Van_SUV(
		vin char(17) primary key,
        has_third_row bool,
        foreign key (vin) references Vehicle(vin)
);

create table Service (
		id int,
        worked_on_vehicle char(17),
        foreign key(id) references Department(id),
        foreign key(worked_on_vehicle) references Vehicle(vin)
);
create table Finance (
		id int,
        total_loans int,
        total_leases int,
        foreign key(id) references Department(id)
);
create table Sales (
		id int,
        total_sales int,
        foreign key(id) references Department(id)
);
create table Customer(
		ssn char(9) primary key,
        name varchar(30),
        phone_number varchar(20),
        address varchar(50),
        credit_score int,
        secondary_owner varchar(30),
        purchased_vehicle char(17),
        foreign key(purchased_vehicle) references Vehicle(vin)
);

insert into Vehicle
values ("5FPYK3F64SB026882",23,21,2025,"Honda","Ridgeline", "TrailSport",
		 48765, "Light Blue", "unsold", 280, null, 5, "new", null, 
         null,null, "AWD", false, false, true,false, null, null,null, "2025-04-01");
         
insert into Truck
values("5FPYK3F64SB026882", "63 by 55 inches", 5000, "crew");

insert into Vehicle
values ("5FPYK3F8XSB019792",13,21,2025,"Honda","Ridgeline", "Black Edition",
		 48200, "Black", "unsold", 280, null, 5, "new", null, 
         null,null, "AWD", false, false, true,false, null, null,null, "2025-03-21");
         
insert into Truck
values("5FPYK3F8XSB019792", "63 by 55 inches", 5000, "crew");

insert into Vehicle
values ("3C63RRHL8MG549203",33807,12,2021,"Ram","3500", "Big Horn",
		 53000, "White", "unsold", 400, "light scratches in the bed", 5, "used", "8JWS031", 
         "2025-03-15","maintenance", "4WD", false, false, true,false, null, null,null, "2025-02-23");
         
insert into Truck
values("3C63RRHL8MG549203", "96 by 50 inches", 37100, "crew");

insert into Vehicle
values ("7FARS6H52SE083394",2,37,2025,"Honda","CR-V Hybrid", "Sport",
		 37545, "Black", "unsold", 204, null, 5, "new", null, 
         null,null, "AWD", false, false, true,false, null, null,null, "2025-03-13");
         
insert into Van_SUV
values("7FARS6H52SE083394", false);


insert into Vehicle
values ("5FNYG1H80SB118326",5,21,2025,"Honda","Pilot", "Elite",
		 54985, "White", "unsold", 285, null, 8, "new", null, 
         null,null, "AWD", false, false, true,false, null, null,null, "2025-03-30");
         
insert into Van_SUV
values("5FNYG1H80SB118326", true);

insert into Vehicle
values ("2HGFE4F8XSH327649",7,49,2025,"Honda","Civic Hybrid", "Sport Touring",
		 33100, "Grey", "unsold", 200, null, 5, "new", null, 
         null,null, "FWD", false, false, true,false, null, null,null, "2025-03-28");
         
insert into Car
values("2HGFE4F8XSH327649", "sedan", "FWD");

insert into Vehicle
values ("2HGFE1E51SH476103",1,32,2025,"Honda","Civic Si", "Base",
		 32115, "Grey", "unsold", 200, null, 5, "new", null, 
         null,null, "FWD", false, false, true,false, null, null,null, "2025-04-01");
         
insert into Car
values("2HGFE1E51SH476103", "sedan", "FWD");

insert into Vehicle
values ("5FNYF9H38TB003562",9,22,2026,"Honda","Passport", "RTL Towing",
		 47870, "Grey", "unsold", 285, null, 5, "new", null, 
         null,null, "AWD", false, false, true,false, null, null,null, "2025-02-19");
         
insert into Van_SUV
values("5FNYF9H38TB003562", false);

insert into Vehicle
values ("5FNRL6H63SB049417",3,24,2025,"Honda","Odyssey", "EX-L",
		 45145, "White", "unsold", 280, null, 8, "new", null, 
         null,null, "FWD", false, false, true,false, null, null,null, "2025-01-02");
         
insert into Van_SUV
values("5FNRL6H63SB049417", true);

insert into Vehicle
values ("3FA6P0SU5HR277136",88375,42,2017,"Ford","Fusion Energi", "Titanium",
		 14000, "Red", "unsold", 188, null, 5, "used", "8YCO592", 
         "2025-03-29","maintenance", "FWD", false, false, true,false, null, null,null, "2025-01-29");
         
insert into Car
values("3FA6P0SU5HR277136", "sedan", "FWD");

insert into Vehicle
values ("JHMAP21408S001676",72523,21,2008,"Honda","S2000", "Base",
		 35500, "Silver", "unsold", 237, null, 2, "used", "6JSW921", 
         null,null, "RWD", false, false, true,false, null, null,null, "2025-04-04");
         
insert into Car
values("JHMAP21408S001676", "Coupe", "RWD");
insert into Vehicle
values ("1GYS4NKT0MR346580",64878,23,2021,"Cadillac","Escalade", "ESV Sport",
		 66400, "Black", "unsold", 277, null, 7, "used", "9LCP354", 
         "2025-03-09","maintenance", "4WD", false, false, true,false, null, null,null, "2025-03-24");
         
insert into Van_SUV
values("1GYS4NKT0MR346580", true);

insert into Vehicle
values ("MH3RH25Y5SK001308",1,56,2025,"Yamaha","YZF-R3", null,
		 5499, "Black", "unsold", 42, null, 7, "new", null, 
        null,null, "RWD", false, false, true,false, null, null,null, "2025-01-23");
         
insert into Motorcycle
values("MH3RH25Y5SK001308", 321,"Supersport");

insert into Vehicle
values ("ZDMBAS2N6SB003748",2,49,2025,"Ducati","Hypermotard 698", "Mono RVE",
		 14895, "Graffiti", "unsold", 77, null, 2, "new", null, 
         null,null, "RWD", false, false, true,false, null, null,null, "2025-01-28");

-- To insert Departments
-- Service
insert into Department
values(100,7075262722, "Service");
-- Sales
insert into Department
values(101,7075425377, "Sales");
-- Finance
insert into Department
values(102,7076837873, "Finance");

insert into Sales
values(101, 23);

insert into Finance
values(102,3,12);

-- To insert Employees
insert into Employee
values(999001111, "David Tayor", 5559990011, 120000, 12, null, 101);
insert into Employee
values(123456789, "John Smith", 5551234567, 50000, 2, 999001111, 101);
insert into Employee
values(987654321, "Jane Doe", 5559876543, 60000, 8, 999001111, 101);
insert into Employee
values(111223333, "Alice Johnson", 5551112233, 45000, 3, 999001111, 101);
insert into Employee
values(444556666, "Robert Brown", 5554445566, 52000, 6, 999001111, 101);
insert into Employee
values(777889999, "Emily White", 5557778899, 48000, 4, 999001111, 101);
insert into Employee
values(222334444, "Michael Green", 5552223344, 55000, 7, 999001111, 101);
insert into Employee
values(888776666, "Sarah Black", 5558887766, 47000, 2, 999001111, 101);
insert into Employee
values(666554444, "Laura Scott", 5556665544, 49000, 5, 999001111, 101);
insert into Employee
values(333221111, "Kevin Walker", 5553332211, 53000, 6, 999001111, 101);

insert into Employee
values(555443333, "Olivia Martin", 5555443333, 140000, 10, null, 102);
INSERT INTO Employee (ssn, name, phone_number, pay, tenure, manager_ssn, dept_id) VALUES
(123549876, "Mark Wilson", 5551234987, 59800, 6, 555443333, 102),
(456789123, "Lucy Adams", 5554567891, 55200, 4, 555443333, 102),
(789123456, "Nathan Cooper", 5557891234, 60950, 5, 555443333, 102),
(839237593, "Stella Carter", 5553082255, 64400, 8, 555443333, 102),
(654321987, "Liam Bennett", 5556543219, 54050, 3, 555443333, 102),
(321098765, "Sophia Daniels", 5553210987, 56350, 4, 555443333, 102),
(213476589, "Evan Hawkins", 5552134765, 62100, 7, 555443333, 102),
(432875610, "Mia Parker", 5554328756, 63250, 5, 555443333, 102),
(876543210, "Jack Robinson", 5558765432, 57500, 6, 555443333, 102);

insert into Employee
values(581043856, "John Doe", 5551203222, 100000, 4, null, 100);
INSERT INTO Employee (ssn, name, phone_number, pay, tenure, manager_ssn, dept_id) VALUES
(112233445, "Charlotte Hill", 5551122334, 57500, 6, 581043856, 100),
(223344556, "Oliver Brooks", 5552233445, 58000, 5, 581043856, 100),
(334455667, "Amelia Bennett", 5553344556, 61000, 7, 581043856, 100),
(445566778, "James Evans", 5554455667, 64000, 9, 581043856, 100),
(556677889, "Isabella Garcia", 5555566778, 59000, 6, 581043856, 100),
(667788990, "Luka Tim", 5556677889, 53000, 4, 581043856, 100),
(778899001, "Mia Peterson", 5557788990, 56000, 5, 581043856, 100),
(889900112, "Noah Reed", 5558899001, 60000, 8, 581043856, 100),
(990011223, "Sophia Hughes", 5559900112, 62000, 7, 581043856, 100);

insert into Motorcycle
values("ZDMBAS2N6SB003748", 659,"Sports Bike");

insert into Vehicle
values ("KMTG34TA5PU116459",1855,25,2023,"Genesis","G70", "Base",
		 31592, "Black", "sold", 252, null, 5, "used", "9JEG171", 
         null,null, "RWD", false, false, true,false, 222334444, 31592/10, "2025-03-23", "2025-03-20");
         
insert into Car
values("KMTG34TA5PU116459", "sedan", "RWD");

insert into Vehicle
values ("JTEFU5JR4P5303168",34961,18,2023,"Toyota","4Runner", "SR5 Premium",
		 42993, "Red", "sold", 270, null, 5, "used", "9GED482", 
         null,null, "RWD", false, false, true,false, 888776666, 42993 * 0.10, "2025-03-29", "2025-02-09" );
         
insert into Van_SUV
values("JTEFU5JR4P5303168", false);

insert into Vehicle
values ("5LMCJ1DA6PUL09339",27870,24,2023,"Lincoln","Corsair", "Standard",
		 27996, "Silver", "sold", 266, null, 5, "used", "9HEJ381", 
         null,null, "AWD", false, false, true,false, 666554444, 2799, "2025-04-2", "2024-12-29");
         
insert into Van_SUV
values("5LMCJ1DA6PUL09339", false);







-- Insert into Customers
insert into Customer
values(432552222, "Elowen Faraday",5558219000, "321 Cypress Dr, Monterey, California",720, null, "5LMCJ1DA6PUL09339");
insert into Customer
values(332441111, "Thaddeus Quill",5558219230, "456 Redwood Ln, Eureka California",680, "Maribel Quill", "JTEFU5JR4P5303168");
insert into Customer
values(923773333, "Percival Hawthorne",5559999999, "202 Sunset Blvd, Beverly Hills, California",810, "Seraphina Hawthorne", "KMTG34TA5PU116459");







insert into Service
values(100, "1GYS4NKT0MR346580");
insert into Service
values(100, "3C63RRHL8MG549203");
insert into Service
values(100, "3FA6P0SU5HR277136");



-- Query 1: [all vehicles currently ready to purchase, with a year after 1999 and selling for less than $10,000]
select vin
from Vehicle
where year >= 1999 and price < 10000 and availability_status = "unsold"; -- maybe change availabilty status

-- Query 2: [A query that retrieves information of customers and vehicles they have purchased from that dealership. 
-- This will be useful for salespeople to contact them regarding trade-ins/upgrades or for service to contact them about their maintenance.]
select name, purchased_vehicle
from Customer
where purchased_vehicle in  (select vin from Vehicle where availability_status = "sold");

-- Query 3: [A query that can retrieve information about the sales department’s workers and cars sold. 
-- This would be useful for commission information.]
select Vehicle.vin, Employee.name-- need to check if this works
from Vehicle
join Employee on Vehicle.availability_status = "sold" and Employee.ssn = Vehicle.sold_by;

-- -- Query 4: [A query that will update the status of a vehicle. 
-- -- This allows the dealership to  view/update if a vehicle is sold, financed/leased, in transit, or available]
update Vehicle
set availability_status = "sold", sold_by = "ssn", commission_amount = price/10, date_of_sale =  CURRENT_DATE
where vin = "temp"; -- temp will be replaced with the car just sold

-- query 5 using groupby and aggregate
select make, model, trim, price, count(make)
from Vehicle
where price < 50000
group by make;

-- query 6 first view
create view top_sellers as 
select Employee.name, sum(Vehicle.price)
from Employee, Vehicle
where Employee.ssn in (select Vehicle.sold_by from Vehicle) 
order by sum(Vehicle.price);

SELECT * FROM top_sellers;

-- query 7 second view
create view need_service as
select Customer.name, Customer.purchased_vehicle
from Customer 
where Customer.purchased_vehicle in (select Vehicle.vin from Vehicle where curdate() - Vehicle.date_of_service >1);

select * from need_service;


