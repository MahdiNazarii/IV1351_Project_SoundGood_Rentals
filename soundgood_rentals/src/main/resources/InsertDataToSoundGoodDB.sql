INSERT INTO person (name, person_number)
VALUES
  ('Oliver Ellis', 199403151234),
  ('Cassandra Levy', 199404151234),
  ('Cade Levy', 199203151324),
  ('Chase Britt', 200403151234),
  ('Kirby Mcpherson', 199403151234);


INSERT INTO address (street,city,zip, person_id)
VALUES
  ('Ap #335-700 Sed Road','Borlänge','38477', 1),
  ('153-2547 Imperdiet, Av.','Kovel','21209', 2),
  ('415-1987 Ac Rd.','Ceuta','K1 2WD', 3),
  ('P.O. Box 412, 7917 Gravida Road','Lochgilphead','981840', 4),
  ('Ap #540-9335 In St.','Pocatello','447875', 5);

INSERT INTO phone_number (phone_number, person_id)
VALUES
  ('1-761-738-7608', 1),
  ('1-823-878-5272', 2),
  ('1-445-543-2492', 3),
  ('1-932-346-8165', 4),
  ('(579) 141-3366', 5);

INSERT INTO email (email, person_id)
VALUES
  ('ultricies.ornare@google.com', 1),
  ('quis.turpis.vitae@icloud.edu', 2),
  ('ac.turpis@outlook.com', 3),
  ('magna.a@icloud.net', 4),
  ('sit.amet@aol.org', 5);

INSERT INTO contact_person (person_id)
VALUES
  (2);


INSERT INTO student (person_id, contact_person_id)
VALUES
  (3, NULL),
  (4, 1),
  (5, 1);

INSERT INTO instructor (person_id)
VALUES
	(1);

INSERT INTO price_schema (price, skill_level, discount, instructor_payment, initial_time)
VALUES
(100, 'Beginner', 0.2, 50, NOW()),
(100, 'Intermediate', 0.2, 50, NOW()),
(200, 'Advanced', 0.2, 100, NOW());

INSERT INTO lesson (instructor_id, start_time, end_time, place, price_schema_id)
VALUES
	(1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '2 hours', 'room 301', 1),
	(1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '2 hours', 'room 302', 2),
	(1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '2 hours', 'room 303', 3);


INSERT INTO instrument_type(name, present_skill_id)
VALUES
	('Guitar', NULL),
	('Piano', NULL);

INSERT INTO individual_lesson(lesson_id, skill_level, instrument_type_id)
VALUES
	(1,'Beginner', 1);

INSERT INTO instrument_details (brand, price)
VALUES
	('Gibson', 420);

INSERT INTO ensemble_lesson(lesson_id, genre, minimum_of_students, maximum_of_students)
VALUES
	(2, 'Jazz', 5, 10);


INSERT INTO group_lesson(lesson_id, skill_level, minimum_of_students, maximum_of_students, instrument_type_id)
VALUES
	(3, 'Advanced', 5, 10, 2);
	
INSERT INTO instruments (instrument_type_id, instrument_details_id)
VALUES
	(1, 1);

INSERT INTO constraints_config (rule_id, constraint_value, constraint_description, start_time, end_time)
VALUES (1, 2, 'maximum rented instruments', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '12 months');
INSERT INTO instructor_instrument_type (instructor_id, instrument_type_id)
VALUES (1, 1),
	(1, 2);


INSERT INTO student_lesson(lesson_id, student_id)
VALUES
	(1, 1),
	(2, 2),
	(2, 3),
	(3, 2),
	(3, 3);

UPDATE ensemble_lesson
SET minimum_of_students = '2'
WHERE minimum_of_students = '5';



UPDATE group_lesson
SET minimum_of_students = '2'
WHERE minimum_of_students = '5';


INSERT INTO instructor_availability (instructor_id, date, duration)
VALUES
(1, CURRENT_TIMESTAMP + INTERVAL '1 months', 60);





INSERT INTO person (name, person_number)
VALUES
  ('Christopher Barnes', 201112101603),
  ('Fitzgerald Strickland', 199903089481),
  ('Jamal Espinoza', 201307172138),
  ('Jared Whitaker', 193312263241),
  ('Brianna Wong', 196402284761),
  ('Quynn Leon', 197606014939),
  ('Indigo Goodman', 194411054747),
  ('Levi Parrish', 197805289878),
  ('Macey Kidd', 198704122186),
  ('Axel Hernandez', 199802250226);


