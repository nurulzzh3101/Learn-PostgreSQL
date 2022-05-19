CREATE TABLE mahasiswa (
	id_mahasiswa int PRIMARY KEY,
	nama_mahasiswa varchar(20),
	tlg_lahir timestamp,
	email varchar(30),
	jurusan varchar(30)
);

ALTER TABLE mahasiswa_indonesia ADD kas varchar(50);

ALTER TABLE mahasiswa
  RENAME TO mahasiswa_indonesia;
  
ALTER TABLE mahasiswa_indonesia 
DROP COLUMN kas;

ALTER TABLE mahasiswa_indonesia
  RENAME COLUMN tgl_alhir TO tgl_lahir;
  
  ALTER TABLE mahasiswa_indonesia
  RENAME COLUMN jursan TO jurusan;


SELECT id_mahasiswa, nama_mahasiswa, tgl_lahir, email, jurusan, alamat FROM mahasiswa_indonesia;

INSERT INTO mahasiswa_indonesia
(id_mahasiswa, nama_mahasiswa, tgl_lahir, email, jurusan, alamat)
VALUES('1', 'Taufiiqulhakim', NOW(), 'taufiiqulhakim@gmail.com','Teknik Komputer', 'palembang');

INSERT INTO mahasiswa_indonesia
(id_mahasiswa, nama_mahasiswa, tgl_lahir, email, jurusan, alamat)
VALUES('2', 'zaki tirta', NOW(), 'zakitirta2@gmail.com','Teknik Komputer', 'Sekip');

INSERT INTO mahasiswa_indonesia
(id_mahasiswa, nama_mahasiswa, tgl_lahir, email, jurusan, alamat)
VALUES('3', 'auzan', NOW(), 'auzan@gmail.com','Teknik Komputer', 'dwi kora');


UPDATE mahasiswa_indonesia SET email = 'taufik@gmail.com' WHERE id_mahasiswa = '1';
UPDATE mahasiswa_indonesia SET jurusan = 'Teknik Informatika' WHERE id_mahasiswa = 1;

DELETE FROM 
mahasiswa_indonesia
WHERE id_mahasiswa = 3;

SELECT nama_mahasiswa as nama, tgl_lahir, nama_jurusan FROM mahasiswa_indonesia JOIN jurusan ON mahasiswa_indonesia.id_jurusan = jurusan.id_jurusan;



INSERT INTO jurusan
(id_jurusan, nama_jurusan)
VALUES('1', 'Teknik Informatika');

INSERT INTO jurusan
(id_jurusan, nama_jurusan)
VALUES('2', 'Teknik Komputer');

INSERT INTO jurusan
(id_jurusan, nama_jurusan)
VALUES('3', 'Teknik Mesin');

INSERT INTO jurusan
(id_jurusan, nama_jurusan)
VALUES('4', 'Teknik Listrik');

INSERT INTO mahasiswa_indonesia
(id_mahasiswa, nama_mahasiswa, tgl_lahir, email, id_jurusan, alamat)
VALUES('4', 'Rahman', NOW(), 'rahman@gmail.com', NULL , 'dwi kora');

SELECT * FROM mahasiswa_indonesia;


-- Cara membuat SELECT FUNTION

create function read_all_mahasiswa()
	returns TABLE(p_id_mahasiswa integer, p_nama_mahasiswa character varying, p_tgl_lahir date, p_email character varying, p_id_jurusan integer, alamat character varying)
	language plpgsql
	as
	$$
BEGIN
    return query
    SELECT id_mahasiswa, nama_mahasiswa, tgl_lahir, email, id_jurusan 
	FROM "mahasiswa_indonesia"
    ORDER BY id_mahasiswa asc;
END;
$$;

alter function read_all_mahasiswa() owner to postgres;

create function read_all_mahasiswa_join_jurusan()
	returns TABLE(p_id_mahasiswa integer, p_nama_mahasiswa character varying, p_tgl_lahir date, p_email character varying, p_jurusan character varying, p_alamat character varying)
	language plpgsql
	as
	$$
BEGIN
    return query
    SELECT id_mahasiswa, nama_mahasiswa, tgl_lahir, email, nama_jurusan, alamat
	FROM "mahasiswa_indonesia" 
	JOIN "jurusan" ON mahasiswa_indonesia.id_jurusan = jurusan.id_jurusan
    ORDER BY id_mahasiswa asc;
END;
$$;

alter function read_all_mahasiswa_join_jurusan() owner to postgres;

-- Cara membuat INSERT FUNCTION

create function create_mahasiswa(p_id_mahasiswa integer, p_nama_mahasiswa character varying, p_tgl_lahir date, p_email character varying, p_id_jurusan integer, p_alamat character varying) returns void
    language plpgsql
as
$$
BEGIN
INSERT INTO mahasiswa_indonesia(id_mahasiswa, nama_mahasiswa, tgl_lahir, email, id_jurusan, alamat)
VALUES(p_id_mahasiswa, p_nama_mahasiswa, p_tgl_lahir, p_email, p_id_jurusan, p_alamat);
END;
$$;

