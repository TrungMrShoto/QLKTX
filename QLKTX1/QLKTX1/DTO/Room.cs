using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
namespace QLKTX1.DTO
{
    public class Room
    {
        public Room(string tenphong,string tentoanha, int num, string loaiphong, string tinhtrang)
        {
            this.Tenphong = tenphong;
            this.Tentoanha = tentoanha;
            this.Sosvdangco = num;
            this.Loaiphong = loaiphong;
            this.Tinhtrang = tinhtrang;
        }
        public Room(DataRow row)
        {
            this.Tenphong = row["Ten_phong"].ToString();
            this.Tentoanha = row["Ten_toa_nha"].ToString();
            this.Sosvdangco = (int)row["So_SV_dang_co"];
            this.Loaiphong = row["Loai_phong"].ToString();
            this.Tinhtrang = row["Tinh_trang"].ToString();
        }
        private string tenphong;
        private string tentoanha;
        private string loaiphong;
        private int sosvdangco;
        private string tinhtrang;

        public string Tenphong { get => tenphong; set => tenphong = value; }
        public string Tentoanha { get => tentoanha; set => tentoanha = value; }
        public int Sosvdangco { get => sosvdangco; set => sosvdangco = value; }
        public string Loaiphong { get => loaiphong; set => loaiphong = value; }
        public string Tinhtrang { get => tinhtrang; set => tinhtrang = value; }
    }
}
