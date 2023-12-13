CREATE TABLE constraints_config (
 constraints_config_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 rule_id INT NOT NULL,
 constraint_value INT NOT NULL,
 constraint_description VARCHAR(200) NOT NULL,
 start_time TIMESTAMP(6) NOT NULL,
 end_time TIMESTAMP(6) NOT NULL
);

ALTER TABLE constraints_config ADD CONSTRAINT PK_constraints_config PRIMARY KEY (constraints_config_id);


CREATE TABLE instrument_details (
 instrument_details_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 brand VARCHAR(100) NOT NULL,
 price INT NOT NULL
);

ALTER TABLE instrument_details ADD CONSTRAINT PK_instrument_details PRIMARY KEY (instrument_details_id);


CREATE TABLE person (
 person_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 name VARCHAR(100) NOT NULL,
 person_number VARCHAR(12) NOT NULL
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (person_id);


CREATE TABLE phone_number (
 phone_number VARCHAR(100) NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE phone_number ADD CONSTRAINT PK_phone_number PRIMARY KEY (phone_number,person_id);

CREATE TYPE skill AS ENUM ('Beginner', 'Intermediate', 'Advanced');

CREATE TABLE price_schema (
 price_schema_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 price INT NOT NULL,
 skill_level skill NOT NULL,
 discount FLOAT(50) NOT NULL,
 instructor_payment INT NOT NULL,
 initial_time TIMESTAMP(6) NOT NULL
);

ALTER TABLE price_schema ADD CONSTRAINT PK_price_schema PRIMARY KEY (price_schema_id);


CREATE TABLE address (
 address_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 city VARCHAR(100) NOT NULL,
 zip VARCHAR(100) NOT NULL,
 street VARCHAR(100) NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE address ADD CONSTRAINT PK_address PRIMARY KEY (address_id);


CREATE TABLE contact_person (
 contact_person_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE contact_person ADD CONSTRAINT PK_contact_person PRIMARY KEY (contact_person_id);


CREATE TABLE email (
 email VARCHAR(100) NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE email ADD CONSTRAINT PK_email PRIMARY KEY (email,person_id);


CREATE TABLE instructor (
 instructor_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id);


CREATE TABLE instructor_availability (
 instructor_id INT NOT NULL,
 date TIMESTAMP(6) NOT NULL,
 duration VARCHAR(100) NOT NULL
);

ALTER TABLE instructor_availability ADD CONSTRAINT PK_instructor_availability PRIMARY KEY (instructor_id);


CREATE TABLE lesson (
 lesson_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instructor_id INT NOT NULL,
 start_time TIMESTAMP(6) NOT NULL,
 end_time TIMESTAMP(6) NOT NULL,
 place VARCHAR(100) NOT NULL,
 price_schema_id INT NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (lesson_id);


CREATE TABLE student (
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_id INT NOT NULL,
 contact_person_id INT
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE student_lesson (
 lesson_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE student_lesson ADD CONSTRAINT PK_student_lesson PRIMARY KEY (lesson_id,student_id);


CREATE TABLE student_sibling (
 student_id_1 INT NOT NULL,
 student_id_0 INT NOT NULL
);

ALTER TABLE student_sibling ADD CONSTRAINT PK_student_sibling PRIMARY KEY (student_id_1,student_id_0);


CREATE TYPE genres AS ENUM ('Hip hop', 'Jazz', 'Classical', 'Blues', 'Rock', 'Punk rock', 'Pop');

CREATE TABLE ensemble_lesson (
 lesson_id INT NOT NULL,
 genre genres NOT NULL,
 minimum_of_students VARCHAR(100) NOT NULL,
 maximum_of_students VARCHAR(100) NOT NULL
);

ALTER TABLE ensemble_lesson ADD CONSTRAINT PK_ensemble_lesson PRIMARY KEY (lesson_id);


CREATE TABLE present_skill (
 present_skill_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 student_id INT NOT NULL,
 skill_level skill NOT NULL
);

ALTER TABLE present_skill ADD CONSTRAINT PK_present_skill PRIMARY KEY (present_skill_id);


CREATE TABLE instrument_type (
 instrument_type_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 name VARCHAR(100) NOT NULL,
 present_skill_id INT
);

ALTER TABLE instrument_type ADD CONSTRAINT PK_instrument_type PRIMARY KEY (instrument_type_id);


CREATE TABLE instruments (
 instrument_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument_type_id INT NOT NULL,
 instrument_details_id INT NOT NULL
);

ALTER TABLE instruments ADD CONSTRAINT PK_instruments PRIMARY KEY (instrument_id,instrument_type_id,instrument_details_id);


CREATE TABLE rented_instrument (
 rented_instrument_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 rental_start_time TIMESTAMP(6) NOT NULL,
 rental_end_time TIMESTAMP(6),
 instrument_id INT NOT NULL,
 student_id INT NOT NULL,
 instrument_type_id INT,
 instrument_details_id INT,
 constraints_config_id INT
);

ALTER TABLE rented_instrument ADD CONSTRAINT PK_rented_instrument PRIMARY KEY (rented_instrument_id);


CREATE TABLE group_lesson (
 lesson_id INT NOT NULL,
 skill_level skill NOT NULL,
 minimum_of_students VARCHAR(100) NOT NULL,
 maximum_of_students VARCHAR(100) NOT NULL,
 instrument_type_id INT NOT NULL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


CREATE TABLE individual_lesson (
 lesson_id INT NOT NULL,
 skill_level skill NOT NULL,
 instrument_type_id INT NOT NULL
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id);


CREATE TABLE instructor_instrument_type (
 instructor_id INT NOT NULL,
 instrument_type_id INT NOT NULL
);

ALTER TABLE instructor_instrument_type ADD CONSTRAINT PK_instructor_instrument_type PRIMARY KEY (instructor_id,instrument_type_id);


ALTER TABLE phone_number ADD CONSTRAINT FK_phone_number_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE address ADD CONSTRAINT FK_address_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE contact_person ADD CONSTRAINT FK_contact_person_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE email ADD CONSTRAINT FK_email_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE instructor_availability ADD CONSTRAINT FK_instructor_availability_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (price_schema_id) REFERENCES price_schema (price_schema_id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (person_id);
ALTER TABLE student ADD CONSTRAINT FK_student_1 FOREIGN KEY (contact_person_id) REFERENCES contact_person (contact_person_id);


ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);
ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE student_sibling ADD CONSTRAINT FK_student_sibling_0 FOREIGN KEY (student_id_1) REFERENCES student (student_id);
ALTER TABLE student_sibling ADD CONSTRAINT FK_student_sibling_1 FOREIGN KEY (student_id_0) REFERENCES student (student_id);


ALTER TABLE ensemble_lesson ADD CONSTRAINT FK_ensemble_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


ALTER TABLE present_skill ADD CONSTRAINT FK_present_skill_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE instrument_type ADD CONSTRAINT FK_instrument_type_0 FOREIGN KEY (present_skill_id) REFERENCES present_skill (present_skill_id);


ALTER TABLE instruments ADD CONSTRAINT FK_instruments_0 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (instrument_type_id);
ALTER TABLE instruments ADD CONSTRAINT FK_instruments_1 FOREIGN KEY (instrument_details_id) REFERENCES instrument_details (instrument_details_id);


ALTER TABLE rented_instrument ADD CONSTRAINT FK_rented_instrument_0 FOREIGN KEY (instrument_id,instrument_type_id,instrument_details_id) REFERENCES instruments (instrument_id,instrument_type_id,instrument_details_id);
ALTER TABLE rented_instrument ADD CONSTRAINT FK_rented_instrument_1 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE rented_instrument ADD CONSTRAINT FK_rented_instrument_2 FOREIGN KEY (constraints_config_id) REFERENCES constraints_config (constraints_config_id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);
ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_1 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (instrument_type_id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (instrument_type_id);


ALTER TABLE instructor_instrument_type ADD CONSTRAINT FK_instructor_instrument_type_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE instructor_instrument_type ADD CONSTRAINT FK_instructor_instrument_type_1 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (instrument_type_id);

--Trigger for business logic

CREATE OR REPLACE FUNCTION prevent_insert_trigger_function()
RETURNS TRIGGER AS $$
DECLARE
    row_count INT;
BEGIN
    -- Get the count of rows for the specific student_id where rental_end_time IS NULL
    SELECT COUNT(*) INTO row_count 
    FROM rented_instrument
    WHERE student_id = NEW.student_id AND rental_end_time IS NULL;

    -- Check the condition and raise an error if count is greater than or equal to 2
    IF row_count >= 2 THEN
        RAISE EXCEPTION 'Insertion not allowed. Row count is >= 2 for the specified student_id.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_insert_trigger
BEFORE INSERT ON rented_instrument
FOR EACH ROW
EXECUTE FUNCTION prevent_insert_trigger_function();
