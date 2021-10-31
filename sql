#1 Write a SELECT statement that returns these column names and data from the Products table:
              product_name               The product_name column

              list_price                        The list_price column

              discount_percent            The discount_percent column

              discount_amount            A column that’s calculated from the previous two columns

              discount_price               A column that’s calculated from the previous three columns

Round the discount_amount and discount_price columns to two decimal places. Sort the result set by the discount_price column in descending sequence. 
Use the LIMIT clause so the result set contains only the first five rows.

ANSWER:
select product_name, list_price, discount_percent, 
round(discount_percent*list_price, 2) AS discount_amount,
round(list_price - (discount_percent/100 *list_price), 2) AS discount_price
from products
order by discount_price desc
LIMIT 5;

#2 Write a SELECT statement that returns these column names and data from the Order_Items table:
              item_id                           The item_id column

              item_price                      The item_price column

              discount_amount            The discount_amount column

              quantity                          The quantity column

              price_total                       A column that’s calculated by multiplying the item price by the quantity

              discount_total                  A column that’s calculated by multiplying the discount amount by the quantity

              item_total                         A column that’s calculated by subtracting the discount amount from the item price and then multiplying by the quantity

Only return rows where the item_total is greater than 500. Sort the result set by the item_total column in descending sequence. 

ANSWER:
select item_id, item_price, discount_amount, quantity, 
item_price * quantity AS price_total,
discount_amount * quantity AS discount_total,
(item_price - discount_amount) * quantity AS item_total
from order_items 
having item_total > 500
order by item_total desc;

#3 Write a SELECT statement that returns the product_name and list_price columns from the Products table.
Return one row for each product that has the same list price as another product.

Hint: Use a self-join to check that the product_id columns aren’t equal but the list_price columns are equal.

Sort the result set by the product_name column.

ANSWER:
select a.product_name as product1, b.product_name as product2, a.list_price
from products a, products b
where a.list_price = b.list_price
order by a.product_name;

#4 Write a SELECT statement that returns these two columns:
category_name        The category_name column from the Categories table

product_id               The product_id column from the Products table

Return one row for each category that has never been used. Hint: Use an outer join and only return rows where the product_id column contains a null value.

ANSWER:
select categories.category_name, products.product_id
from categories
left outer join products on categories.category_id=products.category_id
where product_id is null;

#5 Write an INSERT statement that adds this row to the Customers table:
email_address:         rick@raven.com

password:                (empty string)

first_name:                Rick

last_name:                 Raven

Use a column list for this statement. 

ANSWER:
insert into customers (email_address, password, first_name, last_name)
values ('rick@raven.com', '', 'Rick', 'Raven');

#6 Write a SELECT statement that answers this question: Which customers have ordered more than one product? Return these columns:
The email_address column from the Customers table

The count of distinct products from the customer’s orders

Sort the result set in ascending sequence by the email_address column.

ANSWER:
select email_address, count(*)
from customers, orders
where customers.customer_id = orders.customer_id
group by email_address
having count(*)>1
order by email_address asc;

#7 Write a SELECT statement that answers this question: What is the total quantity purchased for each product within each category? Return these columns
The category_name column from the category table

The product_name column from the products table

The total quantity purchased for each product with orders in the Order_Items table

Use the WITH ROLLUP operator to include rows that give a summary for each category name as well as a row that gives the grand total.

Use the IF and GROUPING functions to replace null values in the category_name and product_name columns with literal values if they’re for summary rows. 

ANSWER: 
select coalesce(a.category_name, 'Total'), coalesce(b.product_name, 'Total'), count(c.quantity) as total
from
categories a
inner join products b ON a.category_id = b.category_id
inner join order_items c on c.product_id = b.product_id
group by a.category_name, b.product_name with rollup;

#8 Write and execute a script that creates a user with a username using your firstname initial and lastname and password of your choosing. This user should be able to connect to MySQL from any computer.
This user should have SELECT, INSERT, UPDATE, and DELETE privileges for the Customers, Addresses, Orders, and Order_Items tables of the My Guitar Shop database.

However, this user should only have SELECT privileges for the Products and Categories tables. Also, this user should not have the right to grant privileges to other users.

Check the privileges for the user by using the SHOW GRANTS statement.

ANSWER:
create user scole identified by 'cfpf';
grant select, insert, update, delete ON customers to scole;
grant select, insert, update, delete ON addresses to scole;
grant select, insert, update, delete ON orders to scole;
grant select on products to scole;
grant select on categories to scole;
revoke all privileges, grant option from scole;


















