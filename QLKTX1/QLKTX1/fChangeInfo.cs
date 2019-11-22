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
    public partial class fChangeInfo : Form
    {
        private Account loginAccount;
        public Account LoginAccount
        {
            get { return loginAccount; }
            set { loginAccount = value; LoadInfo(loginAccount); }
        }

        public fChangeInfo(Account Acc)
        {
            InitializeComponent();
            LoginAccount = Acc;
           
            this.label1.BackColor =  System.Drawing.Color.Transparent;
            this.label2.BackColor = System.Drawing.Color.Transparent;
            this.label3.BackColor = System.Drawing.Color.Transparent;
            this.label15.BackColor = System.Drawing.Color.Transparent;
            this.label16.BackColor = System.Drawing.Color.Transparent;
            LoadInfo(LoginAccount);
        }
        void LoadInfo(Account account)
        {
            txbDisplayName.Text = LoginAccount.Hovatendem + LoginAccount.Ten;
            txbUserName.Text = LoginAccount.UserName;

        }

        private void btnShowPass_MouseDown(object sender, MouseEventArgs e)
        {
            txbPassWord.UseSystemPasswordChar = false;
            txbNewPass.UseSystemPasswordChar = false;
            txbReEnterNewPass.UseSystemPasswordChar = false;
        }

        private void btnShowPass_MouseUp(object sender, MouseEventArgs e)
        {
            txbPassWord.UseSystemPasswordChar = true;
            txbNewPass.UseSystemPasswordChar = true;
            txbReEnterNewPass.UseSystemPasswordChar = true;
        }
        private event EventHandler<AccountEvent> updateAccount;
        public event EventHandler<AccountEvent> UpdateAccount
        {
            add { updateAccount += value; }
            remove { updateAccount -= value; }
        }
        private void btnChange_Click(object sender, EventArgs e)
        {
            string username = txbUserName.Text;
            string displayname = txbDisplayName.Text;
            string password = txbPassWord.Text;
            string newpass = txbNewPass.Text;
            string reenterpass = txbReEnterNewPass.Text;
            if (string.Compare(password, this.LoginAccount.Password) == 1)
                MessageBox.Show("Mật khẩu không đúng!");
            else if (string.Compare(newpass, reenterpass) == 1)
                MessageBox.Show("Nhập lại mật khẩu mới không đúng!");
            else
                if (AccountDAO.Instance.UpdateAccount(username, displayname, password, newpass))
                {
                    MessageBox.Show("Cập nhật tài khoản thành công");
                    if (updateAccount != null)
                         updateAccount(this, new AccountEvent(AccountDAO.Instance.GetAccountByUserName(username)));
                }
            else
                MessageBox.Show("Cập nhật tài khoản thất bại");
                
            
        }
       
        public class AccountEvent : EventArgs
        {
            private Account acc;

            public Account Acc
            {
                get { return acc; }
                set { acc = value; }
            }

            public AccountEvent(Account acc)
            {
                this.Acc = acc;
            }
        }
    }
}
