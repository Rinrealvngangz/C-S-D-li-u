/*Học phần: Cơ sở dữ liệu
Giảng viên: Tạ Thị Thu Phượng
Ngày: 18/05/2020
Người thực hiện: Nguyễn Mậu Tuấn
MSSV: 1812866*/

create database Lab08_Quanlysinhvien
use Lab08_Quanlysinhvien

go
create table KHOA
(MSKhoa nchar(2) primary key,
TenKhoa nvarchar(30) not null unique,
TenTat nchar(4) not null unique)

go
create table Lop
(MSLop nchar(4) primary key,
TenLop nvarchar(30) not null unique,
MSKhoa nchar(2) references KHOA(MSKhoa),
NienKhoa nchar(4) not null)

go
create table Tinh
(MSTinh nchar(2) primary key,
TenTinh nvarchar(20) not null unique)

go
create table MonHoc
(MSMH nchar(4) primary key,
TenMH nvarchar(30) not null,
HeSo tinyint not null)

go
create table SinhVien
(MSSV nchar(7) primary key,
Ho nvarchar(20) not null,
Ten nchar(10) not null,
NgaySinh date not null,
MSTinh nchar(2) references TINH(MSTinh),
NgayNhapHoc date not null,
MSLop nchar(4) references LOP(MSLop),
Phai char(4) not null,
DiaChi nvarchar(30) not null,
DienThoai nchar(10))


create table SinhVienTinh
(MSSV nchar(7) primary key,
Ho nvarchar(20) not null,
Ten nchar(10) not null,
NgaySinh date not null,
MSTinh nchar(2) references TINH(MSTinh),
NgayNhapHoc date not null,
MSLop nchar(4) references LOP(MSLop),
Phai char(4) not null,
DiaChi nvarchar(30) not null,
DienThoai nchar(10),
HBong int)

go
create table BANGDIEM
(MSSV nchar(7) foreign key references SinhVien(MSSV),
MSMH nchar(4) foreign key references MonHoc(MSMH),
LanThi tinyint not null,
Diem float not null,
primary key (MSSV, MSMH, LanThi))

Insert into KHOA Values('1','Cong nghe thong tin','CNTT')
Insert into KHOA Values('2','Dien tu vien thong','DTVT')
Insert into KHOA Values('3','Quan tri kinh doanh','QTKD')
Insert into KHOA Values('4','Cong nghe sinh hoc','CNSH')

Insert into Lop Values('98TH','Tin hoc khoa 1998','1','1998')
Insert into Lop Values('98VT','Vien thong khoa 1998','2','1998')
Insert into Lop Values('99QT','Quan tri khoa 1999','3','1999')
Insert into Lop Values('99TH','Tin hoc khoa 1999','1','1999')
Insert into Lop Values('99VT','Vien thong khoa 1999','2','1999')

Insert into Tinh Values('01','An Giang')
Insert into Tinh Values('02','TPHCM')
Insert into Tinh Values('03','Dong Nai')
Insert into Tinh Values('04','Long An')
Insert into Tinh Values('05','Hue')
Insert into Tinh Values('06','Ca Mau')

Insert into MonHoc Values('QA01','Kinh te vi mo','2')
Insert into MonHoc Values('QA02','Quan tri chat luong','3')
Insert into MonHoc Values('TA01','Nhap mon tin hoc','2')
Insert into MonHoc Values('TA02','Lap trinh co ban','3')
Insert into MonHoc Values('TB01','Cau truc du lieu','2')
Insert into MonHoc Values('TB02','Co so du lieu','2')
Insert into MonHoc Values('VA01','Dien tu co ban','2')
Insert into MonHoc Values('VA02','Mach so','3')
Insert into MonHoc Values('VB01','Truyen so lieu','3')
Insert into MonHoc Values('XA01','Vat ly dai cuong','2')

