using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using QLKTX1.DAO;
using QLKTX1.DTO;
using System.Globalization;
using System.Threading;
using System.Data.SqlClient;

namespace QLKTX1
{
    public partial class fStudent : Form
    {
        BindingSource studentsList = new BindingSource();
        BindingSource accountList = new BindingSource();
        BindingSource sextypeList = new BindingSource();
        BindingSource billList = new BindingSource();
        BindingSource receivelist = new BindingSource();
        BindingSource sendlist = new BindingSource();

        private Account loginAccount;
        public Account LoginAccount
        {
            get { return loginAccount; }
            set { loginAccount = value;
                ChangeAccount(); }
        }
        public fStudent(Account acc)
        {
            InitializeComponent();
            this.LoginAccount = acc;
            Load();
        }
        void ChangeAccount()
        {
            tabPage1.Text+= " (" + LoginAccount.Hovatendem + LoginAccount.Ten + ")";
        }
        void Load()
        {
            LoadAccount();
            LoadstudentsList();
            AddAccountBinding();
            Load_Require();
           // LoadbillList();
            //LoadreceiveList();
            //LoadsendList();
        }
        void LoadbillList()
        {
            string query1 = "SELECT * FROM dbo.Students Where UserName = N'" + this.LoginAccount.UserName + "'";
            DataTable dataStudent = DataProvider.Instance.ExecuteQuery(query1);
            string s="" ;
            if (dataStudent.Rows.Count > 0)
                for (int i = 0;i< dataStudent.Rows.Count;i++)
                {
                    s = dataStudent.Rows[0]["Room"].ToString();
                }
            string query = "EXEC USP_LoadBill @RoomName = N'" + s + "'";
            dtgvWAE.DataSource = DataProvider.Instance.ExecuteQuery(query);
            CultureInfo culture = new CultureInfo("vi-VN");
            Thread.CurrentThread.CurrentCulture = culture;
            dtgvWAE.Columns["Tổng"].DefaultCellStyle.Format = "c";
            dtgvWAE.Columns["Tiền nước"].DefaultCellStyle.Format = "c";
            dtgvWAE.Columns["Tiền điện"].DefaultCellStyle.Format = "c";
        }
        /*
        void LoadsendList()
        {
            string query = "SELECT TextID, dbo.Text.DisplayNameReceive AS [Người nhận], dbo.Text.UserName AS [Tài khoản người nhận], dbo.Text.Text AS [Tin nhắn],dbo.Text.Date AS [Ngày gửi] FROM dbo.Text WHERE Sender = N'" + this.LoginAccount.UserName + "'";
           dtgvSend.DataSource = DataProvider.Instance.ExecuteQuery(query);

        }
        
        void LoadreceiveList()
        {
            string query = "SELECT TextID, dbo.Text.DisplayName AS [Người gửi], dbo.Text.Sender AS [Tài khoản người gửi], dbo.Text.Text AS [Tin nhắn],dbo.Text.Date AS [Ngày gửi] FROM dbo.Text WHERE UserName = N'" + this.LoginAccount.UserName + "'";
            dtgvReceive.DataSource = DataProvider.Instance.ExecuteQuery(query);
        }
        */
        void LoadstudentsList()
        {
            string query = "exec P_Info '" + this.LoginAccount.UserName + "'";
            studentsList.DataSource = DataProvider.Instance.ExecuteQuery(query);
        }
        void LoadAccountList()
        {
            string query = "SELECT * FROM dbo.Account";
            accountList.DataSource = DataProvider.Instance.ExecuteQuery(query);
        }
        void AddAccountBinding()
        {
            txbUserName.DataBindings.Add(new Binding("Text", studentsList.DataSource,"HoVaTen", true));          
            txbRoomName.DataBindings.Add(new Binding("Text", studentsList.DataSource, "Phong", true, DataSourceUpdateMode.Never));
            txbDOB.DataBindings.Add(new Binding("Text", studentsList.DataSource, "Ngay_sinh", true, DataSourceUpdateMode.Never));
            txbMSSV.DataBindings.Add(new Binding("Text", studentsList.DataSource, "MSSV", true, DataSourceUpdateMode.Never));
            txbSchool.DataBindings.Add(new Binding("Text", studentsList.DataSource, "Truong", true, DataSourceUpdateMode.Never));
            txbSex.DataBindings.Add(new Binding("Text", studentsList.DataSource, "Gioi_tinh", true, DataSourceUpdateMode.Never));
            txbPhoneNumber.DataBindings.Add(new Binding("Text", studentsList.DataSource, "SDT", true, DataSourceUpdateMode.Never));
            txbEmail.DataBindings.Add(new Binding("Text", studentsList.DataSource, "Email", true, DataSourceUpdateMode.Never));
            txbHomeLand.DataBindings.Add(new Binding("Text", studentsList.DataSource, "Quan_Huyen", true, DataSourceUpdateMode.Never));
            txbCountry.DataBindings.Add(new Binding("Text", studentsList.DataSource, "Tinh_TP", true, DataSourceUpdateMode.Never));
            nmSVNam.DataBindings.Add(new Binding("Text", studentsList.DataSource, "Nam_thu", true, DataSourceUpdateMode.Never));
            txbUser.DataBindings.Add(new Binding("Text", studentsList.DataSource, "Ten_dang_nhap", true, DataSourceUpdateMode.Never));
            txbUserName1.DataBindings.Add(new Binding("Text", studentsList.DataSource, "Ten_dang_nhap", true, DataSourceUpdateMode.Never));
            //txbSender.DataBindings.Add(new Binding("Text", studentsList.DataSource, "Ten_dang_nhap", true, DataSourceUpdateMode.Never));
        }
        void LoadAccount()      {
            accountList.DataSource = AccountDAO.Instance.GetAccountByUserName(this.LoginAccount.UserName);
        }
        private void fStudent_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (MessageBox.Show("Bạn có thực sự muốn đăng xuất ?", "Thông báo", MessageBoxButtons.OKCancel) != System.Windows.Forms.DialogResult.OK)
                e.Cancel = true;
        }

