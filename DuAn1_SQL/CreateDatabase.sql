USE master
GO
DROP DATABASE QL_RAPPHIM
GO

CREATE DATABASE QL_RAPPHIM
GO

USE QL_RAPPHIM
GO

CREATE TABLE [TheLoai] (
	ID INT IDENTITY(1,1) NOT NULL,
	[MaTheLoai] as cast('TL'+Cast(ID as VARCHAR(10)) as VARCHAR(10)) PERSISTED PRIMARY KEY,
	[TenTheLoai] NVARCHAR(50),
	[HIDE] BIT DEFAULT 0
);
GO

CREATE TABLE [NhanVien] (
	ID INT IDENTITY(1,1) NOT NULL,
	[MaNhanVien] as cast('NV'+Cast(ID as VARCHAR(10))as VARCHAR(10))  PERSISTED PRIMARY KEY,
	[HoTen] NVARCHAR(100),
	[SDT] VARCHAR(10),
	[GioiTinh] BIT DEFAULT 0,
	[ChucVu] BIT DEFAULT 0,
	[GhiChu] nvarchar(255),
	[MatKhau] VARCHAR(30),
	[Hinh] VARCHAR(200),
	[HIDE] BIT DEFAULT 0
);
GO

CREATE TABLE [Phim] (
	ID INT IDENTITY(1,1) NOT NULL,
	[MaPhim] as cast('MP'+Cast(ID as VARCHAR(3)) as VARCHAR(10)) PERSISTED PRIMARY KEY,
	[TenPhim] NVARCHAR(100),
	[NgayKhoiChieu] DATE,
	[NgayKetThuc] DATE,
	[QuocGia] NVARCHAR(50),
	[MaTheLoai] VARCHAR(10),
	[DinhDang] VARCHAR(10),
	[Hinh] VARCHAR(200),
	[MaNhanVien] VARCHAR(10),
	[HIDE] BIT DEFAULT 0,
	CONSTRAINT [FK_Phim.MaTheLoai] FOREIGN KEY ([MaTheLoai]) 
			REFERENCES [TheLoai]([MaTheLoai]) ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT [FK_Phim.MaNhanVien] FOREIGN KEY ([MaNhanVien]) 
			REFERENCES [NhanVien]([MaNhanVien]) ON DELETE NO ACTION ON UPDATE CASCADE
);
GO

CREATE TABLE [Phong] (
	ID INT IDENTITY(1,1) NOT NULL,
	[MaPhong] as cast('P'+Cast(ID as VARCHAR(10))as VARCHAR(10))  PERSISTED PRIMARY KEY,
	[HIDE] bit
);
GO

