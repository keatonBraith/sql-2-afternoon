SELECT *
FROM invoice i
    JOIN invoice_line il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;

SELECT invoice_date, c.first_name, c.last_name, total
FROM invoice i
    JOIN customer c ON c.customer_id = i.customer_id;

SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
    JOIN employee e ON c.support_rep_id = e.employee_id;

SELECT album.title, artist.name
FROM album
    JOIN artist ON artist.artist_id = album.artist_id;

SELECT pt.track_id
FROM playlist_track pt
    JOIN playlist p ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';

SELECT t.name
FROM track t
    JOIN playlist_track pt ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5;

SELECT t.name, p.name
FROM track t
    JOIN playlist_track pt ON pt.track_id = t.track_id
    JOIN playlist p ON p.playlist_id = pt.playlist_id;

SELECT t.name, a.title
FROM track t
    JOIN album a ON a.album_id = t.album_id
    JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

SELECT *
FROM invoice
WHERE invoice_id IN
(SELECT invoice_id
FROM invoice_line
WHERE unit_price > 0.99);

SELECT *
FROM playlist_track
WHERE playlist_id IN
(SELECT playlist_id
FROM playlist
WHERE name = 'Music');

SELECT *
FROM track
WHERE track_id IN
(SELECT track_id
FROM playlist_track
WHERE playlist_id = 5);

SELECT *
FROM track
WHERE genre_id IN
(SELECT genre_id
FROM genre
WHERE name = 'Comedy');

SELECT *
FROM track
WHERE album_id IN
(SELECT album_id
FROM album
WHERE title = 'Fireball');

SELECT *
FROM track
WHERE album_id IN
(SELECT album_id
FROM album
WHERE artist_id IN
(SELECT artist_id
FROM artist
WHERE name = 'Queen'));

UPDATE customer
SET fax = null
WHERE fax IS NOT null;

UPDATE customer
SET company = 'Self'
WHERE company IS null;

UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia'
    AND last_name = 'Barnett';

UPDATE customer
SET support_rep_id = 4
WHERE email = luisrojas@yahoo.cl;

UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id IN (SELECT genre_id
    FROM genre
    WHERE name = 'Metal')
    AND composer IS null;

SELECT COUNT(*), g.name
FROM track t
    JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

SELECT COUNT(*), g.name
FROM track t
    JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;

SELECT ar.name, COUNT(*)
FROM album al
    JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY ar.name;

SELECT DISTINCT composer
FROM track;

SELECT DISTINCT billing_postal_code
FROM invoice;

SELECT DISTINCT company
FROM customer;

DELETE FROM practice_delete WHERE type = 'bronze';

DELETE FROM practice_delete WHERE type = 'silver';

DELETE FROM practice_delete WHERE value = 150;

CREATE TABLE users(
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100)
  );
  
INSERT INTO users (name, email)
VALUES
('Harry', 'theboywholived@hogwarts.com'),
('Ron', 'redhead@hogwarts.com'),
('Hermoine', 'starstudent@hogwarts.com');

CREATE TABLE products(
  product_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  price DECIMAL(10,2)
  );
  
INSERT INTO products (name, price)
VALUES
('Chocolate Frogs', 10.99),
('Butterbeer', 8.50),
('Nimbus 2000', 1000.00);

CREATE TABLE orders(
  order_id SERIAL PRIMARY KEY,
  product_id INT REFERENCES products(product_id),
  order_quantity INT
  );
  
INSERT INTO orders (product_id, order_quantity)
VALUES
(1, 5),
(3, 1),
(2, 24);

SELECT * FROM products p
JOIN orders o ON o.product_id = p.product_id
WHERE order_id = 1;

SELECT * FROM orders;

SELECT SUM(p.price * o.order_quantity) FROM products p
JOIN orders o ON o.product_id = p.product_id
WHERE order_id = 1;

ALTER TABLE orders
ADD COLUMN user_id INT REFERENCES users(user_id);

UPDATE orders
SET user_id = 1
WHERE order_id = 3;

SELECT * FROM orders;

UPDATE orders
SET user_id = 2
WHERE order_id = 1;

SELECT * FROM orders;

UPDATE orders
SET user_id = 3
WHERE order_id = 2;

SELECT * FROM orders;

SELECT * FROM orders o
JOIN users u ON u.user_id = o.user_id;

SELECT COUNT(*), name FROM users u
JOIN orders o ON o.user_id = u.user_id
GROUP BY u.user_id;