        private void btnEditPass_Click(object sender, EventArgs e)
        {
            string name = txbUserName1.Text;
            string pass = txbPassWord1.Text;
            string newpass = txbNewPass.Text;
            string reenternewpass = txbReEnterNewPass.Text;
            if (string.Compare(pass, this.LoginAccount.Password) == 1)
                MessageBox.Show("Mật khẩu không đúng!");
            else if (string.Compare(newpass, reenternewpass) == 1)
                MessageBox.Show("Nhập lại mật khẩu mới không đúng!");
            else
            {
                if (AccountDAO.Instance.UpdateAccount(name, pass, newpass))
                    MessageBox.Show("Cập nhật tài khoản thành công");
                else
                    MessageBox.Show("Cập nhật tài khoản thất bại");
                LoadAccount();
            }
        }
        //private void btnSend_Click(object sender, EventArgs e)
        //{
        //    string Sender = txbSender.Text;
        //    string Receiver = txbUserReceive.Text;
        //    string text = txbMess.Text;
        //    string query = "INSERT dbo.Text (UserName , Text , Date , Sender ) VALUES (  N'" + Receiver +"' , N'"+text + "', GETDATE(), N'"+Sender +"')";
        //    if(DataProvider.Instance.ExecuteNonQuery(query) > 0)
        //        MessageBox.Show("Gửi tin nhắn thành công");
        //    else
        //        MessageBox.Show("Gửi tin nhắn thất bại");
        //    LoadsendList();
        //}
        private void btnShowPass_MouseUp(object sender, MouseEventArgs e)
        {
            txbNewPass.UseSystemPasswordChar = true;
            txbPassWord1.UseSystemPasswordChar = true;
            txbReEnterNewPass.UseSystemPasswordChar = true;
        }
        private void btnShowPass_MouseDown(object sender, MouseEventArgs e)
        {
            txbNewPass.UseSystemPasswordChar = false;
            txbPassWord1.UseSystemPasswordChar = false;
            txbReEnterNewPass.UseSystemPasswordChar = false;
        }

