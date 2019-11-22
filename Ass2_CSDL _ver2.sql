create database DORM_MANAGEMENT1
go

use DORM_MANAGEMENT1
go

-- Tao bang nguoi dung
create table Nguoi_dung
(
	Ten_dang_nhap varchar(20) check(len(Ten_dang_nhap)>=6),
	Mat_khau varchar(1000) not null default '123456',
	Nguoi_dung nvarchar(20) not null check(Nguoi_dung = N'Sinh viên' or Nguoi_dung = N'Trưởng nhà' or Nguoi_dung = N'Bảo vệ' or Nguoi_dung = N'Thu ngân') default 'Sinh viên',
	Ho_ten_dem nvarchar(20) not null,
	Ten nvarchar(6) not null,
	Ngay_sinh date not null default '1999-01-01',
	CMND bigint not null unique,check(len(CMND)=9 or len(CMND)=12 ),
	Gioi_tinh nvarchar(3) not null check(Gioi_tinh = N'Nam' or Gioi_tinh = N'Nữ') default N'Nam',
	Quan_Huyen nvarchar(50) not null default N'Thủ Đức',
	Tinh_TP nvarchar (20) not null default N'TP Hồ Chí Minh',
	Hinh_anh image,
	Tinh_trang char(1) not null check(Tinh_trang = 'X' or Tinh_trang = 'O') default 'X', --'X' neu còn ở và 'O' nếu không còn ở

	primary key(Ten_dang_nhap)
)
go

--Tao bang Ten_dang_nhap
create table Email_Nguoi_dung
(
	Ten_dang_nhap varchar(20) not null,
	Email varchar(30) not null ,

	primary key(Ten_dang_nhap,Email)
)
go

--Tao bang SDT_nguoi_dung
create table SDT_Nguoi_dung
(
	Ten_dang_nhap varchar(20) not null,
	SDT char(10) not null ,check(len(SDT)=10),--:3 :v

	primary key(Ten_dang_nhap,SDT)
)
go

--Tao bang thu ngan
create table Thu_ngan
(
	Ten_dang_nhap varchar(20) not null,
	MSNV varchar(6) not null,
	primary key(Ten_dang_nhap, MSNV)
)
go

--Tao bang Bao ve
create table Bao_ve
(
	Ten_dang_nhap varchar(20) not null,
	MSNV varchar(6) not null,
	primary key(Ten_dang_nhap, MSNV)
)
go

--Tao bang truong nha
create table Truong_nha
(
	Ten_dang_nhap varchar(20) not null,
	MSNV varchar(6) not null,
	primary key(Ten_dang_nhap, MSNV)
)
go

--tao bang Bao_ve_Truc
create table Bao_ve_truc
(
	MSNV varchar(6) not null,
	Ten_dang_nhap varchar(20) not null,
	Ngay_truc date not null,
	Ca_truc char(1) not null check(Ca_truc = 'S' or Ca_truc = 'T') default 'S' ,
	primary key (MSNV, Ten_dang_nhap, Ngay_truc, Ca_truc)
)
go

create table Sinh_vien
(
	Ten_dang_nhap varchar(20) not null,
	MSSV bigint not null,
	Truong nvarchar(50) not null default N'BK TPHCM',
	Nam_thu int not null check(Nam_thu >= '1' and Nam_thu <= '6') default '1',
	primary key(Ten_dang_nhap)
)
go

create table Yeu_cau
(
	Req_ID int identity(1,1) not null,
	Tinh_trang char(1) not null check(Tinh_trang = 'X' or Tinh_trang = 'O') default 'X', --Nếu chưa giải quyết thì là 'X' ngược lại là 'O'.
	Noi_dung_yeu_cau nvarchar(500) not null,
	Ngay_gui date,
	Ten_dang_nhap_SV varchar(20) not null,
	Ngay_giai_quyet date,
	Ten_dang_nhap_TN varchar(20) not null,
	MSNV varchar(6) not null,
	check (Ngay_giai_quyet >= Ngay_gui),
	primary key(Req_ID, Ten_dang_nhap_SV, Ten_dang_nhap_TN, MSNV),
)
go

create table Tin_nhan
(
	Mess_ID int identity(1,1) not null,
	Noi_dung_tin_nhan nvarchar(500) not null,
	Ngay_gui date,
	Ten_dang_nhap varchar(20) not null,
	primary key(Mess_ID)
) 
go
CREATE TABLE Toa_nha
(
	Ten_toa_nha nvarchar(5) primary key,
	Ngay_thi_cong date,
	Ngay_hoan_thanh date,
	So_phong int,
)
go

CREATE TABLE Phong
(
	Ten_phong int check(len(Ten_phong) = 3),
	Ten_toa_nha nvarchar(5) not null,
	Loai_phong NVARCHAR(8) CHECK(Loai_phong IN (N'Phòng 2', N'Phòng 4', N'Phòng 6', N'Phòng 8')) NOT NULL DEFAULT N'Phòng 2',
	So_SV_dang_co int not null default 0,
	So_SV_toi_da int check(So_SV_toi_da in (2,4,6,8)) not null default 2,
	Tinh_trang nvarchar(10) check(Tinh_trang = N'Trống' or Tinh_trang = N'Có người' or Tinh_trang = N'Đầy' ) not null default N'Trống'
	primary key (Ten_phong, Ten_toa_nha)
)
go

create table Hoa_don
(
	Bill_ID int primary key,
	Ngay_lap_hoa_don date not null,
	Tong_tien int,
	Tinh_trang char(1) not null check(Tinh_trang = 'X' or Tinh_trang = 'O') default 'X', --Nếu trả tiền rồi thì là 'X' ngược lại là 'O'.
	Hoc_ky nvarchar(2) not null check(Hoc_ky = '1' or Hoc_ky = '2' or Hoc_ky = 'Hè') default '1',
	Nam int,
)
go

--Phần của Giang
CREATE TABLE Tien_Dien_Nuoc
(
	Bill_ID int unique not null,
	Ten_phong int check(len(Ten_phong) = 3),
	Ten_toa_nha nvarchar(5) not null,
	Chi_so_dien_thang_nay int not null,
	Chi_so_nuoc_thang_nay int not null,
	Tien_dien float,
	Tien_nuoc float,
	Ten_dang_nhap_TN varchar(20) not null,
	MSNV varchar(6) not null,
	Ngay_chot_chi_so date,
	Thang int,
	primary key(Bill_ID,Ten_dang_nhap_TN, MSNV,Ten_phong,Ten_toa_nha)
)
go

CREATE TABLE Tien_phong
(
	Bill_ID int not null,
	So_thang int,
	primary key (Bill_ID)
)
go


CREATE TABLE Tien_BHYT
(
	Bill_ID int unique not null,
	Ma_BHYT varchar(15),
	primary key( Bill_ID , Ma_BHYT)

)
go



CREATE TABLE Truong_phong 
(
	Ten_toa_nha nvarchar(5) not null,
	Ten_phong int not null check(len(Ten_phong)=3),
	Ten_dang_nhap_SV varchar(20) not null,
	Ngay_bat_dau date not null,
	Ngay_ket_thuc date,
	primary key(Ten_toa_nha, Ten_phong, Ten_dang_nhap_SV,Ngay_bat_dau)

)
go

CREATE TABLE Thoi_gian_o_cua_SV
(
	Ten_dang_nhap_SV varchar(20) not null,
	Ten_toa_nha nvarchar(5) not null,
	Ten_phong int not null check(len(Ten_phong)=3),
	Ngay_bat_dau date not null,
	Ngay_ket_thuc date,
	primary key(Ten_dang_nhap_SV, Ten_phong, Ten_toa_nha,Ngay_bat_dau)
)
go
CREATE TABLE SV_o_phong
(
	Ten_dang_nhap_SV varchar(20) not null,
	Ten_phong int not null check(len(Ten_phong)=3),
	Ten_toa_nha nvarchar(5) not null,
	primary key(Ten_dang_nhap_SV, Ten_phong, Ten_toa_nha)
)
go

CREATE TABLE Nhan_tin_nhan
(
	Mess_ID int not null,
	Ten_dang_nhap varchar(20) not null check(len(Ten_dang_nhap)>6),
	primary key ( Mess_ID , Ten_dang_nhap)
)
go
CREATE TABLE TN_lam_viec_o_toa_nha
(
	Ten_dang_nhap_TN varchar(20) not null,
	MSNV varchar(6) not null,
	Ten_toa_nha nvarchar(5) not null,
	primary key(Ten_dang_nhap_TN,MSNV ,Ten_toa_nha)
)
go
CREATE TABLE Thoi_gian_lam_viec_cua_TN
(
	Ten_dang_nhap_TN varchar(20) not null,
	MSNV varchar(6) not null,
	Ten_toa_nha nvarchar(5) not null,
	Ngay_bat_dau date not null,
	Ngay_ket_thuc date,
	primary key(Ten_dang_nhap_TN, MSNV, Ten_toa_nha,Ngay_bat_dau)
)
go
CREATE TABLE BV_lam_viec_o_toa_nha
(
	Ten_dang_nhap_BV varchar(20) not null,
	MSNV varchar(6) not null,
	Ten_toa_nha nvarchar(5) not null,
	primary key(Ten_dang_nhap_BV,MSNV ,Ten_toa_nha)
)
go
CREATE TABLE Thoi_gian_lam_viec_cua_BV
(
	Ten_dang_nhap_BV varchar(20) not null,
	MSNV varchar(6) not null,
	Ten_toa_nha nvarchar(5) not null,
	Ngay_bat_dau date not null,
	Ngay_ket_thuc date,
	primary key(Ten_dang_nhap_BV, MSNV, Ten_toa_nha,Ngay_bat_dau)
)
go
CREATE TABLE Thu_ngan_thanh_toan_hoa_don_SV
(
	Ten_dang_nhap_ThN varchar(20) not null,
	MSNV varchar(6) not null,
	Bill_ID int,
	Ten_dang_nhap_SV varchar(20) not null,
	Ngay_thanh_toan date,
	primary key(Ten_dang_nhap_ThN, MSNV, Bill_ID)
)
go
---------------------------------Constraint------------------------------
---------------------------------End-Constraint--------------------------
---------------------------------Refrence--------------------------------
ALTER TABLE dbo.Email_Nguoi_dung
ADD FOREIGN KEY(Ten_dang_nhap) REFERENCES dbo.Nguoi_dung(Ten_dang_nhap)
go
ALTER TABLE dbo.SDT_Nguoi_dung
ADD FOREIGN KEY(Ten_dang_nhap) REFERENCES dbo.Nguoi_dung(Ten_dang_nhap)
go
ALTER TABLE dbo.Thu_ngan
ADD FOREIGN KEY(Ten_dang_nhap) REFERENCES dbo.Nguoi_dung(Ten_dang_nhap)
go
ALTER TABLE dbo.Truong_nha
ADD FOREIGN KEY(Ten_dang_nhap) REFERENCES dbo.Nguoi_dung(Ten_dang_nhap)
go
ALTER TABLE dbo.Bao_ve
ADD FOREIGN KEY(Ten_dang_nhap) REFERENCES dbo.Nguoi_dung(Ten_dang_nhap)
go
ALTER TABLE dbo.Bao_ve_truc
ADD FOREIGN KEY(Ten_dang_nhap, MSNV) REFERENCES dbo.Bao_ve(Ten_dang_nhap, MSNV)
go
ALTER TABLE dbo.Sinh_vien
ADD FOREIGN KEY(Ten_dang_nhap) REFERENCES dbo.Nguoi_dung(Ten_dang_nhap)
go
ALTER TABLE dbo.Yeu_cau
ADD FOREIGN KEY(Ten_dang_nhap_SV) REFERENCES dbo.Sinh_vien(Ten_dang_nhap)
go
ALTER TABLE dbo.Yeu_cau
ADD FOREIGN KEY(Ten_dang_nhap_TN, MSNV) REFERENCES dbo.Truong_nha(Ten_dang_nhap, MSNV)
go
ALTER TABLE dbo.Tin_nhan
ADD FOREIGN KEY(Ten_dang_nhap) REFERENCES dbo.Nguoi_dung(Ten_dang_nhap)
go
ALTER TABLE dbo.Tien_Dien_Nuoc
ADD FOREIGN KEY(Bill_ID) REFERENCES dbo.Hoa_don(Bill_ID)
go
ALTER TABLE dbo.Tien_dien_nuoc
ADD FOREIGN KEY(Ten_dang_nhap_TN, MSNV) REFERENCES dbo.Truong_nha(Ten_dang_nhap, MSNV)
go
ALTER TABLE dbo.Tien_dien_nuoc
ADD FOREIGN KEY(Ten_phong, Ten_toa_nha) REFERENCES dbo.Phong(Ten_phong,Ten_toa_nha)
go
ALTER TABLE dbo.Tien_phong
ADD FOREIGN KEY(Bill_ID) REFERENCES dbo.Hoa_don(Bill_ID)
go

ALTER TABLE dbo.Tien_BHYT
ADD FOREIGN KEY(Bill_ID) REFERENCES dbo.Hoa_don(Bill_ID)
go


ALTER TABLE dbo.Phong
ADD FOREIGN KEY(Ten_toa_nha) REFERENCES dbo.Toa_nha(Ten_toa_nha)
go
ALTER TABLE dbo.Truong_phong
ADD FOREIGN KEY(Ten_phong, Ten_toa_nha) REFERENCES dbo.Phong(Ten_phong, Ten_toa_nha)
go
ALTER TABLE dbo.SV_o_phong
ADD FOREIGN KEY(Ten_dang_nhap_SV) REFERENCES dbo.Sinh_vien(Ten_dang_nhap)
go
ALTER TABLE dbo.SV_o_phong
ADD FOREIGN KEY(Ten_phong, Ten_toa_nha) REFERENCES dbo.Phong(Ten_phong, Ten_toa_nha)
go
ALTER TABLE dbo.Thoi_gian_o_cua_SV
ADD FOREIGN KEY(Ten_dang_nhap_SV,Ten_phong, Ten_toa_nha) REFERENCES dbo.SV_o_phong(Ten_dang_nhap_SV,Ten_phong, Ten_toa_nha)
go
ALTER TABLE dbo.Nhan_tin_nhan
ADD FOREIGN KEY(Mess_ID) REFERENCES dbo.Tin_nhan(Mess_ID)
go
ALTER TABLE dbo.Nhan_tin_nhan
ADD FOREIGN KEY(Ten_dang_nhap) REFERENCES dbo.Nguoi_dung(Ten_dang_nhap)
go
ALTER TABLE dbo.TN_lam_viec_o_toa_nha
ADD FOREIGN KEY(Ten_toa_nha) REFERENCES dbo.Toa_nha(Ten_toa_nha)
go
ALTER TABLE dbo.TN_lam_viec_o_toa_nha
ADD FOREIGN KEY(Ten_dang_nhap_TN, MSNV) REFERENCES dbo.Truong_nha(Ten_dang_nhap,MSNV)
go
ALTER TABLE dbo.Thoi_gian_lam_viec_cua_TN
ADD FOREIGN KEY(Ten_dang_nhap_TN,MSNV, Ten_toa_nha) REFERENCES dbo.TN_lam_viec_o_toa_nha(Ten_dang_nhap_TN,MSNV, Ten_toa_nha)
go
ALTER TABLE dbo.BV_lam_viec_o_toa_nha
ADD FOREIGN KEY(Ten_toa_nha) REFERENCES dbo.Toa_nha(Ten_toa_nha)
go
ALTER TABLE dbo.BV_lam_viec_o_toa_nha
ADD FOREIGN KEY(Ten_dang_nhap_BV, MSNV) REFERENCES dbo.Bao_ve(Ten_dang_nhap,MSNV)
go
ALTER TABLE dbo.Thoi_gian_lam_viec_cua_BV
ADD FOREIGN KEY(Ten_dang_nhap_BV,MSNV, Ten_toa_nha) REFERENCES dbo.BV_lam_viec_o_toa_nha(Ten_dang_nhap_BV,MSNV, Ten_toa_nha)
go
ALTER TABLE dbo.Thu_ngan_thanh_toan_hoa_don_SV
ADD FOREIGN KEY(Ten_dang_nhap_ThN,MSNV) REFERENCES dbo.Thu_ngan(Ten_dang_nhap,MSNV)
go
ALTER TABLE dbo.Thu_ngan_thanh_toan_hoa_don_SV
ADD FOREIGN KEY(Bill_ID) REFERENCES dbo.Hoa_don(Bill_ID)
go
---------------------------------End-Refrence----------------------------
---------------------------------Data------------------------------------
---Table--Nguoi_dung---
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND])VALUES('1111112',N'Nguyễn Hà',N'Hải','1999-03-29',197374833)
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND])VALUES('1111113',N'Nguyễn Minh',N'Hòa','1999-04-29',197474833)
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND])VALUES('1111114',N'Nguyễn Văn',N'Hùng','1999-05-29',197574833)
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND])VALUES('1111115',N'Nguyễn Tiến',N'Hưng','1999-06-29',197674833)
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND])VALUES('1111116',N'Nguyễn Trọng',N'Hướng','1999-07-29',197774833)
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111111',N'Nguyễn Văn',N'Đạt','1999-03-28',197374834,'Nam',N'Dĩ An',N'Bình Dương',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111120',N'Nguyễn Trọng',N'Đạt','1999-03-21',197344834,'Nam',N'Biên Hòa',N'Đồng Nai',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111121',N'Phan Văn',N'Khánh','1998-03-28',193374834,'Nam',N'Vĩnh Linh',N'Quảng Trị',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111122',N'Phùng Duy',N'Kha','1997-03-28',192374834,'Nam',N'Phú Lộc',N'Thừa Thiên Huế',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111123',N'Phạm Bá',N'Linh','1999-05-18',197374894,'Nam',N'Phong Điền',N'Thừa Thiên Huế',null,'X')
--TN
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND])VALUES('1111118',N'Trưởng nhà',N'Nguyễn Văn',N'Hường','1999-08-29',197874833)
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111124',N'Trưởng nhà',N'Ông Văn',N'Đức','1975-04-28',187974834,'Nam',N'Mường Nhé',N'Điện Biên',null,'O')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111125',N'Trưởng nhà',N'Nguyễn Trung',N'Hòa','1983-09-28',190974834,'Nam',N'Vạn Ninh',N'Khánh Hòa',null,'O')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111126',N'Trưởng nhà',N'Phùng Quán',N'Thanh','1985-04-28',191974834,'Nam',N'Mường Nhé',N'Điện Biên',null,'O')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111127',N'Trưởng nhà',N'Phạm Minh',N'Đăng','1987-04-28',192974834,'Nam',N'Vạn Ninh',N'Khánh Hòa',null,'O')
--
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111117',N'Bảo vệ',N'Phương',N'Đăng','1991-04-28',197974834,'Nam',N'Mường Nhé',N'Điện Biên',null,'O')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111128',N'Bảo vệ',N'Phạm',N'Hòa','1992-04-08',193974834,'Nam',N'Ngọc Hiển',N'Cà Mau',null,'O')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111129',N'Bảo vệ',N'Phùng',N'Huy','1993-04-18',194974834,'Nam',N'Đồng Văn',N'Hà Giang',null,'O')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111130',N'Bảo vệ',N'Nguyễn Minh',N'Trương','1989-03-28',195974834,'Nam',N'Ngọc Hiển',N'Cà Mau',null,'O')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111131',N'Bảo vệ',N'Nguyễn Văn',N'Khá','1988-05-28',196974834,'Nam',N'Đồng Văn',N'Hà Giang',null,'O')

INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111119',N'Thu ngân',N'Nguyễn Văn',N'Dương','1989-05-28',197074834,'Nam',N'Hải Lăng',N'Quảng Trị',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111132',N'Thu ngân',N'Nguyễn Thị Minh',N'Thư','1991-05-28',197064834,N'Nữ',N'Đông Hà',N'Quảng Trị',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111133',N'Thu ngân',N'Nguyễn Đăng',N'Phong','1992-05-28',197054834,'Nam',N'Vĩnh Linh',N'Quảng Trị',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111134',N'Thu ngân',N'Nguyễn Thị',N'Thương','1993-05-28',197044834,N'Nữ',N'Gio Linh',N'Quảng Trị',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('1111135',N'Thu ngân',N'Nguyễn Văn',N'Đường','1994-05-28',197034834,'Nam',N'Hướng Hóa',N'Quảng Trị',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])
VALUES	('3000001',N'Trương Ngọc',		N'Hân',		'1999-06-12',	345182379,	N'Nữ',	N'Thủ Thừa',	N'Long An',			NULL,	'X'),
		('3000002',N'Tạ Thanh',			N'Nhàn',	'1998-08-09',	319879887,	N'Nam',	N'Đức Hòa' ,	N'Long An',			NULL,	'X'),
		('3000003',N'Tăng Thanh',		N'Hà'  ,	'2000-09-29',	319876582,	N'Nữ' ,	N'Đức Huệ',		N'Long An',			NULL,	'X'),
		('3000004',N'Văn Mai',			N'Hương',	'1997-10-09' ,	329879667,	N'Nữ',	N'Châu Thành',	N'Tiền Giang',		NULL,	'X'),
		('3000005',N'Vương Tấn',		N'Tài',		'1998-12-06',	343124618,	N'Nam',	N'Tân Thành',	N'Long An',			NULL,	'X'),
		('3000006',N'Trần Thị Thanh',	N'Thùy',	'2000-06-07',	346872464,	N'Nữ',	N'Quận 9',		N'TP Hồ Chí Minh',	NULL,	'X'),
		('3000007',N'Trịnh Thị Mai',	N'Anh',		'2000-09-10',	324734782,	N'Nữ',	N'Quận 10',		N'TP Hồ Chí Minh',	NULL,	'X'),
		('3000008',N'Trần Tuấn',		N'Hậu',		'1998-12-08',	349877809,	N'Nam',	N'Tân An',		N'Long An',			NULL,	'X'),
		('3000009',N'Trang Thị',		N'Hồng',	'1997-12-09',	327876651,	N'Nữ',	N'Mỏ Cày',		N'Bến Tre',			NULL,	'X'),
		('3000010',N'Trương Gia',		N'Yên',		'1999-01-10',	301387642,	N'Nữ',	N'Nhà Bè',		N'TP Hồ Chí Minh',	NULL,	'X')
--insert thu ngan
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2200001',N'Thu ngân',N'Đinh Văn',N'Cương','1995-06-28',197074344,'Nam',N'Dĩ An',N'Bình Dương',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2200002',N'Thu ngân',N'Doãn Chí',N'Bình','1994-05-28',191374834,'Nam',N'Dĩ An',N'Bình Dương',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2200003',N'Thu ngân',N'Dương',N'Quá','1993-02-20',307074834,'Nam',N'Dĩ An',N'Bình Dương',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2200004',N'Thu ngân',N'Giang Bình',N'Thuận','1995-03-15',397374834,'Nam',N'Biên Hòa',N'Đồng Nai',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2200005',N'Thu ngân',N'Hà Thiên',N'Nhân','1993-08-24',297073434,'Nam',N'Biên Hòa',N'Đồng Nai',null,'X')

--insert SV
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2000001',N'Sinh viên',N'Đinh Quốc',N'Cường','1997-06-28',197073344,'Nam',N'Dĩ An',N'Bình Dương',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2000002',N'Sinh viên',N'Đinh Xuân',N'Hinh','1998-11-28',197234444,'Nam',N'Biên Hòa',N'Đồng Nai',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2000003',N'Sinh viên',N'Châu Văn',N'Sa','1999-12-28',193074344,'Nam',N'Dĩ An',N'Bình Dương',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2000004',N'Sinh viên',N'Hà Duy',N'Tập','1998-10-28',197078344,'Nam',N'Châu Thành',N'Tiền Giang',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2000005',N'Sinh viên',N'Hồ Kim',N'Bảo','1997-09-28',196743441,'Nam',N'Châu Thành',N'Bến Tre',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2000006',N'Sinh viên',N'Hoàng Thanh',N'Thanh','1997-05-28',197076384,'Nam',N'Dĩ An',N'Bình Dương',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2000007',N'Sinh viên',N'Lâm Cao',N'Cường','1997-07-29',197943424,'Nam',N'Biên Hòa',N'Đồng Nai',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2000008',N'Sinh viên',N'Cao Dương',N'Dương','1997-01-03',207074344,'Nam',N'Dĩ An',N'Bình Dương',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2000009',N'Sinh viên',N'Hoàng Văn',N'Công','1997-02-22',207174344,'Nam',N'Phan Thiết',N'Khánh Hòa',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2000010',N'Sinh viên',N'Đinh Văn',N'Lâm','1999-05-01',207074334,'Nam',N'Dĩ An',N'Bình Dương',null,'X')


--insert Trưởng Nhà
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2100001',N'Trưởng nhà',N'Đoàn Văn',N'Hậu','1990-01-04',197074224,'Nam',N'Thủ Đức',N'TP Hồ Chí Minh',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2100002',N'Trưởng nhà',N'An Dương',N'Vương','1991-03-21',197064345,'Nam',N'Dĩ An',N'Bình Dương',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2100003',N'Trưởng nhà',N'Châu Tinh',N'Trì','1989-04-15',197022396,'Nam',N'Bắc Trà My',N'Quảng Nam',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2100004',N'Trưởng nhà',N'Đỗ Văn',N'Đô','1988-06-11',197076744,'Nam',N'Dĩ An',N'Bình Dương',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2100005',N'Trưởng nhà',N'Đậu Thế',N'Phạt','1991-09-22',197074321,'Nam',N'Dĩ An',N'Bình Dương',null,'X')

--insert Bảo Vệ
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2300001',N'Bảo vệ',N'Chu Văn',N'An','1970-03-04',197004224,'Nam',N'Thủ Đức',N'TP Hồ Chí Minh',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2300002',N'Bảo vệ',N'Lại Văn',N'Sâm','1977-04-07',197074299,'Nam',N'Phú Nhuận',N'TP Hồ Chí Minh',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2300003',N'Bảo vệ',N'Lại Thế',N'Phúc','1980-05-15',197074278,'Nam',N'Tân Phú',N'TP Hồ Chí Minh',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2300004',N'Bảo vệ',N'Lê Trần',N'Hoàng','1990-11-22',197067547,'Nam',N'Hải Lăng',N'Quảng Trị',null,'X')
INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])VALUES('2300005',N'Bảo vệ',N'Lê Nhật',N'Linh','1980-12-17',197767546,'Nam',N'Tam Kỳ',N'Quảng Nam',null,'X')
--Nhan vien
INSERT INTO [dbo].Nguoi_dung(Ten_dang_nhap,Nguoi_dung,Ho_ten_dem,Ten,Ngay_sinh,CMND,Gioi_tinh,Quan_Huyen,Tinh_TP,Hinh_anh,Tinh_trang)
values
		('3100001',	N'Trưởng nhà',	N'Trương Quỳnh',	N'Như',		'1970-01-03',	321245467,	N'Nữ',	N'Quận 1',		N'TP Hồ Chí Minh',	NULL,	'X'),
		('3100002', N'Trưởng nhà',	N'Trần Ngọc Như',	N'Quỳnh',	'1962-03-21',	301245523,	N'Nữ',	N'Quận 2',		N'TP Hồ Chí Minh',  NULL,	'X'),
		('3100003',	N'Trưởng nhà',	N'Trịnh Kim',		N'Chi',		'1972-09-23',	319876722,	N'Nữ',	N'Quận 3',		N'TP Hồ Chí Minh',	NULL,	'X'),
		('3100004', N'Trưởng nhà',	N'Vương Chí',		N'Cường',	'1968-09-29',	212354546,	N'Nam',	N'Thủ Đức',		N'TP Hồ Chí Minh',	NULL,	'X'),
		('3100005',	N'Trưởng nhà',	N'Trang Hào',		N'Nam',		'1972-09-23',	235246257,	N'Nam',	N'Dĩ An',		N'Bình Dương',		NULL,	'X'),
		('3200001',	N'Thu ngân',	N'Trịnh Văn',		N'Toàn',	'1970-10-21',	325243565,	N'Nam',	N'Quận 9',		N'TP Hồ Chí Minh',	NULL,	'X'),
		('3200002', N'Thu ngân',	N'Trang Thị Ngọc',	N'Quế',		'1980-11-09',	235256764,	N'Nữ',	N'Bình Thạnh',	N'TP Hồ Chí Minh',	NULL,	'X'),
		('3200003',	N'Thu ngân',	N'Tạ Thị Hồng',		N'Nga',		'1970-07-10',	123546764,	N'Nữ',	N'Mộc Hóa',		N'Long An',			NULL,	'X'),
		('3200004',	N'Thu ngân',	N'Tương Thị Ngọc',	N'Chi',		'1974-08-09',	124364740,	N'Nữ',	N'Tân Trụ',		N'Long An',			NULL,	'X'),
		('3200005',	N'Thu ngân',	N'Tăng Hồng',		N'Hoa',		'1982-09-24',	216573235,	N'Nữ',	N'Biên Hòa',	N'Đồng Nai',		NULL,	'X'),
		('3300001',	N'Bảo vệ',		N'Trương Lực',		N'Lưỡng',	'1978-03-12',	238576876,	N'Nam',	N'Giồng Trôm',	N'Bến Tre',			NULL,	'X'),
		('3300002', N'Bảo vệ',		N'Trang Anh',		N'Hùng',	'1975-04-22',	439821764,	N'Nam',	N'Mỏ Cày',		N'Bến Tre',			NULL,	'X'),
		('3300003',	N'Bảo vệ',		N'Tạ Văn',			N'Mạnh',	'1987-01-23',	132587162,	N'Nam',	N'Quận 1',		N'TP Hồ Chí Minh',	NULL,	'X'),
		('3300004',	N'Bảo vệ',		N'Vương Chí',		N'Cường',	'1970-12-09',	132587683,	N'Nam',	N'Củ Chi',		N'TP Hồ Chí Minh',	NULL,	'X'),
		('3300005',	N'Bảo vệ',		N'Trần Nguyên Anh',	N'Dũng',	'1972-10-23',	234128346,	N'Nam',	N'Quận 12',		N'TP Hồ Chí Minh',	NULL,	'X')
go		
--select * from Nguoi_dung
--go

----Table--Email_nguoi_dung
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111111','nguyenvandat@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111112','nguyenvanduc@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111113','nguyenvanhoa@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111111','nguyenvandat1@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111112','nguyenvanduc1@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111113','nguyenvanhoa1@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111114','nguyenvanhung@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111115','nguyenvanhuwng@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111116','nguyenvanhuóngs@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111117','nguyenvanhuongf@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111118','nguyenvandang@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111119','nguyenvanduong@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111120','nguyentrongdat@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111121','phanvankhanh@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111122','phungduykha@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111123','phambalinh@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111124','ongvanduc@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111125','nguyentrunghoa@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111126','phungquanthanh@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111127','phaminhdang@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111128','phamhoa@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111129','phunghuy@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111130','nguyenminhtruong@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111131','nguyenvankha@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111132','nguyenthiminhthu@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111133','nguyendangphong@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111134','nguyenthithuong@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111135','nguyenvanduong@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111133','nguyendangphong1@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111134','nguyenthithuong1@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('1111135','nguyenvanduong1@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])
values	('3000001',	'truongngochan@gmail.com'),			('3000002',	'tathanhnhan@@gmail.com'),				('3000003',	'tangthanhha@gmail.com'),
		('3000004',	'vanmaihuongn@gmail.com'),			('3000005',	'vuongtantain@gmail.com'),				('3000006',	'tranthithanhthuyn@gmail.com'),
		('3000007',	'trinhthimaianhn@gmail.com'),		('3000008',	'trantuanhau@gmail.com'),				('3000009',	'trangthihongn@gmail.com'),
		('3000010',	'truonggiayenn@gmail.com'),			('3000010',	'truonggiayen1n@gmail.com'),
		('3100001',	'truongquynhnhun@gmail.com'),		('3100002',	'tranngocnhuquynhn@gmail.com'),			('3100003',	'trinhkimchin@gmail.com'),
		('3200001',	'trinhvantoann@gmail.com'),			('3200002',	'trangthingocquen@gmail.com'),			('3200003',	'tathihongngan@gmail.com'),
		('3300001',	'truonglucluongn@gmail.com'),		('3300002',	'tranhanhhungn@gmail.com'),				('3300003',	'tavanmanhn@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2000001','dinhquoccuong@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2000002','dinhxuanhinh@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2000003','chauvansa@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2000004','haduytap@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2000005','hokimbao@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2000006','hoangthanhthanh@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2000007','lamcaocuomg@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2000008','caoduongduong@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2000009','hoangvancong@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2000010','dinhvanlam@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2200001','dinhvancuong@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2200002','doanchibinh@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2200003','duongqua@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2300001','chuvanan@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2300002','laivansam@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2300003','laithephuc@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2100001','doanvanhau@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2100002','chautinhtri@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2100003','dothephat@gmail.com')
INSERT INTO [dbo].[Email_Nguoi_dung]([Ten_dang_nhap],[Email])VALUES('2100003','dothephat123@gmail.com')
go

--select * from Email_Nguoi_dung
--go

-----Table--SDT_Nguoi_dung------
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111111','0111111111')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111112','0111111112')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111113','0111111113')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111114','0111111114')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111115','0111111115')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111116','0111111116')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111117','0111111117')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111118','0111111118')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111119','0111111119')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111120','0111111120')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111121','0111111121')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111122','0111111122')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111123','0111111123')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111124','0111111124')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111125','0111111125')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111126','0111111126')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111127','0111111127')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111128','0111111128')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111129','0111111129')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111130','0111111130')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111131','0111111131')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111132','0111111132')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111133','0111111133')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111134','0111111134')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111135','0111111135')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111134','0111111136')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111135','0111111137')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111133','0111111138')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111134','0111111139')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111132','0111111140')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111131','0111111141')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('1111130','0111111142')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])
values	
		('3000001',	'0218764812'),			('3000002',	'0903020406'),				('3000003',	'0823621640'),
		('3000004',	'0128746262'),			('3000005',	'0823462135'),				('3000006',	'0812357321'),
		('3000007',	'0283612846'),			('3000008',	'0318327652'),				('3000009',	'0912374521'),
		('3000010',	'0928374668'),			('3000010',	'0813256434'),
		('3100001',	'0821836245'),			('3100002',	'0235134633'),				('3100003',	'0912387461'),
		('3200001',	'0912874686'),			('3200002',	'0821354564'),				('3200003',	'0418273641'),
		('3300001',	'0912987648'),			('3300002',	'0812354632'),				('3300003',	'0318273612')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2000001','0969888442')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2000002','0969222441')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2000003','0912456842')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2000004','0969643642')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2000005','0974534142')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2000006','0969338432')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2000007','0969678442')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2000008','0969146348')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2000009','0969432244')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2000010','0963448442')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2100001','0358846789')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2100002','0962341232')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2100003','0947245825')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2200001','0397257574')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2200002','0394651203')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2200003','0395377245')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2200003','0392315203')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2300001','0394367599')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2300002','0309105987')
INSERT INTO [dbo].[SDT_Nguoi_dung]([Ten_dang_nhap],[SDT])VALUES('2300003','0328435794')

go

--select * from SDT_Nguoi_dung
--go
----Table--Thu_ngan------
INSERT INTO [dbo].[Thu_ngan]([Ten_dang_nhap],[MSNV])VALUES('1111119','THU006')
INSERT INTO [dbo].[Thu_ngan]([Ten_dang_nhap],[MSNV])VALUES('1111132','THU007')
INSERT INTO [dbo].[Thu_ngan]([Ten_dang_nhap],[MSNV])VALUES('1111133','THU008')
INSERT INTO [dbo].[Thu_ngan]([Ten_dang_nhap],[MSNV])VALUES('1111134','THU009')
INSERT INTO [dbo].[Thu_ngan]([Ten_dang_nhap],[MSNV])VALUES('1111135','THU010')
INSERT INTO [dbo].[Thu_ngan]([Ten_dang_nhap],[MSNV])VALUES('2200001','THU011')
INSERT INTO [dbo].[Thu_ngan]([Ten_dang_nhap],[MSNV])VALUES('2200002','THU012')
INSERT INTO [dbo].[Thu_ngan]([Ten_dang_nhap],[MSNV])VALUES('2200003','THU013')
INSERT INTO [dbo].[Thu_ngan]([Ten_dang_nhap],[MSNV])VALUES('2200004','THU014')
INSERT INTO [dbo].[Thu_ngan]([Ten_dang_nhap],[MSNV])VALUES('2200005','THU015')
INSERT INTO [dbo].[Thu_ngan]([Ten_dang_nhap],[MSNV])
values	('3200001',	'THU001'), 
		('3200002',	'THU002'), 
		('3200003',	'THU003'), 
		('3200004',	'THU004'), 
		('3200005',	'THU005')
go

--select * from Thu_ngan
--go
----Table--Truong_nha----
INSERT INTO [dbo].[Truong_nha]([Ten_dang_nhap],[MSNV])VALUES('1111118','TRN006')
INSERT INTO [dbo].[Truong_nha]([Ten_dang_nhap],[MSNV])VALUES('1111124','TRN007')
INSERT INTO [dbo].[Truong_nha]([Ten_dang_nhap],[MSNV])VALUES('1111125','TRN008')
INSERT INTO [dbo].[Truong_nha]([Ten_dang_nhap],[MSNV])VALUES('1111126','TRN009')
INSERT INTO [dbo].[Truong_nha]([Ten_dang_nhap],[MSNV])VALUES('1111127','TRN010')
INSERT INTO [dbo].[Truong_nha]([Ten_dang_nhap],[MSNV])VALUES('2100001','TRN011')
INSERT INTO [dbo].[Truong_nha]([Ten_dang_nhap],[MSNV])VALUES('2100002','TRN012')
INSERT INTO [dbo].[Truong_nha]([Ten_dang_nhap],[MSNV])VALUES('2100003','TRN013')
INSERT INTO [dbo].[Truong_nha]([Ten_dang_nhap],[MSNV])VALUES('2100004','TRN014')
INSERT INTO [dbo].[Truong_nha]([Ten_dang_nhap],[MSNV])VALUES('2100005','TRN015')
INSERT INTO [dbo].[Truong_nha]([Ten_dang_nhap],[MSNV])
values	('3100001',	'TRN001'),
		('3100002',	'TRN002'),
		('3100003',	'TRN003'),
		('3100004',	'TRN004'),
		('3100005',	'TRN005')
