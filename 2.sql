-- DATABASE PINJAM_BUKU

-- FUNCTION SELECT ALL DATA BY ID 
-- tabel siswa
create function read_all_siswa()
	returns TABLE(p_id_siswa integer, p_nama_siswa character varying, p_email character varying)
	language plpgsql
	as $$
	
BEGIN
    return query
    SELECT id_siswa, nama_siswa, email
	FROM "siswa"
    ORDER BY id_siswa asc;
END; $$;

-- tabel buku
create function read_all_buku()
	returns TABLE(p_id_buku integer, p_nama_buku character varying, p_penerbit character varying)
	language plpgsql
	as $$

BEGIN
    return query
    SELECT id_buku, nama_buku, penerbit
	FROM "buku"
    ORDER BY id_buku asc;
END; $$;

-- tabel pinjam join siswa
create function read_all_pinjam()
	returns TABLE(p_id_pinjam integer, p_id_siswa integer, p_id_buku integer, tanggal_pinjam date)
	language plpgsql
	as 	$$
BEGIN
    return query
    SELECT id_pinjam, pinjam.id_siswa, pinjam.id_buku, pinjam.tanggal_pinjam
	FROM "pinjam" 
	JOIN "siswa" ON siswa.id_siswa = pinjam.id_siswa
    ORDER BY id_pinjam asc;
END; $$;

-- tabel pinjam join buku
create function read_all_pinjam2()
	returns TABLE(p_id_pinjam integer, p_id_siswa integer, p_id_buku integer, tanggal_pinjam date)
	language plpgsql
	as 	$$
BEGIN
    return query
    SELECT id_pinjam, pinjam.id_siswa, pinjam.id_buku, pinjam.tanggal_pinjam
	FROM "pinjam" 
	JOIN "buku" ON buku.id_buku = pinjam.id_buku
    ORDER BY id_pinjam asc;
END; $$;


-- FUNCTION INSERT DATA
-- tabel siswa
create function create_siswa
    (p_id_siswa integer, p_nama_siswa character varying, p_email character varying) 
    returns void
    language plpgsql
    as $$
BEGIN
    INSERT INTO siswa(id_siswa, nama_siswa, email)
    VALUES(p_id_siswa, p_nama_siswa,p_email);
END; $$;

alter function create_siswa(integer, varchar,varchar) owner to postgres;


create function create_buku
    (p_id_buku integer, p_nama_buku character varying, p_penerbit character varying) 
    returns void
    language plpgsql
    as $$
BEGIN
    INSERT INTO buku(id_buku, nama_buku, penerbit)
    VALUES(p_id_buku, p_nama_buku,p_penerbit);
END; $$;

alter function create_buku(integer, varchar,varchar) owner to postgres;

-- tabel pinjam
create function create_pinjam
    (p_id_pinjam integer,p_id_siswa integer, p_id_buku integer, p_tanggal_pinjam date) 
    returns void
    language plpgsql
    as $$
BEGIN
    INSERT INTO pinjam(id_pinjam, id_siswa, id_buku,tanggal_pinjam)
    VALUES(p_id_pinjam, p_id_siswa,p_id_buku,p_tanggal_pinjam);
END; $$;

alter function create_pinjam(integer, integer, integer, date) owner to postgres;


-- FUNCTION UPDATE DATA
-- tabel siswa
create function update_siswa
    (p_id_siswa integer, p_nama_siswa character varying, p_email character varying) 
    returns void
    language plpgsql
    as $$
BEGIN
    UPDATE "siswa" 
    SET nama_siswa = p_nama_siswa, email = p_email WHERE id_siswa = p_id_siswa;
END; $$;

alter function update_siswa( integer, varchar, varchar) owner to postgres;

-- tabel buku
create function update_buku
    (p_id_buku integer, p_nama_buku character varying, p_penerbit character varying) 
    returns void
    language plpgsql
    as $$
BEGIN
    UPDATE "buku" 
    SET nama_buku = p_nama_buku, penerbit = p_penerbit WHERE id_buku = p_id_buku;
END; $$;

alter function update_buku(integer, varchar,varchar) owner to postgres;

-- tabel pinjam
create function update_pinjam
    (p_id_pinjam integer,p_id_siswa integer, p_id_buku integer, p_tanggal_pinjam date) 
    returns void
    language plpgsql
    as $$
