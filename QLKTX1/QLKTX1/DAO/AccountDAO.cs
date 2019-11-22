using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QLKTX1.DTO;
using System.Data;

namespace QLKTX1.DAO
{
    class AccountDAO
    {
        private static AccountDAO instance;

        public static AccountDAO Instance
        {
            get { if (instance == null) instance = new AccountDAO(); return instance; }
            private set { instance = value; }
        }

        private AccountDAO() { }

        public bool Login(string userName, string passWord)
        {

            string query = "exec P_Login @UserName , @PassWord";

            DataTable result = DataProvider.Instance.ExecuteQuery(query, new object[] { userName, passWord });

            return result.Rows.Count > 0;
        }
        
        public DataTable GetListAccount()
        {
            return DataProvider.Instance.ExecuteQuery("select Sinh_vien.Ten_dang_nhap,Ho_ten_dem,Ten from (Nguoi_dung inner join Sinh_vien on Nguoi_dung.Ten_dang_nhap = Sinh_vien.Ten_dang_nhap  )");
        }

        public Account GetAccountByUserName(string userName)
        {
            DataTable data = DataProvider.Instance.ExecuteQuery("select * from Nguoi_dung where Ten_dang_nhap = '" + userName + "'");

            foreach (DataRow item in data.Rows)
            {
                return new Account(item);
            }

            return null;
        }
        public bool InsertAccount(string username, string displayName)
        {
            string query1 = string.Format("SELECT COUNT(*) FROM dbo.Sinh_vien WHERE UserName ='" + username + "'");
            DataTable result1 = DataProvider.Instance.ExecuteQuery(query1);
            string s = "";
            if (result1.Rows.Count > 0)
                for (int i = 0; i < result1.Rows.Count; i++)
                {
                    s = result1.Rows[0]["Column1"].ToString();
                }
            if (string.Compare(s, "0") == 0)
            {
                string query = string.Format("INSERT dbo.Account (UserName,DisplayName) VALUES ( N'{0}', N'{1}')", username, displayName);
                int result = DataProvider.Instance.ExecuteNonQuery(query);

                return result > 0;
            }
            else
                return false;
        }
        public bool EditAccount(string username, string displayname, string room)
        {
            string query1 = string.Format("SELECT COUNT(*) FROM dbo.Account WHERE UserName =N'" + username + "'");
            DataTable result1 = DataProvider.Instance.ExecuteQuery(query1);
            string s = "";
            if (result1.Rows.Count > 0)
                for (int i = 0; i < result1.Rows.Count; i++)
                {
                    s = result1.Rows[0]["Column1"].ToString();
                }
            if (string.Compare(s, "0") == 0)
            {
                string query2 = string.Format("SELECT dbo.Room.RoomStatus FROM dbo.Room WHERE RoomName = N'" + room + "'");
                DataTable result2 = DataProvider.Instance.ExecuteQuery(query2);
                string str = "";
                if (result2.Rows.Count > 0)
                    for (int i = 0; i < result2.Rows.Count; i++)
                    {
                        str = result2.Rows[0]["RoomStatus"].ToString();
                    }
                if (string.Compare(str, "Đầy") == 0)
                {
                    return false;
                }
                else
                {
                    string query = string.Format("INSERT dbo.Account (UserName,DisplayName) VALUES ( N'{0}', N'{1}')", username, displayname);
                    int result = DataProvider.Instance.ExecuteNonQuery(query);
                    return result > 0;
                }
            }
            else
            {
                string query = string.Format("UPDATE dbo.Account SET DisplayName= N'{0}' WHERE UserName =N'{1}' ", displayname, username);
                int result = DataProvider.Instance.ExecuteNonQuery(query);
                return result > 0;
            }

        }
        public bool UpdateAccount(string userName, string pass, string newPass)
        {
            int result = DataProvider.Instance.ExecuteNonQuery("exec P_ChangePass @userName , @password , @newPassword ", new object[] { userName, pass, newPass });

            return result > 0;
        }
        public bool UpdateAccount(string userName, string displayname, string pass, string newPass)
        {
            int result = DataProvider.Instance.ExecuteNonQuery("exec USP_Change_Acc @userName , @displayname , @password , @newPassword ", new object[] { userName, displayname, pass, newPass });

            return result > 0;
        }

        public bool DeleteAccount(string name)
        {
            string query = string.Format("DELETE dbo.Account WHERE dbo.Account.UserName = N'{0}'", name);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }

        public bool ResetPassword(string username)
        {
            string query = string.Format("UPDATE dbo.Account SET PassWord  = N'123456'  WHERE UserName = N'{0}'", username);
            int result = DataProvider.Instance.ExecuteNonQuery(query);

            return result > 0;
        }
    }
}
