
create Database Lab06_QLHocVien
go

use  Lab06_QLHocVien

go

create table CaHoc
(
  Ca tinyint primary key,
  GioBatDau DateTime,
  GioKetThuc DateTime

)

create table GiaoVien
(
  MSGV  char(4) primary key,
  HoGV Nvarchar(20),
  TenGV Nvarchar(20),
  DienThoai varchar(11)

)

create table Lop
(
  MaLop  char(4) primary key,
  TenLop Nvarchar(20),
  NgayKG DateTime,
  HocPhi int ,
  Ca     tinyint references CaHoc(Ca), 
  SoTiet int,
  SoHV   int,
  MSGV   char(4) references GiaoVien(MSGV)
)


create table HocVien
(
  MSHV  char(4) primary key,
  Ho Nvarchar(20),
  Ten Nvarchar(20),
  NgaySinh DateTime ,
  Phai     nvarchar(4), 
  MaLop char(4) references Lop(MaLop)
)
drop table  HocPhi
create table HocPhi
(
  SoBL  char(6) primary key,
  MSHV char(4) references HocVien(MSHV) ,
  NgayThu DateTime,
  SoTien int ,
  NoiDung  nvarchar(50), 
  NguoiThu nvarchar(30),
)

select * from CaHoc
select * from GiaoVien
select * from Lop
select * from HocVien
select * from HocPhi

--XÂY DỰNG CÁC THỦ TỤC NHẬP DỮ LIỆU--

create proc usp_ThemCaHoc
@Ca tinyint,@GioBatDau DateTime,@GioKetThuc DateTime 
as
  
     if exists(select * from CaHoc where Ca=@Ca)
			print N'Đã có ca Học ' +@Ca+N'trong CSDL!'
	 else
		 begin
			 insert into CaHoc values(@Ca,@GioBatDau,@GioKetThuc) 
		 end
go

exec usp_ThemCaHoc 1,'7:30','10:45'
exec usp_ThemCaHoc 2,'13:30','16:45'
exec usp_ThemCaHoc  3,'17:30','20:45'

create proc usp_ThemGiaoVien

 @MSGV char(4),@HoGV Nvarchar(20),@TenGV Nvarchar(20),@DienThoai varchar(11)
 as
  if exists(select * from GiaoVien where MSGV = @MSGV)
      print N'Đã có giáo viên có mã số ' +@msgv+ N' trong CSDL!'
	  else
	     begin
		    	 insert into GiaoVien values(@MSGV,@HoGV,@TenGV,@DienThoai)
				 print N'Thêm Giao Viên Thành công'
		 end
go
exec usp_ThemGiaoVien 'G001',N'Lê Hoàng',N'Anh', '858936'
exec usp_ThemGiaoVien 'G002',N'Nguyễn Ngọc',N'Lan', '845623'
exec usp_ThemGiaoVien 'G003',N'Trần Minh',N'Hùng', '823456'
exec usp_ThemGiaoVien 'G004',N'Võ Thanh',N'Trung', '841256'

create proc usp_ThemLopHoc
 @MaLop  char(4),
  @TenLop Nvarchar(20),
  @NgayKG DateTime,
  @HocPhi int ,
  @Ca     tinyint, 
  @SoTiet int,
  @SoHV   int,
  @MSGV   char(4)
  as
     if exists (Select * from CaHoc where Ca =@Ca) and exists (Select * from GiaoVien where MSGV =@MSGV)
	      
		     if exists (Select * from Lop where MaLop =@Malop)
			       print N'Đã có lớp '+ @MaLop +' trong CSDL!'
		   else
		        begin
				  insert into Lop values(@MaLop, @TenLop, @NgayKG, @HocPhi, @Ca, @SoTiet, @SoHV, @MSGV)
				end
     else
	      if not exists (Select * from CaHoc where Ca =@Ca)
		     print N'Không có ca học '+@Ca+' trong CSDL.'
			 else
			 print N'Không có ca học '+@MSGV+' trong CSDL.'