CREATE TABLE [LichChieu] (
	ID INT IDENTITY(1,1) NOT NULL,
	[MaLichChieu] as cast('LC'+Cast(ID as VARCHAR(10))as VARCHAR(10))  PERSISTED PRIMARY KEY,
	[NgayChieu] Date,
	[GioChieu] VARCHAR(10),
	[MaPhim] VARCHAR(10),
	[MaPhong] VARCHAR(10),
	[HIDE] BIT DEFAULT 0,
	CONSTRAINT [FK_LichChieu.MaPhim] FOREIGN KEY ([MaPhim]) 
			REFERENCES [Phim]([MaPhim]) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT [FK_LichChieu.MaPhong] FOREIGN KEY ([MaPhong]) 
			REFERENCES [Phong]([MaPhong]) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

CREATE TABLE [Ghe] (
	[MaGhe] VARCHAR(5),
	[LoaiGhe] BIT,
	[GiaGhe] FLOAT,
	[MaPhong] VARCHAR(10),
	[TrangThai] BIT DEFAULT 0,
	PRIMARY KEY ([MaGhe],[MaPhong]),
	CONSTRAINT [FK_Ghe.MaPhong] FOREIGN KEY ([MaPhong]) 
			REFERENCES [Phong]([MaPhong]) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

CREATE TABLE [KhuyenMai] (
	[MaKM] VARCHAR(50),
	[TenKM] NVARCHAR(255),--duongsua
	[ThongTinKM] NVARCHAR(255),
	[MucGiamGia] FLOAT,
	[NgayBatDau] DATE,
	[NgayKetThuc] DATE,
	[MaNhanVien] VARCHAR(10),
	[HIDE] BIT DEFAULT 0,
	PRIMARY KEY ([MaKM]),
	CONSTRAINT [FK_KhuyenMai.MaNhanVien] FOREIGN KEY ([MaNhanVien]) 
			REFERENCES [NhanVien]([MaNhanVien]) ON DELETE NO ACTION ON UPDATE CASCADE
);
GO

CREATE TABLE [KhachHangThanThiet] (
	ID INT IDENTITY(1,1) NOT NULL,
	[MaKHTT] as cast('KH'+Cast(ID as VARCHAR(10))as VARCHAR(10))  PERSISTED PRIMARY KEY,
	[Ten] NVARCHAR(50),
	[SDT] VARCHAR(10),
	[Email] VARCHAR(50),
	[NgayDK] DATE,
	[MucGiamGia] FLOAT,
	[SoLanSuDung] INT,
	[MaNhanVien] VARCHAR(10),
	[HIDE] BIT DEFAULT 0,
	CONSTRAINT [FK_KhachHangThanThiet.MaNhanVien] FOREIGN KEY ([MaNhanVien]) 
			REFERENCES [NhanVien]([MaNhanVien]) ON DELETE NO ACTION ON UPDATE CASCADE
);
GO

CREATE TABLE [HoaDon](
	ID INT IDENTITY(1,1) NOT NULL,
	[MaHoaDon]	as cast('HD'+Cast(ID as VARCHAR(10))as VARCHAR(10))  PERSISTED PRIMARY KEY,
	[TongTien] FLOAT,
	[MaKM] VARCHAR(50),
	[MaKHTT] VARCHAR(10),
	[MucGiamGia] INT,
	[ThanhTien] FLOAT,
	[NgayLap] DATE,
	[MaNhanVien] VARCHAR(10),
	[HIDE] BIT DEFAULT 0,
	CONSTRAINT [FK_HoaDon.MaKM] FOREIGN KEY ([MaKM]) 
			REFERENCES [KhuyenMai]([MaKM]) ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT [FK_HoaDon.MaKHTT] FOREIGN KEY ([MaKHTT]) 
			REFERENCES [KhachHangThanThiet]([MaKHTT]) ON DELETE NO ACTION,
	CONSTRAINT [FK_HoaDon.MaNhanVien] FOREIGN KEY ([MaNhanVien]) 
			REFERENCES [NhanVien]([MaNhanVien]) ON DELETE NO ACTION
);
GO

CREATE TABLE [Ve] (
	ID INT IDENTITY(1,1) NOT NULL,
	[MaVe] as cast('VE'+Cast(ID as VARCHAR(50))as VARCHAR(50))  PERSISTED PRIMARY KEY,
	[MaPhim] VARCHAR(10),
	[MaLichChieu] VARCHAR(10),
	[MaPhong] VARCHAR(10),
	[MaGhe] VARCHAR(5),
	CONSTRAINT [FK_Ve.MaPhim] FOREIGN KEY ([MaPhim]) 
			REFERENCES [Phim]([MaPhim]) ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT [FK_Ve.MaLichChieu] FOREIGN KEY ([MaLichChieu]) 
			REFERENCES [LichChieu]([MaLichChieu]) ON DELETE NO ACTION,
	CONSTRAINT [FK_Ve.MaPhong] FOREIGN KEY ([MaPhong]) 
			REFERENCES [Phong]([MaPhong]) ON DELETE NO ACTION ON UPDATE CASCADE,
	CONSTRAINT [FK_Ve.MaGhe] FOREIGN KEY ([MaGhe],[MaPhong]) 
			REFERENCES [Ghe]([MaGhe],[MaPhong]) ON DELETE NO ACTION
);
GO

CREATE TABLE [DichVu] (
	[MaDichVu] VARCHAR(50),
	[TenDichVu] NVARCHAR(50),
	[GiaDichVu] FLOAT,
	[HIDE] BIT DEFAULT 0,
	PRIMARY KEY ([MaDichVu])
);
GO

CREATE TABLE [HoaDonChiTiet] (
	ID INT IDENTITY(1,1) NOT NULL,
	[MaHoaDonChiTiet] as cast('HDCT'+Cast(ID as VARCHAR(10))as VARCHAR(10))  PERSISTED PRIMARY KEY ,
	[MaDichVu] VARCHAR(50),
	[MaVe] VARCHAR(50),
	[GiaTien] FLOAT,
	[SoLuong] INT,
	[ThanhTien] FLOAT,
	[MaHoaDon] VARCHAR(10),
	[HIDE] BIT DEFAULT 0,
	CONSTRAINT [FK_HoaDonChiTiet.Ve] FOREIGN KEY ([MaVe]) 
			REFERENCES [Ve]([MaVe]) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT [FK_HoaDonChiTiet.DichVu] FOREIGN KEY ([MaDichVu]) 
			REFERENCES [DichVu]([MaDichVu]) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT [FK_HoaDonChiTiet.MaHoaDon] FOREIGN KEY ([MaHoaDon]) 
			REFERENCES [HoaDon]([MaHoaDon]) ON DELETE CASCADE
);
GO