INSERT INTO address (city,street,zip,person_id)
VALUES
  ('Cork','P.O. Box 831, 7761 Fusce Rd.','711985',6),
  ('Sakhalin','P.O. Box 580, 4203 Tempus St.','2273 YU',7),
  ('Wichita','Ap #512-5500 Ipsum Rd.','107004',8),
  ('Empangeni','Ap #692-6662 Pretium Road','08467',9),
  ('Delft','780-6053 Felis Av.','43581',10),
  ('Melilla','157-4723 Purus. St.','1052 XM',11),
  ('Whitehorse','5236 Sed Rd.','9135',12),
  ('Fuenlabrada','143-2098 Vulputate Avenue','5384',13),
  ('Chapadinha','P.O. Box 489, 7574 In Avenue','53997-587',14),
  ('Gore','Ap #208-4726 Purus Rd.','3601 QI',15);

INSERT INTO phone_number (phone_number,person_id)
VALUES
  ('(373) 205-8435',6),
  ('(487) 758-5337',7),
  ('1-676-613-4165',8),
  ('1-963-854-7685',9),
  ('1-847-107-1664',10),
  ('(779) 824-6537',11),
  ('(485) 774-3686',12),
  ('1-654-562-3835',13),
  ('1-344-856-8247',14),
  ('1-488-368-4465',15);

INSERT INTO email (email,person_id)
VALUES
  ('vitae@protonmail.ca',6),
  ('molestie.sodales@yahoo.couk',7),
  ('aliquam@google.net',8),
  ('mauris.ut@google.edu',9),
  ('lacus.etiam@aol.org',10),
  ('nisl.nulla@hotmail.com',11),
  ('bibendum.donec@google.couk',12),
  ('semper.et.lacinia@hotmail.ca',13),
  ('et.pede@yahoo.net',14),
  ('in.cursus.et@protonmail.couk',15);

INSERT INTO instructor (person_id)
VALUES
(6),
(7),
(8);

INSERT INTO student (person_id)
VALUES
(9),
(10),
(11),
(12),
(13),
(14),
(15);

INSERT INTO lesson (instructor_id, start_time, end_time, place, price_schema_id)
VALUES
	(1, CURRENT_TIMESTAMP + INTERVAL '3 months', CURRENT_TIMESTAMP  + INTERVAL '3 months' + INTERVAL '2 hours', 'room 301', 1),
	(2, CURRENT_TIMESTAMP + INTERVAL '4 months', CURRENT_TIMESTAMP  + INTERVAL '4 months' + INTERVAL '2 hours', 'room 302', 2),
	(3, CURRENT_TIMESTAMP + INTERVAL '5 months', CURRENT_TIMESTAMP  + INTERVAL '5 months' + INTERVAL '2 hours', 'room 303', 3),
	(4, CURRENT_TIMESTAMP + INTERVAL '6 months', CURRENT_TIMESTAMP  + INTERVAL '6 months' + INTERVAL '2 hours', 'room 301', 1),
	(2, CURRENT_TIMESTAMP + INTERVAL '7 months', CURRENT_TIMESTAMP  + INTERVAL '7 months' + INTERVAL '2 hours', 'room 302', 2),
	(3, CURRENT_TIMESTAMP + INTERVAL '7 months', CURRENT_TIMESTAMP  + INTERVAL '7 months' + INTERVAL '2 hours', 'room 303', 3),
	(4, CURRENT_TIMESTAMP + INTERVAL '8 months', CURRENT_TIMESTAMP  + INTERVAL '8 months' + INTERVAL '2 hours', 'room 301', 1),
	(1, CURRENT_TIMESTAMP + INTERVAL '9 months', CURRENT_TIMESTAMP  + INTERVAL '9 months' + INTERVAL '2 hours', 'room 302', 2),
	(2, CURRENT_TIMESTAMP + INTERVAL '9 months', CURRENT_TIMESTAMP  + INTERVAL '9 months' + INTERVAL '2 hours', 'room 303', 3),
	(3, CURRENT_TIMESTAMP + INTERVAL '10 months', CURRENT_TIMESTAMP  + INTERVAL '10 months' + INTERVAL '2 hours', 'room 301', 1),
	(4, CURRENT_TIMESTAMP + INTERVAL '2 months', CURRENT_TIMESTAMP  + INTERVAL '2 months' + INTERVAL '2 hours', 'room 302', 2),
	(1, CURRENT_TIMESTAMP + INTERVAL '1 months', CURRENT_TIMESTAMP  + INTERVAL '1 months' + INTERVAL '2 hours', 'room 303', 3),
	(2, CURRENT_TIMESTAMP + INTERVAL '11 months', CURRENT_TIMESTAMP  + INTERVAL '11 months' + INTERVAL '2 hours', 'room 301', 1),
	(2, CURRENT_TIMESTAMP + INTERVAL '12 months', CURRENT_TIMESTAMP  + INTERVAL '12 months' + INTERVAL '2 hours', 'room 302', 2),
	(3, CURRENT_TIMESTAMP + INTERVAL '12 months', CURRENT_TIMESTAMP  + INTERVAL '12 months' + INTERVAL '2 hours', 'room 303', 3),

    (1, CURRENT_TIMESTAMP - INTERVAL '3 months', CURRENT_TIMESTAMP - INTERVAL '3 months' + INTERVAL '2 hours', 'room 301', 1),
    (2, CURRENT_TIMESTAMP - INTERVAL '4 months', CURRENT_TIMESTAMP - INTERVAL '4 months' + INTERVAL '2 hours', 'room 302', 2),
    (3, CURRENT_TIMESTAMP - INTERVAL '5 months', CURRENT_TIMESTAMP - INTERVAL '5 months' + INTERVAL '2 hours', 'room 303', 3),
    (4, CURRENT_TIMESTAMP - INTERVAL '6 months', CURRENT_TIMESTAMP - INTERVAL '6 months' + INTERVAL '2 hours', 'room 301', 1),
    (2, CURRENT_TIMESTAMP - INTERVAL '7 months', CURRENT_TIMESTAMP - INTERVAL '7 months' + INTERVAL '2 hours', 'room 302', 2),
    (3, CURRENT_TIMESTAMP - INTERVAL '7 months', CURRENT_TIMESTAMP - INTERVAL '7 months' + INTERVAL '2 hours', 'room 303', 3),
    (4, CURRENT_TIMESTAMP - INTERVAL '8 months', CURRENT_TIMESTAMP - INTERVAL '8 months' + INTERVAL '2 hours', 'room 301', 1),
    (1, CURRENT_TIMESTAMP - INTERVAL '9 months', CURRENT_TIMESTAMP - INTERVAL '9 months' + INTERVAL '2 hours', 'room 302', 2),
    (2, CURRENT_TIMESTAMP - INTERVAL '9 months', CURRENT_TIMESTAMP - INTERVAL '9 months' + INTERVAL '2 hours', 'room 303', 3),
    (3, CURRENT_TIMESTAMP - INTERVAL '10 months', CURRENT_TIMESTAMP - INTERVAL '10 months' + INTERVAL '2 hours', 'room 301', 1),
    (4, CURRENT_TIMESTAMP - INTERVAL '2 months', CURRENT_TIMESTAMP - INTERVAL '2 months' + INTERVAL '2 hours', 'room 302', 2),
    (1, CURRENT_TIMESTAMP - INTERVAL '1 months', CURRENT_TIMESTAMP - INTERVAL '1 months' + INTERVAL '2 hours', 'room 303', 3),
    (2, CURRENT_TIMESTAMP - INTERVAL '11 months', CURRENT_TIMESTAMP - INTERVAL '11 months' + INTERVAL '2 hours', 'room 301', 1),
    (2, CURRENT_TIMESTAMP - INTERVAL '12 months', CURRENT_TIMESTAMP - INTERVAL '12 months' + INTERVAL '2 hours', 'room 302', 2),
    (3, CURRENT_TIMESTAMP - INTERVAL '12 months', CURRENT_TIMESTAMP - INTERVAL '12 months' + INTERVAL '2 hours', 'room 303', 3);

