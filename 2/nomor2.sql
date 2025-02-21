drop user prakbd cascade;
create user prakbd identified by prakbd;
conn prakbd/prakbd

set linesize 1000;
set pagesize 500;

spool "D:\SPOOL2_220116919.sql";
set time on;
set sqlprompt "220116919 >";

--DDL DML
--NO 1
drop table mahasiswa cascade constraint purge;
drop table buku cascade constraint purge;
drop table penerbit cascade constraint purge;
drop table pinjam cascade constraint purge;

create table mahasiswa(
    kode_mahasiswa varchar2(9) constraint pk_mhs primary key,
    nama_mahasiswa varchar2(50) constraint nn_nama not null,
    email_mahasiswa varchar2(50) constraint un_email unique,
    no_telp_mahasiswa varchar2(50),
    peliharaan_mahasiswa number(1) constraint ch_peliharaan check(peliharaan_mahasiswa >= 0 or peliharaan_mahasiswa < 4)
);

create table penerbit(
    kode_penerbit varchar2(4) constraint pk_penerbit primary key,
    nama_penerbyte varchar2(50) constraint nn_penerbit not null
);

create table buku(
    kode_buku varchar2(4) constraint pk_buku primary key,
    nama_buku varchar2(50) constraint nn_buku not null,
    tahun_terbit_buku number(4),
    penerbit_buku varchar2(4) constraint fk_penerbit references penerbit(kode_penerbit),
    status_buku number(1) constraint ch_status check (status_buku = 0 or status_buku = 1)
);

create table pinjam(
    kode_pinjam varchar2(5) constraint pk_pinjam primary key,
    kode_peminjam varchar2(9) constraint fk_mahasiswa references mahasiswa(kode_mahasiswa),
    kode_buku varchar2(4) constraint fk_buku references buku(kode_buku),
    tanggal_pinjam date
);

--NO 2
alter table penerbit rename column nama_penerbyte to nama_penerbit;

--NO 3
alter table mahasiswa drop column peliharaan_mahasiswa;

--NO 4
insert into mahasiswa values('218116122', 'Currey Smallcombe', 'csmallcombe0@google.co.jp', '3986276122');
insert into mahasiswa values('218114007', 'Melody Grund', 'mgrund1@theguardian.com', '3378014007');
insert into mahasiswa values('218113962', 'Rubetta Manilow', 'rmanilow2@sitemeter.com', '1127093962');
insert into mahasiswa values('218115573', 'Tresa Beeres', 'tbeeres3@squarespace.com', '5639695573');

insert into penerbit values('P001', 'Cogilith');
insert into penerbit values('P002', 'Jetpulse');
insert into penerbit values('P003', 'Myworks');
insert into penerbit values('P004', 'Chatterpoint');

insert into buku values('B001', 'Buku aiy', 2007, 'P001', 1);
insert into buku values('B002', 'Buku kau', 2013, 'P002', 0);
insert into buku values('B003', 'Buku ente', 2015, 'P003', 1);
insert into buku values('B004', 'Bukuna', 2017, 'P004', 0);

insert into pinjam values('PJ001', '218114007', 'B001', to_date('16/07/2000','DD/MM/YYYY'));
insert into pinjam values('PJ002', '218115573', 'B002', to_date('21/12/2000','DD/MM/YYYY'));
insert into pinjam values('PJ003', '218116122', 'B002', to_date('08/03/2001','DD/MM/YYYY'));
insert into pinjam values('PJ004', '218115573', 'B003', to_date('26/06/2001','DD/MM/YYYY'));

--NO 5
update buku set nama_buku = 'Bukub' where kode_buku = 'B002';

--NO 6
delete from pinjam where nama_buku = 'Buku kau';

spool off;