set dateformat dmy
go
exec usp_ThemLopHoc 'A075',N'Access 2-4-6','18/12/2008', 150000,3,60,3,'G003'
exec usp_ThemLopHoc 'E114',N'Excel 3-5-7','02/01/2008', 120000,1,45,3,'G003'
exec usp_ThemLopHoc 'A115',N'Excel 2-4-6','22/01/2008', 120000,3,45,0,'G001'
exec usp_ThemLopHoc 'W123',N'Word 2-4-6','18/02/2008', 100000,3,30,1,'G001'
exec usp_ThemLopHoc 'W124',N'Word 3-5-7','01/03/2008', 100000,1,30,0,'G002'

drop proc usp_ThemHocVien
create proc usp_ThemHocVien
 @MSHV  char(4),
  @Ho Nvarchar(20),
  @Ten Nvarchar(20),
@NgaySinh Datetime, @Phai nvarchar(4), @MaLop char(4)
As
	If exists(select * from Lop where MaLop = @MaLop) --kiểm tra có RBTV khóa ngoại
	  Begin
		if exists(select * from HocVien where MSHV = @MSHV) --kiểm tra có trùng khóa chính (MAHV) 
			print N'Đã có mã số học viên này trong CSDL!'
		else
			begin
				insert into HocVien values(@MSHV,@Ho, @Ten,@NgaySinh,@Phai,@MaLop)
				print N'Thêm học viên thành công.'
			end
	  End
	Else
		print N'Lớp '+ @MaLop + N' không tồn tại trong CSDL nên không thể thêm học viên vào lớp này!'
		
go

set dateformat dmy
go
exec usp_ThemHocVien '0001',N'Lê Văn', N'Minh', '10/06/1988',N'Nam', 'A075'
exec usp_ThemHocVien '0002',N'Nguyễn Thị', N'Mai', '20/04/1988',N'Nữ', 'A075'
exec usp_ThemHocVien '0003',N'Lê Ngọc', N'Tuấn', '10/06/1984',N'Nam', 'A075'
exec usp_ThemHocVien '0004',N'Vương Tuấn', N'Vũ', '25/03/1979',N'Nam', 'E114'
exec usp_ThemHocVien '0005',N'Lý Ngọc', N'Hân', '01/12/1985',N'Nữ', 'E114'
exec usp_ThemHocVien '0006',N'Trần Mai', N'Linh', '04/06/1980',N'Nữ', 'E114'
exec usp_ThemHocVien '0007',N'Nguyễn Ngọc', N'Tuyết', '12/05/1986',N'Nữ', 'W123'

----------------------------
drop proc usp_ThemHocPhi
create PROC usp_ThemHocPhi

@SoBL char(6),
@MSHV char(4),
@NgayThu Datetime,
@SoTien	int,
@NoiDung nvarchar(50),
@NguoiThu nvarchar(30)
As
	If exists(select * from HocVien where MSHV = @MSHV) --kiểm tra có RBTV khóa ngoại
	  Begin
		if exists(select * from HocPhi where SoBL = @SoBL) --kiểm tra có trùng khóa(SoBL) 
			print N'Đã có số biên lai học phí này trong CSDL!'
		else
		 begin
			insert into HocPhi values(@SoBL,@MSHV,@NgayThu, @SoTien, @NoiDung,@NguoiThu)
			print N'Thêm biên lai học phí thành công.'
		 end
	  End
	Else
		print N'Học viên '+ @MSHV + N' không tồn tại trong CSDL nên không thể thêm biên lai học phí của học viên này!'
go
----goi thuc hien thu tuc usp_ThemHocPhi-------
set dateformat dmy
go
exec usp_ThemHocPhi 'A07501','0001','16/12/2008',150000,'HP Access 2-4-6', N'Lan'
exec usp_ThemHocPhi 'A07502','0002','16/12/2008',100000,'HP Access 2-4-6', N'Lan'
exec usp_ThemHocPhi 'A07503','0003','18/12/2008',150000,'HP Access 2-4-6', N'Vân'
exec usp_ThemHocPhi 'A07504','0002','15/01/2009',50000,'HP Access 2-4-6', N'Vân'
exec usp_ThemHocPhi 'E11401','0004','02/01/2008',120000,'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocPhi 'E11402','0005','02/01/2008',120000,'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocPhi 'E11403','0006','02/01/2008',80000,'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocPhi 'W12301','0007','18/02/2008',100000,'HP Word 2-4-6', N'Lan'