go
--select * from Truong_nha
--go

----Table--Bao_ve----
INSERT INTO [dbo].[Bao_ve]([Ten_dang_nhap],[MSNV])VALUES('1111117','BVE006')
INSERT INTO [dbo].[Bao_ve]([Ten_dang_nhap],[MSNV])VALUES('1111128','BVE007')
INSERT INTO [dbo].[Bao_ve]([Ten_dang_nhap],[MSNV])VALUES('1111129','BVE008')
INSERT INTO [dbo].[Bao_ve]([Ten_dang_nhap],[MSNV])VALUES('1111130','BVE009')
INSERT INTO [dbo].[Bao_ve]([Ten_dang_nhap],[MSNV])VALUES('1111131','BVE010')
INSERT INTO [dbo].[Bao_ve]([Ten_dang_nhap],[MSNV])VALUES('2300001','BVE011')
INSERT INTO [dbo].[Bao_ve]([Ten_dang_nhap],[MSNV])VALUES('2300002','BVE012')
INSERT INTO [dbo].[Bao_ve]([Ten_dang_nhap],[MSNV])VALUES('2300003','BVE013')
INSERT INTO [dbo].[Bao_ve]([Ten_dang_nhap],[MSNV])VALUES('2300004','BVE014')
INSERT INTO [dbo].[Bao_ve]([Ten_dang_nhap],[MSNV])VALUES('2300005','BVE015')
INSERT INTO [dbo].[Bao_ve]([Ten_dang_nhap],[MSNV])
values	('3300001',	'BVE001'),
		('3300002',	'BVE002'),
		('3300003',	'BVE003'),
		('3300004',	'BVE004'),
		('3300005',	'BVE005')
go

--select * from Bao_ve
--go
----Table-Bao_ve_truc---
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc])-- VALUES('1111117','BVE001','2018-03-01','T')
values	('1111117', 'BVE006', '2019-05-20','S'),	('1111117', 'BVE006', '2019-05-20','T'),
		('1111117', 'BVE006', '2019-05-21','S'),	('1111117', 'BVE006', '2019-05-21','T'),
		('1111117', 'BVE006', '2019-05-22','S'),	('1111117', 'BVE006', '2019-05-22','T'),
		('1111117', 'BVE006', '2019-05-23','S'),	('1111117', 'BVE006', '2019-05-23','T'),
		('1111117', 'BVE006', '2019-05-24','S'),	('1111117', 'BVE006', '2019-05-24','T'),

		('1111128', 'BVE007', '2019-05-20','S'),	('1111128', 'BVE007', '2019-05-20','T'),
		('1111128', 'BVE007', '2019-05-21','S'),	('1111128', 'BVE007', '2019-05-21','T'),
		('1111128', 'BVE007', '2019-05-22','S'),	('1111128', 'BVE007', '2019-05-22','T'),
		('1111128', 'BVE007', '2019-05-23','S'),	('1111128', 'BVE007', '2019-05-23','T'),
		('1111128', 'BVE007', '2019-05-24','S'),	('1111128', 'BVE007', '2019-05-24','T'),

		('1111129', 'BVE008', '2019-05-20','S'),	('1111129', 'BVE008', '2019-05-20','T'),
		('1111129', 'BVE008', '2019-05-21','S'),	('1111129', 'BVE008', '2019-05-21','T'),
		('1111129', 'BVE008', '2019-05-22','S'),	('1111129', 'BVE008', '2019-05-22','T'),
		('1111129', 'BVE008', '2019-05-23','S'),	('1111129', 'BVE008', '2019-05-23','T'),
		('1111129', 'BVE008', '2019-05-24','S'),	('1111129', 'BVE008', '2019-05-24','T'),

		('1111130', 'BVE009', '2019-05-20','S'),	('1111130', 'BVE009', '2019-05-20','T'),
		('1111130', 'BVE009', '2019-05-21','S'),	('1111130', 'BVE009', '2019-05-21','T'),
		('1111130', 'BVE009', '2019-05-22','S'),	('1111130', 'BVE009', '2019-05-22','T'),
		('1111130', 'BVE009', '2019-05-23','S'),	('1111130', 'BVE009', '2019-05-23','T'),
		('1111130', 'BVE009', '2019-05-24','S'),	('1111130', 'BVE009', '2019-05-24','T'),

		('1111131', 'BVE010', '2019-05-20','S'),	('1111131', 'BVE010', '2019-05-20','T'),
		('1111131', 'BVE010', '2019-05-21','S'),	('1111131', 'BVE010', '2019-05-21','T'),
		('1111131', 'BVE010', '2019-05-22','S'),	('1111131', 'BVE010', '2019-05-22','T'),
		('1111131', 'BVE010', '2019-05-23','S'),	('1111131', 'BVE010', '2019-05-23','T'),
		('1111131', 'BVE010', '2019-05-24','S'),	('1111131', 'BVE010', '2019-05-24','T'),

		('3300001', 'BVE001', '2019-05-20','S'),	('3300005', 'BVE005', '2019-05-20','T'),
		('3300001', 'BVE001', '2019-05-21','S'),	('3300005', 'BVE005', '2019-05-21','T'),
		('3300001', 'BVE001', '2019-05-22','S'),	('3300005', 'BVE005', '2019-05-22','T'),
		('3300001', 'BVE001', '2019-05-23','S'),	('3300005', 'BVE005', '2019-05-23','T'),
		('3300001', 'BVE001', '2019-05-24','S'),	('3300005', 'BVE005', '2019-05-24','T'),

		('3300002', 'BVE002', '2019-05-20','S'),	('3300001', 'BVE001', '2019-05-20','T'),
		('3300002', 'BVE002', '2019-05-21','S'),	('3300001', 'BVE001', '2019-05-21','T'),
		('3300002', 'BVE002', '2019-05-22','S'),	('3300001', 'BVE001', '2019-05-22','T'),
		('3300002', 'BVE002', '2019-05-23','S'),	('3300001', 'BVE001', '2019-05-23','T'),
		('3300002', 'BVE002', '2019-05-24','S'),	('3300001', 'BVE001', '2019-05-24','T'),

		('3300003', 'BVE003', '2019-05-20','S'),	('3300002', 'BVE002', '2019-05-20','T'),
		('3300003', 'BVE003', '2019-05-21','S'),	('3300002', 'BVE002', '2019-05-21','T'),
		('3300003', 'BVE003', '2019-05-22','S'),	('3300002', 'BVE002', '2019-05-22','T'),
		('3300003', 'BVE003', '2019-05-23','S'),	('3300002', 'BVE002', '2019-05-23','T'),
		('3300003', 'BVE003', '2019-05-24','S'),	('3300002', 'BVE002', '2019-05-24','T'),

		('3300004', 'BVE004', '2019-05-20','S'),	('3300003', 'BVE003', '2019-05-20','T'),
		('3300004', 'BVE004', '2019-05-21','S'),	('3300003', 'BVE003', '2019-05-21','T'),
		('3300004', 'BVE004', '2019-05-22','S'),	('3300003', 'BVE003', '2019-05-22','T'),
		('3300004', 'BVE004', '2019-05-23','S'),	('3300003', 'BVE003', '2019-05-23','T'),
		('3300004', 'BVE004', '2019-05-24','S'),	('3300003', 'BVE003', '2019-05-24','T'),

		('3300005', 'BVE005', '2019-05-20','S'),	('3300004', 'BVE004', '2019-05-20','T'),
		('3300005', 'BVE005', '2019-05-21','S'),	('3300004', 'BVE004', '2019-05-21','T'),
		('3300005', 'BVE005', '2019-05-22','S'),	('3300004', 'BVE004', '2019-05-22','T'),
		('3300005', 'BVE005', '2019-05-23','S'),	('3300004', 'BVE004', '2019-05-23','T'),
		('3300005', 'BVE005', '2019-05-24','S'),	('3300004', 'BVE004', '2019-05-24','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300001','BVE011','2019-05-20','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300001','BVE011','2019-05-21','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300001','BVE011','2019-05-22','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300001','BVE011','2019-05-23','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300001','BVE011','2019-05-24','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300001','BVE011','2019-05-20','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300001','BVE011','2019-05-21','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300001','BVE011','2019-05-22','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300001','BVE011','2019-05-23','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300001','BVE011','2019-05-24','S')
--------
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300002','BVE012','2019-05-20','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300002','BVE012','2019-05-21','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300002','BVE012','2019-05-22','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300002','BVE012','2019-05-23','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300002','BVE012','2019-05-24','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300002','BVE012','2019-05-20','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300002','BVE012','2019-05-21','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300002','BVE012','2019-05-22','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300002','BVE012','2019-05-23','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300002','BVE012','2019-05-24','S')
-------
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300003','BVE013','2019-05-20','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300003','BVE013','2019-05-21','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300003','BVE013','2019-05-22','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300003','BVE013','2019-05-23','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300003','BVE013','2019-05-24','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300003','BVE013','2019-05-20','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300003','BVE013','2019-05-21','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300003','BVE013','2019-05-22','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300003','BVE013','2019-05-23','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300003','BVE013','2019-05-24','S')
-------
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300004','BVE014','2019-05-20','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300004','BVE014','2019-05-21','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300004','BVE014','2019-05-22','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300004','BVE014','2019-05-23','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300004','BVE014','2019-05-24','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300004','BVE014','2019-05-20','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300004','BVE014','2019-05-21','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300004','BVE014','2019-05-22','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300004','BVE014','2019-05-23','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300004','BVE014','2019-05-24','S')

------
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300005','BVE015','2019-05-20','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300005','BVE015','2019-05-21','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300005','BVE015','2019-05-22','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300005','BVE015','2019-05-23','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300005','BVE015','2019-05-24','T')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300005','BVE015','2019-05-20','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300005','BVE015','2019-05-21','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300005','BVE015','2019-05-22','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300005','BVE015','2019-05-23','S')
INSERT INTO [dbo].[Bao_ve_truc]([Ten_dang_nhap],[MSNV],[Ngay_truc],[Ca_truc]) VALUES('2300005','BVE015','2019-05-24','S')

go

--select * from Bao_ve_truc
--go
----Table-Sinh_vien----
INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Nam_thu])VALUES('1111111','171001',2)
INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Nam_thu])VALUES('1111112','171002',2)
INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Nam_thu])VALUES('1111113','171003',2)
INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Nam_thu])VALUES('1111114','171004',2)
INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Nam_thu])VALUES('1111115','171005',2)
INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Nam_thu])VALUES('1111116','171006',2)
INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Nam_thu])VALUES('2000001','151001',4)
INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Nam_thu])VALUES('2000002','161002',3)
INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Nam_thu])VALUES('2000003','171003',2)
INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Nam_thu])VALUES('2000004','161004',3)
INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Nam_thu])VALUES('2000005','151005',4)
INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Nam_thu])VALUES('2000006','151006',4)
INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Nam_thu])VALUES('2000007','151007',4)
INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Nam_thu])VALUES('2000008','151008',4)
INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Nam_thu])VALUES('2000009','151008',4)
INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Nam_thu])VALUES('2000010','171010',2)
INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Truong],[Nam_thu])
values	('1111120',	1710001,	'KHXHNV',		2),
		('1111121',	1610001,	'KHXHNV',		3),
		('1111122',	1510001,	'KHTN',			1),
		('1111123',	1710002,	'KHTN',			4),
		('3000001',	1710001,	'BK TPHCM',		2),
		('3000002',	1610001,	'KHXHNV',		3),
		('3000003',	1810001,	'KHTN',			1),
		('3000004',	1510001,	'BK TPHCM',		4),
		('3000005', 1610002,	'SPKT',			3),
		('3000006',	1810002,	'BK TPHCM',		1),
		('3000007',	1810003,	'KHXHNV',		1),
		('3000008',	1610003,	'BK TPHCM',		3),
		('3000009',	1510002,	'KHTN',			4),
		('3000010',	1710002,	'BK TPHCM',		2)
go
--select * from Sinh_vien
--go

--Table Toa_nha
INSERT INTO [dbo].[Toa_nha]([Ten_toa_nha],[Ngay_thi_cong],[Ngay_hoan_thanh],[So_phong])VALUES('A1','2012-01-01','2014-01-01',8)
INSERT INTO [dbo].[Toa_nha]([Ten_toa_nha],[Ngay_thi_cong],[Ngay_hoan_thanh],[So_phong])VALUES('A2','2012-01-01','2014-01-01',8)
INSERT INTO [dbo].[Toa_nha]([Ten_toa_nha],[Ngay_thi_cong],[Ngay_hoan_thanh],[So_phong])VALUES('A3','2012-01-01','2014-01-01',8)
INSERT INTO [dbo].[Toa_nha]([Ten_toa_nha],[Ngay_thi_cong],[Ngay_hoan_thanh],[So_phong])VALUES('A4','2012-01-01','2014-01-01',8)
INSERT INTO [dbo].[Toa_nha]([Ten_toa_nha],[Ngay_thi_cong],[Ngay_hoan_thanh],[So_phong])VALUES('A5','2012-01-01','2014-01-01',8)
INSERT INTO [dbo].[Toa_nha]([Ten_toa_nha],[Ngay_thi_cong],[Ngay_hoan_thanh],[So_phong])VALUES('B1','2012-01-01','2014-01-01',8)
INSERT INTO [dbo].[Toa_nha]([Ten_toa_nha],[Ngay_thi_cong],[Ngay_hoan_thanh],[So_phong])VALUES('B2','2012-01-01','2014-01-01',8)
INSERT INTO [dbo].[Toa_nha]([Ten_toa_nha],[Ngay_thi_cong],[Ngay_hoan_thanh],[So_phong])VALUES('B3','2012-01-01','2014-01-01',8)
INSERT INTO [dbo].[Toa_nha]([Ten_toa_nha],[Ngay_thi_cong],[Ngay_hoan_thanh],[So_phong])VALUES('B4','2012-01-01','2014-01-01',8)
INSERT INTO [dbo].[Toa_nha]([Ten_toa_nha],[Ngay_thi_cong],[Ngay_hoan_thanh],[So_phong])VALUES('B5','2012-01-01','2014-01-01',8)
INSERT INTO [dbo].[Toa_nha]([Ten_toa_nha],[Ngay_thi_cong],[Ngay_hoan_thanh],[So_phong]) 
VALUES	('C1','2012-01-01','2014-01-01',8),	
		('C2','2012-01-01','2014-01-01',8),
		('C3','2012-01-01','2014-01-01',8),
		('C4','2012-01-01','2014-01-01',8),
		('C5','2012-01-01','2014-01-01',8)
go
--select * from Toa_nha
--go