alter function create_mahasiswa(integer, varchar, date, varchar, integer, varchar) owner to postgres;

-- Cara membuat UPDATE FUNCTION

create function update_mahasiswa(p_nama_mahasiswa character varying, p_tgl_lahir date, p_email character varying, p_id_jurusan integer, p_alamat character varying, p_id_mahasiswa integer) returns void
    language plpgsql
as
$$
BEGIN
UPDATE "mahasiswa_indonesia" 
SET nama_mahasiswa = p_nama_mahasiswa, tgl_lahir = p_tgl_lahir, email = p_email, id_jurusan = p_id_jurusan WHERE id_mahasiswa = p_id_mahasiswa;
END;
$$;

alter function update_mahasiswa( varchar, date, varchar, integer, varchar, integer) owner to postgres;

-- Cara Membuat DELETE FUNCTION

create function delete_mahasiswa(p_id_mahasiswa integer) returns void
    language plpgsql
as
$$
BEGIN
    DELETE FROM "mahasiswa_indonesia"
    WHERE id_mahasiswa = p_id_mahasiswa;
END;
$$;

alter function delete_mahasiswa(integer) owner to postgres;

-- Cara Membuat VIEW SELECT
CREATE VIEW get_all_mahasiswa as
SELECT id_mahasiswa, 
		nama_mahasiswa, 
		tgl_lahir, 
		email, 
		id_jurusan, 
		alamat 
FROM "mahasiswa_indonesia";

alter table get_all_mahasiswa
    owner to postgres;

-- Create materialized VIEW

CREATE materialized VIEW get_all_mahasiswa_materialized as
SELECT id_mahasiswa, 
		nama_mahasiswa, 
		tgl_lahir, 
		email, 
		id_jurusan, 
		alamat 
FROM "mahasiswa_indonesia";

alter table get_all_mahasiswa_materialized
    owner to postgres;


-- Untuk memanggil FUNCTION

SELECT * FROM create_mahasiswa(5, 'Azahra', '2000-03-01', 'azahra@gmail.com', 1, 'Pak Jo');

SELECT * FROM read_all_mahasiswa();

SELECT * FROM read_all_mahasiswa_by_id(5);

SELECT * FROM update_mahasiswa('Azahra', '2000-03-01', 'azahra@gmail.com', 1, 'Pak Jo', 5);

-- Untuk Memanggil VIEW dan Materiallized

SELECT * FROM get_all_mahasiswa;

SELECT * FROM get_all_mahasiswa_materialized;

REFRESH MATERIALIZED VIEW get_all_mahasiswa_materialized;

-- Trigger Function


create function log_mahasiswa_indonesia_delete() returns trigger
	language plpgsql
	
as
$$
BEGIN

INSERT INTO log_mahasiswa_indonesia(id_mahasiswa, nama_mahasiswa, tgl_lahir, email, id_jurusan, alamat, created_date)
		 VALUES( 
			     OLD."id_mahasiswa"
				,OLD."nama_mahasiswa"
			 	,OLD."tgl_lahir"
			 	,OLD."email"
				,OLD."id_jurusan"
			 	,OLD."alamat"
				,now()
			   );
	RETURN OLD;

END;
$$;

alter function log_mahasiswa_indonesia_delete() owner to postgres;

-- Trigger 
create trigger delete_mahasiswa
    after delete
    on "mahasiswa_indonesia"
    for each row
execute procedure log_mahasiswa_indonesia_delete();


-- Trigger Function Update

create function log_mahasiswa_indonesia_update() returns trigger
	language plpgsql
	
as
$$
BEGIN
	IF NEW."id_mahasiswa" <> OLD."id_mahasiswa" 
	or NEW."nama_mahasiswa" <> OLD."nama_mahasiswa" 
	or NEW."tgl_lahir" <> OLD."tgl_lahir" 
	or NEW."email" <> OLD."email" 
	or NEW."id_jurusan" <> OLD."id_jurusan" 
	or NEW."alamat" <> OLD."alamat" 
	THEN
		 INSERT INTO log_mahasiswa_indonesia_update(id_mahasiswa, nama_mahasiswa, tgl_lahir, email, id_jurusan, alamat, update_date)
		 VALUES( 
			     OLD."id_mahasiswa"
				,OLD."nama_mahasiswa"
				,OLD."tgl_lahir"
				,OLD."email"
				,OLD."id_jurusan"
				,OLD."alamat"
				,now()
			   );
	END IF;
	RETURN NEW;
END;
$$;

alter function log_mahasiswa_indonesia_update() owner to postgres;

-- Trigger Update

create trigger update_mahasiswa
    before update
    on "mahasiswa_indonesia"
    for each row
execute procedure log_mahasiswa_indonesia_update();

-- ALur nya buat Table Dulu, baru Trigger Function, baru ke Trigger nya