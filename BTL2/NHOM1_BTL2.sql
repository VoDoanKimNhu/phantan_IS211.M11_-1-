riak-admin bucket-type create n_val_of_1 '{"props":{"n_val":1}}'

riak-admin bucket-type activate n_val_of_1


------------------------CONNECT
var Riak = require('basho-riak-client');
var nodes = ['192.168.235.139:8087', '192.168.235.140:8087'];

var client = new Riak.Client(nodes, function (err, c) {
    if (err) {
        throw new Error(err);
    } else {
        console.log('Connect successfully');
    }
});

------------------------bucket
var cnbucket = "chinhanh";
var khbucket = "khachhang";
var hdbucket = "hoadon";
var nvbucket = "nhanvien";
var hdsbucket = "HDSummaries";
var cnsbucket = "CNSummaries";

------------------------cnbucket
var async = require('async');
var logger = require('winston');
function checkErr(err) {
    if (err) {
        logger.error(err);
        process.exit(1);
    }
}

var chinhanh1 = [
    {
        MaCN: 'CN01',
        TenCN: 'CHI NHANH 1',
        ThanhPho: 'Ha Noi', 
    }
];

var chinhanh2 = [
    {
        MaCN: 'CN02',
        TenCN: 'CHI NHANH 2',
        ThanhPho: 'Ho Chi Minh',
    },
];
  
var storeChiNhanhFuncs = [];
chinhanh1.forEach(function (cn) {
    storeChiNhanhFuncs.push(function (async_cb) {
        client.storeValue(
            {
                bucket: cnbucket,
                key: cn.MaCN,
                value: cn,
            },
            function (err, rslt) {
              async_cb(err, rslt);
            }
        );
    });
});

chinhanh2.forEach(function (cn) {
    storeChiNhanhFuncs.push(function (async_cb) {
        client.storeValue(
            {
                bucket: cnbucket,
                key: cn.MaCN,
                value: cn,
            },
            function (err, rslt) {
              async_cb(err, rslt);
            }
        );
    });
});  

async.parallel(storeChiNhanhFuncs, function (err, rslts) {
    if (err) {
        throw new Error(err);
    }
});

------------------------nvbucket
var nhanvien1 = [
    {
        MaNV: 'NV01',
        HoTen: 'Nguyen Van Anh',
        GioiTinh: 'Nam',
        NgaySinh: '01/01/2001',
        SDT: '0946075986',
        MaCN: 'CN01',
    },
    {
        MaNV: 'NV03', 
        HoTen: 'Tran Binh Nhu',
        GioiTinh: 'Nu',
        NgaySinh: '11/08/1999',
        Sdt: '0942159862',
        MaCN: 'CN01',
    },
    {
        MaNV: 'NV04', 
        HoTen: 'Vo Duy Khang',
        GioiTinh: 'Nam',
        NgaySinh: '19/07/1998',
        Sdt: '0856429751',
        MaCN: 'CN01',
    },
];

var nhanvien2 = [
    {
        MaNV: 'NV02', 
        HoTen: 'Nguyen Thi Huong Thi',
        GioiTinh: 'Nu',
        NgaySinh: '02/09/1997',
        Sdt: '0908564782',
        MaCN: 'CN02',
    },
    {
        MaNV: 'NV05', 
        HoTen: 'Than Thu Quyen',
        GioiTinh: 'Nu',
        NgaySinh: '28/12/2000',
        Sdt: '0942568741',
        MaCN: 'CN02',
    },
];
  
var storeNhanVienFuncs = [];
nhanvien1.forEach(function (nv) {
    storeNhanVienFuncs.push(function (async_cb) {
        client.storeValue(
            {
                bucket: nvbucket,
                key: nv.MaNV,
                value: nv,
            },
            function (err, rslt) {
                async_cb(err, rslt);
            }
        );
    });
});

nhanvien2.forEach(function (nv) {
    storeNhanVienFuncs.push(function (async_cb) {
        client.storeValue(
            {
                bucket: nvbucket,
                key: nv.MaNV,
                value: nv,
            },
            function (err, rslt) {
                async_cb(err, rslt);
            }
        );
    });
  });  

