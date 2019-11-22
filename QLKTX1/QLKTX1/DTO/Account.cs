using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLKTX1.DTO
{
    public class Account
    {
        public Account(string userName, string type,string ho, string ten, DateTime? dob, long cmnd, string sex, string huyen, string tinh,string tinhtrang, string password = null)
        {
            this.UserName = userName;
            this.Hovatendem = ho;
            this.Type = type;
            this.Ten = ten;
            this.Ngaysinh = dob;
            this.Cmnd = cmnd;
            this.Sex = sex;
            this.Quanhuyen = huyen;
            this.Tinh = tinh;
            this.Tinhtrang = tinhtrang;
            this.Password = password;
        }

        public Account(DataRow row)
        {
            this.UserName = row["Ten_dang_nhap"].ToString();
            this.Hovatendem = row["Ho_ten_dem"].ToString();
            this.Type = row["Nguoi_dung"].ToString();
            this.Ten = row["Ten"].ToString();
            this.Ngaysinh = (DateTime?)row["Ngay_sinh"];
            this.Cmnd = (long)row["CMND"];
            this.Sex = row["Gioi_tinh"].ToString();
            this.Quanhuyen = row["Quan_Huyen"].ToString();
            this.Tinh = row["Tinh_TP"].ToString();
            this.Tinhtrang = row["Tinh_trang"].ToString();
            this.Password = row["Mat_khau"].ToString();
        }

        private string type;

        public string Type
        {
            get { return type; }
            set { type = value; }
        }

        private string password;

        public string Password
        {
            get { return password; }
            set { password = value; }
        }

        private string hovatendem;

        public string Hovatendem
        {
            get { return hovatendem; }
            set { hovatendem = value; }
        }

        private string ten;

        public string Ten
        {
            get { return ten; }
            set { ten = value; }
        }
        private string userName;

        public string UserName
        {
            get { return userName; }
            set { userName = value; }
        }
        private DateTime? ngaysinh;

        public DateTime? Ngaysinh
        {
            get { return ngaysinh; }
            set { ngaysinh = value; }
        }
        private long cmnd;

        public long Cmnd
        {
            get { return cmnd; }
            set { cmnd = value; }
        }
        private string sex;

        public string Sex
        {
            get { return sex; }
            set { sex = value; }
        }
        private string quanhuyen;

        public string Quanhuyen
        {
            get { return quanhuyen; }
            set { quanhuyen = value; }
        }
        private string tinh;

        public string Tinh
        {
            get { return tinh; }
            set { tinh = value; }
        }
        private string tinhtrang;

        public string Tinhtrang
        {
            get { return tinhtrang; }
            set { tinhtrang = value; }
        }
    }
}
