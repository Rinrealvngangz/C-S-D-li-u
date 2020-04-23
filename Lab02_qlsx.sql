
CREATE DATABASE Lab02_Quanly_SX
go
use Lab02_Quanly_SX

--ToSanXuat(MaTSX, TenTSX)
create table  ToSanXuat
(MaTSX char (5) primary key,
  TenTSX nvarchar (5)
)
--CongNhan(MACN, Ho, Ten, Phai, NgaySinh, MaTSX)
go
create table CongNhan
(	MACN char (5) primary key,
   Ho nvarchar(20),
   Ten nvarchar(20),
   Phai nvarchar(4) ,
   NgaySinh datetime,
   MaTSX char (5) references ToSanXuat(MaTSX)
)


--SanPham(MaSP, TenSP, DVT, TienCong)
go
create table SanPham

(MaSP char(5) primary key, 
TenSP nvarchar(20),
DVT nvarchar(5) ,
TienCong smallint)

--ThanhPham(MACN, MaSP, Ngay, SoLuong)
go
create table ThanhPham
(MACN char(5) references CongNhan(MACN),
MaSP char(5)  references SanPham(MASP),
Ngay datetime,
Soluong tinyint,
primary key(MACN,MASP,Ngay)
)
--xem cac bang
select * from  CongNhan
select * from  ToSanXuat
select * from  SanPham
select * from  ThanhPham


--nhap du lieu cho bang ToSX

insert into ToSanXuat values('TS01',N'Tổ 1')
insert into ToSanXuat values( 'TS02',N'Tổ 2')

--xem bang ToSX
select * from  ToSanXuat

--nhap du lieu cho bang Cong Nhan
set dateformat dmy
go
insert into CongNhan values('CN001',N'Nguyễn Trường', N'An',N'Nam',' 12/05/1981','TS01')
insert into CongNhan values('CN002', N'Lê Thị Hồng' ,N'Gấm', N'Nữ', '04/06/1980','TS01')
insert into CongNhan values('CN003', N'Nguyễn Công', N'Thành' ,N'Nam','04/05/1981','TS02')
insert into CongNhan values('CN004', N'Võ Hữu', N'Hạnh', N'Nam', '15/02/1980', 'TS02')
insert into CongNhan values('CN005', N'Lý Thanh', 'Hân', N'Nữ', '03/12/1981', 'TS01')
--xem bang cong nhan
select * from  CongNhan


----nhap du lieu cho bang SanPham

insert into SanPham values('SP001', N'Nồi đất', N'cái', 10000)
insert into SanPham values('SP002', N'Chén', N'cái', 2000)
insert into SanPham values('SP003', N'Bình gốm nhỏ', N'cái', 20000)
insert into SanPham values('SP004', N'Bình gốm lớn', N'cái', 25000)

--xem bang SanPham
select * from  SanPham

set dateformat dmy
go
----nhap du lieu cho bang ThanhPham
insert into ThanhPham values('CN001', 'SP001','01/02/2007', '10')
insert into ThanhPham values('CN002','SP001', '01/02/2007', '5')
insert into ThanhPham values('CN003', 'SP002' ,'10/01/2007', '50')
insert into ThanhPham values('CN004', 'SP003', '12/01/2007' ,'10')
insert into ThanhPham values('CN005', 'SP002', '12/01/2007' ,'100')
insert into ThanhPham values('CN002', 'SP004', '13/02/2007' ,'10')
insert into ThanhPham values('CN001', 'SP003', '14/02/2007', '15')
insert into ThanhPham values('CN003','SP001', '15/01/2007', '20')
insert into ThanhPham values('CN003', 'SP004', '14/02/2007', '15')
insert into ThanhPham values('CN004', 'SP002', '30/01/2007', '100')
insert into ThanhPham values('CN005', 'SP003', '01/02/2007', '50')
insert into ThanhPham values('CN001', 'SP001','20/02/2007', '30')
--xem bang Thanh Pham
select * from  ThanhPham



--Q1:Liệt kê các công nhân theo tổ sản xuất gồm các thông tin: TenTSX, HoTen,
--NgaySinh, Phai (xếp thứ tự tăng dần của tên tổ sản xuất, Tên của công nhân).

select  A.TenTSX,B.Ho+' '+B.Ten as HoTen, B.NgaySinh,B.Phai
from  ToSanXuat A ,CongNhan B
order by A.TenTSX, B.Ten

--Q2:Liệt kê các thành phẩm mà công nhân ‘Nguyễn Trường An’ đã làm được gồm
--các thông tin: TenSP, Ngay, SoLuong, ThanhTien (xếp theo thứ tự tăng dần
--của ngày).
select A.TenSP, B.Soluong,A.TienCong as ThanhTien,B.Ngay
from CongNhan C  ,SanPham A,ThanhPham B ,ToSanXuat D
where D.MaTSX =C.MaTSX and  A.MaSP=B.MaSP and C.MACN =B.MACN and  Ten = 'An'

