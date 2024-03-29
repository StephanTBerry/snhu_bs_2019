-- This was originally written for MySQL and now written in PostgreSQL

-- Author: Joe Petronio
-- Date created: Feb 21, 2017 **
-- This is a helper function that helps to prevent duplicate items being created in the database. 

CREATE OR REPLACE FUNCTION public.does_column_exist(p_schema_name VARCHAR, p_table_name VARCHAR, p_column_name VARCHAR)
 RETURNS BOOLEAN
 LANGUAGE plpgsql STABLE
AS $function$
   
BEGIN
        PERFORM table_name FROM information_schema.columns 
           WHERE table_schema = lower(p_schema_name) AND table_name = lower(p_table_name) AND column_name = lower(p_column_name);
        IF NOT FOUND THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.does_table_exist(p_schema_name VARCHAR, p_table_name VARCHAR)
 RETURNS BOOLEAN
 LANGUAGE plpgsql STABLE
AS $function$
   
BEGIN
        PERFORM table_name FROM information_schema.tables 
           WHERE table_schema = lower(p_schema_name) AND table_name = lower(p_table_name);
        IF NOT FOUND THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
END;
$function$
;

-- **
BEGIN;

DO $main$

DECLARE

  BEGIN -- THis is so we can commit it or roll it back if something fails.

    -- USE messaging; This is the schema for the tables

    -- First Task: add yourself to the table Person.
    -- INSERT INTO person(first_name, last_name) VALUES ('Stephan', 'Berry');

    -- Alternate method of using an Insert is with a statement
    INSERT INTO messaging.person(first_name, last_name) SELECT 'Stephan', 'Berry' WHERE messaging.person NOT EXISTS(SELECT 1 FROM messaging.person WHERE first_name='Stephan' AND last_name='Berry');
    -- This method makes this a rerunable section of code. It will only insert if that does not currently exist. 

    -- Second task: Alter table and add a new column to Person.
    -- Lets wrap this in a check statement to ensure if that column exists or not. 
    IF NOT public.does_column_exist('messaging','age') THEN
      ALTER table messaging.person ADD COLUMN age SMALLINT(3) NOT NULL;
    END IF;

    -- Added in a column for person age, and made it required. 

    -- Third task: Update some records in the Person table. Need to add in data for the new column.
    UPDATE messaging.person SET age=29 WHERE person_id=1;
    UPDATE messaging.person SET age=31 WHERE person_id=2;
    UPDATE messaging.person SET age=45 WHERE person_id=3;
    UPDATE messaging.person SET age=23 WHERE person_id=4;
    UPDATE messaging.person SET age=56 WHERE person_id=5;
    UPDATE messaging.person SET age=22 WHERE person_id=6;
    UPDATE messaging.person SET age=39 WHERE person_id=7;

    -- Updating all person records to now have an age associated with them.

    -- Fourth task: Delete some specific records from the Person table.
    DELETE FROM messaging.person WHERE first_name='Diana' AND last_name='Taurasi';

    -- This will delete the person with a specific first name and last name. 

    -- Fifth task: Alter table contact list, add new column favorite.
    IF NOT public.does_column_exist('messaging','favorite') THEN
      ALTER TABLE messaging.contact_list ADD COLUMN favorite VARCHAR(10);
    END IF;

    -- Sixth task: Update the table contact list so everyones fav is Micheal Phelps(contact ID = 1) and fav='y'.
    UPDATE messaging.contact_list SET favorite='y' WHERE contact_id=1;

    -- Setting all persons whom have Mr. Phelps as a contact to their fav.

    -- Seventh task: Update remaining persons in contact list to fav='n' where it is not Phelps.
    UPDATE messaging.contact_list SET favorite='n' WHERE contact_id <> 1;

    -- Updated all other records in this table to now show a not fav.

    -- Eighth task: Need to add in 3 new records to the Contact list, utilizing all columns and myself as a list member.
    INSERT INTO messaging.contact_list (person_id, contact_id, favorite) 
    VALUES
    (6,7,'n'),
    (7,5,'n'),
    (7,1,'y');

    -- Insert new data into the contact list.

    -- Ninth task: Create a new table named Image.
    IF NOT public.does_table_exist('messaging','image') THEN
      CREATE TABLE messaging.image (
          image_id        INT(8) auto_increment,
          immage_name     VARCHAR(50) NOT NULL,
          image_location  VARCHAR(250) NOT NULL,
          PRIMARY KEY(image_id))
          AUTO_INCREMENT = 1;
    END IF;

    -- Created new table with the specifications on the instruction sheet. 

    -- Tenth task: Create another table message_image with two primary keys assigned.
    IF NOT public.does_table_exist('messaging','message_image') THEN
      CREATE TABLE messaging.message_image(
          message_id    INT(8),
          image_id      INT(8),
          PRIMARY KEY(message_id, image_id));
    END IF;

    -- Created table per spec with primary key on both columns.

    -- Eleventh task: Insert new records (5) into the new image table.
    INSERT INTO messaging.image (image_name, image_location) VALUES
        ('800m winner','/pics/800mWinner.jpg'),
        ('23 Golds!!!', '/pics/allMedals.jpg'),
        ('Best Buds!','/pics/best_buddy.jpg'),
        ('Swim Meet 2017', '/pics/swim17.jpg'),
        ('sprinter shoes','/pics/raggyShoes.jpg');

    -- created 5 new images for the new table. 

    -- Twevlth task: Now insert 5 new records corrisponding to those previous, into the message image table.
    INSERT INTO messaging.message_image (message_id, image_id) VALUES
        (1,1),
        (5,5),
        (3,3),
        (3,4),
        (2,2);

    -- Inserted new rows of message to image links with a input of one message having multiple images.

    -- Thirteenth task: Find all messages Phelps sent with columns: Sender (first name, last name), Reciever (first , last name), message ID, Message and message timestamp.
    SELECT p1.first_name AS "Sender first name", p1.last_name AS "Sender last name", p2.first_name AS "Receiver first name", p2.last_name AS "Receiver last name",
           m.message_id AS "message id" , m.message, m.send_datetime AS "Message sent" 
           FROM messaging.person p1 
           JOIN messaging.person p2 ON p1.person_id != p2.person_id
           JOIN messaging.message m ON m.sender_id = p1.person_id AND m.receiver_id = p2.person_id
           WHERE m.sender_id=1;

    -- The select statement generates a list or return of only Michael Phelps messages out to the receiver.

    -- Fourteenth task: Find the number of messages sent by every person. Use columns Count of messages, person id, first name and last name.
    SELECT count(message_id)AS "Count of messages", p.person_id AS "Person ID", p.first_name AS "First Name", p.last_name AS "Last Name" 
    FROM messaging.person p 
    JOIN messaging.message m ON m.sender_id = p.person_id
    WHERE m.receiver_id IS NOT NULL
    GROUP BY m.sender_id;

    -- This returns a grouped list of persons and how many messages they sent.

  END $main$;

COMMIT;