Insert into SinhVien Values('98TH001','Nguyen Van','An','8/6/1980','01','9/3/1998','98TH','YES','12 Tran Hung Dao, Q.1','8234512')
Insert into SinhVien Values('98TH002','Le Thi','An','10/17/1979','01','9/3/1998','98TH','NO','23 CMT8, Q.Tan Binh','0303234342')
Insert into SinhVien Values('98VT001','Nguyen Duc','Bình','11/25/1981','02','9/3/1998','98VT','YES','245 Lac Long Quan, Q.11','8654323')
Insert into SinhVien Values('98VT002','Tran Ngoc','Anh','8/19/1980','02','9/3/1998','98VT','NO','242 Tran Hung Dao, Q.1','')
Insert into SinhVien Values('99QT001','Nguyen Thi','Oanh','8/19/1973','04','10/5/1999','99QT','YES','76 Hung Vuong, Q.5','0901656324')
Insert into SinhVien Values('99QT002','Le My','Hanh','5/20/1976','04','10/5/1999','99QT','NO','12 Pham Ngoc Thach, Q.3','')
Insert into SinhVien Values('99TH001','Ly Van Hung','Dung','9/27/1981','03','10/5/1999','99TH','YES','178 CMT8, Q. Tân Bình','7563213')
Insert into SinhVien Values('99TH002','Van Minh','Hoang','1/1/1981','04','10/5/1999','99TH','YES','272 Ly Thuong Kiet, Q.10','8341234')
Insert into SinhVien Values('99TH003','Nguyen','Tuan','1/12/1980','03','10/5/1999','99TH','YES','162 Tran Hung Dao, Q.5','')
Insert into SinhVien Values('99TH004','Tran Van','Minh','6/25/1981','04','10/5/1999','99TH','YES','147 Dien Bien Phu, Q.3','7236754')
Insert into SinhVien Values('99TH005','Nguyen Thai','Minh','1/1/1980','04','10/5/1999','99TH','YES','345 Le Dai Hanh, Q.11','')
Insert into SinhVien Values('99VT001','Le Ngoc','Mai','6/21/1982','01','10/5/1999','99VT','NO','129 Tran Hung Dao, Q.1','0903124534')


Insert into SinhVienTinh Values('98TH001','Nguyen Van','An','8/6/1980','01','9/3/1998','98TH','YES','12 Tran Hung Dao, Q.1','8234512',null)
Insert into SinhVienTinh Values('98TH002','Le Thi','An','10/17/1979','01','9/3/1998','98TH','NO','23 CMT8, Q.Tan Binh','0303234342',null)
Insert into SinhVienTinh Values('99QT001','Nguyen Thi','Oanh','8/19/1973','04','10/5/1999','99QT','YES','76 Hung Vuong, Q.5','0901656324',null)
Insert into SinhVienTinh Values('99QT002','Le My','Hanh','5/20/1976','04','10/5/1999','99QT','NO','12 Pham Ngoc Thach, Q.3','',null)
Insert into SinhVienTinh Values('99TH001','Ly Van Hung','Dung','9/27/1981','03','10/5/1999','99TH','YES','178 CMT8, Q. Tân Bình','7563213',null)
Insert into SinhVienTinh Values('99TH002','Van Minh','Hoang','1/1/1981','04','10/5/1999','99TH','YES','272 Ly Thuong Kiet, Q.10','8341234',null)
Insert into SinhVienTinh Values('99TH003','Nguyen','Tuan','1/12/1980','03','10/5/1999','99TH','YES','162 Tran Hung Dao, Q.5','',null)
Insert into SinhVienTinh Values('99TH004','Tran Van','Minh','6/25/1981','04','10/5/1999','99TH','YES','147 Dien Bien Phu, Q.3','7236754',null)
Insert into SinhVienTinh Values('99TH005','Nguyen Thai','Minh','1/1/1980','04','10/5/1999','99TH','YES','345 Le Dai Hanh, Q.11','',null)
Insert into SinhVienTinh Values('99VT001','Le Ngoc','Mai','6/21/1982','01','10/5/1999','99VT','NO','129 Tran Hung Dao, Q.1','0903124534',null)


Insert into BANGDIEM Values('98TH001','TA01','1','8.5')
Insert into BANGDIEM Values('98TH001','TA02','1','8')
Insert into BANGDIEM Values('98TH001','TB01','1','7')
Insert into BANGDIEM Values('98TH002','TA01','1','4')
Insert into BANGDIEM Values('98TH002','TA01','2','5.5')
Insert into BANGDIEM Values('98TH002','TB01','1','7.5')
Insert into BANGDIEM Values('98VT001','VA01','1','4')
Insert into BANGDIEM Values('98VT001','VA01','2','5')
Insert into BANGDIEM Values('98VT002','VA02','1','7.5')
Insert into BANGDIEM Values('99QT001','QA01','1','7')
Insert into BANGDIEM Values('99QT001','QA02','1','6.5')
Insert into BANGDIEM Values('99QT002','QA01','1','8.5')
Insert into BANGDIEM Values('99QT002','QA02','1','9')
Insert into BANGDIEM Values('99TH001','TA01','1','4')
Insert into BANGDIEM Values('99TH001','TA01','2','6')
Insert into BANGDIEM Values('99TH001','TB01','1','6.5')
Insert into BANGDIEM Values('99TH002','TB01','1','10')
Insert into BANGDIEM Values('99TH002','TB02','1','9')
Insert into BANGDIEM Values('99TH003','TA02','1','7.5')
Insert into BANGDIEM Values('99TH003','TB01','1','3')
Insert into BANGDIEM Values('99TH003','TB01','2','6')
Insert into BANGDIEM Values('99TH003','TB02','1','8')
Insert into BANGDIEM Values('99TH004','TB02','1','2')
Insert into BANGDIEM Values('99TH004','TB02','2','4')
Insert into BANGDIEM Values('99TH004','TB02','3','3')