------------------CÀI ĐẶT RÀNG BUỘC TOÀN VẸN----------------
/*4a) Giờ kết thúc của một ca học không được trước giờ bắt đầu ca học đó 
(RBTV liên thuộc tính)*/

create trigger tr_Ca_inser_update_GiBD_GiKT

on CaHoc for insert, update

as
  if UPDATE(GioBatDau) or UPDATE(GioKetThuc)
       if exists (Select * from inserted i where i.GioBatDau > i.GioKetThuc)
	   begin
	        raiserror(N'Giờ kết thúc ca học không thể nhỏ hơn giờ bắt đầu',15,1)
			rollback tran
	      end
go
--insert into CaHoc values(4,'17:00','15:30')
--Update CaHoc set GioKetThuc = '5:45' where ca 

/* 4b): Số học viên của 1 lớp không quá 30 và đúng bằng số học viên thuộc lớp đó. 
(RBTV do thuộc tính tổng hợp)*/

create trigger HV_Koqua_BaMuoi_bangSoHV
on Lop for insert , update
as
if UPDATE(MaLop) or UPDATE(SoHV)
 begin
if exists (select * from inserted i where i.SoHV > 30 )

   begin
      raiserror (N'So Hoc vien Khong duoc lon hon 30',15,1)
	  rollback tran
	   end
	  if exists ( select * from inserted l where l.SoHV <>
	  (select count(MSHV) from HocVien where HocVien.MaLop = l.MaLop ))
   begin
      raiserror (N'Số học viên của một lớp không bằng số lượng học viên tại lớp đó',15,1)
	  rollback tran
	   end
End

select * from Lop
Set dateformat dmy
go
insert into Lop values('P001',N'Photoshop','1/11/2018',250000,1,100,0,'G004')

update Lop set SoHV = 1 where MaLop = 'P001'

/*4b): Cài đặt trigger cho bảng HocVien*/   
create trigger tg_SiSo2
on HocVien for delete
as
if exists (select * from deleted)
	begin
		declare @MaLop char(4)
		set @MaLop = (select MaLop from deleted)
		update Lop
		set SoHV = SoHV - 1
		where MaLop = @MaLop
	end
go
select * from HocVien
select * from Lop
delete HocVien where MSHV ='0008'

drop trigger insert_HV_siso
create trigger insert_HV_siso

on HocVien for insert
as
if UPDATE(MaLop)
   if exists ( select * from inserted )
      begin
	       declare @MaLop char(4)
		   set  @MaLop = (Select MaLop from inserted )
		   update Lop
		     set SoHV =SoHV+1
			 where MaLop =@MaLop
	  end
	  go 
	  select * from Lop
exec usp_ThemHocVien '0008',N'Nguyễn Mậu', N'Tuấn', '03/06/1988',N'Nam', 'P001'

create trigger tg_SiSo4
on HocVien for update
as
if UPDATE (MaLop)
	if exists(select * from inserted)
		begin
			declare @MaLopMoi char(4)
			declare @MaLopCu char(4)
			set @MaLopCu = (select MaLop from deleted)
			set @MaLopMoi = (select MaLop from inserted)
			update Lop
			set SoHV = SoHV + 1
			where MaLop = @MaLopMoi
			update Lop
			set SoHV = SoHV - 1
			where MaLop = @MaLopCu
		end
update HocVien set MaLop ='W124' where MSHV = '0008'
select * from Lop
select * from HocVien
create function HP_Thu_HV( @MSHV char (4)) returns int

as
  begin 
        declare @HocPhi int
		set @HocPhi = (select HocPhi from HocVien v ,Lop l where l.MaLop = v.MaLop and v.MSHV =@MSHV)
		return @HocPhi
end
print dbo.HP_Thu_HV('0006')