async.parallel(storeNhanVienFuncs, function (err, rslts) {
    if (err) {
        throw new Error(err);
    }
});




------------------------cnsbucket
function createCNSummary1(nhanvien1){
    var CNSummary1 = {
            MaCN: 'CN01',
            NhanVien: []
    };
 
    nhanvien1.forEach(function (nv) {
        CNSummary1.NhanVien.push({
            MaNV: nv.MaNV
        })
    }); 

    var storeCNSummariesFuncs = [];
    CNSummary1.forEach(function (cns) {
        storeCNSummariesFuncs.push(function (async_cb) {
            client.storeValue(
                {
                    bucket: cnsbucket,
                    key: cns.MaCN,
                    value: cns,
                },
                function (err, rslt) {
                    async_cb(err, rslt);
                }
            );
        });
    });
    async.parallel(storeCNSummariesFuncs, function (err, rslts) {
        if (err) {
            throw new Error(err);
        }
    });  

    return CNSummary1;
}

  
function createCNSummary2(nhanvien2){
    var CNSummary2 = {
            MaCN: 'CN02',
            NhanVien: []
    };
 
    nhanvien2.forEach(function (nv) {
        CNSummary2.NhanVien.push({
            MaNV: nv.MaNV
        })
    }); 

    var storeCNSummariesFuncs = [];
    CNSummary2.forEach(function (cns) {
        storeCNSummariesFuncs.push(function (async_cb) {
            client.storeValue(
                {
                    bucket: cnsbucket,
                    key: cns.MaCN,
                    value: cns,
                },
                function (err, rslt) {
                    async_cb(err, rslt);
                }
            );
        });
    });
    async.parallel(storeCNSummariesFuncs, function (err, rslts) {
        if (err) {
            throw new Error(err);
        }
    });  
    return CNSummary2;
}

------------------------khbucket
var khachhang = [
    {
        MaKH: 'KH01',
        TenKH: 'Nguyen Thi Van Anh',
        NgaySinh: '01/02/2002',
        SDT: '0941856942',
        GioiTinh:'Nu',
        LoaiKH: 'VIP',
        DiaChi: 'Ha Tinh',
    },
    {
        MaKH: 'KH02',
        TenKH: 'Tran An Nhien',
        NgaySinh: '19/05/2002',
        SDT: '0942563254',
        GioiTinh:'Nam',
        LoaiKH: 'Binh thuong',
        DiaChi: 'Da Nang',
    },
    {
        MaKH: 'KH03',
        TenKH: 'Bui Nguyen Nguyen',
        NgaySinh: '30/01/2003',
        SDT: '0956248952',
        GioiTinh:'Nu',
        LoaiKH: 'Binh thuong',
        DiaChi: 'Ha Noi',
    },
    {
        MaKH: 'KH04',
        TenKH: 'Nguyen Tran Khanh',
        NgaySinh: '26/11/1999',
        SDT: '0987562136',
        GioiTinh:'Nam',
        LoaiKH: 'VIP',
        DiaChi: 'Ho Chi Minh',
    },
    {
        MaKH: 'KH05',
        TenKH: 'Dang Thy Thy',
        NgaySinh: '05/04/2002',
        SDT: '0946598760',
        GioiTinh:'Nam',
        LoaiKH: 'VIP',
        DiaChi: 'Ha Tinh',
    },
];

var storeKhachHangFuncs = [];
khachhang.forEach(function (kh) {
    storeKhachHangFuncs.push(function (async_cb) {
        client.storeValue(
            {
                bucket: khbucket,
                key: kh.MaKH,
                value: kh,
            },
            function (err, rslt) {
                async_cb(err, rslt);
            }
        );
    });
});

async.parallel(storeKhachHangFuncs, function (err, rslts) {
    if (err) {
        throw new Error(err);
    }
});