select *
from KHOA

select *
from Lop

select *
from Tinh

select *
from MonHoc

select *
from SinhVien

select *
from BANGDIEM

/*Liệt kê MSSV, Họ, Tên, Địa chỉ của tất cả các sinh viên*/
select A.MSSV ,A.Ho,A.Ten,A.DiaChi,A.DiaChi
from SinhVien A


--Liệt kê MSSV, Họ, Tên, MS Tỉnh của tất cả các sinh viên. Sắp xếp kết quả theo MS
--tỉnh, trong cùng tỉnh sắp xếp theo họ tên của sinh viên.

select A.MSSV ,A.Ho,A.Ten,A.MSTinh
from SinhVien A
order by A.MSTinh ,A.Ten,A.Ho


--Liệt kê các sinh viên nữ của tỉnh Long An


select *
from SinhVien A 
Where A.Phai =0 and A.MSTinh ='04'


--Liệt kê các sinh viên có sinh nhật trong tháng giêng.
select *
from SinhVien A 
Where Month(A.NgaySinh ) =1

 --Liệt kê các sinh viên có sinh nhật nhằm ngày 1/1.

 select *
from SinhVien A 
Where Month(A.NgaySinh ) =1 and Day (A.NgaySinh) =1

-- Liệt kê các sinh viên có số điện thoại.


 select *
from SinhVien A 
Where A.DienThoai Not in( select A.DienThoai
from SinhVien A 
Where A.DienThoai ='')

--Liệt kê các sinh viên có số điện thoại di động.

 select *
from SinhVien A 
Where A.DienThoai LIKE '0%' and A.DienThoai Not in( select A.DienThoai
from SinhVien A 
Where   A.DienThoai ='')

--Liệt kê các sinh viên tên ‘Minh’ học lớp ’99TH’

select *
from SinhVien A 
Where A.Ten ='Minh' and A.MSLop ='99TH'


-- Liệt kê các sinh viên có địa chỉ ở đường ‘Tran Hung Dao’

select *
from SinhVien A 
Where A.DiaChi LIKE '%Tran Hung Dao%'

-- Liệt kê các sinh viên có tên lót chữ ‘Van’ (không liệt kê người họ ‘Van’)

select *
from SinhVien A 
Where A.Ho LIKE '%Van%' and A.Ten not in (select A.Ten
from SinhVien A 
Where A.Ho LIKE 'V%')

-- Liệt kê MSSV, Họ Ten (ghép họ và tên thành một cột), Tuổi của các sinh viên ở tỉnh Long An

select A.Ho+' '+ A.Ten as HovaTen, A.MSSV , YEAR(GETDATE())-YEAR(A.NgaySinh)as Tuoi 
from SinhVien A 
Where A.MSTinh ='04'

--Liệt kê các sinh viên nam từ 23 đến 28 tuổi.
select * ,YEAR(GETDATE())-YEAR(A.NgaySinh)as Tuoi
from SinhVien A 
Where A.Phai =1 and YEAR(GETDATE())-YEAR(A.NgaySinh) >23 and YEAR(GETDATE())-YEAR(A.NgaySinh) <28 


-- Liệt kê các sinh viên nam từ 32 tuổi trở lên và các sinh viên nữ từ 27 tuổi trở lên

select * ,YEAR(GETDATE())-YEAR(A.NgaySinh)as Tuoi
from SinhVien A 
Where A.Phai =1 and  YEAR(GETDATE())-YEAR(A.NgaySinh) >32 or A.Phai =0 and  YEAR(GETDATE())-YEAR(A.NgaySinh) >=27