        private void Load_Require()
        {
            string query = "exec Load_Yeu_cau '" + this.LoginAccount.UserName + "'";
            View_Yeu_cau.DataSource = DataProvider.Instance.ExecuteQuery(query);
            CultureInfo culture = new CultureInfo("vi-VN");
            Thread.CurrentThread.CurrentCulture = culture;
            View_Yeu_cau.Columns["Req_ID"].AutoSizeMode = DataGridViewAutoSizeColumnMode.DisplayedCells;
            View_Yeu_cau.Columns["Nội dung yêu cầu"].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            View_Yeu_cau.Columns["Nội dung yêu cầu"].DefaultCellStyle.Format = "s"; 
            View_Yeu_cau.Columns["Ngày gửi"].DefaultCellStyle.Format = "dd'/'MM'/'yyyy";
            View_Yeu_cau.Columns["Ngày gửi"].AutoSizeMode = DataGridViewAutoSizeColumnMode.DisplayedCells;
            txt_Ngay_gui.Enabled = false;
            txt_Req.Enabled = false;
            
        }

        private void Add_Yeu_cau_Click(object sender, EventArgs e)
        {
            Add_Requirement();
        }   
        private void Add_Requirement()
        {
            string require = "exec Insert_Yeu_cau '" + this.LoginAccount.UserName + "',N'" + txt_Noi_dung_add.Text + "' ";
            StringBuilder errorMess = new StringBuilder();
            try
            {
                int count = DataProvider.Instance.ExecuteNonQuery(require);
                if (count > 0)
                    MessageBox.Show("Success!!!!");
                Load_Require();

            }

            catch (SqlException ex)
            {
                errorMess.Append(ex.Errors[0].Message);
                MessageBox.Show(errorMess.ToString());
            }

        }
        private void Update_Yeu_cau_Click(object sender, EventArgs e)
        {
            StringBuilder errorMess = new StringBuilder();
            var confirmResult = MessageBox.Show("Are you sure to update this record ????", "Confirm Update!!!!", MessageBoxButtons.YesNo);
            if (confirmResult == DialogResult.Yes)
            {
                try
                {

                    int iRowIndex = View_Yeu_cau.CurrentCell.RowIndex;
                    string record = Convert.ToString(View_Yeu_cau.Rows[iRowIndex].Cells["Req_ID"].Value);
                    string require = "exec Update_Yeu_cau " + record + ",'" + txt_Noi_dung_chinh.Text + "'";
                    int count = DataProvider.Instance.ExecuteNonQuery(require);
                    Load_Require();
                }
                catch(SqlException ex)
                {
                    errorMess.Append(ex.Errors[0].Message);
                    MessageBox.Show(errorMess.ToString());
                }
            }
        }

        private void Delete_Yeu_Cau_Click(object sender, EventArgs e)
        {
            var confirmResult = MessageBox.Show("Are you sure to delete this record ????", "Confirm Delete!!!!", MessageBoxButtons.YesNo);
            if (confirmResult == DialogResult.Yes)
            {
                
                int iRowIndex = View_Yeu_cau.CurrentCell.RowIndex;
                string record = Convert.ToString(View_Yeu_cau.Rows[iRowIndex].Cells["Req_ID"].Value);
                string require = "exec Delete_Yeu_cau " + record + ",'" + this.LoginAccount.UserName + "'";
                int count = DataProvider.Instance.ExecuteNonQuery(require);
                Load_Require();
            }
        }

        private void txt_Noi_dung_add_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                Add_Requirement();
            }
        }

        private void View_Yeu_cau_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int iRowIndex = View_Yeu_cau.CurrentCell.RowIndex;

            txt_Req.Text = Convert.ToString(View_Yeu_cau.Rows[iRowIndex].Cells["Req_ID"].Value);
            txt_Req.Enabled = false;
            string str = Convert.ToString(View_Yeu_cau.Rows[iRowIndex].Cells["Ngày gửi"].Value);
            txt_Ngay_gui.Text = str.Remove(10);
            txt_Ngay_gui.Enabled = false;
            txt_Noi_dung_chinh.Text = Convert.ToString(View_Yeu_cau.Rows[iRowIndex].Cells["Nội dung yêu cầu"].Value);
        }
    }

        
    
}