-----Table--Phong-----
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[Loai_phong],[So_SV_dang_co], [So_SV_toi_da],[Tinh_trang])
values	(201, 'A1', N'Phòng 2', 2, 2, N'Đầy'),
		(202, 'A1', N'Phòng 2', 0, 2, N'Trống'),
		(203, 'A1', N'Phòng 4', 1, 4, N'Có người'),
		(204, 'A1', N'Phòng 4', 0, 4, N'Trống'),
		(205, 'A1', N'Phòng 6', 1, 6, N'Có người'),
		(206, 'A1', N'Phòng 6', 3, 6, N'Có người'),
		(207, 'A1', N'Phòng 8', 0, 8, N'Trống'),
		(208, 'A1', N'Phòng 8', 3, 8, N'Có người'),

		(201, 'A2', N'Phòng 2', 0, 2, N'Trống'),
		(202, 'A2', N'Phòng 2', 0, 2, N'Trống'),
		(203, 'A2', N'Phòng 4', 0, 4, N'Trống'),
		(204, 'A2', N'Phòng 4', 0, 4, N'Trống'),
		(205, 'A2', N'Phòng 6', 0, 6, N'Trống'),
		(206, 'A2', N'Phòng 6', 0, 6, N'Trống'),
		(207, 'A2', N'Phòng 8', 0, 8, N'Trống'),
		(208, 'A2', N'Phòng 8', 0, 8, N'Trống'),

		(201, 'A3', N'Phòng 2', 0, 2, N'Trống'),
		(202, 'A3', N'Phòng 2', 0, 2, N'Trống'),
		(203, 'A3', N'Phòng 4', 0, 4, N'Trống'),
		(204, 'A3', N'Phòng 4', 0, 4, N'Trống'),
		(205, 'A3', N'Phòng 6', 0, 6, N'Trống'),
		(206, 'A3', N'Phòng 6', 0, 6, N'Trống'),
		(207, 'A3', N'Phòng 8', 0, 8, N'Trống'),
		(208, 'A3', N'Phòng 8', 0, 8, N'Trống'),

		(201, 'A4', N'Phòng 2', 0, 2, N'Trống'),
		(202, 'A4', N'Phòng 2', 0, 2, N'Trống'),
		(203, 'A4', N'Phòng 4', 0, 4, N'Trống'),
		(204, 'A4', N'Phòng 4', 0, 4, N'Trống'),
		(205, 'A4', N'Phòng 6', 0, 6, N'Trống'),
		(206, 'A4', N'Phòng 6', 0, 6, N'Trống'),
		(207, 'A4', N'Phòng 8', 0, 8, N'Trống'),
		(208, 'A4', N'Phòng 8', 0, 8, N'Trống'),

		(201, 'A5', N'Phòng 2', 0, 2, N'Trống'),
		(202, 'A5', N'Phòng 2', 0, 2, N'Trống'),
		(203, 'A5', N'Phòng 4', 0, 4, N'Trống'),
		(204, 'A5', N'Phòng 4', 0, 4, N'Trống'),
		(205, 'A5', N'Phòng 6', 0, 6, N'Trống'),
		(206, 'A5', N'Phòng 6', 0, 6, N'Trống'),
		(207, 'A5', N'Phòng 8', 0, 8, N'Trống'),
		(208, 'A5', N'Phòng 8', 0, 8, N'Trống'),
		(201, 'C1', N'Phòng 2', 2, 2, N'Đầy'),
		(202, 'C1', N'Phòng 2', 0, 2, N'Trống'),
		(203, 'C1', N'Phòng 2', 1, 2, N'Có người'),
		(204, 'C1', N'Phòng 2', 0, 2, N'Trống'),
		(205, 'C1', N'Phòng 4', 0, 4, N'Trống'),
		(206, 'C1', N'Phòng 4', 0, 4, N'Trống'),
		(207, 'C1', N'Phòng 4', 0, 4, N'Trống'),
		(208, 'C1', N'Phòng 4', 0, 4, N'Trống'),

		(201, 'C2', N'Phòng 2', 0, 2, N'Trống'),
		(202, 'C2', N'Phòng 2', 1, 2, N'Có người'),
		(203, 'C2', N'Phòng 2', 0, 2, N'Trống'),
		(204, 'C2', N'Phòng 2', 0, 2, N'Trống'),
		(205, 'C2', N'Phòng 4', 2, 4, N'Có người'),
		(206, 'C2', N'Phòng 4', 0, 4, N'Trống'),
		(207, 'C2', N'Phòng 4', 4, 4, N'Đầy'),
		(208, 'C2', N'Phòng 4', 0, 4, N'Trống'),

		(201, 'C3', N'Phòng 2', 0, 2, N'Trống'),
		(202, 'C3', N'Phòng 2', 0, 2, N'Trống'),
		(203, 'C3', N'Phòng 2', 0, 2, N'Trống'),
		(204, 'C3', N'Phòng 2', 0, 2, N'Trống'),
		(205, 'C3', N'Phòng 4', 0, 4, N'Trống'),
		(206, 'C3', N'Phòng 4', 0, 4, N'Trống'),
		(207, 'C3', N'Phòng 4', 0, 4, N'Trống'),
		(208, 'C3', N'Phòng 4', 0, 4, N'Trống'),

		(201, 'C4', N'Phòng 2', 0, 2, N'Trống'),
		(202, 'C4', N'Phòng 2', 0, 2, N'Trống'),
		(203, 'C4', N'Phòng 2', 0, 2, N'Trống'),
		(204, 'C4', N'Phòng 2', 0, 2, N'Trống'),
		(205, 'C4', N'Phòng 4', 0, 4, N'Trống'),
		(206, 'C4', N'Phòng 4', 0, 4, N'Trống'),
		(207, 'C4', N'Phòng 4', 0, 4, N'Trống'),
		(208, 'C4', N'Phòng 4', 0, 4, N'Trống'),

		(201, 'C5', N'Phòng 2', 0, 2, N'Trống'),
		(202, 'C5', N'Phòng 2', 0, 2, N'Trống'),
		(203, 'C5', N'Phòng 2', 0, 2, N'Trống'),
		(204, 'C5', N'Phòng 2', 0, 2, N'Trống'),
		(205, 'C5', N'Phòng 4', 0, 4, N'Trống'),
		(206, 'C5', N'Phòng 4', 0, 4, N'Trống'),
		(207, 'C5', N'Phòng 4', 0, 4, N'Trống'),
		(208, 'C5', N'Phòng 4', 0, 4, N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(201,'B1',4,N'Phòng 4',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(202,'B1',4,N'Phòng 4',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(203,'B1',2,N'Phòng 2',	N'Có người')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(204,'B1',4,N'Phòng 4',	N'Có người')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(205,'B1',4,N'Phòng 4',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(206,'B1',4,N'Phòng 4',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(207,'B1',4,N'Phòng 4',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(208,'B1',4,N'Phòng 4',	N'Trống')

INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(201,'B2',2,N'Phòng 2',	N'Đầy')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(202,'B2',4,N'Phòng 4',	N'Đầy')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(203,'B2',4,N'Phòng 4',	N'Có người')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(204,'B2',4,N'Phòng 4',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(205,'B2',2,N'Phòng 2',	N'Có người')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(206,'B2',4,N'Phòng 4',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(207,'B2',4,N'Phòng 4',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(208,'B2',4,N'Phòng 4',	N'Trống')

INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(201,'B3',2,N'Phòng 2',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(202,'B3',2,N'Phòng 2',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(203,'B3',2,N'Phòng 2',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(204,'B3',2,N'Phòng 2',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(205,'B3',4,N'Phòng 4',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(206,'B3',4,N'Phòng 4',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(207,'B3',4,N'Phòng 4',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(208,'B3',4,N'Phòng 4',	N'Trống')

INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(201,'B4',2,N'Phòng 2',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(202,'B4',2,N'Phòng 2',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(203,'B4',2,N'Phòng 2',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(204,'B4',2,N'Phòng 2',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(205,'B4',4,N'Phòng 4',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(206,'B4',4,N'Phòng 4',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(207,'B4',4,N'Phòng 4',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(208,'B4',4,N'Phòng 4',	N'Trống')

INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(201,'B5',2,N'Phòng 2',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(202,'B5',2,N'Phòng 2',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(203,'B5',2,N'Phòng 2',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(204,'B5',2,N'Phòng 2',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(205,'B5',4,N'Phòng 4',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(206,'B5',4,N'Phòng 4',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(207,'B5',4,N'Phòng 4',	N'Trống')
INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[So_SV_toi_da],[Loai_phong],[Tinh_trang])VALUES(208,'B5',4,N'Phòng 4',	N'Trống')

go

--select * from Phong
--go

----Table--SV_o_phong-----------
INSERT INTO [dbo].[SV_o_phong]([Ten_dang_nhap_SV],[Ten_phong],[Ten_toa_nha])
values	('1111111', 201,'A1'),
		('1111112', 201,'A1'),
		('1111113', 203,'A1'),
		('1111114', 205,'A1'),
		('1111115', 206,'A1'),
		('1111116', 206,'A1'),
		('1111120', 206,'A1'),
		('1111121', 208,'A1'),
		('1111122', 208,'A1'),
		('1111123', 208,'A1'),
		('3000001', 202,'C2'),
		('3000002', 201,'C1'),
		('3000003', 205,'C2'),
		('3000004', 205,'C2'),
		('3000005', 201,'C1'),
		('3000006', 207,'C2'),
		('3000007', 207,'C2'),
		('3000008', 203,'C1'),
		('3000009', 207,'C2'),
		('3000010', 207,'C2')
INSERT INTO [dbo].[SV_o_phong]([Ten_dang_nhap_SV],[Ten_phong],[Ten_toa_nha])VALUES('2000001',203,'B1')
INSERT INTO [dbo].[SV_o_phong]([Ten_dang_nhap_SV],[Ten_phong],[Ten_toa_nha])VALUES('2000002',204,'B1')
INSERT INTO [dbo].[SV_o_phong]([Ten_dang_nhap_SV],[Ten_phong],[Ten_toa_nha])VALUES('2000003',201,'B2')
INSERT INTO [dbo].[SV_o_phong]([Ten_dang_nhap_SV],[Ten_phong],[Ten_toa_nha])VALUES('2000004',201,'B2')
INSERT INTO [dbo].[SV_o_phong]([Ten_dang_nhap_SV],[Ten_phong],[Ten_toa_nha])VALUES('2000005',202,'B2')
INSERT INTO [dbo].[SV_o_phong]([Ten_dang_nhap_SV],[Ten_phong],[Ten_toa_nha])VALUES('2000006',202,'B2')
INSERT INTO [dbo].[SV_o_phong]([Ten_dang_nhap_SV],[Ten_phong],[Ten_toa_nha])VALUES('2000007',202,'B2')
INSERT INTO [dbo].[SV_o_phong]([Ten_dang_nhap_SV],[Ten_phong],[Ten_toa_nha])VALUES('2000008',202,'B2')
INSERT INTO [dbo].[SV_o_phong]([Ten_dang_nhap_SV],[Ten_phong],[Ten_toa_nha])VALUES('2000009',203,'B2')
INSERT INTO [dbo].[SV_o_phong]([Ten_dang_nhap_SV],[Ten_phong],[Ten_toa_nha])VALUES('2000010',205,'B2')


go
--select * from SV_o_phong
--go
----Table--Truong_phong----
INSERT INTO [dbo].[Truong_phong]([Ten_phong],[Ten_toa_nha],[Ten_dang_nhap_SV],[Ngay_bat_dau])
values	(201,'A1','1111111','2019-01-01'),
		(203,'A1','1111113','2019-01-01'),
		(205,'A1','1111114','2019-01-01'),
		(208,'A1','1111115','2019-01-01'),
		(208,'A1','1111121','2019-01-01'),
		(202,'C2','3000001','2019-01-01'),
		(205,'C2','3000003','2019-01-01'),
		(207,'C2','3000006','2019-01-01'),
		(201,'C1','3000002','2019-01-01'),
		(203,'C1','3000008','2019-01-01')
INSERT INTO [dbo].[Truong_phong]([Ten_toa_nha],[Ten_phong],[Ten_dang_nhap_SV],[Ngay_bat_dau])VALUES('B1',203,'2000001','2019-01-01')
INSERT INTO [dbo].[Truong_phong]([Ten_toa_nha],[Ten_phong],[Ten_dang_nhap_SV],[Ngay_bat_dau])VALUES('B1',204,'2000002','2019-01-01')
INSERT INTO [dbo].[Truong_phong]([Ten_toa_nha],[Ten_phong],[Ten_dang_nhap_SV],[Ngay_bat_dau])VALUES('B2',201,'2000003','2019-01-01')
INSERT INTO [dbo].[Truong_phong]([Ten_toa_nha],[Ten_phong],[Ten_dang_nhap_SV],[Ngay_bat_dau])VALUES('B2',202,'2000005','2019-01-01')
INSERT INTO [dbo].[Truong_phong]([Ten_toa_nha],[Ten_phong],[Ten_dang_nhap_SV],[Ngay_bat_dau])VALUES('B2',203,'2000009','2019-01-01')

go 

--select * from Truong_phong
--go


----Table--Thoi_gian_o_cua_SV------
INSERT INTO [dbo].[Thoi_gian_o_cua_SV]([Ten_dang_nhap_SV],[Ten_phong],[Ten_toa_nha],[Ngay_bat_dau])
values	('1111111', 201,'A1','2019-01-01'),
		('1111112', 201,'A1','2019-01-01'),
		('1111113', 203,'A1','2019-01-01'),
		('1111114', 205,'A1','2019-01-01'),
		('1111115', 206,'A1','2019-01-01'),
		('1111116', 206,'A1','2019-01-01'),
		('1111120', 206,'A1','2019-01-01'),
		('1111121', 208,'A1','2019-01-01'),
		('1111122', 208,'A1','2019-01-01'),
		('1111123', 208,'A1','2019-01-01'),
	    ('3000001', 202,'C2','2019-01-01'),
		('3000002', 201,'C1','2019-01-01'),
		('3000003', 205,'C2','2019-01-01'),
		('3000004', 205,'C2','2019-01-01'),
		('3000005', 201,'C1','2019-01-01'),
		('3000006', 207,'C2','2019-01-01'),
		('3000007', 207,'C2','2019-01-01'),
		('3000008', 203,'C1','2019-01-01'),
		('3000009', 207,'C2','2019-01-01'),
		('3000010', 207,'C2','2019-01-01')
INSERT INTO [dbo].[Thoi_gian_o_cua_SV]([Ten_dang_nhap_SV],[Ten_toa_nha],[Ten_phong],[Ngay_bat_dau])VALUES('2000001','B1',203,'2019-01-01')
INSERT INTO [dbo].[Thoi_gian_o_cua_SV]([Ten_dang_nhap_SV],[Ten_toa_nha],[Ten_phong],[Ngay_bat_dau])VALUES('2000002','B1',204,'2019-01-01')
INSERT INTO [dbo].[Thoi_gian_o_cua_SV]([Ten_dang_nhap_SV],[Ten_toa_nha],[Ten_phong],[Ngay_bat_dau])VALUES('2000003','B2',201,'2019-01-01')
INSERT INTO [dbo].[Thoi_gian_o_cua_SV]([Ten_dang_nhap_SV],[Ten_toa_nha],[Ten_phong],[Ngay_bat_dau])VALUES('2000004','B2',201,'2019-01-01')
INSERT INTO [dbo].[Thoi_gian_o_cua_SV]([Ten_dang_nhap_SV],[Ten_toa_nha],[Ten_phong],[Ngay_bat_dau])VALUES('2000005','B2',202,'2019-01-01')
INSERT INTO [dbo].[Thoi_gian_o_cua_SV]([Ten_dang_nhap_SV],[Ten_toa_nha],[Ten_phong],[Ngay_bat_dau])VALUES('2000006','B2',202,'2019-01-01')
INSERT INTO [dbo].[Thoi_gian_o_cua_SV]([Ten_dang_nhap_SV],[Ten_toa_nha],[Ten_phong],[Ngay_bat_dau])VALUES('2000007','B2',202,'2019-01-01')
INSERT INTO [dbo].[Thoi_gian_o_cua_SV]([Ten_dang_nhap_SV],[Ten_toa_nha],[Ten_phong],[Ngay_bat_dau])VALUES('2000008','B2',202,'2019-01-01')
INSERT INTO [dbo].[Thoi_gian_o_cua_SV]([Ten_dang_nhap_SV],[Ten_toa_nha],[Ten_phong],[Ngay_bat_dau])VALUES('2000009','B2',203,'2019-01-01')
INSERT INTO [dbo].[Thoi_gian_o_cua_SV]([Ten_dang_nhap_SV],[Ten_toa_nha],[Ten_phong],[Ngay_bat_dau])VALUES('2000010','B2',205,'2019-01-01')

go
 
 --select * from Thoi_gian_o_cua_SV
 --go
-----Table--Truong_nha_lam_viec_o_Toa_nha-----
INSERT INTO [dbo].[TN_lam_viec_o_toa_nha]([Ten_dang_nhap_TN],[MSNV],[Ten_toa_nha])
values	('1111118','TRN006','A1'),
		('1111124','TRN007','A2'),
		('1111125','TRN008','A3'),
		('1111126','TRN009','A4'),
		('1111127','TRN010','A5'),
		('3100001','TRN001','C1'),
		('3100002','TRN002','C2'),
		('3100003','TRN003','C3'),
		('3100004','TRN004','C4'),
		('3100005','TRN005','C5')
INSERT INTO [dbo].[TN_lam_viec_o_toa_nha]([Ten_dang_nhap_TN],[MSNV],[Ten_toa_nha])VALUES('2100001','TRN011','B1')
INSERT INTO [dbo].[TN_lam_viec_o_toa_nha]([Ten_dang_nhap_TN],[MSNV],[Ten_toa_nha])VALUES('2100002','TRN012','B2')
INSERT INTO [dbo].[TN_lam_viec_o_toa_nha]([Ten_dang_nhap_TN],[MSNV],[Ten_toa_nha])VALUES('2100003','TRN013','B3')
INSERT INTO [dbo].[TN_lam_viec_o_toa_nha]([Ten_dang_nhap_TN],[MSNV],[Ten_toa_nha])VALUES('2100004','TRN014','B4')
INSERT INTO [dbo].[TN_lam_viec_o_toa_nha]([Ten_dang_nhap_TN],[MSNV],[Ten_toa_nha])VALUES('2100005','TRN015','B5')

go

--select * from TN_lam_viec_o_toa_nha
--go
-----Table--Thoi_gian_lam_viec_cua_truong_nha-----
INSERT INTO [dbo].[Thoi_gian_lam_viec_cua_TN]([Ten_dang_nhap_TN],[MSNV],[Ten_toa_nha],[Ngay_bat_dau])--VALUES('1111118','TRN001','AH1','2018-01-01')
values	('1111118','TRN006','A1','2018-12-25'),
		('1111124','TRN007','A2','2018-12-25'),
		('1111125','TRN008','A3','2018-12-25'),
		('1111126','TRN009','A4','2018-12-25'),
		('1111127','TRN010','A5','2018-12-25'),
		('3100001','TRN001','C1','2018-12-25'),
		('3100002','TRN002','C2','2018-12-25'),
		('3100003','TRN003','C3','2018-12-25'),
		('3100004','TRN004','C4','2018-12-25'),
		('3100005','TRN005','C5','2018-12-25')
INSERT INTO [dbo].[Thoi_gian_lam_viec_cua_TN]([Ten_dang_nhap_TN],[MSNV],[Ten_toa_nha],[Ngay_bat_dau])VALUES('2100001','TRN011','B1','2018-12-25')
INSERT INTO [dbo].[Thoi_gian_lam_viec_cua_TN]([Ten_dang_nhap_TN],[MSNV],[Ten_toa_nha],[Ngay_bat_dau])VALUES('2100002','TRN012','B2','2018-12-25')
INSERT INTO [dbo].[Thoi_gian_lam_viec_cua_TN]([Ten_dang_nhap_TN],[MSNV],[Ten_toa_nha],[Ngay_bat_dau])VALUES('2100003','TRN013','B3','2018-12-25')
INSERT INTO [dbo].[Thoi_gian_lam_viec_cua_TN]([Ten_dang_nhap_TN],[MSNV],[Ten_toa_nha],[Ngay_bat_dau])VALUES('2100004','TRN014','B4','2018-12-25')
INSERT INTO [dbo].[Thoi_gian_lam_viec_cua_TN]([Ten_dang_nhap_TN],[MSNV],[Ten_toa_nha],[Ngay_bat_dau])VALUES('2100005','TRN015','B5','2018-12-25')

go

--select * from Thoi_gian_lam_viec_cua_TN
--go
-----Table--Bao_ve_lam_viec_o_Toa_nha
INSERT INTO [dbo].[BV_lam_viec_o_toa_nha]([Ten_dang_nhap_BV],[MSNV],[Ten_toa_nha])
values	('1111117','BVE006','A1'),	('1111117','BVE006','A3'),
		('1111128','BVE007','A2'),	('1111128','BVE007','A4'),
		('1111129','BVE008','A3'),	('1111129','BVE008','A5'),
		('1111130','BVE009','A4'),	('1111130','BVE009','A2'),
		('1111131','BVE010','A5'),	('1111131','BVE010','A1'),
		('3300001','BVE001','C1'),	('3300001','BVE001','C2'),
		('3300002','BVE002','C2'),	('3300002','BVE002','C3'),
		('3300003','BVE003','C3'),	('3300003','BVE003','C4'),
		('3300004','BVE004','C4'),	('3300004','BVE004','C5'),
		('3300005','BVE005','C5'),	('3300005','BVE005','C1')
INSERT INTO [dbo].[BV_lam_viec_o_toa_nha]([Ten_dang_nhap_BV],[MSNV],[Ten_toa_nha])VALUES('2300001','BVE011','B1')
INSERT INTO [dbo].[BV_lam_viec_o_toa_nha]([Ten_dang_nhap_BV],[MSNV],[Ten_toa_nha])VALUES('2300002','BVE012','B2')
INSERT INTO [dbo].[BV_lam_viec_o_toa_nha]([Ten_dang_nhap_BV],[MSNV],[Ten_toa_nha])VALUES('2300003','BVE013','B3')
INSERT INTO [dbo].[BV_lam_viec_o_toa_nha]([Ten_dang_nhap_BV],[MSNV],[Ten_toa_nha])VALUES('2300004','BVE014','B4')
INSERT INTO [dbo].[BV_lam_viec_o_toa_nha]([Ten_dang_nhap_BV],[MSNV],[Ten_toa_nha])VALUES('2300005','BVE015','B5')
go

--select * from BV_lam_viec_o_toa_nha
--go
-----Table--Thoi_gian_lam_viec_cua_bao_ve-----
INSERT INTO [dbo].[Thoi_gian_lam_viec_cua_BV]([Ten_dang_nhap_BV],[MSNV],[Ten_toa_nha],[Ngay_bat_dau])
values	('1111117','BVE006','A1','2018-12-25'),
		('1111128','BVE007','A2','2018-12-25'),
		('1111129','BVE008','A3','2018-12-25'),
		('1111130','BVE009','A4','2018-12-25'),
		('1111131','BVE010','A5','2018-12-25'),
		('3300001','BVE001','C1','2018-12-25'),
		('3300002','BVE002','C2','2018-12-25'),
		('3300003','BVE003','C3','2018-12-25'),
		('3300004','BVE004','C4','2018-12-25'),
		('3300005','BVE005','C5','2018-12-25')
INSERT INTO [dbo].[Thoi_gian_lam_viec_cua_BV]([Ten_dang_nhap_BV],[MSNV],[Ten_toa_nha],[Ngay_bat_dau])VALUES('2300001','BVE011','B1','2018-12-25')
INSERT INTO [dbo].[Thoi_gian_lam_viec_cua_BV]([Ten_dang_nhap_BV],[MSNV],[Ten_toa_nha],[Ngay_bat_dau])VALUES('2300002','BVE012','B2','2018-12-25')
INSERT INTO [dbo].[Thoi_gian_lam_viec_cua_BV]([Ten_dang_nhap_BV],[MSNV],[Ten_toa_nha],[Ngay_bat_dau])VALUES('2300003','BVE013','B3','2018-12-25')
INSERT INTO [dbo].[Thoi_gian_lam_viec_cua_BV]([Ten_dang_nhap_BV],[MSNV],[Ten_toa_nha],[Ngay_bat_dau])VALUES('2300004','BVE014','B4','2018-12-25')
INSERT INTO [dbo].[Thoi_gian_lam_viec_cua_BV]([Ten_dang_nhap_BV],[MSNV],[Ten_toa_nha],[Ngay_bat_dau])VALUES('2300005','BVE015','B5','2018-12-25')
go
--select * from Thoi_gian_lam_viec_cua_BV
--go

-----Table--Yeu_cau----viet
INSERT INTO [dbo].[Yeu_cau]([Ten_dang_nhap_SV],[Noi_dung_yeu_cau],[Tinh_trang],Ngay_gui,Ngay_giai_quyet,[Ten_dang_nhap_TN],[MSNV])
values	('1111111', N'Hư bóng đèn nhà tắm',			'O',	'2019-04-09','2019-04-20',	'1111118','TRN006'),
		('1111112', N'Hư khóa cửa',					'X',	'2019-03-08', NULL,			'1111118','TRN006'),
		('1111113', N'Hư lavabo',					'X',	'2019-02-01', NULL,			'1111118','TRN006'),
		('1111114', N'Hư máy quạt trần',			'O'	,	'2019-04-12', '2019-05-01',	'1111118','TRN006'),
		('1111115', N'Hư bóng đèn trần tủ quần áo', 'X',	'2019-04-08', NULL,			'1111118','TRN006'),
		('1111116', N'Vòi xịt bị hư',				'X',	'2019-04-04', NULL,			'1111118','TRN006'),
		('1111120', N'Hư ổ điện',					'O',	'2019-01-21','2019-03-20',	'1111118','TRN006'),
		('1111121', N'Hư bóng đèn nhà tắm',			'X',	'2019-01-13',NULL,			'1111118','TRN006'),
		('1111122', N'Hư bóng đèn nhà tắm',			'X',	'2019-02-02',NULL,			'1111118','TRN006'),
		('1111123', N'Hư bóng đèn nhà tắm',			'O',	'2019-04-06','2019-04-20',	'1111118','TRN006'),
		('3000001', N'Hư bóng đèn nhà tắm',			'O',	'2019-04-09','2019-04-20',	'3100002','TRN002'),
		('3000002', N'Hư khóa cửa',					'X',	'2019-03-08', NULL,			'3100001','TRN001'),

		('3000001', N'Hư lavabo',					'X',	'2019-02-01', NULL,			'3100002','TRN002'),
		('3000001', N'Hư máy quạt trần',			'O'	,	'2019-04-12', '2019-05-01',	'3100002','TRN002'),
		('3000005', N'Hư bóng đèn trần tủ quần áo', 'X',	'2019-04-08', NULL,			'3100001','TRN001'),
		('3000001', N'Vòi xịt bị hư',				'X',	'2019-04-04', NULL,			'3100002','TRN002'),
		('3000008', N'Hư ổ điện',					'O',	'2019-01-21','2019-03-20',	'3100001','TRN001'),
		('3000003', N'Hư bóng đèn nhà tắm',			'X',	'2019-01-13',NULL,			'3100002','TRN002'),
		('3000007', N'Hư bóng đèn nhà tắm',			'X',	'2019-02-02',NULL,			'3100002','TRN002'),
		('3000004', N'Hư bóng đèn nhà tắm',			'O',	'2019-04-06','2019-04-20',	'3100002','TRN002')
INSERT INTO [dbo].[Yeu_cau]([Ten_dang_nhap_SV],[Noi_dung_yeu_cau],[Tinh_trang],[Ngay_gui],[Ngay_giai_quyet],[Ten_dang_nhap_TN],[MSNV])VALUES('2000001',N'Bóng đèn 1,2m bị hỏng.','O','2018-05-01','2018-05-02','2100001','TRN011')
INSERT INTO [dbo].[Yeu_cau]([Ten_dang_nhap_SV],[Noi_dung_yeu_cau],[Tinh_trang],[Ngay_gui],[Ngay_giai_quyet],[Ten_dang_nhap_TN],[MSNV])VALUES('2000002',N'Cầu tiêu bị hư','O','2018-05-11','2018-05-12','2100001','TRN011')
INSERT INTO [dbo].[Yeu_cau]([Ten_dang_nhap_SV],[Noi_dung_yeu_cau],[Tinh_trang],[Ngay_gui],[Ngay_giai_quyet],[Ten_dang_nhap_TN],[MSNV])VALUES('2000003',N'Cửa sổ bị bung bản lề.','O','2018-05-01','2018-05-02','2100002','TRN012')
INSERT INTO [dbo].[Yeu_cau]([Ten_dang_nhap_SV],[Noi_dung_yeu_cau],[Tinh_trang],[Ngay_gui],[Ngay_giai_quyet],[Ten_dang_nhap_TN],[MSNV])VALUES('2000004',N'Bể cửa kính của cửa sổ','O','2018-05-01','2018-05-02','2100002','TRN012')
INSERT INTO [dbo].[Yeu_cau]([Ten_dang_nhap_SV],[Noi_dung_yeu_cau],[Tinh_trang],[Ngay_gui],[Ngay_giai_quyet],[Ten_dang_nhap_TN],[MSNV])VALUES('2000005',N'Chân giường bị gãy','O','2018-05-01','2018-05-02','2100002','TRN012')
INSERT INTO [dbo].[Yeu_cau]([Ten_dang_nhap_SV],[Noi_dung_yeu_cau],[Tinh_trang],[Ngay_gui],[Ngay_giai_quyet],[Ten_dang_nhap_TN],[MSNV])VALUES('2000006',N'Hỏng quạt trần','O','2018-05-01','2018-05-02','2100002','TRN012')
INSERT INTO [dbo].[Yeu_cau]([Ten_dang_nhap_SV],[Noi_dung_yeu_cau],[Tinh_trang],[Ngay_gui],[Ngay_giai_quyet],[Ten_dang_nhap_TN],[MSNV])VALUES('2000007',N'Hư cửa thông gió','O','2018-05-01','2018-05-02','2100002','TRN012')
INSERT INTO [dbo].[Yeu_cau]([Ten_dang_nhap_SV],[Noi_dung_yeu_cau],[Tinh_trang],[Ngay_gui],[Ngay_giai_quyet],[Ten_dang_nhap_TN],[MSNV])VALUES('2000008',N'Nghẹt cầu tiêu','O','2018-05-01','2018-05-02','2100002','TRN012')
INSERT INTO [dbo].[Yeu_cau]([Ten_dang_nhap_SV],[Noi_dung_yeu_cau],[Tinh_trang],[Ngay_gui],[Ngay_giai_quyet],[Ten_dang_nhap_TN],[MSNV])VALUES('2000009',N'Vòi hoa sen gãy làm đôi','O','2018-05-01','2018-05-02','2100002','TRN012')
INSERT INTO [dbo].[Yeu_cau]([Ten_dang_nhap_SV],[Noi_dung_yeu_cau],[Tinh_trang],[Ngay_gui],[Ngay_giai_quyet],[Ten_dang_nhap_TN],[MSNV])VALUES('2000010',N'Công tắc đèn phòng bị hư','O','2018-05-01','2018-05-02','2100002','TRN012')

go

--select * from Yeu_cau
--go
----Table--tin_nhan----
INSERT INTO [dbo].[Tin_nhan]([Ten_dang_nhap],[Noi_dung_tin_nhan],[Ngay_gui]) VALUES('1111111',N'Tối nay t k về','2019-03-05')
INSERT INTO [dbo].[Tin_nhan]([Ten_dang_nhap],[Noi_dung_tin_nhan],[Ngay_gui]) VALUES('1111112',N'Ok','2019-03-05')
INSERT INTO [dbo].[Tin_nhan]([Ten_dang_nhap],[Noi_dung_tin_nhan],[Ngay_gui]) VALUES('1111113',N'Mai sang gọi tui đi học chung với','2019-03-07')
INSERT INTO [dbo].[Tin_nhan]([Ten_dang_nhap],[Noi_dung_tin_nhan],[Ngay_gui]) VALUES('1111112',N'Sáng mai t nghỉ','2019-03-07')
INSERT INTO [dbo].[Tin_nhan]([Ten_dang_nhap],[Noi_dung_tin_nhan],[Ngay_gui]) VALUES('1111115',N'Tối mai t mới về KTX nha','2019-04-05')
INSERT INTO [dbo].[Tin_nhan]([Ten_dang_nhap],[Noi_dung_tin_nhan],[Ngay_gui]) VALUES('1111120',N'Không về càng tốt man','2019-04-05')
INSERT INTO [dbo].[Tin_nhan]([Ten_dang_nhap],[Noi_dung_tin_nhan],[Ngay_gui]) VALUES('1111118',N'Đề nghị trưởng phòng 201 xuống đóng tiền điện nước gấp','2019-04-13')
INSERT INTO [dbo].[Tin_nhan]([Ten_dang_nhap],[Noi_dung_tin_nhan],[Ngay_gui]) VALUES('1111118',N'Đề nghị các phòng dọn dẹp vệ sinh sạch sẽ, cuối tuần có đợt kiểm tra vệ sinh phòng','2019-04-27')

INSERT INTO [dbo].[Tin_nhan]([Ten_dang_nhap],[Noi_dung_tin_nhan],[Ngay_gui]) VALUES('3000001',N'Lên KTX chưa man','2019-03-05')
INSERT INTO [dbo].[Tin_nhan]([Ten_dang_nhap],[Noi_dung_tin_nhan],[Ngay_gui]) VALUES('3000002',N'Rồi m','2019-03-05')
INSERT INTO [dbo].[Tin_nhan]([Ten_dang_nhap],[Noi_dung_tin_nhan],[Ngay_gui]) VALUES('3000003',N'Mai t về quê nha','2019-03-07')
INSERT INTO [dbo].[Tin_nhan]([Ten_dang_nhap],[Noi_dung_tin_nhan],[Ngay_gui]) VALUES('3000004',N'Nhớ đem cái gì ăn đc lên nha m','2019-03-07')
INSERT INTO [dbo].[Tin_nhan]([Ten_dang_nhap],[Noi_dung_tin_nhan],[Ngay_gui]) VALUES('3000005',N'Nhớ đóng tiền ktx kìa','2019-04-05')
INSERT INTO [dbo].[Tin_nhan]([Ten_dang_nhap],[Noi_dung_tin_nhan],[Ngay_gui]) VALUES('3000006',N'ok man','2019-04-05')
INSERT INTO [dbo].[Tin_nhan]([Ten_dang_nhap],[Noi_dung_tin_nhan],[Ngay_gui]) VALUES('3000007',N'Về mua giúp t mấy cây viết','2019-04-13')
INSERT INTO [dbo].[Tin_nhan]([Ten_dang_nhap],[Noi_dung_tin_nhan],[Ngay_gui]) VALUES('3000008',N'K nhé, tự mua đi','2019-04-27')

--select Tin_nhan.Mess_ID, Noi_dung_tin_nhan, Ngay_gui, Tin_nhan.Ten_dang_nhap as Nguoigui,Nhan_tin_nhan.Ten_dang_nhap as Nguoinhan from Tin_nhan inner join Nhan_tin_nhan on Tin_nhan.Mess_ID = Nhan_tin_nhan.Mess_ID
go

--select * from Tin_nhan
--go
---Table--Nhan_tin_nhan------
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(1,'1111112')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(2,'1111111')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(3,'1111112')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(4,'1111113')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(5,'1111120')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(5,'1111116')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(6,'1111115')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(7,'1111111')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(7,'1111112')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(8,'1111111')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(8,'1111112')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(8,'1111113')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(8,'1111114')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(8,'1111115')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(8,'1111116')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(8,'1111120')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(8,'1111121')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(8,'1111122')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(8,'1111123')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(9,'3000002')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(10,'3000001')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(11,'3000004')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(12,'3000003')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(13,'3000006')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(14,'3000005')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(15,'3000008')
INSERT INTO [dbo].[Nhan_tin_nhan]([Mess_ID],[Ten_dang_nhap])VALUES(16,'3000007')
go

--select * from Nhan_tin_nhan
--go

-----Table--Hoa_don---
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang]) 
values	(1,'2019-01-01','2019','O'),(2,'2019-01-01','2019','O'),(3,'2019-01-01','2019','O'),(4,'2019-01-01','2019','O'),
		(5,'2019-01-01','2019','O'),
		(6,'2019-01-01','2019','O'),(7,'2019-01-01','2019','O'),(8,'2019-01-01','2019','O'),(9,'2019-01-01','2019','O'),
		(10,'2019-01-01','2019','O'),

		(11,'2019-01-01','2019','O'),(12,'2019-01-01','2019','O'),(13,'2019-01-01','2019','O'),(14,'2019-01-01','2019','O'),
		(15,'2019-01-01','2019','O'),
		(16,'2019-01-01','2019','O'),(17,'2019-01-01','2019','O'),(18,'2019-01-01','2019','O'),(19,'2019-01-01','2019','O'),
		(20,'2019-01-01','2019','O'),

		(21,'2019-02-01','2019','O'),(22,'2019-03-01','2019','O'),(23,'2019-04-01','2019','X'),(24,'2019-05-01','2019','X'),
		(25,'2019-02-01','2019','O'),(26,'2019-03-01','2019','O'),(27,'2019-04-01','2019','X'),(28,'2019-05-01','2019','X'),
		(29,'2019-02-01','2019','O'),(30,'2019-03-01','2019','O'),(31,'2019-04-01','2019','X'),(32,'2019-05-01','2019','X'),
		(33,'2019-02-01','2019','O'),(34,'2019-03-01','2019','O'),(35,'2019-04-01','2019','X'),(36,'2019-05-01','2019','X'),
		(55,'2019-01-01','2019','O'),(56,'2019-01-01','2019','O'),(57,'2019-01-01','2019','O'),(58,'2019-01-01','2019','O'),
		(59,'2019-01-01','2019','O'),
		(60,'2019-01-01','2019','O'),(61,'2019-01-01','2019','O'),(62,'2019-01-01','2019','O'),(63,'2019-01-01','2019','O'),
		(64,'2019-01-01','2019','O'),

		(65,'2019-01-01','2019','O'),(66,'2019-01-01','2019','O'),(67,'2019-01-01','2019','O'),(68,'2019-01-01','2019','O'),
		(69,'2019-01-01','2019','O'),
		(70,'2019-01-01','2019','O'),(71,'2019-01-01','2019','O'),(72,'2019-01-01','2019','O'),(73,'2019-01-01','2019','O'),
		(74,'2019-01-01','2019','O'),

		(75,'2019-02-01','2019','O'),(76,'2019-03-01','2019','O'),(77,'2019-04-01','2019','X'),(78,'2019-05-01','2019','X'),
		(79,'2019-02-01','2019','O'),(80,'2019-03-01','2019','O'),(81,'2019-04-01','2019','X'),(82,'2019-05-01','2019','X'),
		(83,'2019-02-01','2019','O'),(84,'2019-03-01','2019','O'),(85,'2019-04-01','2019','X'),(86,'2019-05-01','2019','X'),
		(87,'2019-02-01','2019','O'),(88,'2019-03-01','2019','O'),(89,'2019-04-01','2019','X'),(90,'2019-05-01','2019','X'),
		(91,'2019-02-01','2019','O'),(92,'2019-03-01','2019','O'),(93,'2019-04-01','2019','X'),(94,'2019-05-01','2019','X')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('151','2019-01-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('152','2019-01-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('153','2019-01-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('154','2019-01-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('155','2019-01-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('156','2019-01-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('157','2019-01-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('158','2019-01-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('159','2019-01-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('160','2019-01-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('161','2019-02-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('162','2019-02-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('163','2019-02-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('164','2019-02-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('165','2019-02-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('166','2019-02-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('167','2019-02-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('168','2019-02-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('169','2019-02-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('170','2019-02-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('171','2019-03-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('172','2019-03-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('173','2019-03-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('174','2019-03-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('175','2019-03-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('176','2019-03-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('177','2019-03-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('178','2019-03-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('179','2019-03-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('180','2019-03-01','2019','O')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('181','2019-04-01','2019','X')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('182','2019-04-01','2019','X')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('183','2019-04-01','2019','X')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('184','2019-04-01','2019','X')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('185','2019-04-01','2019','X')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('186','2019-04-01','2019','X')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('187','2019-04-01','2019','X')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('188','2019-04-01','2019','X')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('189','2019-04-01','2019','X')
INSERT INTO [dbo].[Hoa_don]([Bill_ID],[Ngay_lap_hoa_don],[Nam],[Tinh_trang])VALUES('190','2019-04-01','2019','X')
go
--select * from Hoa_don
--go
----Table-Tien_phong-----
INSERT INTO [dbo].[Tien_phong]([Bill_ID],[So_thang])
values	(1,5),(2,5),
		(3,5),(4,5),
		(5,5),(6,5),
		(7,5),(8,5),
		(9,5),(10,5),
		(65,5),(66,5),
		(67,5),(68,5),
		(69,5),(70,5),
		(71,5),(72,5),
		(73,5),(74,5)
INSERT INTO [dbo].[Tien_phong]([Bill_ID],[So_thang])VALUES(161,5)
INSERT INTO [dbo].[Tien_phong]([Bill_ID],[So_thang])VALUES(162,5)
INSERT INTO [dbo].[Tien_phong]([Bill_ID],[So_thang])VALUES(163,5)
INSERT INTO [dbo].[Tien_phong]([Bill_ID],[So_thang])VALUES(164,5)
INSERT INTO [dbo].[Tien_phong]([Bill_ID],[So_thang])VALUES(165,5)
INSERT INTO [dbo].[Tien_phong]([Bill_ID],[So_thang])VALUES(166,5)
INSERT INTO [dbo].[Tien_phong]([Bill_ID],[So_thang])VALUES(167,5)
INSERT INTO [dbo].[Tien_phong]([Bill_ID],[So_thang])VALUES(168,5)
INSERT INTO [dbo].[Tien_phong]([Bill_ID],[So_thang])VALUES(169,5)
INSERT INTO [dbo].[Tien_phong]([Bill_ID],[So_thang])VALUES(170,5)
go

--select * from Tien_phong
--go
----Table-Tien_BHYT-----
INSERT INTO [dbo].[Tien_BHYT]([Bill_ID],[Ma_BHYT])
values		(11,'BHYT01'),(12,'BHYT02'),
			(13,'BHYT03'),(14,'BHYT04'),
			(15,'BHYT05'),(16,'BHYT06'),
			(17,'BHYT07'),(18,'BHYT08'),
			(19,'BHYT09'),(20,'BHYT10'),
			(55,'BHYT21'),(56,'BHYT22'),
			(57,'BHYT23'),(58,'BHYT24'),
			(59,'BHYT25'),(60,'BHYT26'),
			(61,'BHYT27'),(62,'BHYT28'),
			(63,'BHYT29'),(64,'BHYT30')
INSERT INTO [dbo].[Tien_BHYT]([Bill_ID],[Ma_BHYT])VALUES(151, 'BHYT11')
INSERT INTO [dbo].[Tien_BHYT]([Bill_ID],[Ma_BHYT])VALUES(152, 'BHYT12')
INSERT INTO [dbo].[Tien_BHYT]([Bill_ID],[Ma_BHYT])VALUES(153, 'BHYT13')
INSERT INTO [dbo].[Tien_BHYT]([Bill_ID],[Ma_BHYT])VALUES(154, 'BHYT14')
INSERT INTO [dbo].[Tien_BHYT]([Bill_ID],[Ma_BHYT])VALUES(155, 'BHYT15')
INSERT INTO [dbo].[Tien_BHYT]([Bill_ID],[Ma_BHYT])VALUES(156, 'BHYT16')
INSERT INTO [dbo].[Tien_BHYT]([Bill_ID],[Ma_BHYT])VALUES(157, 'BHYT17')
INSERT INTO [dbo].[Tien_BHYT]([Bill_ID],[Ma_BHYT])VALUES(158, 'BHYT18')
INSERT INTO [dbo].[Tien_BHYT]([Bill_ID],[Ma_BHYT])VALUES(159, 'BHYT19')
INSERT INTO [dbo].[Tien_BHYT]([Bill_ID],[Ma_BHYT])VALUES(160, 'BHYT20')

go

--select * from Tien_BHYT
--go
----Table--Tien_dien_nuoc-----
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])
values		(21,201,'A1',27,10,'1111118','TRN006','2019-02-01',1),
			(22,201,'A1',61,21,'1111118','TRN006','2019-03-01',2),
			(23,201,'A1',93,32,'1111118','TRN006','2019-04-01',3),
			(24,201,'A1',153,40,'1111118','TRN006','2019-05-01',4),

			(25,203,'A1',25,11,'1111118','TRN006','2019-02-01',1),
			(26,203,'A1',51,22,'1111118','TRN006','2019-03-01',2),
			(27,203,'A1',71,33,'1111118','TRN006','2019-04-01',3),
			(28,203,'A1',102,45,'1111118','TRN006','2019-05-01',4),

			(29,205,'A1',35,17,'1111118','TRN006','2019-02-01',1),
			(30,205,'A1',69,40,'1111118','TRN006','2019-03-01',2),
			(31,205,'A1',120,59,'1111118','TRN006','2019-04-01',3),
			(32,205,'A1',170,85,'1111118','TRN006','2019-05-01',4),

			(33,208,'A1',33,15,'1111118','TRN006','2019-02-01',1),
			(34,208,'A1',65,39,'1111118','TRN006','2019-03-01',2),
			(35,208,'A1',111,55,'1111118','TRN006','2019-04-01',3),
			(36,208,'A1',153,80,'1111118','TRN006','2019-05-01',4),
			(75,202,'C2',30,0,'3100002','TRN002','2019-02-01',1),
			(76,202,'C2',60,30,'3100002','TRN002','2019-03-01',2),
			(77,202,'C2',90,60,'3100002','TRN002','2019-04-01',3),
			(78,202,'C2',150,90,'3100002','TRN002','2019-05-01',4),

			(79,205,'C2',40,0,'3100002','TRN002','2019-02-01',1),
			(80,205,'C2',80,30,'3100002','TRN002','2019-03-01',2),
			(81,205,'C2',120,80,'3100002','TRN002','2019-04-01',3),
			(82,205,'C2',200,120,'3100002','TRN002','2019-05-01',4),

			(83,207,'C2',50,0,'3100002','TRN002','2019-02-01',1),
			(84,207,'C2',100,50,'3100002','TRN002','2019-03-01',2),
			(85,207,'C2',150,100,'3100002','TRN002','2019-04-01',3),
			(86,207,'C2',250,150,'3100002','TRN002','2019-05-01',4),

			(87,201,'C1',50,0,'3100001','TRN001','2019-02-01',1),
			(88,201,'C1',100,50,'3100001','TRN001','2019-03-01',2),
			(89,201,'C1',150,100,'3100001','TRN001','2019-04-01',3),
			(90,201,'C1',250,150,'3100001','TRN001','2019-05-01',4),

			(91,203,'C1',50,0,'3100001','TRN001','2019-02-01',1),
			(92,203,'C1',100,50,'3100001','TRN001','2019-03-01',2),
			(93,203,'C1',150,100,'3100001','TRN001','2019-04-01',3),
			(94,203,'C1',250,150,'3100001','TRN001','2019-05-01',4)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(171,203,'B1',30,10,'2100001','TRN011','2018-02-01',1)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(172,203,'B1',60,20,'2100001','TRN011','2018-03-01',2)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(173,203,'B1',90,30,'2100001','TRN011','2018-04-01',3)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(174,203,'B1',120,40,'2100001','TRN011','2018-05-01',4)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(175,204,'B1',30,10,'2100001','TRN011','2018-02-01',1)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(176,204,'B1',60,20,'2100001','TRN011','2018-03-01',2)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(177,204,'B1',90,30,'2100001','TRN011','2018-04-01',3)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(178,204,'B1',120,40,'2100001','TRN011','2018-05-01',4)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(179,201,'B2',30,10,'2100002','TRN012','2018-02-01',1)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(180,201,'B2',60,20,'2100002','TRN012','2018-03-01',2)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(181,201,'B2',90,30,'2100002','TRN012','2018-04-01',3)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(182,201,'B2',120,40,'2100002','TRN012','2018-05-01',4)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(183,202,'B2',30,10,'2100002','TRN012','2018-02-01',1)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(184,202,'B2',60,20,'2100002','TRN012','2018-03-01',2)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(185,202,'B2',90,30,'2100002','TRN012','2018-04-01',3)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(186,202,'B2',120,40,'2100002','TRN012','2018-05-01',4)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(187,203,'B2',30,10,'2100002','TRN012','2018-02-01',1)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(188,203,'B2',60,20,'2100002','TRN012','2018-03-01',2)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(189,203,'B2',90,30,'2100002','TRN012','2018-04-01',3)
INSERT INTO [dbo].[Tien_Dien_Nuoc]([Bill_ID],[Ten_phong],[Ten_toa_nha],[Chi_so_dien_thang_nay],[Chi_so_nuoc_thang_nay],[Ten_dang_nhap_TN],[MSNV],[Ngay_chot_chi_so],[Thang])VALUES(190,203,'B2',120,40,'2100002','TRN012','2018-05-01',4)

go

--select * from Tien_Dien_Nuoc
--go
-----Table--Thu_ngan_thanh_toan_hoa_don------
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])
--VALUES('1111119','THU001','1111111',6,'2018-01-28')
values	('1111119','THU006','1111111',1,'2019-01-15'),
		('1111119','THU006','1111112',2,'2019-01-16'),
		('1111119','THU006','1111113',3,'2019-01-17'),
		('1111119','THU006','1111114',4,'2019-01-12'),
		('1111119','THU006','1111115',5,'2019-01-12'),
		('1111119','THU006','1111116',6,'2019-01-13'),
		('1111119','THU006','1111120',7,'2019-01-15'),

		('1111132','THU007','1111121',8,'2019-01-11'),
		('1111132','THU007','1111122',9,'2019-01-19'),
		('1111132','THU007','1111123',10,'2019-01-18'),
		('1111132','THU007','1111111',11,'2019-01-15'),
		('1111132','THU007','1111112',12,'2019-01-16'),
		('1111132','THU007','1111113',13,'2019-01-17'),
		('1111132','THU007','1111114',14,'2019-01-12'),

		('1111133','THU008','1111115',15,'2019-01-12'),
		('1111133','THU008','1111116',16,'2019-01-13'),
		('1111133','THU008','1111120',17,'2019-01-15'),
		('1111133','THU008','1111121',18,'2019-01-11'),
		('1111133','THU008','1111122',19,'2019-01-19'),
		('1111133','THU008','1111122',20,'2019-01-18'),

		('1111134','THU009','1111111',21,'2019-02-18'),
		('1111134','THU009','1111111',22,'2019-03-16'),

		('1111134','THU009','1111113',25,'2019-02-18'),
		('1111134','THU009','1111113',26,'2019-03-16'),

		('1111135','THU010','3000001',29,'2019-02-18'),
		('1111135','THU010','3000001',30,'2019-03-16'),

		('1111135','THU010','3000003',33,'2019-02-18'),
		('1111135','THU010','3000003',34,'2019-03-16'),

		('3200001','THU001','3000001',55,'2019-01-15'),
		('3200001','THU001','3000002',56,'2019-01-16'),
		('3200001','THU001','3000003',57,'2019-01-17'),
		('3200001','THU001','3000004',58,'2019-01-12'),
		('3200001','THU001','3000005',59,'2019-01-12'),
		('3200001','THU001','3000006',60,'2019-01-13'),
		('3200001','THU001','3000007',61,'2019-01-15'),
		('3200001','THU001','3000008',62,'2019-01-11'),
		('3200001','THU001','3000009',63,'2019-01-19'),
		('3200001','THU001','3000010',64,'2019-01-18'),

		('3200002','THU002','3000001',65,'2019-01-15'),
		('3200002','THU002','3000002',66,'2019-01-16'),
		('3200002','THU002','3000003',67,'2019-01-17'),
		('3200002','THU002','3000004',68,'2019-01-12'),
		('3200002','THU002','3000005',69,'2019-01-12'),
		('3200002','THU002','3000006',70,'2019-01-13'),
		('3200002','THU002','3000007',71,'2019-01-15'),
		('3200002','THU002','3000008',72,'2019-01-11'),
		('3200002','THU002','3000009',73,'2019-01-19'),
		('3200002','THU002','3000010',74,'2019-01-18'),
	
		('3200003','THU003','3000002',75,'2019-02-18'),
		('3200003','THU003','3000002',76,'2019-03-16'),

		('3200004','THU004','3000008',79,'2019-02-18'),
		('3200004','THU004','3000008',80,'2019-03-16'),

		('3200005','THU005','3000001',83,'2019-02-18'),
		('3200005','THU005','3000001',84,'2019-03-16'),

		('3200003','THU003','3000003',87,'2019-02-18'),
		('3200005','THU005','3000003',88,'2019-03-16'),

		('3200004','THU004','3000006',91,'2019-02-18'),
		('3200005','THU005','3000006',92,'2019-03-16')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200001','THU011','2000001',151,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200001','THU011','2000002',152,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200001','THU011','2000003',153,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200001','THU011','2000004',154,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200001','THU011','2000005',155,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200001','THU011','2000006',156,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200001','THU011','2000007',157,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200001','THU011','2000008',158,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200001','THU011','2000009',159,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200001','THU011','2000010',160,'2019-01-28')

INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200002','THU012','2000001',161,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200002','THU012','2000002',162,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200002','THU012','2000003',163,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200002','THU012','2000004',164,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200002','THU012','2000005',165,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200002','THU012','2000006',166,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200002','THU012','2000007',167,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200002','THU012','2000008',168,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200002','THU012','2000009',169,'2019-01-28')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200002','THU012','2000010',170,'2019-01-28')

INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200003','THU013','2000001',171,'2019-02-02')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200003','THU013','2000001',172,'2019-03-02')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200003','THU013','2000001',173,'2019-04-02')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200003','THU013','2000001',174,'2019-05-02')

INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200004','THU014','2000002',175,'2019-02-02')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200004','THU014','2000002',176,'2019-03-02')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200004','THU014','2000002',177,'2019-04-02')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200004','THU014','2000002',178,'2019-05-02')


INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200003','THU013','2000003',179,'2019-02-02')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200003','THU013','2000003',180,'2019-03-02')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200003','THU013','2000003',181,'2019-04-02')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200003','THU013','2000003',182,'2019-05-02')


INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200005','THU015','2000005',183,'2019-02-02')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200005','THU015','2000005',184,'2019-03-02')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200005','THU015','2000005',185,'2019-04-02')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200005','THU015','2000005',186,'2019-05-02')


INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200004','THU014','2000009',187,'2019-02-02')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200004','THU014','2000009',188,'2019-03-02')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200004','THU014','2000009',189,'2019-04-02')
INSERT INTO [dbo].[Thu_ngan_thanh_toan_hoa_don_SV]([Ten_dang_nhap_ThN],[MSNV],[Ten_dang_nhap_SV],[Bill_ID],[Ngay_thanh_toan])VALUES('2200004','THU014','2000009',190,'2019-05-02')

go

--select * from Thu_ngan_thanh_toan_hoa_don_SV
--go
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create index Index_nguoidung on Nguoi_dung(Ten_dang_nhap)
create index Index_Sinhvien on Sinh_vien(Ten_dang_nhap)
create index Index_nguoidung_status on Nguoi_dung(Nguoi_dung)
create index Index_Phong_toa_nha on Phong(Ten_toa_nha)
create index Index_Sinh_vien_o_phong on SV_o_phong(Ten_toa_nha)
create index Index_Hoa_don on Hoa_don(Bill_ID)
create index Index_Truong_nha on Truong_nha(Ten_dang_nhap)
create index Index_Bao_ve on Bao_ve(Ten_dang_nhap)
create index Index_Yeu_cau on Yeu_cau(Ten_dang_nhap_TN)
create index Index_Bao_ve_truc on Bao_ve_truc(MSNV)
go

---------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
--Author : Nguyen Trong Trung
create or alter procedure Insert_Yeu_cau
	@Ten_dang_nhap_SV varchar(20),
	@Noi_dung_yeu_cau nvarchar(500)
	
as begin
	if (not exists (select * from Nguoi_dung as S where S.Ten_dang_nhap = @Ten_dang_nhap_SV))
		begin
			raiserror('There no account like that',16,1);
			return 0;
		end;
	if (not exists(select * from Sinh_vien as S where S.Ten_dang_nhap = @Ten_dang_nhap_SV))
		begin
			raiserror('You arenot student',16,1);
			return 0;
		end;
	declare @Noi_dung_chuoi nvarchar(500) = (select REPLACE(@Noi_dung_yeu_cau,' ',''));
	if (@Noi_dung_yeu_cau is null or LEN(@Noi_dung_chuoi) = 0)
		begin
			raiserror('Lose context of Requirement',16,1);
			return 0;
		end
	declare @Ten_dang_nhap_TN varchar(20), @MSNV varchar(6);
	declare @Ten_toa_nha nvarchar(5);
	set @Ten_toa_nha = (select A.Ten_toa_nha from SV_o_phong as A join TN_lam_viec_o_toa_nha as B on A.Ten_toa_nha = B.Ten_toa_nha where A.Ten_dang_nhap_SV = @Ten_dang_nhap_SV) 
	select @Ten_dang_nhap_TN = A.Ten_dang_nhap_TN, @MSNV = A.MSNV from TN_lam_viec_o_toa_nha as A where A.Ten_toa_nha = @Ten_toa_nha
	insert into dbo.Yeu_cau ([Noi_dung_yeu_cau] ,[Ngay_gui] ,[Ten_dang_nhap_SV] ,[Ten_dang_nhap_TN],[MSNV])
	  values (@Noi_dung_yeu_cau, getdate(), @Ten_dang_nhap_SV,@Ten_dang_nhap_TN, @MSNV)
end
go
--exec Insert_yeu_cau '3000001','1'
--exec Insert_yeu_cau '3000001',' '
--exec Insert_yeu_cau '3000000','1'
--go
--------------------------------------------------------------------------------------------------------------
create or alter procedure Yeu_cau_chua_giai_quyet
	@Ten_dang_nhap varchar(20)
as begin
	select C.Ho_ten_dem, C.Ten, B.Ten_phong, B.Ten_toa_nha, A.Ngay_gui, A.Noi_dung_yeu_cau
	from (Yeu_cau as A join SV_o_phong as B on A.Ten_dang_nhap_SV = B.Ten_dang_nhap_SV)
		join Nguoi_dung as C on B.Ten_dang_nhap_SV = C.Ten_dang_nhap
	where A.Ten_dang_nhap_TN = @Ten_dang_nhap and A.Tinh_trang = 'X'
	order by A.Ngay_giai_quyet ASC
end
go
--exec Yeu_cau_chua_giai_quyet '3100002'
--go
---------------------------------------------------------------------------------------------------------------
create or alter procedure So_luong_yeu_cau_tung_phong
	@Ten_dang_nhap varchar(20)
as begin
	select B.Ten_phong, B.Ten_toa_nha, count(*) as N'Số lượng'
	from Yeu_cau as A join SV_o_phong as B on A.Ten_dang_nhap_SV = B.Ten_dang_nhap_SV
			join TN_lam_viec_o_toa_nha as C on C.Ten_toa_nha = B.Ten_toa_nha 
	where C.Ten_dang_nhap_TN = @Ten_dang_nhap and A.Tinh_trang = 'X'
	group by B.Ten_phong, B.Ten_toa_nha
	having count(*) > 1 
	order by B.Ten_phong ASC
end
go
--exec So_luong_yeu_cau_tung_phong '3100001'
--go
------------------------------------------------
create function Thanh_tich_truong_nha
	(@MSNV varchar(6))
returns varchar(4)
as begin
	if (not exists(select * from Truong_nha where @MSNV = MSNV))
		begin
			return 'SaiM';
		end;
	declare @thanh_tich varchar(4);
	declare @So_luong int = 0;
	declare @So_luong_xong int = 0;
	declare @Ten_dang_nhap varchar(20) = (select Truong_nha.Ten_dang_nhap from Truong_nha where @MSNV = Truong_nha.MSNV);
	select @So_luong = count(*) from Yeu_cau as Y where Y.Ten_dang_nhap_TN = @Ten_dang_nhap and Y.Tinh_trang = 'X';
	select @So_luong_xong = count(*) from Yeu_cau as Y where Y.Ten_dang_nhap_TN = @Ten_dang_nhap and Y.Tinh_trang = 'O';

	if (@So_luong_xong >= @So_luong and @So_luong <= 5)
		set @thanh_tich = 'Dat';
	else 
		set @thanh_tich = 'KDat';
	return @thanh_tich;
end
go

--select dbo.Thanh_tich_truong_nha ('TRN001')
--select dbo.Thanh_tich_truong_nha ('TRN000')
--select dbo.Thanh_tich_truong_nha ('TRN005')
--go


create or alter function Tim_ca_truc_gan_cua_bao_ve
	(@MSNV varchar(6), @Ca_hien_Tai varchar(1))
returns nvarchar (20)
as
begin
	declare @Chuoi_tam varchar(20);
	if not exists(select * from Bao_ve_truc where MSNV = @MSNV)
		return N'Sai mã số nhân viên rồi';
	declare @Ngay_truc date;
	declare @Ca_truc varchar(1);
	if (@Ca_hien_Tai = 'T')
		select top 1 @Chuoi_tam = CONVERT(varchar,B.Ngay_truc) +'  '+ CONVERT(varchar, B.Ca_truc) 
				from Bao_ve_truc as B where B.MSNV = @MSNV and datediff(day, getdate(), B.Ngay_truc) > 0 	
	else  if (@Ca_hien_Tai = 'S')
	begin
		declare @So_luong int;
		select	@So_luong = count(*), @Ngay_truc = B.Ngay_truc
				from Bao_ve_truc as B where B.MSNV = @MSNV
				 and datediff(day,convert(date,getdate()), B.Ngay_truc) = 0
				group by B.Ngay_truc
		if (@So_luong = 2)
		begin
			set @Chuoi_tam = convert(varchar,@Ngay_truc) + ' T';
		end
		
		else 
			select top 1 @Chuoi_tam = CONVERT(varchar,B.Ngay_truc) +'  '+ CONVERT(varchar, B.Ca_truc) 
				from Bao_ve_truc as B where B.MSNV = @MSNV and datediff(day, getdate(),B.Ngay_truc) > 0 	
		
	end
	else 
	begin
		return N'Bạn đã nhập sai rồi'; 
	end
	return @Chuoi_tam;
end
go

--select dbo.Tim_ca_truc_gan_cua_bao_ve ('BVE001','S')
--select dbo.Tim_ca_truc_gan_cua_bao_ve ('BVE001','M')
--go
--------------------------------------------------------------------------------------
create or alter trigger Xay_nha
on Toa_nha instead of insert
as begin
	declare @Ten_nha nvarchar(5);
	set @Ten_nha = (select i.Ten_toa_nha from inserted i);
	set @Ten_nha = (select REPLACE(@Ten_nha, ' ','')); 
	if ( len(@Ten_nha) = 0 or @Ten_nha is null or exists(select * from Toa_nha where Toa_nha.Ten_toa_nha = @Ten_nha))
	begin
		print (N'Tòa nhà đã có rồi');
		return;
	end
	else
	declare @so_luong_phong int;
	set @so_luong_phong = (select i.So_phong from inserted i);
	if (@so_luong_phong <=0) 
		begin
				print(N'Bạn nhập sai số phòng rồi');
				return;
		end

	declare @ngay_dau date, @ngay_cuoi date;
	set @ngay_dau = (select i.Ngay_thi_cong from inserted i);
	set @ngay_cuoi = (select i.Ngay_hoan_thanh from inserted i);

	if (@ngay_dau >=@ngay_cuoi or @ngay_cuoi > getdate() or DATEDIFF(day,@ngay_dau,@ngay_cuoi)<= 6*30)
	begin
		print(N'Bạn nhập sai ngày rồi');
		return
	end

	insert into dbo.Toa_nha (Ten_toa_nha,Ngay_thi_cong,Ngay_hoan_thanh, So_phong)
	select i.Ten_toa_nha,i.Ngay_thi_cong, i.Ngay_hoan_thanh, i.So_phong from inserted i

	declare @count int = 1;
	declare @ten_phong int  = 201;
	while (@count <= @so_luong_phong)
	begin
		insert into Phong (Ten_phong, Ten_toa_nha) values (CONVERT(varchar,@ten_phong),@Ten_nha);
		set @ten_phong = @ten_phong + 1;
		set @count = @count + 1;
	end
end
go

--insert into dbo.Toa_nha (Ten_toa_nha, Ngay_thi_cong, Ngay_hoan_thanh, So_phong) values ('B0','2018-5-1','2019-5-18', 1)

--select * from Toa_nha
--go
--select * from Phong
--go


create or alter trigger Them_MSNV
on Nguoi_dung after insert
as begin
	declare @Nguoi_dung nvarchar(20);
	declare @TDN nvarchar(20);
	declare @STT varchar(6);
	declare @MSNV varchar(6);
	select @Nguoi_dung= i.Nguoi_dung, @TDN = i.Ten_dang_nhap from inserted i;
	if (@Nguoi_dung = N'Bảo vệ')
	begin
		select @STT = max(MSNV) from Bao_ve;
		if (@STT is null)
			insert into Bao_ve (MSNV, Ten_dang_nhap)
			values ('BVE001', @TDN)
		else
		begin
			set @MSNV = 'BVE';
			set @STT = REPLACE(@STT,'BVE','');
			if (convert(int, @STT + 1) <10)
				set @MSNV = @MSNV +'00'+ convert(varchar,convert(int, @STT + 1))
			else if (convert(int, @STT + 1) <100)
				set @MSNV = @MSNV +'0'+ convert(varchar,convert(int, @STT + 1))
			else 
				set @MSNV = @MSNV + convert(varchar,convert(int, @STT + 1))
			insert into Bao_ve(MSNV, Ten_dang_nhap)
			values (@MSNV,@TDN)
		end
	end
	else if (@Nguoi_dung = N'Thu ngân')
	begin
		select @STT = max(MSNV) from Thu_ngan;
		if (@STT is null)
			insert into Thu_ngan(MSNV, Ten_dang_nhap)
			values ('THU001', @TDN)
		else
		begin
			set @MSNV = 'THU';
			set @STT = REPLACE(@STT,'THU','');
			if (convert(int, @STT + 1) <10)
				set @MSNV = @MSNV +'00'+ convert(varchar,convert(int, @STT + 1))
			else if (convert(int, @STT + 1) <100)
				set @MSNV = @MSNV +'0'+ convert(varchar,convert(int, @STT + 1))
			else 
				set @MSNV = @MSNV + convert(varchar,convert(int, @STT + 1))
			insert into Thu_ngan(MSNV, Ten_dang_nhap)
			values (@MSNV,@TDN)
		end
	end
	else
	if (@Nguoi_dung = N'Trưởng nhà')
	begin
		select @STT = max(MSNV) from Truong_nha;
		if (@STT is null)
			insert into Truong_nha(MSNV, Ten_dang_nhap)
			values ('TRN001', @TDN)
		else
		begin
			set @MSNV = 'TRN';
			set @STT = REPLACE(@STT,'TRN','');
			if (convert(int, @STT + 1) <10)
				set @MSNV = @MSNV +'00'+ convert(varchar,convert(int, @STT + 1))
			else if (convert(int, @STT + 1) <100)
				set @MSNV = @MSNV +'0'+ convert(varchar,convert(int, @STT + 1))
			else 
				set @MSNV = @MSNV + convert(varchar,convert(int, @STT + 1))
			insert into Truong_nha(MSNV, Ten_dang_nhap)
			values (@MSNV,@TDN)
		end
	end
end
go

/*INSERT INTO [dbo].[Nguoi_dung]([Ten_dang_nhap],[Nguoi_dung],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP],[Hinh_anh],[Tinh_trang])
VALUES('1111137',N'Bảo vệ',N'Nguyễn Văn',N'Đường','1994-05-28',187034934,'Nam',N'Hướng Hóa',N'Quảng Trị',null,'X')
select * from Nguoi_dung
select * from Bao_ve
go
*/
--------------------------------------------------------------------
--PHan cho app ung dung---------------------------------------------
create or alter procedure Load_Yeu_cau
	@Ten_dang_nhap varchar(20)
as begin
	select  Y.Req_ID,Y.Ngay_gui as N'Ngày gửi',Y.Noi_dung_yeu_cau as N'Nội dung yêu cầu'
	from Yeu_cau as Y where Y.Ten_dang_nhap_SV = @Ten_dang_nhap and Y.Tinh_trang = 'X';
end
go

create or alter procedure Delete_Yeu_cau
	@RegID int, @Ten_dang_nhap varchar(20)
as begin
	/*
	declare @Count int = (select count(*) from Yeu_cau where @Ten_dang_nhap = Ten_dang_nhap_SV);
	if (@Count is null or @Count = 0)
		begin
			raiserror('Table is NULL',16,1);
			return 0;
		end
		*/
	delete Yeu_cau where Req_ID = @RegID;
end
go


Create or alter procedure Update_Yeu_Cau
	@Req int,
	@Noi_dung_yeu_cau nvarchar(500)
as
begin
	declare @Noi_dung_chuoi nvarchar(500) = (select REPLACE(@Noi_dung_yeu_cau,' ',''));
	if (@Noi_dung_yeu_cau is null or LEN(@Noi_dung_chuoi) = 0)
		begin
			raiserror('Lose context of Requirement',16,1);
			return 0;
		end
	update Yeu_cau
	set Noi_dung_yeu_cau = @Noi_dung_yeu_cau, Ngay_gui = getdate()
	where Req_ID = @Req
end
go
--------------------------------------------------------------------------------
-------------------------------Phần--của---Đạt----------------------------------
---------------------------------------------------------------------------------
create function Suc_chua_toi_da_cua_toa_nha_tren_mot_phong(@toa varchar(5))
returns int
as
begin
	if not exists (select * from Toa_nha where Ten_toa_nha = @toa)
		return -1
	DECLARE DSPhong CURSOR FOR
	select So_SV_toi_da from Phong where Ten_toa_nha = @toa
	open DSPhong
	DECLARE @So_SV_toi_da_cua_toa_nha int = 0 
	declare @count int = 0
	fetch next from DSPhong into @count
	WHILE @@FETCH_STATUS = 0
		begin
			set @So_SV_toi_da_cua_toa_nha = @So_SV_toi_da_cua_toa_nha + @count
			fetch next from DSPhong into @count
		end	
	close DSPhong
	deallocate DSPhong
	select @count = count(*) from Phong where Ten_toa_nha = @toa
	return @So_SV_toi_da_cua_toa_nha/ @count
end
go

--select dbo.Suc_chua_toi_da_cua_toa_nha_tren_mot_phong('A1')

create function SV_co_tuoi_lon_hon (@age int)
returns int
as
begin
	if(@age < 16)
		begin
			return -1
		end
	DECLARE DSSV CURSOR FOR
	select Ngay_sinh from Nguoi_dung as N inner join Sinh_vien as S on N.Ten_dang_nhap = S.Ten_dang_nhap
	open DSSV
	DECLARE @dob Datetime 
	declare @count int = 0
	fetch next from DSSV into @dob
	WHILE @@FETCH_STATUS = 0
		BEGIN
			if (YEAR(CURRENT_TIMESTAMP) - YEAR(@dob)) >= @age
				set @count = @count + 1
			fetch next from DSSV into @dob
		end
	close DSSV
	deallocate DSSV
	return @count
end
go
--select dbo.SV_co_tuoi_lon_hon(21)
--select dbo.SV_co_tuoi_lon_hon(22)
--select dbo.SV_co_tuoi_lon_hon(15)
go
---------
create function load_phong_trong_toa_nha(@toa varchar(5))
returns TABLE
as
	return(select * from Phong where Ten_toa_nha = @toa)
go
--select * from load_phong_trong_toa_nha('A1')

-----
create function load_cb_phong(@loaiphong nvarchar(20), @toa varchar(5))
returns TABLE
as
	return(select Ten_phong from Phong where Loai_phong = @loaiphong and Ten_toa_nha = @toa)
go
--select * from load_cb_phong(N'Phòng 2', 'A1')
create function load_toa_nha(@username varchar(7))
returns TABLE
as
	return(select Ten_toa_nha from TN_lam_viec_o_toa_nha where Ten_dang_nhap_TN = @username)
go
--select * from load_toa_nha('1111118')
----
create function select_sv(@toa varchar(5))
returns TABLE
as
	return(select N.Ten_dang_nhap, N.Ho_ten_dem, N.Ten, N.Ngay_sinh, N.CMND, N.Gioi_tinh, N.Quan_Huyen, N.Tinh_TP,S.MSSV, S.Truong, S.Nam_thu, O.Ten_phong, O.Ten_toa_nha, E.Email, SDT.SDT from Nguoi_dung as N inner join Sinh_vien as S on N.Ten_dang_nhap = S.Ten_dang_nhap inner join SV_o_phong as O on N.Ten_dang_nhap = O.Ten_dang_nhap_SV left join Email_Nguoi_dung as E on N.Ten_dang_nhap = E.Ten_dang_nhap left join SDT_Nguoi_dung as SDT on N.Ten_dang_nhap = SDT.Ten_dang_nhap where Ten_toa_nha = @toa)
go
create function load_tinh_trang_phong(@phong int, @toa varchar(5))
returns TABLE
as
	return(select Tinh_trang from Phong where Ten_toa_nha= @toa and Ten_phong = @phong)
go
--select * from load_tinh_trang_phong(201,'A1')

--select * from select_sv('A1')
--select S.Ten_dang_nhap,MSSV,Truong,Nam_thu,Ho_ten_dem,Ten,Ngay_sinh,CMND,Gioi_tinh,Quan_Huyen,Tinh_TP,Ten_phong,Ten_toa_nha,SDT,Email from Sinh_vien as S inner join Nguoi_dung as N on S.Ten_dang_nhap = N.Ten_dang_nhap inner join SV_o_phong as O on O.Ten_dang_nhap_SV=S.Ten_dang_nhap inner join SDT_Nguoi_dung as SDT on S.Ten_dang_nhap=SDT.Ten_dang_nhap inner join Email_Nguoi_dung as E on S.Ten_dang_nhap = E.Ten_dang_nhap
------------------------------------------------
create function select_sv_in(@phong int, @toa varchar(5))
returns TABLE
as
	return(select N.Ten_dang_nhap, N.Ho_ten_dem, N.Ten, N.Ngay_sinh, N.CMND, N.Gioi_tinh, N.Quan_Huyen, N.Tinh_TP,S.MSSV, S.Truong, S.Nam_thu, O.Ten_phong, O.Ten_toa_nha, E.Email, SDT.SDT from Nguoi_dung as N inner join Sinh_vien as S on N.Ten_dang_nhap = S.Ten_dang_nhap inner join SV_o_phong as O on N.Ten_dang_nhap = O.Ten_dang_nhap_SV left join Email_Nguoi_dung as E on N.Ten_dang_nhap = E.Ten_dang_nhap left join SDT_Nguoi_dung as SDT on N.Ten_dang_nhap = SDT.Ten_dang_nhap where Ten_toa_nha = @toa and Ten_phong = @phong)

go
--select * from select_sv_in(202,'A1')
--select N.Ten_dang_nhap, N.Ho_ten_dem, N.Ten, N.Ngay_sinh, N.CMND, N.Gioi_tinh, N.Quan_Huyen, N.Tinh_TP,S.MSSV, S.Truong, S.Nam_thu, O.Ten_phong, O.Ten_toa_nha, E.Email, SDT.SDT from Nguoi_dung as N inner join Sinh_vien as S on N.Ten_dang_nhap = S.Ten_dang_nhap inner join SV_o_phong as O on N.Ten_dang_nhap = O.Ten_dang_nhap_SV left join Email_Nguoi_dung as E on N.Ten_dang_nhap = E.Ten_dang_nhap left join SDT_Nguoi_dung as SDT on N.Ten_dang_nhap = SDT.Ten_dang_nhap

--select S.Ten_dang_nhap,MSSV,Truong,Nam_thu,Ho_ten_dem,Ten,Ngay_sinh,CMND,Gioi_tinh,Quan_Huyen,Tinh_TP,Ten_phong,Ten_toa_nha,SDT,Email from Sinh_vien as S inner join Nguoi_dung as N on S.Ten_dang_nhap = N.Ten_dang_nhap inner join SV_o_phong as O on O.Ten_dang_nhap_SV=S.Ten_dang_nhap inner join SDT_Nguoi_dung as SDT on S.Ten_dang_nhap=SDT.Ten_dang_nhap inner join Email_Nguoi_dung as E on S.Ten_dang_nhap = E.Ten_dang_nhap where Ten_phong=204
-------------------------------------------------
--select * from Phong
--select Loai_phong from Phong where Phong.Ten_phong = 201
--select Ten_phong from Phong where Phong.Loai_phong = N'Phòng 2'
--------------
---------------------------------------------------------------------
CREATE PROCEDURE P_Login
@userName varchar(100), @passWord varchar(100)
AS
BEGIN
	SELECT * FROM dbo.Nguoi_dung WHERE Ten_dang_nhap = @userName AND Mat_khau=@passWord
END
GO
---------------------------------
--exec P_Login '1111111','123456'
--select Sinh_vien.Ten_dang_nhap,Ho_ten_dem,Ten from (Nguoi_dung inner join Sinh_vien on Nguoi_dung.Ten_dang_nhap = Sinh_vien.Ten_dang_nhap  )
--select Nguoi_dung.Ten_dang_nhap from  (Nguoi_dung inner join  Sinh_vien on Nguoi_dung.Ten_dang_nhap = Sinh_vien.Ten_dang_nhap )
--select * from Sinh_vien
create procedure P_Info
	@tendangnhap char(100)
as
begin
	select N.Ten_dang_nhap, (N.Ho_ten_dem +' '+ N.Ten) as HoVaTen, N.Ngay_sinh, N.CMND, N.Gioi_tinh, N.Quan_Huyen, N.Tinh_TP, S.MSSV, S.Truong, S.Nam_thu, E.Email, SDT.SDT, convert(varchar,Ten_phong)+Ten_toa_nha as Phong
	from Nguoi_dung as N inner join Sinh_vien as S on N.Ten_dang_nhap = S.Ten_dang_nhap 
	inner join Email_Nguoi_dung as E on E.Ten_dang_nhap = N.Ten_dang_nhap 
	inner join SDT_Nguoi_dung as SDT on N.Ten_dang_nhap = SDT.Ten_dang_nhap
	inner join SV_o_phong as P on P.Ten_dang_nhap_SV = N.Ten_dang_nhap
	 where N.Ten_dang_nhap = @tendangnhap
end
go
--exec P_Info '1111111'

-------------------------------------
create procedure P_ChangePass
@userName NVARCHAR(100), @password NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN
	DECLARE @isRightPass INT = 0
	SELECT @isRightPass = COUNT(*) FROM Nguoi_dung WHERE Ten_dang_nhap = @userName AND Mat_khau = @password
	IF (@isRightPass = 1)
		BEGIN
			IF (@newPassword is NULL or @newPassword='')
				raiserror('Mat khau khong hop le!',16,1)
			ELSE
				begin
					UPDATE Nguoi_dung SET Mat_khau = @newPassword WHERE Ten_dang_nhap = @userName
					print'doi mat khau thanh cong'
			end
	end
	else
		raiserror('Sai mat khau!',16,1)
END
go
--exec P_Info '1111111'
--select * from Nguoi_dung where Ten_dang_nhap='1111111'
--exec P_ChangePass '1111111','123456','dat123'
--select * from Nguoi_dung where Ten_dang_nhap='1111111'
----------------------------------------
go
create procedure INS_SV
	@username NVARCHAR(100),
	@ho_ten_dem nvarchar(100),
	@ten nvarchar(10),
	@ngaysinh Date,
	@CMND bigint,
	@gioi_tinh  nvarchar(5),
	@quan_huyen nvarchar(30),
	@tinh_tp nvarchar(30),
	@MSSV bigint,
	@truong nvarchar(100),
	@namthu int,
	@ten_phong int,
	@ten_toa_nha nvarchar(5) 
as
begin
	if not exists (select * from Nguoi_dung where Ten_dang_nhap = @username)
		begin
			DECLARE @status NVARCHAR(20)
			select @status=Tinh_trang from Phong where Ten_toa_nha = @ten_toa_nha and Ten_phong = @ten_phong		
			if @status is not null and @status <> N'Đầy'
				begin
					INSERT INTO [dbo].[Nguoi_dung]([Nguoi_dung],[Ten_dang_nhap],[Ho_ten_dem],[Ten],[Ngay_sinh],[CMND],[Gioi_tinh],[Quan_Huyen],[Tinh_TP])
					VALUES(N'Sinh viên',@username,@ho_ten_dem,@ten,@ngaysinh,@CMND,@gioi_tinh,@quan_huyen,@tinh_tp)
			
					INSERT INTO [dbo].[Sinh_vien]([Ten_dang_nhap],[MSSV],[Truong],[Nam_thu])
					VALUES(@username,@MSSV,@truong,@namthu)
			
					INSERT INTO [dbo].[SV_o_phong]([Ten_dang_nhap_SV],[Ten_phong],[Ten_toa_nha])
					VALUES(@username,@ten_phong,@ten_toa_nha)
						
				end
			else
				begin
					if @status is null
						raiserror('Khong ton tai phong tren!',16,1)
					else
						raiserror('Phong da day!',16,1)
				end
		end
	else
		begin
			raiserror('Da ton tai ten dang nhap',16,1)
		end	
end
go
--exec INS_SV '1111138', N'Trần Huy',N'Khanh','1998-01-01','197974113',N'Nam',N'Mường Nhé',N'Điện Biên','1711131',N'Đại học Bách Khoa',2,203,'A1'

--select * from Sinh_vien
--select * from Nguoi_dung
--select * from SV_o_phong

--select * from Phong
create proc SwitchRoom
	@phong1 int, 
	@phong2 int,
	@toa1 varchar(5),
	@toa2 varchar(5)
as
begin
	if @toa1 <> @toa2
		raiserror('Hai toa nha khac nhau!',16,1)
	else
		begin
			DECLARE @numofstudentroom1 INT
			SELECT @numofstudentroom1 = So_SV_dang_co FROM dbo.Phong WHERE Ten_phong = @phong1 and Ten_toa_nha = @toa1

			DECLARE @numofstudentroom2 INT
			SELECT @numofstudentroom2 = So_SV_dang_co FROM dbo.Phong WHERE Ten_phong = @phong2 and Ten_toa_nha = @toa2

			DECLARE @Max1 int
			SELECT @Max1=So_SV_toi_da FROM dbo.Phong WHERE Ten_phong = @phong1 and Ten_toa_nha = @toa1

			DECLARE @Max2 int
			SELECT @Max2=So_SV_toi_da FROM dbo.Phong WHERE Ten_phong = @phong2 and Ten_toa_nha = @toa2
			
			IF(@numofstudentroom1<=@Max2 AND @numofstudentroom2<= @Max1)
				BEGIN
					DECLARE @temp_phong int = 201
					DECLARE	@temp_toa varchar(5) = 'XYZ'

					INSERT INTO [dbo].[Toa_nha]([Ten_toa_nha]) VALUES(@temp_toa)
					INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[Loai_phong],[So_SV_dang_co],[So_SV_toi_da])
					VALUES(@temp_phong,@temp_toa,N'Phòng 8',0,8)
					
          			--UPDATE dbo.SV_o_phong SET Ten_phong = @temp_phong, Ten_toa_nha = @temp_toa WHERE dbo.SV_o_phong.Ten_phong=@phong1 and Ten_toa_nha = @toa1
					--UPDATE dbo.SV_o_phong SET Ten_phong =@phong1, Ten_toa_nha = @toa1 WHERE dbo.SV_o_phong.Ten_phong=@phong2 and Ten_toa_nha = @toa2
					--UPDATE dbo.SV_o_phong SET Ten_phong =@phong2, Ten_toa_nha = @temp_toa WHERE dbo.SV_o_phong.Ten_phong=@temp_phong and Ten_toa_nha = @temp_toa
					DECLARE cursorPhong1 CURSOR FOR
					select * from SV_o_phong where Ten_toa_nha = @toa1 and Ten_phong = @phong1
					open cursorPhong1
					DECLARE @phong int 
					DECLARE	@toa varchar(5)
					DECLARE	@tdn varchar(7)
					fetch next from cursorPhong1 into @tdn, @phong, @toa
					WHILE @@FETCH_STATUS = 0
						BEGIN
							UPDATE dbo.SV_o_phong SET Ten_phong = @temp_phong, Ten_toa_nha = @temp_toa WHERE Ten_phong = @phong1 and Ten_toa_nha = @toa1 and Ten_dang_nhap_SV=@tdn
							fetch next from cursorPhong1 into @tdn, @phong, @toa	
						end
					close cursorPhong1
					deallocate cursorPhong1
					
					DECLARE cursorPhong2 CURSOR FOR
					select * from SV_o_phong where Ten_toa_nha = @toa2 and Ten_phong = @phong2
					open cursorPhong2
					fetch next from cursorPhong2 into @tdn, @phong, @toa
					WHILE @@FETCH_STATUS = 0
						BEGIN
							UPDATE dbo.SV_o_phong SET Ten_phong = @phong1, Ten_toa_nha = @toa1 WHERE Ten_phong = @phong2 and Ten_toa_nha = @toa2 and Ten_dang_nhap_SV=@tdn
							fetch next from cursorPhong2 into @tdn, @phong, @toa
						end
					close cursorPhong2
					deallocate cursorPhong2

					DECLARE cursorTempphong CURSOR FOR
					select * from SV_o_phong where Ten_toa_nha = @temp_toa and Ten_phong = @temp_phong
					open cursorTempphong
					fetch next from cursorTempphong into @tdn, @phong, @toa
					WHILE @@FETCH_STATUS = 0
						BEGIN
							UPDATE dbo.SV_o_phong SET Ten_phong = @phong2, Ten_toa_nha = @toa2 WHERE Ten_phong = @temp_phong and Ten_toa_nha = @temp_toa and Ten_dang_nhap_SV=@tdn
							fetch next from cursorTempphong into @tdn, @phong, @toa
						end
					close cursorTempphong
					deallocate cursorTempphong
						
					DELETE FROM dbo.Phong WHERE Phong.Ten_phong = @temp_phong and Phong.Ten_toa_nha = @temp_toa
					DELETE FROM dbo.Toa_nha where Toa_nha.Ten_toa_nha=@temp_toa
				end
			else
				raiserror('Hai phong khong thoa dieu kien hoan doi!',16,1)
		end
end
go
--INSERT INTO [dbo].[Toa_nha]([Ten_toa_nha]) VALUES('XYZ')
--select * from Phong
--INSERT INTO [dbo].[Phong]([Ten_phong],[Ten_toa_nha],[Loai_phong],[So_SV_dang_co],[So_SV_toi_da])
--VALUES(201,'XYZ',N'Phòng 8',0,8)
--UPDATE dbo.SV_o_phong SET Ten_phong = 201, Ten_toa_nha = 'XYZ' WHERE Ten_phong = 201 and Ten_toa_nha = 'A1' and Ten_dang_nhap_SV='1111111'
--UPDATE dbo.SV_o_phong SET Ten_phong = 201, Ten_toa_nha = 'XYZ' WHERE Ten_phong = 201 and Ten_toa_nha = 'A1' and Ten_dang_nhap_SV='1111112'
--UPDATE dbo.SV_o_phong SET Ten_phong = 201, Ten_toa_nha = 'A1' WHERE Ten_phong = 202 and Ten_toa_nha = 'A1' and Ten_dang_nhap_SV='1111136'
--UPDATE dbo.SV_o_phong SET Ten_phong = 202, Ten_toa_nha = 'A1' WHERE Ten_phong = 201 and Ten_toa_nha = 'XYZ' and Ten_dang_nhap_SV='1111111'
--UPDATE dbo.SV_o_phong SET Ten_phong = 202, Ten_toa_nha = 'A1' WHERE Ten_phong = 201 and Ten_toa_nha = 'XYZ' and Ten_dang_nhap_SV='1111112'
--select * from Phong where (Ten_phong = 201 or Ten_phong = 202) and Ten_toa_nha = 'A1'
--select * from SV_o_phong where (Ten_phong = 201 or Ten_phong = 202) and Ten_toa_nha = 'A1'
--exec SwitchRoom 201,202,'A1','A1'
--select * from Phong where (Ten_phong = 201 or Ten_phong = 202) and Ten_toa_nha = 'A1'
--select * from SV_o_phong where (Ten_phong = 201 or Ten_phong = 202) and Ten_toa_nha = 'A1'
--select * from Thoi_gian_o_cua_SV where Ten_toa_nha = 'A1'
--select * from SV_o_phong   WHERE Ten_phong = 201 and Ten_toa_nha = 'A1'

create procedure Xoa_SV_ra_khoi_phong
	@tdn varchar(7),
	@toa varchar(5),
	@phong int
as
begin
	if not exists(select * from Nguoi_dung where Ten_dang_nhap = @tdn )
		raiserror('Khong ton tai ten tai khoan!',16,1)
	else
		if not exists(select * from Toa_nha where Ten_toa_nha = @toa )
			raiserror('Khong ton tai toa nha nay!',16,1)
		else
			if not exists(select * from Phong where Ten_toa_nha = @toa and Ten_phong = @phong )
				raiserror('Khong ton tai phong nay!',16,1)
			else
				if not exists(select * from SV_o_phong where Ten_toa_nha = @toa and Ten_phong = @phong and Ten_dang_nhap_SV = @tdn )	
					raiserror('Khong co sinh vien nao co ten dang nhap nhu vay o phong nay!',16,1)	
				else
					begin
						delete SV_o_phong where Ten_dang_nhap_SV = @tdn and Ten_toa_nha = @toa and Ten_phong = @phong
						update Nguoi_dung set Tinh_trang = 'O' where Ten_dang_nhap = @tdn
					end	
end
go

--select * from Phong where Ten_toa_nha='A1'
--select * from SV_o_phong where Ten_toa_nha = 'A1'
--select * from SV_o_phong where Ten_toa_nha = 'A1' and Ten_phong = 202
--exec Xoa_SV_ra_khoi_phong '1111113','A1',203
--select * from Nguoi_dung where Ten_dang_nhap = '1111113'
--select * from SV_o_phong where Ten_toa_nha = 'A1' and Ten_phong = 202
--select * from Nguoi_dung
------------------------------------------------------
------------------------------------------------------
----------------TRIGGER-------------------------------
------------------------------------------------------
create trigger RoomStatus
on Phong for insert, update
as
begin
	DECLARE @roomname NVARCHAR(30)
	SELECT @roomname = Inserted.Ten_phong FROM Inserted

	DECLARE @buildingname NVARCHAR(30)
	SELECT @buildingname = Inserted.Ten_toa_nha FROM Inserted

	DECLARE @type NVARCHAR(20)
	SELECT @type= inserted.Loai_phong FROM inserted

	DECLARE @numofstudent INT
	SELECT @numofstudent = inserted.So_SV_dang_co FROM inserted

	IF(@type = N'Phòng 2' )
		BEGIN
			IF(@numofstudent = 0)
				UPDATE dbo.Phong SET Tinh_trang = N'Trống' WHERE Phong.Ten_phong=@roomname and Phong.Ten_toa_nha = @buildingname
			ELSE IF (@numofstudent <2)
				UPDATE dbo.Phong SET Tinh_trang = N'Có người' WHERE Phong.Ten_phong=@roomname and Phong.Ten_toa_nha = @buildingname
			ELSE
				UPDATE dbo.Phong SET Tinh_trang = N'Đầy' WHERE Phong.Ten_phong=@roomname and Phong.Ten_toa_nha = @buildingname
		END
    ELSE IF(@type = N'Phòng 4')
		BEGIN
			IF(@numofstudent = 0)
				UPDATE dbo.Phong SET Tinh_trang = N'Trống' WHERE Phong.Ten_phong=@roomname and Phong.Ten_toa_nha = @buildingname
			ELSE IF (@numofstudent <4)
					UPDATE dbo.Phong SET Tinh_trang = N'Có người' WHERE Phong.Ten_phong=@roomname and Phong.Ten_toa_nha = @buildingname
			ELSE
				UPDATE dbo.Phong SET Tinh_trang = N'Đầy' WHERE Phong.Ten_phong=@roomname and Phong.Ten_toa_nha = @buildingname
		END
	 ELSE IF(@type = N'Phòng 6')
		BEGIN
			IF(@numofstudent = 0)
				UPDATE dbo.Phong SET Tinh_trang = N'Trống' WHERE Phong.Ten_phong=@roomname and Phong.Ten_toa_nha = @buildingname
			ELSE IF (@numofstudent <6)
					UPDATE dbo.Phong SET Tinh_trang = N'Có người' WHERE Phong.Ten_phong=@roomname and Phong.Ten_toa_nha = @buildingname
			ELSE
				UPDATE dbo.Phong SET Tinh_trang = N'Đầy' WHERE Phong.Ten_phong=@roomname and Phong.Ten_toa_nha = @buildingname
		END
	ELSE
		BEGIN
			IF(@numofstudent = 0)
				UPDATE dbo.Phong SET Tinh_trang = N'Trống' WHERE Phong.Ten_phong=@roomname and Phong.Ten_toa_nha = @buildingname
			ELSE IF (@numofstudent <8)
				UPDATE dbo.Phong SET Tinh_trang = N'Có người' WHERE Phong.Ten_phong=@roomname and Phong.Ten_toa_nha = @buildingname
			ELSE
				UPDATE dbo.Phong SET Tinh_trang = N'Đầy' WHERE Phong.Ten_phong=@roomname and Phong.Ten_toa_nha = @buildingname
		END
end
go
--select * from Phong
--update Phong set So_SV_dang_co = 2 where Ten_phong = 201 and Ten_toa_nha = 'A2'
--select * from Phong
------------------------------------
create trigger Them_TG_O_SV
on SV_o_phong for insert
as
begin
	DECLARE @roomname int
	SELECT @roomname = Inserted.Ten_phong FROM Inserted

	DECLARE @buildingname NVARCHAR(30)
	SELECT @buildingname = Inserted.Ten_toa_nha FROM Inserted

	DECLARE @username NVARCHAR(30)
	SELECT @username = Inserted.Ten_dang_nhap_SV FROM Inserted

	INSERT INTO [dbo].[Thoi_gian_o_cua_SV]([Ten_dang_nhap_SV],[Ten_toa_nha],[Ten_phong],[Ngay_bat_dau])
					VALUES(@username,@buildingname,@roomname,CURRENT_TIMESTAMP)
	DECLARE @numofstudent INT
	SELECT @numofstudent = COUNT(*) FROM dbo.SV_o_phong WHERE Ten_toa_nha = @buildingname and Ten_phong = @roomname
	
	UPDATE dbo.Phong SET So_SV_dang_co=@numofstudent WHERE Ten_toa_nha = @buildingname and Ten_phong = @roomname
end
go
---
--select * from Phong where Ten_phong = 203 and Ten_toa_nha = 'A1'
--select * from SV_o_phong where Ten_phong = 203 and Ten_toa_nha = 'A1'
--select * from Thoi_gian_o_cua_SV where Ten_phong = 203 and Ten_toa_nha = 'A1'
--INSERT INTO [dbo].[SV_o_phong]([Ten_dang_nhap_SV],[Ten_phong],[Ten_toa_nha])
--VALUES('1111137',203,'A1')
--select * from Phong where Ten_phong = 203 and Ten_toa_nha = 'A1'
--select * from SV_o_phong where Ten_phong = 203 and Ten_toa_nha = 'A1'
--select * from Thoi_gian_o_cua_SV where Ten_phong = 203 and Ten_toa_nha = 'A1'

create TRIGGER Cap_nhat_TG_O_SV
ON SV_o_phong  instead of UPDATE 
AS
BEGIN	
	DECLARE @old_roomname NVARCHAR(30)
	SELECT @old_roomname = deleted.Ten_phong FROM deleted

	DECLARE @old_buildingname NVARCHAR(30)
	SELECT @old_buildingname = deleted.Ten_toa_nha FROM deleted

	DECLARE @old_username NVARCHAR(30)
	SELECT @old_username = deleted.Ten_dang_nhap_SV FROM deleted

	delete from Thoi_gian_o_cua_SV where Ten_toa_nha = @old_buildingname and Ten_phong = @old_roomname and Ten_dang_nhap_SV = @old_username
	delete from SV_o_phong where Ten_toa_nha = @old_buildingname and Ten_phong = @old_roomname and Ten_dang_nhap_SV = @old_username

	DECLARE @new_roomname NVARCHAR(30)
	SELECT @new_roomname = inserted.Ten_phong FROM inserted

	DECLARE @new_buildingname NVARCHAR(30)
	SELECT @new_buildingname = inserted.Ten_toa_nha FROM inserted

	DECLARE @new_username NVARCHAR(30)
	SELECT @new_username = inserted.Ten_dang_nhap_SV FROM inserted

	INSERT INTO [dbo].[SV_o_phong]([Ten_dang_nhap_SV],[Ten_phong],[Ten_toa_nha])
    VALUES(@new_username,@new_roomname,@new_buildingname)

	DECLARE @numofstudent INT
	
	SELECT @numofstudent = COUNT(*) FROM dbo.SV_o_phong WHERE Ten_toa_nha = @old_buildingname and Ten_phong = @old_roomname
	UPDATE dbo.Phong SET So_SV_dang_co=@numofstudent WHERE Ten_toa_nha = @old_buildingname and Ten_phong = @old_roomname
	
	SELECT @numofstudent = COUNT(*) FROM dbo.SV_o_phong WHERE Ten_toa_nha = @new_buildingname and Ten_phong = @new_roomname
	UPDATE dbo.Phong SET So_SV_dang_co=@numofstudent WHERE Ten_toa_nha = @new_buildingname and Ten_phong = @new_roomname
	
END
go
--select * from SV_o_phong where (Ten_phong = 203  or Ten_phong = 204) and Ten_toa_nha = 'A1'
--select * from Phong where (Ten_phong = 203  or Ten_phong = 204) and Ten_toa_nha = 'A1'
--update SV_o_phong set Ten_phong = 203 where Ten_dang_nhap_SV = '1111136' 
--select * from SV_o_phong where (Ten_phong = 203  or Ten_phong = 204) and Ten_toa_nha = 'A1'
--select * from Phong where (Ten_phong = 203  or Ten_phong = 204) and Ten_toa_nha = 'A1'


create trigger Xoa_TG_O_SV
on SV_o_phong instead of delete
as
begin
	DECLARE @roomname NVARCHAR(30)
	SELECT @roomname = deleted.Ten_phong FROM deleted

	DECLARE @buildingname NVARCHAR(30)
	SELECT @buildingname = deleted.Ten_toa_nha FROM deleted

	DECLARE @username NVARCHAR(30)
	SELECT @username = deleted.Ten_dang_nhap_SV FROM deleted
	
	delete from Thoi_gian_o_cua_SV where Ten_toa_nha = @buildingname and Ten_phong = @roomname and Ten_dang_nhap_SV = @username
	delete from SV_o_phong where Ten_toa_nha = @buildingname and Ten_phong = @roomname and Ten_dang_nhap_SV = @username
	
	DECLARE @numofstudent INT
	SELECT @numofstudent = COUNT(*) FROM dbo.SV_o_phong WHERE Ten_toa_nha = @buildingname and Ten_phong = @roomname
	
	UPDATE dbo.Phong SET So_SV_dang_co=@numofstudent WHERE Ten_toa_nha = @buildingname and Ten_phong = @roomname
end
go
--update SV_o_phong set Ten_phong = 204 where Ten_phong = 201 and Ten_toa_nha = 'A1'
--------------------
--select * from Nguoi_dung
--select * from Sinh_vien
--select * from SV_o_phong
--select * from Phong
--select * from Thoi_gian_o_cua_SV
--select * from SDT_Nguoi_dung
--select * from Email_Nguoi_dung