------------------------hdbucket
var hoadon1 = [
    {
        MaHD: 'HD01',
        MaKH: 'KH01',
        MaNV: 'NV01',
        MonAn: [
            {
                MaMA: 'MA01',
                TenMA: 'Ga kho',
                DonGia: 30000,
                SL: 1
            },
            {
                MaMA: 'MA02',
                TenMA: 'Rau xao',
                DonGia: 10000,
                SL: 2
            }
        ],
        TongTien: 50000,
        NgayHD: '2021-11-28'
    },
    {
        MaHD: 'HD02',
        MaKH: 'KH01',
        MaNV: 'NV03',
        MonAn: [
            {
                MaMA: 'MA03',
                TenMA: 'Thit nuong',
                DonGia: 30000,
                SL: 1
            },
            {
                MaMA: 'MA04',
                TenMA: 'Rau xao',
                DonGia: 10000,
                SL: 1
            }
          ],
          TongTien: 40000,
          NgayHD: '2021-12-24'
    },
    {
        MaHD: 'HD03',
        MaKH: 'KH01',
        MaNV: 'NV01',
        MonAn: [
            {
                MaMA: 'MA05',
                TenMA: 'Tra Sua',
                DonGia: 25000,
                SL: 3
            }
        ],
        TongTien: 75000,
        NgayHD: '2021-12-25'
    }   
];  

var storeHoaDonFuncs = [];
hoadon1.forEach(function (hd) {
    storeHoaDonFuncs.push(function (async_cb) {
        client.storeValue(
            {
                bucket: hdbucket,
                key: hd.MaHD,
                value: hd,
            },
            function (err, rslt) {
                async_cb(err, rslt);
            }
        );
    });
});

async.parallel(storeHoaDonFuncs, function (err, rslts) {
    if (err) {
        throw new Error(err);
    }
});

------------------------hdsbucket
function createHDSummary1(hoadon1) {
    var hdSummary = {
        MaKH : 'KH01',
        HoaDon : []
    };

    hoadon1.forEach(function (hd) {
        hdSummary.HoaDon.push({
            MaHD: hd.MaHD,
            MaNV: hd.MaNV,
            TongTien: hd.TongTien,
            NgayHD: hd.NgayHD
        });
    });

    return hdSummary;
}

var hdSum = createHDSummary1(hoadon1);

function store_HDSummary1() {
    logger.info("Storing Data");

    var storeFuncs = [
        function (async_cb) {
            client.storeValue({
                bucket: hdsbucket,
                key: hdSum.MaKH,
                value: hdSum
            }, async_cb);
        }
    ];

    async.parallel(storeFuncs, function (err, rslts) {
        checkErr(err);
    });
}
store_HDSummary1();

-- SELECT 
------------------------Fetch data nvbucket - NV01
var logger = require('winston');
var riakObj, NV02;

client.fetchValue({bucket: nvbucket, key: 'NV02', convertToJs: true },
    function (err, rslt) {
        if (err) {
            throw new Error(err);
        } else {
            riakObj = rslt.values.shift();
            if (!riakObj) {
                logger.info("Can NOT found in 'nhanvien'");
            } else {
                NV02 = riakObj.value;
                logger.info("I found %s in 'nhanvien'", NV02.MaNV);
                console.log(NV02);
            }
        }
    }
);

------------------------Fetch related data by shared key khbucket, hdsbucket
var logger = require('winston');
var riakObj, KH01, HD_KH01;

function fetch_object() {
    client.fetchValue({ bucket: khbucket, key: 'KH01', convertToJs: true },
        function (err, rslt) {
            if (err) {
                throw new Error(err);
            } else {
                riakObj = rslt.values.shift();
                if (!riakObj) {
                    logger.info("Can NOT found in 'khachhang'");
                } else {
                    KH01 = riakObj.value;
                    logger.info("I found %s in 'khachhang'", KH01.MaKH);
                    console.log(KH01);
                }
            }
        },
    );

    client.fetchValue({ bucket: hdsbucket, key: 'KH01', convertToJs: true },
        function (err, rslt) {
            if (err) {
                throw new Error(err);
            } else {
                riakObj = rslt.values.shift();
                if (!riakObj) {
                  logger.info("Can NOT found in 'HDSummaries'");
                } else {
                  HD_KH01 = riakObj.value;
                  logger.info("I found %s in 'HDSummaries'", HD_KH01.MaKH);
                  console.log(HD_KH01);
                }
            }
        },
    );
}
fetch_object();

