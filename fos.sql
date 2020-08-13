create database fos;
use fos;

create table customers(
    cid int not null,
    cname varchar(50),
    cemail varchar(50) not null unique,
    cphone char(10),
    caddress varchar(50),
    PRIMARY KEY (cid)
);

create table restaurant(
    rid int not null,
    rname varchar(50),
    remail varchar(30) not null unique,
    rphone char(10),
    rlocality varchar(50),
    PRIMARY KEY (rid)
);

create table employee(
    eid int not null,
    ename varchar(50),
    eage int,
    ephone char(10),
    PRIMARY KEY(eid),
    check (eage>=18)
);

create table menu(
    foodid int not null,
    rid int not null,
    foodname varchar(30),
    foodtype varchar(10),
    foodprice int,
    PRIMARY KEY (foodid,rid),
    FOREIGN KEY (rid) references restaurant(rid) ON UPDATE CASCADE ON DELETE CASCADE 
);

create table orders(
    orderid int not null,
    cid int not null,
    rid int not null,
    eid int not null,
    totalprice int DEFAULT 0,
    numberofitems int DEFAULT 0,
    PRIMARY KEY (orderid),
    FOREIGN KEY (cid) references customers(cid) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (rid) references restaurant(rid) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (eid) references employee(eid) ON UPDATE CASCADE ON DELETE CASCADE
    
);

create table food(
    fid int not null,
    orderid int,
    fname varchar(50),
    price int,
    quantity int,
    foodid int,
    rid int,
    PRIMARY KEY (fid,orderid,foodid,rid),
    FOREIGN KEY (orderid) references orders(orderid) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (foodid,rid) references menu(foodid,rid) ON UPDATE CASCADE ON DELETE CASCADE
);

/**/
alter table food add check (quantity<5);
alter table employee add check (eage>=18);
/*trigger query*/
delimiter //
create trigger on_food_insert after insert on food
for each 
row 
begin
    update orders
    set totalprice = new.totalprice + new.price*new.quantity
    where new.orderid=orders.orderid;
    update orders
    set numberofitems = numberofitems+1
    where new.orderid=orders.orderid;
end
//
delimiter ;

insert into customers values(132,"Abhijit","mohantyabhijit074@gmail.com",9380246034,"Ashwathnagar");
insert into customers values(242,"Christopher henry Gayle","chris@gmail.com",9344665522,"sanjaynagar");
insert into customers values(356,"Abraham benjmin develliers","abdvelliers@gmail.com",9585754565,"mathikere");
insert into customers values(476,"Sachin","tendi@gmail.com",9898986565,"vadodara");
insert into customers values(598,"Virat kohli","cheeku@gmail.com",9296989795,"gazibad");
insert into customers values(668,"Rohit Sharma","rohit@gmail.com",9797979895,"boriwali");
insert into customers values(790,"Vangipurapu Venkata Sai Laxman","vvs@gmail.com",9380246034,"thane");
insert into customers values(899,"Rahul Dravid","rahulrahul@gmail.com",9865986598,"Venkatanarasimharajuvaripeta");
insert into customers values(192,"Ricky Ponting","Ponting198@gmail.com",9380249884,"gandhinagar");
insert into customers values(198,"Glenn Mgrath","glenn1234@gmail.com",8985566444,"Mirzapur");

insert into customers values(892,"Yuvraj Singh","yuvi@gmail.com",8485879662,"pathankot");
insert into customers values(178,"suresh raina","raina190@gmail.com",9382246762,"shimla");


insert into restaurant values(1259,"KFC","KFCindia@gmail.com",9380246034,"SanjayNagar");
insert into restaurant values(2427,"Dominos","Dominosindia@gmail.com",9344665522,"Ashwathnagar");
insert into restaurant values(8364,"PaPa John","papajohn1567@gmail.com",9585754565,"Bel road");
insert into restaurant values(5291,"CTR","shivsagar@gmail.com",9898986565,"malleshwaram");
insert into restaurant values(4351,"veena stores","veena1819@gmail.com",9296989795,"malleshwaram");
insert into restaurant values(3551,"Albek","albek2200@gmail.com",9797979895,"RT Nagar");
insert into restaurant values(3544,"Meghana's","meghnabiriyani@gmail.com",9380246034,"Rajiv chowk");
insert into restaurant values(3451,"paradise","paradisebangalore@gmail.com",9865986598,"Banashankari");
insert into restaurant values(9652,"Truffles","truffle@gmail.com",9380249884,"Bel Road");
/**/
insert into restaurant values(7895,"Kake Da Dhaba","kakadadhaba@gmail.com",9822556684,"Majithia Road");
insert into restaurant values(6854,"Apna Punjab","Punjabi@gmail.com",9822776684,"Rajouri Garden");
insert into restaurant values(9878,"Have More","havemore@gmail.com",6380522684,"Bel Road");