-- Liệt kê các sinh viên khi nhập học còn dưới 18 tuổi, hoặc đã trên 25 tuổi.

select * ,YEAR(GETDATE())-YEAR(A.NgaySinh)as Tuoi
from SinhVien A 
Where YEAR(YEAR(A.NgayNhapHoc)-YEAR(A.NgaySinh)) <18 or YEAR(YEAR(A.NgayNhapHoc)-YEAR(A.NgaySinh)) >25

-- Liệt kê danh sách các sinh viên của khóa 99 (MSSV có 2 ký tự đầu là ‘99’).

select * 
from SinhVien A 
Where   YEAR(A.NgayNhapHoc) LIKE '%99' and A.MSSV LIKE '99%'

-- Liệt kê MSSV, Điểm thi lần 1 môn ‘Co so du lieu’ của lớp ’99TH’


select * , c.TenMH
from SinhVien A ,BANGDIEM B ,MonHoc C
Where  A.MSSV =B.MSSV and B.MSMH =C.MSMH and B.LanThi='1' and A.MSLop ='99TH'and C.MSMH in(
select C.MSMH 
from BANGDIEM B ,MonHoc C
Where   B.MSMH =C.MSMH and C.MSMH ='TB02'
) 

--Liệt kê MSSV, Họ tên của các sinh viên lớp ’99TH’ thi không đạt lần 1 môn ‘Co so du lieu’
select * , c.TenMH
from SinhVien A ,BANGDIEM B ,MonHoc C
Where  A.MSSV =B.MSSV and B.MSMH =C.MSMH and B.LanThi='2' or  B.LanThi='3' and A.MSLop ='99TH'and C.MSMH in(
select C.MSMH 
from BANGDIEM B ,MonHoc C
Where   B.MSMH =C.MSMH and C.MSMH ='TB02'
)

--Liệt kê tất cả các điểm thi của sinh viên có mã số ’99TH001’ theo mẫu sau

select C.MSMH ,C.TenMH,B.LanThi,B.Diem
from SinhVien A ,BANGDIEM B ,MonHoc C
Where  A.MSSV =B.MSSV and  B.MSMH =C.MSMH and  B.MSSV LIKE '%TH001'

-- Liệt kê MSSV, họ tên, MSLop của các sinh viên có điểm thi lần 1 môn ‘Co so du lieu’ từ 8 điểm trở lên

select A.MSSV ,A.Ho+''+A.Ten as HoTen ,A.MSLop
from SinhVien A ,BANGDIEM B ,MonHoc C
Where  A.MSSV =B.MSSV and B.MSMH =C.MSMH and B.LanThi='1' and  B.Diem >=8 and C.MSMH in(
select C.MSMH 
from BANGDIEM B ,MonHoc C
Where   B.MSMH =C.MSMH and C.MSMH ='TB02'
)
-- Liệt kê các tỉnh không có sinh viên theo học

select *
from Tinh B
Where    B.MSTinh not in (select A.MSTinh
from SinhVien A
)

--Liệt kê các sinh viên hiện chưa có điểm môn thi nào

select *
from SinhVien A 
Where A.MSSV  not in (select A.MSSV
from SinhVien A , BANGDIEM B
Where A.MSSV = B.MSSV
)


--Truy vấn gom nhóm
-- Thống kê số lượng sinh viên ở mỗi lớp theo mẫu sau: MSLop, TenLop, SoLuongSV 

select  A.MSLop ,B.TenLop, Count (A.MSSV) as SoluongSV
from SinhVien A ,Lop B
Group by A.MSLop ,B.TenLop

--Thống kê số lượng sinh viên ở mỗi tỉnh theo mẫu sau:

--MSTinh Tên Tỉnh Số SV Nam Số SV Nữ Tổng cộng

select A.MSTinh,C.TenTinh,'So sinh viên nam'=SUM(case Phai when 'YES' then 1 else 0 end),
'So sinh viên nữ'=SUM(case Phai when 'NO' then 1 else 0 end) , Count(A.MSSV) as TongCong
from SinhVien A, Tinh C
where A.MSTinh =C.MSTinh
group by A.MSTinh,C.TenTinh

--Thống kê kết quả thi lần 1 môn ‘Co so du lieu’ ở các lớp, theo mẫu sau

--MSLop TenLop Số SV đạt Tỉ lệ đạt (%) Số SV không đạt Tỉ lệ không đạt

