using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QLKTX1.DAO;
using QLKTX1.DTO;
using System.Data;


namespace QLKTX1.DAO
{
    class StudentsDAO
    {
        private static StudentsDAO instance;
        public static StudentsDAO Instance
        {
            get { if (instance == null) instance = new StudentsDAO(); return StudentsDAO.instance; }
            private set { StudentsDAO.instance = value; }
        }
        private StudentsDAO() { }

        public List<Students> GetStudentByUS(string username)
        {
            List<Students> list = new List<Students>();
            string query = "select * from dbo.Students WHERE UserName = N'" +username + "'" ;
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                Students student = new Students(item);
                list.Add(student);
            }
            return list;
        }
        public List<Students> GetListStudents(string toa)
        {
            List<Students> list = new List<Students>();
            string query = "select * from select_sv('"+toa+"')";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                Students student = new Students(item);
                list.Add(student);
            }
            return list;
        }
        public bool InsertStudent(string tendangnhap, string hovatendem, string ten, string ngaysinh, string cmnd, string gioitinh, string quanhuyen, string tinh, string MSSV, string truong, int SVNam, string phong, string toanha)
        {
            string query = "exec INS_SV @username , @ho_ten_dem , @ten , @ngaysinh , @CMND , @gioi_tinh , @quan_huyen , @tinh_tp , @MSSV , @truong , @namthu , @ten_phong , @ten_toa_nha";

            int result = DataProvider.Instance.ExecuteNonQuery(query, new object[] { tendangnhap, hovatendem, ten, ngaysinh, cmnd, gioitinh, quanhuyen, tinh, MSSV, truong, SVNam, phong , toanha });

            return result > 0;
        }
        public bool EditStudent(string username, string name, string room, string dob, string mssv, string school, string phone, string homeland, string sex, string mail, string nationality, int th)
        {
            string query1 = string.Format("SELECT COUNT(*) FROM dbo.Students WHERE UserName =N'" + username + "'");
            DataTable result1 = DataProvider.Instance.ExecuteQuery(query1);
            string s = "";
            if (result1.Rows.Count > 0)
                for (int i = 0; i < result1.Rows.Count; i++)
                    s = result1.Rows[0]["Column1"].ToString();
            if (string.Compare(s, "0") == 0)
            {
                string query2 = string.Format("SELECT dbo.Room.RoomStatus FROM dbo.Room WHERE RoomName = N'" + room + "'");
                DataTable result2 = DataProvider.Instance.ExecuteQuery(query2);
                string str = "";
                if (result2.Rows.Count > 0)
                    for (int i = 0; i < result2.Rows.Count; i++)
                        str = result2.Rows[0]["RoomStatus"].ToString();
                if (string.Compare(str, "Đầy") == 0)           
                    return false;              
                else
                {
                    string query = string.Format("INSERT dbo.Students ( UserName, name, Room, DoB, MSSV,School, Phone,  HomeLAnd,Sex, Mail, Nationality, TH) VALUES  ( N'{0}', N'{1}', N'{2}', {3}, N'{4}', N'{5}', N'{6}', N'{7}', N'{8}', N'{9}', N'{10}',{11})", username, name, room, dob, mssv, school, phone, homeland, sex, mail, nationality, th);
                    int result = DataProvider.Instance.ExecuteNonQuery(query);
                    return result > 0;
                }
            }
            else
            {
                string query = string.Format("UPDATE dbo.Students SET name = N'{0}', Room = N'{1}',MSSV = N'{2}', School = N'{3}', Phone = N'{4}', HomeLAnd = N'{5}', Sex =N'{6}', Mail=N'{7}', Nationality=N'{8}', TH=N'{9}', DoB={10}  WHERE dbo.Students.UserName = N'{11}'", name,room,mssv,school,phone,homeland,sex,mail,nationality,th,dob,username);
                int result = DataProvider.Instance.ExecuteNonQuery(query);
                return result > 0;
            }
        }
        public bool UpdateStudent(string username, string name, string mssv, string phone, string school, string homeland, string sex, string mail, string natinonality, DateTime? dob,int th)
        {
            string query = string.Format("UPDATE dbo.Students set  name = {0}, DoB = {1}, MSSV={2}, School = {3}, Phone = {4}, HomeLAnd={5}, Sex ={6}, Mail = {7}, Nationality ={8}, TH={10}  WHERE UserName = {9}", name, dob,mssv,school,phone,homeland,sex,mail,natinonality,username,th);
            int result = DataProvider.Instance.ExecuteNonQuery(query);
            return result > 0;
        }

        public bool DeleteStudent(string tdn, string toa, string phong)
        {
            string query = "exec Xoa_SV_ra_khoi_phong @tdn , @toa , @phong";
            int result = DataProvider.Instance.ExecuteNonQuery(query, new object[] { tdn, toa, phong });
            return result > 0;
        }
    }
}
