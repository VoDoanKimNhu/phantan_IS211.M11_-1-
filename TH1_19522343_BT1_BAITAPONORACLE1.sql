--Cau 1:Tao user BAITHI1 gom 4 table XE,TUYEN,KHACH,VEXE va khoa chinh--
create table BAITHI1.XE
(
    MAXE varchar2(4),
    BIENKS varchar2(9),
    MATUYEN varchar2(4),
    SOGHET1 number,
    SOGHET2 number,
    CONSTRAINT pk_XE primary key (MAXE)
);

create table BAITHI1.TUYEN
(
    MATUYEN varchar2(4),
    BENDAU varchar2(2),
    BENCUOI varchar(10),
    GIATUYEN number,
    NGXB date,
    TGDK varchar(2),
    CONSTRAINT pk_TUYEN PRIMARY KEY (MATUYEN) 
);

create table BAITHI1.KHACH
(
    MAHK varchar2(4),
    HOTEN varchar2(50),
    GIOITINH varchar2(5),
    CMND varchar2(12),
    CONSTRAINT pk_KHACH primary key (MAHK)
);

create table BAITHI1.VEXE
(
    MATUYEN varchar2(4),
    MAHK varchar2(4),
    NGMUA date,
    GIAVE number,
    CONSTRAINT pk_VEXE PRIMARY KEY (MATUYEN,MAHK,NGMUA)
);

ALTER SESSION SET NLS_DATE_FORMAT =' DD/MM/YYYY HH24:MI:SS ';
--Cau 2: Nhap du lieu--
INSERT INTO BAITHI1.XE VALUES ('X01','52LD-4393','T11A',20,20);
INSERT INTO BAITHI1.XE VALUES ('X02','59LD-7247','T32D',36,36);
INSERT INTO BAITHI1.XE VALUES ('X03','55LD-6850','T06F',15,15);

INSERT INTO BAITHI1.TUYEN VALUES ('T11A','SG','DL',210000,'26/12/2016',6);
INSERT INTO BAITHI1.TUYEN VALUES ('T32D','PT','SG',120000,'30/12/2016',4);
INSERT INTO BAITHI1.TUYEN VALUES ('T06F','NT','DNG',225000,'02/01/2017',7);

INSERT INTO BAITHI1.KHACH VALUES ('KH01','Lam Van Ben','Nam','655615896');
INSERT INTO BAITHI1.KHACH VALUES ('KH02','Duong Thi Luc','Nu','275648642');
INSERT INTO BAITHI1.KHACH VALUES ('KH03','Hoang Thanh Tung','Nam','456889143');

INSERT INTO BAITHI1.VEXE VALUES ('T11A','KH01','20/12/2016',210000);
INSERT INTO BAITHI1.VEXE VALUES ('T32D','KH02','25/12/2016',144000);
INSERT INTO BAITHI1.VEXE VALUES ('T06F','KH03','30/12/2016',270000);
--Cau 3:Tuyen co TGDK > 5 luon co gia ve > 200000
ALTER TABLE BAITHI1.TUYEN
ADD CONSTRAINT check_tgdk_gv CHECK (((TGDK>5)AND(GIATUYEN>200000))OR(TGDK<=5));
--Cau 5:Tim tat ca nhung ve xe mua trong thang 12, sap xep giam dan theo gia ve
SELECT * FROM BAITHI1.VEXE 
WHERE extract(month from NGMUA)=12 
order by GIAVE desc;
--Cau 6:Tim tuyen xe co so ve it nhat trong nam 2016--
SELECT DISTINCT MATUYEN FROM BAITHI1.VEXE
WHERE EXTRACT(YEAR FROM NGMUA)=2016
GROUP BY MATUYEN 
HAVING COUNT(MATUYEN) <= ALL(SELECT COUNT(MATUYEN)
                             FROM BAITHI1.VEXE 
                             WHERE EXTRACT(YEAR FROM NGMUA)=2016
                             GROUP BY MATUYEN);
--Cau 7:Tim tuyen xe co ca hanh khach nam va hanh khach nu mua ve--
SELECT a.MATUYEN FROM BAITHI1.VEXE a,BAITHI1.KHACH b
WHERE GIOITINH ='Nam' AND a.MAHK=b.MAHK
intersect 
SELECT a.MATUYEN FROM BAITHI1.VEXE a,BAITHI1.KHACH b
WHERE GIOITINH='Nu' AND a.MAHK=b.MAHK;
--Cau 8: Tim hanh khach nu da tung mua ve tat ca cac chuyen xe
SELECT * FROM BAITHI1.KHACH a
WHERE NOT EXISTS (SELECT * 
                  FROM BAITHI1.TUYEN b WHERE NOT EXISTS (SELECT * 
                                               FROM BAITHI1.VEXE c
                                               WHERE a.MAHK=c.MAHK
                                               AND c.MATUYEN=b.MATUYEN));
                                        
