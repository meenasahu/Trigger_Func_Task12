Create table Report_Table(
	product_id int primary key,
	sum_of_sales int ,
	sum_of_profit int 
	)

create table sales (
	id serial primary key,
	product_id int ,
	sales int ,
	profit int 
	)
	
insert  into sales (product_id,sales,profit) 
	values (101,500,150)
select * from sales

insert  into Report_Table (product_id,sum_of_sales,sum_of_profit) 
	values (102,544,422)
select * from Report_Table

create or Replace function update_Report_Table()
RETURNS Trigger as $$
DECLARE 
	sum_of_sales int;
    sum_Of_profit int;
begin
	if exists(select 1 from Report_Table where product_id=NEW.product_id) 
	then update Report_Table set sum_of_sales=NEW.sum_of_sales,sum_of_profit=NEW.sum_of_profit
	where product_id = NEW.product_id;
    else 
		insert into Report_Table (product_id,sum_of_sales,sum_of_profit)values (NEW.product_id,NEW.sum_of_sales,New.sum_of_profit);
	end if;
 RETURN New;
end;
$$ LANGUAGE plpgsql;

create trigger update_sales_trg
After insert on sales
for each row 
EXECUTE FUNCTION update_Report_Table();

select * from sales
select * from report_table

insert into sales values (12,200,135)

insert into report_table values (10,300,140)