--Q3:Liệt kê các nhân viên không sản xuất sản phẩm ‘Bình gốm lớn’.
select A.MaCN , A.Ho+' '+A.Ten as HoTen
from CongNhan A,ToSanXuat B 
where A.MaTSX=B.MaTSX and A.MACN NOT IN (select A.MACN
							from  CongNhan A  , SanPham B, ThanhPham C
							where A.MACN =C.MACN and C.MaSP=B.MaSP and C.MaSP ='SP004') 
--Q4 :Liệt kê thông tin các công nhân có sản xuất cả ‘Nồi đất’ và ‘Bình gốm nhỏ’.

select Distinct A.MaCN , A.Ho+' '+A.Ten as HoTen
from  CongNhan A  ,SanPham C,ThanhPham D
where A.MaCN =D.MACN and D.MaSP =C.MaSP and D.MaSP='SP001' and A.MACN IN
						(select A.MACN
						from  CongNhan A  ,SanPham C,ThanhPham D
						where A.MaCN =D.MACN and D.MaSP =C.MaSP and C.MaSP='SP003')

--Q5 :Thống kê Số luợng công nhân theo từng tổ sản xuất.
select  A.MaTSX , Count(A.MACN) as Soluong
from ToSanXuat C, CongNhan A 
where   A.MaTSX = C.MaTSX
Group by  A.MaTSX
--Q6 : Tổng số lượng thành phẩm theo từng loại mà mỗi nhân viên làm được (Ho,
--Ten, TenSP, TongSLThanhPham, TongThanhTien).

select A.Ho+' '+ A.Ten as HoTen,C.TenSP  ,SUM(B.Soluong) as ThanhPham,SUM(C.TienCong) as TongThanhTien
from CongNhan A , ThanhPham B,SanPham C
where A.MACN=B.MACN and B.MaSP =C.MaSP 
group by A.Ten ,A.Ho ,C.TenSP

--Q7 :Tổng số tiền công đã trả cho công nhân trong tháng 1 năm 2007

select sum(B.TienCong) as TongTienThang1
from CongNhan A ,SanPham B,ThanhPham C
where A.MACN =C.MACN and B.MaSP=C.MaSP and MONTH(C.Ngay) = 1 and YEAR(C.Ngay)=2007
--group by  C.Soluong, B.TienCong
--Q8: Cho biết sản phẩm được sản xuất nhiều nhất trong tháng 2/2007

select C.TenSP,B.Soluong
from CongNhan A , ThanhPham B,SanPham C
where A.MACN=B.MACN and B.MaSP =C.MaSP  and  MONTH(B.Ngay) = 2 and YEAR(B.Ngay)=2007
group by C.TenSP ,B.Soluong
having B.Soluong >=All (select MAX(B.Soluong)
from CongNhan A , ThanhPham B,SanPham C
where A.MACN=B.MACN and B.MaSP =C.MaSP  and  MONTH(B.Ngay) = 2 and YEAR(B.Ngay)=2007)

--Q9:Cho biết công nhân sản xuất được nhiều ‘Chén’ nhất.

select A.Ho+' '+A.Ten as HoTen ,B.Soluong
from CongNhan A , ThanhPham B,SanPham C
where A.MACN=B.MACN and B.MaSP =C.MaSP and C.MaSP ='SP002'
group by A.Ten,A.Ho, B.Soluong
having B.Soluong >=All ( select MAX(B.Soluong)
from CongNhan A , ThanhPham B,SanPham C
where A.MACN=B.MACN and B.MaSP =C.MaSP and C.MaSP ='SP002'
)
--Q10 : Tiền công tháng 2/2006 của công nhân viên có mã số ‘CN002’

--chen data
insert into ThanhPham values('CN002','SP001', '01/02/2006', '5')
select * from ThanhPham

select A.Ten ,Sum(C.TienCong)*B.Soluong as TienCong
from  CongNhan A , ThanhPham B,SanPham C
where  A.MACN=B.MACN and B.MaSP =C.MaSP  and  A.MACN='CN002'  and YEAR(B.Ngay)=2006 
group by A.Ten ,B.Soluong

--Q11:Liệt kê các công nhân có sản xuất từ 3 loại sản phẩm trở lên.

select  A.Ho+' '+A.Ten as HoTen
from  CongNhan A , ThanhPham B,SanPham C
where  A.MACN=B.MACN and B.MaSP =C.MaSP 
group by A.Ho,A.Ten
having count(B.MaSP) >=3

--Q12: Cập nhật giá tiền công của các loại bình gốm thêm 1000.
update SanPham 
set  TienCong =TienCong+1000
where   MaSP ='SP003'

update SanPham 
set  TienCong =TienCong+1000
where  MaSP ='SP004'

select *from SanPham

--Q13:Thêm bộ <’CN006’, ‘Lê Thị’, ‘Lan’, ‘Nữ’,’TS02’ > vào bảng CongNhan.
set dateformat dmy
go
insert into CongNhan values('CN006', N'Lê Thị', N'Lan', N'Nữ','03/06/2000','TS02')

select * from CongNhan