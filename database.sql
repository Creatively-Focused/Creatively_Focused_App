
-- USER is a reserved keyword with Postgres
-- You must use double quotes in every query that user is in:
-- ex. SELECT * FROM "user";
-- Otherwise you will have errors!
-- You will need to create a database called "creatively-focused" in which you create the following tables.

CREATE TABLE "user" (
	"id" serial NOT NULL,
	"username" varchar(255) NOT NULL UNIQUE,
	"password" varchar(255) NOT NULL,
	"phone" varchar(15),
	"isd" int(5) NOT NULL,
	"school" int(5),
	"auth" int(1) NOT NULL,
	"prefcomm" BOOLEAN,
	CONSTRAINT "user_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "student" (
	"id" serial NOT NULL,
	"firstname" varchar(100) NOT NULL,
	"lastname" varchar(100) NOT NULL,
	"birthdate" DATE NOT NULL,
	"grade" int(2) NOT NULL,
	"student_id" int(13) NOT NULL,
	"disability_cat" int(2) NOT NULL,
	"fed_setting" int(1) NOT NULL,
	"initial_iep" DATE,
	"prev_iep" DATE NOT NULL,
	"next_iep" DATE NOT NULL,
	"prev_eval" DATE NOT NULL,
	"next_eval" DATE NOT NULL,
	"school_id" int NOT NULL,
	"isd_id" int NOT NULL,
	"notes" TEXT,
	"teacher" int(10) NOT NULL,
	CONSTRAINT "student_pk" PRIMARY KEY ("id","prev_iep")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "school" (
	"id" serial NOT NULL,
	"name" varchar(100) NOT NULL,
	"isd_id" int NOT NULL,
	CONSTRAINT "school_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "isd" (
	"id" serial NOT NULL,
	"isd" int(5) NOT NULL,
	"city" varchar(100) NOT NULL,
	"state" varchar(50) NOT NULL,
	CONSTRAINT "isd_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "case_worker" (
	"student_id" int(10) NOT NULL,
	"user_id" int(10) NOT NULL,
	CONSTRAINT "case_worker_pk" PRIMARY KEY ("student_id","user_id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "event" (
	"id" serial NOT NULL,
	"task" varchar(255) NOT NULL,
	CONSTRAINT "event_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "student_event" (
	"id" serial NOT NULL,
	"student_id" int NOT NULL,
	"event_id" int NOT NULL,
	"due_date" DATE NOT NULL,
	"completed" BOOLEAN NOT NULL DEFAULT 'false',
	"date_completed" TIMESTAMP NOT NULL,
	"completed_by" int NOT NULL,
	CONSTRAINT "student_event_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "calendar" (
	"id" serial NOT NULL,
	"date" serial NOT NULL,
	"school_id" int NOT NULL,
	"school_day" BOOLEAN NOT NULL,
	"creator" serial NOT NULL,
	CONSTRAINT "calendar_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

ALTER TABLE "user" ADD CONSTRAINT "user_fk0" FOREIGN KEY ("isd") REFERENCES "isd"("id");
ALTER TABLE "user" ADD CONSTRAINT "user_fk1" FOREIGN KEY ("school") REFERENCES "school"("id");

ALTER TABLE "student" ADD CONSTRAINT "student_fk0" FOREIGN KEY ("school_id") REFERENCES "school"("id");
ALTER TABLE "student" ADD CONSTRAINT "student_fk1" FOREIGN KEY ("isd_id") REFERENCES "isd"("id");
ALTER TABLE "student" ADD CONSTRAINT "student_fk2" FOREIGN KEY ("teacher") REFERENCES "user"("id");

ALTER TABLE "school" ADD CONSTRAINT "school_fk0" FOREIGN KEY ("isd_id") REFERENCES "isd"("id");

ALTER TABLE "case_worker" ADD CONSTRAINT "case_worker_fk0" FOREIGN KEY ("student_id") REFERENCES "student"("id");
ALTER TABLE "case_worker" ADD CONSTRAINT "case_worker_fk1" FOREIGN KEY ("user_id") REFERENCES "user"("id");

ALTER TABLE "student_event" ADD CONSTRAINT "student_event_fk0" FOREIGN KEY ("student_id") REFERENCES "student"("id");
ALTER TABLE "student_event" ADD CONSTRAINT "student_event_fk1" FOREIGN KEY ("event_id") REFERENCES "event"("id");
ALTER TABLE "student_event" ADD CONSTRAINT "student_event_fk2" FOREIGN KEY ("completed_by") REFERENCES "user"("id");

ALTER TABLE "calendar" ADD CONSTRAINT "calendar_fk0" FOREIGN KEY ("school_id") REFERENCES "school"("id");
ALTER TABLE "calendar" ADD CONSTRAINT "calendar_fk1" FOREIGN KEY ("creator") REFERENCES "user"("id");

INSERT INTO "user" ("username", "password", "phone", "isd", "school", "auth", "prefcomm") 
VALUES ('dane_smith@sps.edu', '1234', '651-123-4567', 1, 1, 3, false);

INSERT INTO "school" ("name") 
VALUES ('Jefferson Middle School');

INSERT INTO "isd" ("isd", "city", "state") 
VALUES ('625', 'Saint Paul', 'Minnesota');

INSERT INTO "event" ("task") 
VALUES ('Annual IEP Meeting');

INSERT INTO "student" ("firstname", "lastname", "grade", "id_number", "prev_iep", "next_iep", "prev_eval", "next_eval", "disability", "fed_setting", "birthdate", "school_id", "isd_id", "notes", "teacher") 
VALUES ('Luke', 'Rohde', 9, 3247809967453, '2-12-2020', '3-12-2021', '1-12-2019', '1-12-2022', 5, 2, '2-26-2006', 1, 1, 'notes about Luke', 1),
('Paige', 'Wielgos', 8, 6748671239654, '11-1-2019', '11-1-2020', '10-1-2017', '10-1-2020', 4, 1, '9-27-2007', 1, 1, 'notes about Paige', 1),
('Ken', 'Slack', 7, 3332188904345, '11-15-2019', '11-15-2020', '12-1-2018', '10-1-2021', 3, 4, '3-5-2008', 1, 1, 'notes about Ken', 1),
('Aliye', 'Berento', 6, 9784438919022, '12-10-2019', '12-10-2020', '11-10-2019', '11-10-2021', 2, 2, '5-15-2009', 1, 1, 'notes about Aliye', 1);

INSERT INTO "student_event" ("student_id", "event_id", "completed", "date_due")
VALUES (2, 1, false, '11-1-2020');

INSERT INTO "case_worker" ("student_id", "user_id") 
VALUES(2, 1);

INSERT INTO "calendar" ("date", "creator")
SELECT generate_series('2020-09-08'::DATE, '2021-06-10', '1 day'), '1';

DROP TABLE "user";
DROP TABLE "student";
DROP TABLE "event";
DROP TABLE "student_event";
DROP TABLE "school";
DROP TABLE "isd";
DROP TABLE "case_worker";
DROP TABLE "calendar";