using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QLKTX1.DTO;
namespace QLKTX1.DAO
{
    class RoomDAO
    {
        private static RoomDAO instance;

        public static RoomDAO Instance
        {
            get { if (instance == null) instance = new RoomDAO(); return RoomDAO.instance; }
            private set { RoomDAO.instance = value; }
        }

        public static int RoomWidth = 90;
        public static int RoomHeight = 90;
        public bool SwitchRoom(string phong1, string phong2, string toa)
        {
           int result = DataProvider.Instance.ExecuteNonQuery("SwitchRoom @phong1 , @phong2 , @toa1 , @toa2", new object[] { phong1, phong2 , toa, toa });
            return result > 0;
        }

        private RoomDAO() { }


        public DataTable Load_Building(string username)
        {
            DataTable data = DataProvider.Instance.ExecuteQuery("select * from load_toa_nha(" + username + ")");
            return data;
        }
        public DataTable LoadRoomType(string phong, string toa)
        {
            DataTable data = DataProvider.Instance.ExecuteQuery("select * from load_tinh_trang_phong(" + phong +",'" + toa + "')");
            return data;
        }
        public DataTable LoadRoomByType(string type, string toa)
        {
            DataTable data = DataProvider.Instance.ExecuteQuery("select * from load_cb_phong(N'" + type +"','" +toa+ "')");
            return data;
        }
        public List<Room> LoadRoomList(string toanha)
        {
            List<Room> RoomList = new List<Room>();

            DataTable data = DataProvider.Instance.ExecuteQuery("select * from load_phong_trong_toa_nha('"+toanha+"')");

            foreach (DataRow item in data.Rows)
            {
                Room Room = new Room(item);
                RoomList.Add(Room);
            }

            return RoomList;
        }
        public List<Students> LoadRoomMember(string phong, string toa)
        {
            List<Students> StudentsList = new List<Students>();

            DataTable data = DataProvider.Instance.ExecuteQuery("select * from select_sv_in("+phong+",'"+ toa +"')");

            foreach (DataRow item in data.Rows)
            {
                Students students = new Students(item);
                StudentsList.Add(students);
            }

            return StudentsList;
        }
    }
}