select A.MSLop,C.TenLop,'So sinh viên dat '=sum(case B.LanThi when '1' then 1 else 0 end),
'Ti le  dat (%)'=SUM(case B.LanThi when '1' then 1 else 0 end)*100 /Count(A.MSSV),
'So sinh vien khong dat'=count(A.MSSV)-SUM(case B.LanThi when '1' then 1 else 0 end),
'Ti le khong dat (%)'=100-SUM(case B.LanThi when '1' then 1 else 0 end)*100 /Count(A.MSSV)
from SinhVien A, BANGDIEM B,Lop C
where A.MSLop = C.MSLop and A.MSSV =B.MSSV and B.MSMH ='TB02'
group by A.MSLop,C.TenLop
--Lọc ra điểm cao nhất trong các lần thi cho các sinh viên theo mẫu sau (điểm in ra của
--mỗi môn là điểm cao nhất trong các lần thi của môn đó):
--MSSV MSMH Tên MH Hệ số Điểm Điểm x hệ số
select A.MSSV,B.MSMH,C.TenMH,C.HeSo,Max( B.Diem)as Diem
from SinhVien A, BANGDIEM B,MonHoc C
where A.MSSV =B.MSSV and B.MSMH =C.MSMH
group by A.MSSV,B.MSMH,C.TenMH,C.HeSo

--MSSV Họ Tên ĐTB
--Điểm trung bình (ĐTB) = Tổng (điểm x hệ số)/Tổng hệ số

select A.MSSV,A.Ho +''+A.Ten 'Ho ten',SUM( (B.Diem)*C.HeSo)/Sum(C.HeSo) as DTB
from SinhVien A, BANGDIEM B,MonHoc C
where A.MSSV =B.MSSV and B.MSMH =C.MSMH
group by A.MSSV,A.Ho,A.Ten
--Thống kê số lượng sinh viên tỉnh ‘Long An’ đang theo học ở các khoa, theo mẫu sau:

--Năm học MSKhoa TenKhoa Số lượng SV

select C.NienKhoa 'Nien khoa' , B.MSKhoa,B.TenKhoa ,count (A.MSSV) as 'So luong Sv'
from SinhVien A, KHOA B,Lop C
where B.MSKhoa =C.MSKhoa and A.MSLop =C.MSLop
group by C.NienKhoa,B.MSKhoa,B.TenKhoa

--Thủ tục hàm
--Nhập vào MSSV, in ra bảng điểm của sinh viên đó theo mẫu sau (điểm in ra lấy điểm
--cao nhất trong các lần thi):
--MSMH Tên MH Hệ số Điểm
create PROC  InbangDiemSinhVienMAX
@mssv nvarchar(7)
as
select B.MSMH,B.TenMH,MAX(C.Diem),B.HeSo
from  SinhVien A, MonHoc B,BANGDIEM C
where A.MSSV=C.MSSV and B.MSMH=C.MSMH and A.MSSV=@mssv
Group by B.MSMH,B.TenMH,B.HeSo
go
exec InbangDiemSinhVienMAX '98VT001'

--Nhập vào MS lớp, in ra bảng tổng kết của lớp đó, theo mẫu sau:
--MSSV Họ Tên ĐTB Xếp loại

create PROC  InbangDiemTB_SinhVien_TheoLop
@msLop nvarchar(4)
as
select A.MSSV,A.Ho+''+A.Ten 'Họ Tên',SUM( (B.Diem)*C.HeSo)/Sum(C.HeSo) as DTB
from  SinhVien A,BANGDIEM B,MonHoc C
where A.MSSV=B.MSSV and B.MSMH=C.MSMH and A.MSLop=@msLop
Group by A.MSSV,A.Ho,A.Ten

exec InbangDiemTB_SinhVien_TheoLop '99TH'


--Tạo bảng SinhVienTinh trong đó chứa hồ sơ của các sinh viên (lấy từ table SinhVien)
--có quê quán không phải ở TPHCM. Thêm thuộc tính HBONG (học bổng) cho table SinhVienTinh.
select *from SinhVienTinh

--31)Cập nhật thuộc tính HBONG trong table SinhVienThanh 10000 cho tất cả các sinh viên.

update SinhVienTinh set HBong =10000

--Tăng HBONG lên 10% cho các sinh viên nữ.
update SinhVienTinh set HBong=10100 Where Phai='NO'
--Xóa tất cả các sinh viên có quê quán ở Long An ra khỏi table SinhVienTinh.
Delete SinhVienTinh where MSTinh='04'