------------------------Fetch related data by secondaryIndexQuery hdbucket---------------
-- Add index data
function add_index_data() {
    var funcs = [
        function(async_cb){
            client.fetchValue({ bucket: hdbucket, key : 'HD01' }, function (err, rslt) {
                var fetchedOrderObj = rslt.values.shift();
                fetchedOrderObj.addToIndex('MNV_bin', 'NV01');
                fetchedOrderObj.addToIndex('ngayhoadon_bin', '2021-11-28');
                client.storeValue({ value: fetchedOrderObj }, function (err, rslt) {
                    async_cb(err, rslt);
                });
            });
        },
        function(async_cb){
            client.fetchValue({ bucket: hdbucket, key : 'HD02' }, function (err, rslt) {
                var fetchedOrderObj = rslt.values.shift();
                fetchedOrderObj.addToIndex('MNV_bin', 'NV03');
                fetchedOrderObj.addToIndex('ngayhoadon_bin', '2021-12-24');
                client.storeValue({ value: fetchedOrderObj }, function (err, rslt) {
                    async_cb(err, rslt);
                });
            });
        },
        function(async_cb){
            client.fetchValue({ bucket: hdbucket, key : 'HD03' }, function (err, rslt) {
                var fetchedOrderObj = rslt.values.shift();
                fetchedOrderObj.addToIndex('MNV_bin', 'NV01');
                fetchedOrderObj.addToIndex('ngayhoadon_bin', '2021-12-25');
                client.storeValue({ value: fetchedOrderObj }, function (err, rslt) {
                    async_cb(err, rslt);
                });
            });
        }
    ];

    async.parallel(funcs, function (err, rslts) {
        checkErr(err);
        index_queries();
    });
}

function index_queries() {
    var hd_nv01 = [];
    client.secondaryIndexQuery({ bucket: hdbucket, indexName: 'MNV_bin', indexKey: 'NV01' }, function (err, rslt) {
        checkErr(err);
        if (rslt.values.length > 0) {
            Array.prototype.push.apply(hd_nv01,
                    rslt.values.map(function (value) {
                        return value.objectKey;
                })
            );
        }
        if(rslt.done){
            logger.info("Hoa don do NV01 thanh toan: %s", hd_nv01.join(', '));
        }
    });

    var hd_m12 = [];
    client.secondaryIndexQuery({ bucket: hdbucket, indexName: 'ngayhoadon_bin', rangeStart: '2021-12-01', rangeEnd: '2021-12-31' }, function (err, rslt) {
        checkErr(err);
        if (rslt.values.length > 0) {
            Array.prototype.push.apply(hd_m12,
                    rslt.values.map(function (value) {
                        return value.objectKey;
                })
            );
        }
        if(rslt.done){
            logger.info("Hoa don trong thang 12: %s", hd_m12.join(', '));
        }
        
    });
    return hd_nv01;
}

  
 add_index_data();

 
-- UPDATE 
------------------------Update hoten nvbucket - NV01
NV01.HoTen = 'Co Quan';
riakObj.setValue(NV01);

client.storeValue({ value: riakObj }, function (err, rslt) {
    if (err) {
        throw new Error(err);
    }
});

-- Fetch data nvbucket - NV01
var logger = require('winston');
var riakObj, NV01;

client.fetchValue({ bucket: nvbucket, key: 'NV01', convertToJs: true },
    function (err, rslt) {
        if (err) {
            throw new Error(err);
        } else {
            riakObj = rslt.values.shift();
            if (!riakObj) {
                logger.info("Can NOT found in 'nhanvien'");
            } else {
                NV01 = riakObj.value;
                logger.info("I found %s in 'nhanvien'", NV01.MaNV);
                console.log(NV01);
            }
        }
    }
);

