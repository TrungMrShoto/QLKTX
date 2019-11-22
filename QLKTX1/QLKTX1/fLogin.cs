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
namespace QLKTX1
{
    public partial class fLogin : Form
    {
        public fLogin()
        {
            InitializeComponent();
            this.groupBox1.BackColor = System.Drawing.Color.Transparent;
            this.btnLogin.BackColor = System.Drawing.Color.Transparent;
            this.label3.BackColor  = System.Drawing.Color.Transparent;
            this.panel1.BackColor = System.Drawing.Color.Transparent;
           
        }

        private void fLogin_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (MessageBox.Show("Bạn có thực sự muốn thoát chương trình ?", "Thông báo", MessageBoxButtons.OKCancel) != System.Windows.Forms.DialogResult.OK)
                e.Cancel = true;
        }
        bool Login(string username, string password)
        {
            return AccountDAO.Instance.Login(username, password);
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            string userName = txbUserName.Text;
            string passWord = txbPassWord.Text;
            if (Login(userName, passWord))
            {
                Account loginAccount = AccountDAO.Instance.GetAccountByUserName(userName);
                string query = "select Nguoi_dung from Nguoi_dung where Ten_dang_nhap = '" + userName + "'";
                DataTable dataStudent = DataProvider.Instance.ExecuteQuery(query);
                string s = "";
                if (dataStudent.Rows.Count > 0)
                    for (int i = 0; i < dataStudent.Rows.Count; i++)
                    {
                        s = dataStudent.Rows[0]["Nguoi_dung"].ToString();
                    }
                if(string.Compare(s,"Sinh viên") == 0)
                {
                    fStudent f = new fStudent(loginAccount);
                    this.Hide();
                    f.ShowDialog();
                    this.Show();
                }
                else
                {
                    fadmin f = new fadmin(loginAccount);
                    this.Hide();
                    f.ShowDialog();
                    this.Show();
                }
             
            }
            else
            {
                MessageBox.Show("Sai tên tài khoản hoặc mật khẩu !");
            }
        }

        private void btnShowPass_MouseDown(object sender, MouseEventArgs e)
        {
            txbPassWord.UseSystemPasswordChar = false;
        }

        private void btnShowPass_MouseUp(object sender, MouseEventArgs e)
        {
            txbPassWord.UseSystemPasswordChar = true;
        }

        private void fLogin_Load(object sender, EventArgs e)
        {

        }
    }
}