BEGIN
    UPDATE "pinjam" 
    SET id_pinjam = p_id_pinjam, id_siswa = p_id_siswa, id_buku = p_id_buku, tanggal_pinjam = p_tanggal_pinjam
    WHERE id_pinjam = p_id_pinjam;
END; $$;

alter function update_pinjam(integer, integer, integer, date) owner to postgres;


-- FUNCTION DELETE DATA
-- tabel siswa
create function delete_siswa(p_id_siswa integer) 
    returns void
    language plpgsql
    as $$
BEGIN
    DELETE FROM "siswa"
    WHERE id_siswa = p_id_siswa;
END;
$$;

alter function delete_siswa(integer) owner to postgres;

-- tabel buku
create function delete_buku(p_id_buku integer) 
    returns void
    language plpgsql
    as $$
BEGIN
    DELETE FROM "buku"
    WHERE id_buku = p_id_buku;
END;
$$;

alter function delete_buku(integer) owner to postgres;

-- tabel pinjam
create function delete_pinjam(p_id_pinjam integer) 
    returns void
    language plpgsql
    as $$
BEGIN
    DELETE FROM "pinjam"
    WHERE id_pinjam = p_id_pinjam;
END;
$$;

alter function delete_pinjam(integer) owner to postgres;


-- VIEW DATA
-- tabel siswa
CREATE VIEW get_all_siswa as
    SELECT id_siswa, 
            nama_siswa,
            email
    FROM "siswa";

alter table get_all_siswa
    owner to postgres;

-- tabel buku
CREATE VIEW get_all_buku as
    SELECT id_buku, 
            nama_buku,
            penerbit
    FROM "buku";

alter table get_all_buku
    owner to postgres;

-- tabel pinjam
CREATE VIEW get_all_pinjam as
    SELECT id_pinjam,
            id_siswa,
            id_buku, 
            tanggal_pinjam
    FROM "pinjam";

alter table get_all_pinjam
    owner to postgres;


-- MATERIALIZED VIEW DATA
-- tabel siswa
CREATE materialized VIEW get_all_siswa_materialized as
    SELECT id_siswa, 
            nama_siswa,
            email
    FROM "siswa";

alter table get_all_siswa_materialized
    owner to postgres;

-- tabel buku
CREATE materialized VIEW get_all_buku_materialized as
    SELECT id_buku, 
            nama_buku,
            penerbit
    FROM "buku";

alter table get_all_buku_materialized
    owner to postgres;

-- tabel pinjam
CREATE materialized VIEW get_all_pinjam_materialized as
    SELECT id_pinjam,
            id_siswa,
            id_buku, 
            tanggal_pinjam
    FROM "pinjam";
alter table get_all_pinjam_materialized
    owner to postgres;


-- MEMANGGIL FUNGSI
-- insert data
SELECT * FROM create_siswa('125', 'E', 'e@gmail.com');
SELECT * FROM create_buku('444', 'NLP', 'Prentice Hall');
SELECT * FROM create_pinjam('006', '125', '444', '2022-01-14');

-- select all data by id
SELECT * FROM read_all_siswa();
SELECT * FROM read_all_buku();
SELECT * FROM read_all_pinjam();

-- update data
SELECT * FROM update_siswa('121', 'ABC', 'abc@gmail.com');
SELECT * FROM update_buku('222', 'Hacking', 'Elex Media');
SELECT * FROM update_pinjam('3', '121', '222', '2022-02-25');

-- select all data by id
SELECT * FROM read_all_siswa();
SELECT * FROM read_all_buku();
SELECT * FROM read_all_pinjam();

-- delete data
SELECT * FROM delete_siswa('125');
SELECT * FROM delete_buku('444');
SELECT * FROM delete_pinjam('006');

-- select all data by id
SELECT * FROM read_all_siswa();
SELECT * FROM read_all_buku();
SELECT * FROM read_all_pinjam();

-- MEMANGGIL VIEW DAN MATERIALIZED
-- view
SELECT * FROM get_all_siswa;
SELECT * FROM get_all_buku;
SELECT * FROM get_all_pinjam;

-- materialized
SELECT * FROM get_all_siswa_materialized;
SELECT * FROM get_all_buku_materialized;
SELECT * FROM get_all_pinjam_materialized;

REFRESH MATERIALIZED VIEW get_all_siswa_materialized;
REFRESH MATERIALIZED VIEW get_all_buku_materialized;
REFRESH MATERIALIZED VIEW get_all_pinjam_materialized;