------------------------Update diachi khbucket - KH01
KH01.DiaChi = 'Ha Noi';
riakObj.setValue(KH01);

client.storeValue({ value: riakObj }, function (err, rslt) {
    if (err) {
        throw new Error(err);
    }
});

-- Fetch data khbucket - KH01
var logger = require('winston');
var riakObj, KH01;

client.fetchValue({ bucket: khbucket, key: 'KH01', convertToJs: true },
    function (err, rslt) {
        if (err) {
            throw new Error(err);
        } else {
            riakObj = rslt.values.shift();
            if (!riakObj) {
                logger.info("Can NOT found in 'khachhang'");
            } else {
                KH01 = riakObj.value;
                logger.info("I found %s in 'khachhang'", KH01.MaKH);
                console.log(KH01);
            }
        }
    }
);

-- DELETE 
------------------------Delete nvbucket - NV02
client.deleteValue({ bucket: nvbucket, key: 'NV02' }, function (err, rslt) {
    if (err) {
        throw new Error(err);
    }
});

-- Đọc lại KH01 để kiểm tra - 2 Máy
var logger = require('winston');
var riakObj, NV02;

client.fetchValue({ bucket: nvbucket, key: 'NV02', convertToJs: true },
    function (err, rslt) {
        if (err) {
            throw new Error(err);
        } else {
            riakObj = rslt.values.shift();
            if (!riakObj) {
                logger.info("Can NOT found in 'nhanvien'");
            } else {
                NV02 = riakObj.value;
                logger.info("I found %s in 'nhanvien'", NV02.MaNV);
                console.log(NV02);
            }
        }
    }
);

------------------------Fetch data khbucket - KH01
var logger = require('winston');
var riakObj, KH01;

client.fetchValue({bucket: khbucket, key: 'KH01', convertToJs: true },
    function (err, rslt) {
        if (err) {
            throw new Error(err);
        } else {
            riakObj = rslt.values.shift();
            if (!riakObj) {
                logger.info("Can NOT found in 'khachhang'");
            } else {
                KH01 = riakObj.value;
                logger.info("I found %s in 'khachhang'", KH01.MaKH);
                console.log(KH01);
            }
        }
    }
);
bucketType:'n_val_of_1',


------------------------Delete date khbucket - KH02
client.deleteValue({ bucket: khbucket, key: 'KH02' }, function (err, rslt) {
    if (err) {
        throw new Error(err);
    }
});

var logger = require('winston');
var riakObj, KH02;

client.fetchValue({ bucket: khbucket, key: 'KH02', convertToJs: true },
    function (err, rslt) {
        if (err) {
            throw new Error(err);
        } else {
            riakObj = rslt.values.shift();
            if (!riakObj) {
                logger.info("Can NOT found in 'khachhang'");
            } else {
                KH02 = riakObj.value;
                logger.info("I found %s in 'khachhang'", KH02.MaKH);
                console.log(KH02);
            }
        }
    }
);



-- INSERT 
------------------------insert khbucket - KH06
var khachhang_i = [
    {
        MaKH: 'KH06',
        TenKH: 'Nguyen Anh',
        NgaySinh: '01/02/2000',
        SDT: '0941856942',
        GioiTinh:'Nu',
        LoaiKH: '',
        DiaChi: 'Ho Chi Minh',
    },
];

var storeKhachHangFuncs = [];
khachhang_i.forEach(function (kh) {
    storeKhachHangFuncs.push(function (async_cb) {
        client.storeValue(
            {
                bucket: khbucket,
                key: kh.MaKH,
                value: kh,
            },
            function (err, rslt) {
                async_cb(err, rslt);
            }
        );
    });
});

async.parallel(storeKhachHangFuncs, function (err, rslts) {
    if (err) {
        throw new Error(err);
    }
});




    











