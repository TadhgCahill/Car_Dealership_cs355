drop table if exists Department, Vehicle, Car, Truck, Motorcycle, Van_SUV, Employee, Customer, Sales, Service, Finance;
create table Department (
		id int primary key,
        phone_number varchar(25)
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
        make varchar(10),
        model varchar(15),
        trim varchar(10),
        price int,
        color varchar(10),
        availability_status varchar(10),
        horsepower int,
        known_damage varchar(50),
        seating_capacity int,
        used_or_new varchar(5),
        licesne_plate varchar(10),
        date_of_service date,
        service_type varchar(10),
        drive_train varchar(10),
        is_salvage bool,
        is_rebuilt bool,
        registration_up_to_date bool,
        smog_needed bool,
        sold_by char(9),
        commission_amount int,
        date_of_sale date,
        date_added_to_lot date, -- for the assertion to see how long its been here
        foreign key(sold_by) references Employee(ssn),
        check (commission_amount = price/10 or commission_amount is null) -- makes sure commision ammount is always 10% of sale price (we can change the amount if needed)
);
create table Car(
		vin char(17) primary key,
        body_type varchar(10),
        drive_type varchar(10),
        foreign key (vin) references Vehicle(vin)
);
create table Truck(
		vin char(17) primary key,
        bed_dimensions varchar(10),
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

-- Query 1: [all vehicles currently ready to purchase, with a year after 1999 and selling for less than $10,000]
select vin
from Vehicle
where year >= 1999 and price < 10000 and availability_status = "unsold"; -- maybe change availabilty status

-- Query 2: [A query that retrieves information of customers and vehicles they have purchased from that dealership. 
-- This will be useful for salespeople to contact them regarding trade-ins/upgrades or for service to contact them about their maintenance.]
select name, purchased_vehicle
from customer
where purchased_vehicle in  (select vin from vehicle where availability_status = "sold");

-- Query 3: [A query that can retrieve information about the sales department’s workers and cars sold. 
-- This would be useful for commission information.]
select vin -- need to check if this works
from Vehicle
join (select name from Employee where ssn in (select sold_by from Vehicle where availability_status = "sold")) on availability_status = "sold";

-- Query 4: [A query that will update the status of a vehicle. 
-- This allows the dealership to  view/update if a vehicle is sold, financed/leased, in transit, or available]
update Vehicle
set availability_status = "sold", sold_by = "ssn", commission_amount = price/10, date_of_sale =  CURRENT_DATE
where vin = "temp"; -- temp will be replaced with the car just sold

-- see if a car is available to purchased or financed
select availability_status
from vehicle
where vin = "temp";