INSERT INTO individual_lesson(lesson_id, skill_level, instrument_type_id)
VALUES
	(4,'Beginner', 2),
	(7,'Beginner', 1),
	(10,'Beginner', 2),
	(13,'Beginner', 1),
	(16,'Beginner', 2),
	(19,'Beginner', 1),
	(22,'Beginner', 1),
	(25,'Beginner', 2),
	(28,'Beginner', 1),
	(31,'Beginner', 1);


INSERT INTO group_lesson(lesson_id, skill_level, minimum_of_students, maximum_of_students, instrument_type_id)
VALUES
	(5, 'Advanced', 5, 10, 1),
	(8, 'Advanced', 5, 10, 2),
	(11, 'Advanced', 5, 10, 1),
	(14, 'Advanced', 5, 10, 2),
	(17, 'Advanced', 5, 10, 1),
	(20, 'Advanced', 5, 10, 2),
	(23, 'Advanced', 5, 10, 1),
	(26, 'Advanced', 5, 10, 2),
	(29, 'Advanced', 5, 10, 2),
	(32, 'Advanced', 5, 10, 1);

INSERT INTO ensemble_lesson(lesson_id, genre, minimum_of_students, maximum_of_students)
VALUES
	(6, 'Punk rock', 5, 10),
	(9, 'Classical', 5, 10),
	(12, 'Rock', 5, 10),
	(15, 'Jazz', 5, 10),
	(18, 'Rock', 5, 10),
	(21, 'Jazz', 5, 10),
	(24, 'Punk rock', 5, 10),
	(27, 'Jazz', 5, 10),
	(30, 'Punk rock', 5, 10),
	(33, 'Jazz', 5, 10);

