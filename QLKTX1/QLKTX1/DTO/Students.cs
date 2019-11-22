using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLKTX1.DTO
{
    public class Students
    {
       public Students(string tendangnhap, string mssv, string truong, int namthu, string hotendem, string ten, DateTime? ngaysinh, string cmnd, string gioitinh, string quanhuyen, string tinhtp, string tenphong, string tentoanha, string sdt, string email)
        {
            this.Tendangnhap = tendangnhap;
            this.Mssv = mssv;
            this.Truong = truong;
            this.Namthu = namthu;
            this.Hotendem = hotendem;
            this.Ten = ten;
            this.Ngaysinh = ngaysinh;
            this.CMND = cmnd;
            this.Gioitinh = gioitinh;
            this.Quanhuyen = quanhuyen;
            this.Tinhtp = tinhtp;
            this.Tenphong = tenphong;
            this.Tentoanha = tentoanha;
            this.Sdt = sdt;
            this.Email = email;
        }
        public Students(DataRow row)
        {
            this.Tendangnhap = row["Ten_dang_nhap"].ToString();
            this.Mssv = row["MSSV"].ToString();
            this.Truong = row["Truong"].ToString();
            this.Namthu = (int)row["Nam_thu"];
            this.Hotendem = row["Ho_ten_dem"].ToString();
            this.Ten = row["Ten"].ToString();
            this.Gioitinh = row["Gioi_tinh"].ToString();
            this.Ngaysinh = (DateTime?)row["Ngay_sinh"];
            this.CMND = row["CMND"].ToString();
            this.Quanhuyen = row["Quan_Huyen"].ToString();
            this.Tinhtp = row["Tinh_TP"].ToString();
            this.Tenphong = row["Ten_phong"].ToString();
            this.Tentoanha = row["Ten_toa_nha"].ToString();
            this.Sdt = row["SDT"].ToString();
            this.Email = row["Email"].ToString();
        }
        private string tendangnhap;
        private string mssv;
        private string truong;
        private int namthu;
        private string hotendem;
        private string ten;
        private DateTime? ngaysinh;
        private string cMND;
        private string gioitinh;
        private string quanhuyen;
        private string tinhtp;
        private string tenphong;
        private string tentoanha;
        private string sdt;
        private string email;
        public string Tendangnhap { get => tendangnhap; set => tendangnhap = value; }
        public string Mssv { get => mssv; set => mssv = value; }
        public string Truong { get => truong; set => truong = value; }
        public int Namthu { get => namthu; set => namthu = value; }
        public string Hotendem { get => hotendem; set => hotendem = value; }
        public string Ten { get => ten; set => ten = value; }
        public DateTime? Ngaysinh { get => ngaysinh; set => ngaysinh = value; }
        public string CMND { get => cMND; set => cMND = value; }
        public string Gioitinh { get => gioitinh; set => gioitinh = value; }
        public string Quanhuyen { get => quanhuyen; set => quanhuyen = value; }
        public string Tinhtp { get => tinhtp; set => tinhtp = value; }
        public string Tenphong { get => tenphong; set => tenphong = value; }
        public string Tentoanha { get => tentoanha; set => tentoanha = value; }
        public string Sdt { get => sdt; set => sdt = value; }
        public string Email { get => email; set => email = value; }
    }
}
