using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using QLKTX1.DTO;
namespace QLKTX1.DAO
{
    class BillDAO
    {
        private static BillDAO instance;

        public static BillDAO Instance
        {
            get { if (instance == null) instance = new BillDAO(); return BillDAO.instance; }
            private set { BillDAO.instance = value; }
        }

        private BillDAO() { }
        
        public bool InsertBill(string roomname, int prewa, int curwa, int preelect, int curelect, string status, int month)
        {
           int result= DataProvider.Instance.ExecuteNonQuery("EXEC USP_InsertBill @roomname , @prewaterindex , @curwaterindex , @preelectricindex , @curelectricindex , @status , @month ", new object[] { roomname, prewa, curwa, preelect, curelect, status, month });
           return result > 0;
        }
        public bool EditBill(int id, string roomname, int prewa, int curwa, int preelect, int curelect, string status, int month)
        {
            string query1 = string.Format("SELECT COUNT(*) FROM dbo.WaterAndElectric WHERE BillID =" + id);
            DataTable result1 = DataProvider.Instance.ExecuteQuery(query1);
            string s = "";
            if (result1.Rows.Count > 0)
                for (int i = 0; i < result1.Rows.Count; i++)
                {
                    s = result1.Rows[0]["Column1"].ToString();
                }
            if (string.Compare(s, "0") == 0)
            {
                int result = DataProvider.Instance.ExecuteNonQuery("EXEC USP_InsertBill @roomname , @prewaterindex , @curwaterindex , @preelectricindex , @curelectricindex , @status , @month ", new object[] { roomname, prewa, curwa, preelect, curelect, status, month });
                return result > 0;
            }
            else
            {
                int result = DataProvider.Instance.ExecuteNonQuery("EXEC USP_EditBill @id , @roomname , @prewaterindex , @curwaterindex , @preelectricindex , @curelectricindex , @status , @month ", new object[] { id, roomname, prewa, curwa, preelect, curelect, status, month });
                return result > 0;
            }
        }
        public bool DeleteBill(int id)
        {
            int result = DataProvider.Instance.ExecuteNonQuery("DELETE dbo.WaterAndElectric WHERE BillID = " + id, new object[] { });
            return result > 0;
        }
        public bool PayBill(int id)
        {
            string query1 = string.Format("SELECT BillStatus FROM dbo.WaterAndElectric WHERE BillID = " + id);
            DataTable result1 = DataProvider.Instance.ExecuteQuery(query1);
            string s = "";
            if (result1.Rows.Count > 0)
                for (int i = 0; i < result1.Rows.Count; i++)
                {
                    s = result1.Rows[0]["BillStatus"].ToString();
                }
            if (string.Compare(s, "Chưa thanh toán") == 0)
            {
                int result = DataProvider.Instance.ExecuteNonQuery(" UPDATE dbo.WaterAndElectric SET BillStatus = N'Đã thanh toán',  PayDate = GETDATE() WHERE BillID = " + id, new object[] { });
                return result > 0;
            }
            else return false;
        }
        public DataTable GetListBill()
        {
            string querry = "SELECT BillID AS [ID], RoomName AS [Phòng], Month AS [Tháng], PreWaterIndex AS [Chỉ số nước tháng trước], CurWaterIndex AS [Chỉ số nước tháng này], PreElectricIndex AS [Chỉ số điện thánng trước], CurElectricIndex AS[Chỉ số điện tháng này], ElectricPrince AS [Tiền điện], WaterPrince AS [Tiền nước], TotalPrince AS [Tổng], BillStatus AS [Tình trạng], PayDate AS [Ngày thanh toán] FROM dbo.WaterAndElectric ";
            return DataProvider.Instance.ExecuteQuery(querry);
        }
        //public int GetMaxIDBill()
        //{
        //    try
        //    {
        //        return (int)DataProvider.Instance.ExecuteScalar("SELECT MAX(id) FROM dbo.Bill");
        //    }
        //    catch
        //    {
        //        return 1;
        //    }
        //}
    }
}