INSERT INTO student_sibling (student_id_0, student_id_1)
VALUES
(1, 3),
(3, 1),
(2, 3),
(3, 2),
(4, 5),
(5, 4),
(6, 7),
(7, 6),
(1, 2),
(2, 1);

INSERT INTO lesson (instructor_id, start_time, end_time, place, price_schema_id)
VALUES
	(4, CURRENT_TIMESTAMP + INTERVAL '3 days', CURRENT_TIMESTAMP  + INTERVAL '3 days' + INTERVAL '2 hours', 'room 301', 1),
	(3, CURRENT_TIMESTAMP + INTERVAL '4 days', CURRENT_TIMESTAMP  + INTERVAL '4 days' + INTERVAL '2 hours', 'room 302', 2),
	(2, CURRENT_TIMESTAMP + INTERVAL '5 days', CURRENT_TIMESTAMP  + INTERVAL '5 days' + INTERVAL '2 hours', 'room 303', 3),
	(4, CURRENT_TIMESTAMP + INTERVAL '6 days', CURRENT_TIMESTAMP  + INTERVAL '6 days' + INTERVAL '2 hours', 'room 301', 1),
	(3, CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP  + INTERVAL '7 days' + INTERVAL '2 hours', 'room 302', 2),
	(2, CURRENT_TIMESTAMP + INTERVAL '8 days', CURRENT_TIMESTAMP  + INTERVAL '8 days' + INTERVAL '2 hours', 'room 303', 3);

INSERT INTO lesson (instructor_id, start_time, end_time, place, price_schema_id)
VALUES
	(4, CURRENT_TIMESTAMP + INTERVAL '8 days', CURRENT_TIMESTAMP  + INTERVAL '8 days' + INTERVAL '2 hours', 'room 301', 1),
	(4, CURRENT_TIMESTAMP + INTERVAL '9 days', CURRENT_TIMESTAMP  + INTERVAL '9 days' + INTERVAL '2 hours', 'room 301', 1),
	(4, CURRENT_TIMESTAMP + INTERVAL '10 days', CURRENT_TIMESTAMP  + INTERVAL '10 days' + INTERVAL '2 hours', 'room 301', 1);



INSERT INTO ensemble_lesson(lesson_id, genre, minimum_of_students, maximum_of_students)
VALUES
	(34, 'Punk rock', 5, 10),
	(35, 'Classical', 5, 10),
	(36, 'Rock', 5, 10),
	(37, 'Jazz', 5, 10),
	(38, 'Rock', 5, 10),
	(39, 'Jazz', 5, 10);

INSERT INTO ensemble_lesson(lesson_id, genre, minimum_of_students, maximum_of_students)
VALUES
	(40, 'Jazz', 5, 10),
	(41, 'Rock', 5, 10),
	(42, 'Jazz', 5, 10);


-- Cast the existing data in minimum_of_students to INT
ALTER TABLE ensemble_lesson
ALTER COLUMN minimum_of_students TYPE INT
USING minimum_of_students::INT;

-- Cast the existing data in maximum_of_students to INT
ALTER TABLE ensemble_lesson
ALTER COLUMN maximum_of_students TYPE INT
USING maximum_of_students::INT;

INSERT INTO student_lesson (lesson_id, student_id)
VALUES
	(38, 1),
	(38, 2),
	(38, 3),
	(38, 4),
	(38, 5),
	(38, 6),
	(38, 7),
	(38, 8),
	(38, 9),
	(38, 10);

INSERT INTO student_lesson (lesson_id, student_id)
VALUES
	(40, 1),
	(40, 2),
	(40, 3),
	(40, 4),
	(40, 5),
	(40, 6),
	(40, 7),
	(40, 8);



-- Inserted more data for rented instruments i task 4

insert into instrument_details (brand, price)
VALUES('Yamaha', 1000);

insert into instruments (instrument_type_id, instrument_details_id)
Values(2,2);

INSERT INTO instrument_type (name)
VALUES
	('Trumpet'),
	('Clarinet'),
	('Bagpipe'),
	('Flute'),
	('Drums'),
	('Violin'),
	('Saxophone'),
	('Cello');
INSERT INTO instrument_details (brand, price)
VALUES
	('Yamaha', 500),
	('Selmer', 800),
	('O.Keefe', 1200),
	('Yamaha', 400),
	('Yamaha', 1200),
	('SONOR', 1300),
	('Cecilio', 1200),
	('Cecilio', 1400);

INSERT INTO instruments (instrument_type_id, instrument_details_id)
VALUES
	(3,3),
	(4,4),
	(5,5),
	(6,6),
	(7,7),
	(8,8),
	(9,9),
	(10,10);

INSERT INTO rented_instrument (rental_start_time, instrument_id, student_id)
VALUES
	(NOW() - interval '2 weeks', 1, 1),
	(NOW() - interval '2 weeks', 2, 2);
	

 