create trigger SoTien_KoVuotQua_SoTienLopHoc

on HocPhi for insert ,update

 as
  if exists (select * from HocPhi hp group by MSHV having sum(hp.SoTien) > dbo.HP_Thu_HV(MSHV))
    begin
	      raiserror(N'Tổng số tiền thu của một học viên không vượt quá học phí của lớp mà học viên theo học',15,1)  
	   rollback tran
	end
select * from HocPhi
select * from Lop
select * from HocVien
--update HocPhi set SoTien = 50000 where MSHV ='0002'
drop function fn_TongSoTienThu_Lop
create function fn_TongSoTienThu_Lop(@MaLop char (4)) returns int

as 
begin
if exists ( select * from Lop where MaLop = @MaLop)
   declare @TongTien int

   set @TongTien = (select sum(hp.SoTien) from HocVien v , HocPhi hp where v.MSHV =hp.MSHV and MaLop =@MaLop  )
   return @TongTien
 end

print dbo.fn_TongSoTienThu_Lop('A075')
 
create function fn_TongSoTienThu_HV(@MSHV char (4)) returns bit

as 
begin
if exists ( select * from HocVien where MSHV = @MSHV)
  begin declare @kq bit
   declare @soTien int 
  set  @soTien =(select sum(SoTien) from HocPhi   where MSHV =@MSHV )   
   if (@soTien =  dbo.HP_Thu_HV(@MSHV)) 
   set @kq = 1
	else
	set @kq =0
	end
	return @kq 
 end

 print dbo.fn_TongSoTienThu_HV('0001')
  
create function SinhMaGV() returns char(4)
As
Begin
	declare @MaxMaGV char(4)
	declare @NewMaGV varchar(4)
	declare @stt	int
	declare @i	int	
	declare @sokyso	int

	if exists(select * from GiaoVien)---Nếu bảng giáo viên có dữ liệu
	 begin
		--Lấy mã giáo viên lớn nhất hiện có
		select @MaxMaGV = max(MSGV) 
		from GiaoVien
		--Trích phần ký số của mã lớn nhất và chuyển thành số 
		set @stt=convert(int, right(@MaxMaGV,3)) + 1 --Số thứ tự của giáo viên mới
	 end
	else--Nếu bảng giáo viên đang rỗng (nghĩa là chưa có giáo viên nào được lưu trữ trong CSDL.
	 set @stt= 1 -- Số thứ tự của giáo viên trong trường hợp chưa có gv nào trong CSDL
	--Kiểm tra và bổ sung chữ số 0 để đủ 3 ký số trong mã gv.
	set @sokyso = len(convert(varchar(3), @stt))
	set @NewMaGV='G'
	set @i = 0
	while @i < 3 -@sokyso
		begin
			set @NewMaGV = @NewMaGV + '0'
			set @i = @i + 1
		end	
	set @NewMaGV = @NewMaGV + convert(varchar(3), @stt)

return @NewMaGV	
End
--Thử hàm sinh mã
print dbo.SinhMaGV()
----2. Thủ  tục thêm giáo viên với mã giáo viên được sinh tự động----
CREATE PROC usp_ThemGiaoVien2
@hogv nvarchar(20), @tengv nvarchar(10), @dthoai varchar(10)
As
	declare @Magv char(4)
	
 if not exists(select * from GiaoVien 
				where HoGV = @hogv and TenGV = @tengv and DienThoai = @dthoai)
	Begin
		
		--sinh mã cho giáo viên mới
		set @Magv = dbo.SinhMaGV()
		insert into GiaoVien values(@Magv, @hogv, @tengv,@dthoai)
		print N'Đã thêm giáo viên thành công'
	End
else
	print N'Đã có giáo viên ' + @hogv +' ' + @tengv + ' trong CSDL'
Go
---Sử dụng thủ tục thêm giáo viên
exec usp_ThemGiaoVien2 N'Trần Ngọc Bảo', N'Hân', '0123456789'
exec usp_ThemGiaoVien2 N'Vũ Minh', N'Triết', '0123456788'
select * from GiaoVien