insert into menu values(121,2427,"Mexican Green Wave","Veg",559);
insert into menu values(345,2427,"Peppy Paneer","Veg",599);
insert into menu values(987,1259,"Chicken Bucket","Non Veg",499);
insert into menu values(438,5291,"Masala Dosa","Veg",40);
insert into menu values(524,8364,"Paneer Makhani","Veg",599);
insert into menu values(242,2427,"Pepper Barbeque Chicken","Non Veg",599);
insert into menu values(235,3551,"Tandoori Chicken","Non Veg",299);
insert into menu values(643,3451,"Chicken Biriyani","Non Veg",259);
insert into menu values(137,3544,"Veg Biriyani","Veg",259);
insert into menu values(098,4351,"Thatte Idli","Veg",35);
insert into menu values(958,2427,"Chicken Dominator","Non Veg",699);
insert into menu values(186,1259,"Chicken Burger","Non Veg",159);
insert into menu values(659,5291,"vada","Veg",20);
insert into menu values(731,3544,"Chicken Biriyani","Non Veg",299);
insert into menu values(192,1259,"Chicken wings","Non Veg",259);
/**/
insert into menu values(168,5291,"Onion Dosa","Veg",35);
insert into menu values(894,6854,"Chhole Kulche","Veg",60);
insert into menu values(179,3451,"Mutton Biriyani","Non Veg",299);

insert into employee values(143,"aditya",32,8989897854);
insert into employee values(952,"jerry",37,9685741425);
insert into employee values(352,"prashant",26,9598743256);
insert into employee values(153,"akhil",25,9785654525);
insert into employee values(851,"vimal",24,8996988954);
insert into employee values(651,"adarsh",20,9325874651);

insert into employee values(896,"Pranjal",22,9325878896);


insert into orders values(56891,476,2427,851,0,0);
insert into food values(115,56891,"Mexican Green Wave",559,1,121,2427);
insert into food values(225,56891,"Chicken Dominator",699,1,958,2427);

insert into orders values(25964,132,1259,153,0,0);
insert into food values(111,25964,"Chicken Bucket",499,1,987,1259);
insert into food values(222,25964,"Chicken Burger",159,3,186,1259);
insert into food values(333,25964,"Chicken Wings",259,192,3451);

insert into orders values(98954,598,5291,143,0,0);
insert into food values(252,98954,"Onion Dosa",35,2,168,5291);
insert into food values(264,98954,"vada",20,2,659,5291);
insert into food values(985,98954,"Masala Dosa",40,2,438,5291);


/*sql queries*/
select rname,remail,rphone,rlocality
from menu RIGHT join restaurant on restaurant.rid=menu.rid 
where menu.foodname is NULL


select DISTINCT customers.cname from customers 
where customers.cid in 
                    ( select orders.cid from orders 
                    where orders.rid in
                                        ( select restaurant.rid from restaurant 
                                        where restaurant.rname="Dominos"));

select employee.ename,employee.eage,employee.ephone 
from employee join orders on orders.eid=employee.eid 
where orders.rid in 
                    (select rid from restaurant 
                    where restaurant.rname="KFC")

select restaurant.rname 
from restaurant,menu 
where restaurant.rid=menu.rid 
GROUP BY restaurant.rname 
Having (COUNT(*))>=2

select customers.cname,customers.cphone 
from customers 
where customers.cid in 
                    (select orders.cid 
                    from orders 
                    where totalprice in (SELECT MAX(totalprice) from orders))

select * from restaurant r inner join (SELECT MIN(foodprice),foodname,rid from menu GROUP by menu.rid) F on F.rid=r.rid