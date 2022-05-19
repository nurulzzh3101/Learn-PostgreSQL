-- DATABASE PINJAM_BUKU

-- FUNCTION TRIGGER

-- TABEL SISWA
-- UPDATE
-- Trigger Function Update
create function siswa_update() returns trigger
	language plpgsql
	as $$
BEGIN
	IF NEW."id_siswa" <> OLD."id_siswa" 
	or NEW."nama_siswa" <> OLD."nama_siswa" 
	or NEW."email" <> OLD."email" 
	THEN
		 INSERT INTO siswa_update(id_siswa, nama_siswa, email)
		 VALUES( 
			     OLD."id_siswa"
				,OLD."nama_siswa"
				,OLD."email"
			   );
	END IF;
	RETURN NEW;
END; $$;

alter function siswa_update() owner to postgres;

-- Trigger Update
create trigger update_siswa
    before update
    on "siswa"
    for each row
execute procedure siswa_update();


-- DELETE
-- Trigger Function Delete
create function siswa_delete() returns trigger
	language plpgsql
	as $$
BEGIN

INSERT INTO siswa_delete(id_siswa, nama_siswa, email)
		 VALUES( 
			     OLD."id_siswa"
				,OLD."nama_siswa"
				,OLD."email"
			   );
	RETURN OLD;

END;
$$;

alter function siswa_delete() owner to postgres;

-- Trigger Delete
create trigger delete_siswa
    after delete
    on "siswa"
    for each row
execute procedure siswa_delete();



-- TABEL BUKU
-- UPDATE
-- Trigger Function Update
create function buku_update() returns trigger
	language plpgsql
	as $$
BEGIN
	IF NEW."id_buku" <> OLD."id_buku" 
	or NEW."nama_buku" <> OLD."nama_buku" 
	or NEW."penerbit" <> OLD."penerbit" 
	THEN
		 INSERT INTO buku_update(id_buku, nama_buku, penerbit)
		 VALUES( 
			     OLD."id_buku"
				,OLD."nama_buku"
				,OLD."penerbit"
			   );
	END IF;
	RETURN NEW;
END; $$;

alter function buku_update() owner to postgres;

-- Trigger Update
create trigger update_buku
    before update
    on "buku"
    for each row
execute procedure buku_update();


-- DELETE
-- Trigger Function Delete
create function buku_delete() returns trigger
	language plpgsql
	as $$
BEGIN

INSERT INTO buku_delete(id_buku, nama_buku, penerbit)
		 VALUES( 
			     OLD."id_buku"
				,OLD."nama_buku"
				,OLD."penerbit"
			   );
	RETURN OLD;

END;
$$;

alter function buku_delete() owner to postgres;

-- Trigger Delete
create trigger delete_buku
    after delete
    on "buku"
    for each row
execute procedure buku_delete();



-- TABEL PINJAM
-- UPDATE
-- Trigger Function Update
create function pinjam_update() returns trigger
	language plpgsql
	as $$
BEGIN
	IF NEW."id_pinjam" <> OLD."id_pinjam" 
	or NEW."id_siswa" <> OLD."id_siswa" 
    or NEW."id_buku" <> OLD."id_buku" 
	or NEW."tanggal_pinjam" <> OLD."tanggal_pinjam" 
	THEN
		 INSERT INTO pinjam_update(id_pinjam,id_siswa,id_buku,tanggal_pinjam)
		 VALUES( 
			     OLD."id_pinjam"
				,OLD."id_siswa"
                ,OLD."id_buku"
				,OLD."tanggal_pinjam"
			   );
	END IF;
	RETURN NEW;
END; $$;

alter function pinjam_update() owner to postgres;

-- Trigger Update
create trigger update_pinjam
    before update
    on "pinjam"
    for each row
execute procedure pinjam_update();


-- DELETE
-- Trigger Function Delete
create function pinjam_delete() returns trigger
	language plpgsql
	as $$
BEGIN

INSERT INTO pinjam_delete(id_pinjam,id_siswa,id_buku,tanggal_pinjam)
		 VALUES( 
			     OLD."id_pinjam"
				,OLD."id_siswa"
                ,OLD."id_buku"
				,OLD."tanggal_pinjam"
			   );
	RETURN OLD;

END;
$$;

alter function pinjam_delete() owner to postgres;

-- Trigger Delete
create trigger pinjam_buku
    after delete
    on "pinjam"
    for each row
execute procedure pinjam_delete();


-- INDEXING
-- TABEL SISWA
CREATE INDEX IF NOT EXISTS idx_siswa_01
    ON public.siswa USING btree
    (id_siswa ASC NULLS LAST)
    INCLUDE(id_siswa, nama_siswa, email)
    TABLESPACE pg_default;

-- TABEL BUKU
CREATE INDEX IF NOT EXISTS idx_buku_01
    ON public.buku USING btree
    (id_buku ASC NULLS LAST)
    INCLUDE(id_buku, nama_buku, penerbit)
    TABLESPACE pg_default;

-- TABEL PINJAM
CREATE INDEX IF NOT EXISTS idx_pinjam_01
    ON public.pinjam USING btree
    (id_pinjam ASC NULLS LAST)
    INCLUDE(id_pinjam, id_siswa, id_buku, tanggal_pinjam)
    TABLESPACE pg_default;