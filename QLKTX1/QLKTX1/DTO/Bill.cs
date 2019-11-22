//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;
//using System.Data;
//namespace QLKTX1.DTO
//{
//    class Bill
//    {
//        public Bill(int id, string roomname, int preW, int curW, int preE, int curE, float WP, float EP, float Total, int month, DateTime? paydate, string status)
//        {
//            this.IdBill = id;
//            this.RoomName = roomname;
//            this.PreWaterIndex = preW;
//            this.CurWaterIndex = curW;
//            this.PreElectricIndex = preE;
//            this.CurElectricIndex = curE;
//            this.WaterPrince = WP;
//            this.ElectricPrince = EP;
//            this.TotalPrince = Total;
//            this.Month = month;
//            this.PayDate = paydate;
//            this.BillStatus = status;
//        }
//        public Bill(DataRow row)
//        {
//             this.IdBill = (int)row["idBill"];
//             this.RoomName = row["RoomName"].ToString();
//             this.PreWaterIndex = (int)row["PreWaterIndex"];
//             this.CurWaterIndex = (int)row["CurWaterIndex"];
//             this.PreElectricIndex = (int)row["PreElectricIndex"];
//             this.CurElectricIndex = (int)row["CurElectricIndex"];
//             this.WaterPrince = (int)Convert.ToDouble(row["WaterPrince"]);
//             this.ElectricPrince = (float)Convert.ToDouble(row["ElectricPrince"]);
//             this.TotalPrince = (float)Convert.ToDouble(row["TotalPrince"]);
//             this.Month = (int)row["Month"];
//             this.PayDate = (DateTime?)row["PayDate"];
//             this.BillStatus = row["BillStatus"].ToString() ;
             
           
            
            
//        }
//        private int idBill;
//        private string roomName;
//        private int preWaterIndex;
//        private int curWaterIndex;
//        private int preElectricIndex;
//        private int curElectricIndex;
//        private float waterPrince;
//        private float electricPrince;
//        private float totalPrince;
//        private int month;
//        private DateTime? payDate;
//        private string billStatus;

//        public int IdBill { get => idBill; set => idBill = value; }
//        public string RoomName { get => roomName; set => roomName = value; }
//        public int PreWaterIndex { get => preWaterIndex; set => preWaterIndex = value; }
//        public int CurWaterIndex { get => curWaterIndex; set => curWaterIndex = value; }
//        public int PreElectricIndex { get => preElectricIndex; set => preElectricIndex = value; }
//        public int CurElectricIndex { get => curElectricIndex; set => curElectricIndex = value; }
//        public float WaterPrince { get => waterPrince; set => waterPrince = value; }
//        public float ElectricPrince { get => electricPrince; set => electricPrince = value; }
//        public float TotalPrince { get => totalPrince; set => totalPrince = value; }
//        public int Month { get => month; set => month = value; }
//        public DateTime? PayDate { get => payDate; set => payDate = value; }
//        public string BillStatus { get => billStatus; set => billStatus = value; }
//    }
//}
