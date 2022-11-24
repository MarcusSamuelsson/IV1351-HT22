CREATE TABLE address (
 address_id SERIAL NOT NULL,
 street VARCHAR(85),
 zipcode VARCHAR(20),
 city VARCHAR(85)
);

ALTER TABLE address ADD CONSTRAINT PK_address PRIMARY KEY (address_id);


CREATE TABLE instrument (
 id SERIAL NOT NULL,
 type VARCHAR(50)
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (id);


CREATE TABLE instruments (
 instruments_id SERIAL NOT NULL,
 type VARCHAR(50) NOT NULL,
 brand VARCHAR(10),
 cost VARCHAR(10),
 is_available DATE
);

ALTER TABLE instruments ADD CONSTRAINT PK_instruments PRIMARY KEY (instruments_id);


CREATE TABLE person (
 person_id SERIAL NOT NULL,
 personal_number VARCHAR(12) NOT NULL,
 first_name VARCHAR(500),
 last_name VARCHAR(500)
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (person_id);


CREATE TABLE person_address (
 address_id SERIAL NOT NULL,
 person_id SERIAL NOT NULL
);

ALTER TABLE person_address ADD CONSTRAINT PK_person_address PRIMARY KEY (address_id,person_id);


CREATE TABLE phone (
 phone_number VARCHAR(15) NOT NULL
);

ALTER TABLE phone ADD CONSTRAINT PK_phone PRIMARY KEY (phone_number);


CREATE TABLE pricing_scheme (
 price_type_id SERIAL NOT NULL,
 base_price VARCHAR(7),
 sibling_discount FLOAT(10),
 intermediate_charge VARCHAR(7),
 advanced_charge VARCHAR(7),
 instructor_payment VARCHAR(7)
);

ALTER TABLE pricing_scheme ADD CONSTRAINT PK_pricing_scheme PRIMARY KEY (price_type_id);


CREATE TABLE student (
 student_id SERIAL NOT NULL,
 emergency_contact_name VARCHAR(500),
 emergency_contact_number VARCHAR(15),
 person_id SERIAL NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE email (
 email_address VARCHAR(320) NOT NULL,
 person_id SERIAL NOT NULL
);

ALTER TABLE email ADD CONSTRAINT PK_email PRIMARY KEY (email_address,person_id);


CREATE TABLE instructor (
 instructor_id SERIAL NOT NULL,
 can_hold_ensambles BOOLEAN,
 person_id SERIAL NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id);


CREATE TABLE is_avalable (
 id SERIAL NOT NULL,
 instructor_id SERIAL NOT NULL,
 date DATE
);

ALTER TABLE is_avalable ADD CONSTRAINT PK_is_avalable PRIMARY KEY (id);


CREATE TABLE lesson (
 lesson_id SERIAL NOT NULL,
 instructor_id SERIAL NOT NULL,
 price_type_id SERIAL NOT NULL,
 time TIMESTAMP(6) NOT NULL,
 lesson_type VARCHAR(50) NOT NULL,
 experience_level VARCHAR(50),
 genre VARCHAR(50),
 instrument VARCHAR(50),
 nr_of_students VARCHAR(50),
 minimum_nr_of_students VARCHAR(50),
 maximum_nr_of_students VARCHAR(50)
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (lesson_id);


CREATE TABLE person_phone (
 person_id SERIAL NOT NULL,
 phone_number VARCHAR(15) NOT NULL
);

ALTER TABLE person_phone ADD CONSTRAINT PK_person_phone PRIMARY KEY (person_id,phone_number);


CREATE TABLE rent_instrument (
 rental_id SERIAL NOT NULL,
 rental_start_date DATE NOT NULL,
 rental_end_date DATE NOT NULL,
 student_id SERIAL NOT NULL,
 instruments_id SERIAL NOT NULL
);

ALTER TABLE rent_instrument ADD CONSTRAINT PK_rent_instrument PRIMARY KEY (rental_id);


CREATE TABLE room (
 room_nr VARCHAR(5) NOT NULL,
 lesson_id SERIAL NOT NULL
);

ALTER TABLE room ADD CONSTRAINT PK_room PRIMARY KEY (room_nr);


CREATE TABLE sibling (
 personal_number VARCHAR(12) NOT NULL,
 student_id SERIAL NOT NULL
);

ALTER TABLE sibling ADD CONSTRAINT PK_sibling PRIMARY KEY (personal_number,student_id);


CREATE TABLE student_lesson (
 lesson_id SERIAL NOT NULL,
 student_id SERIAL NOT NULL
);

ALTER TABLE student_lesson ADD CONSTRAINT PK_student_lesson PRIMARY KEY (lesson_id,student_id);


CREATE TABLE techer_instrument (
 instructor_id SERIAL NOT NULL,
 instrument_id SERIAL NOT NULL
);

ALTER TABLE techer_instrument ADD CONSTRAINT PK_techer_instrument PRIMARY KEY (instructor_id,instrument_id);


ALTER TABLE person_address ADD CONSTRAINT FK_person_address_0 FOREIGN KEY (address_id) REFERENCES address (address_id);
ALTER TABLE person_address ADD CONSTRAINT FK_person_address_1 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE email ADD CONSTRAINT FK_email_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE is_avalable ADD CONSTRAINT FK_is_avalable_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (price_type_id) REFERENCES pricing_scheme (price_type_id);


ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_0 FOREIGN KEY (person_id) REFERENCES person (person_id);
ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_1 FOREIGN KEY (phone_number) REFERENCES phone (phone_number);


ALTER TABLE rent_instrument ADD CONSTRAINT FK_rent_instrument_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE rent_instrument ADD CONSTRAINT FK_rent_instrument_1 FOREIGN KEY (instruments_id) REFERENCES instruments (instruments_id);


ALTER TABLE room ADD CONSTRAINT FK_room_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


ALTER TABLE sibling ADD CONSTRAINT FK_sibling_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);
ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE techer_instrument ADD CONSTRAINT FK_techer_instrument_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE techer_instrument ADD CONSTRAINT FK_techer_instrument_1 FOREIGN KEY (instrument_id) REFERENCES instrument (id);


