using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using QLKTX1.DAO;
using QLKTX1.DTO;
using QLKTX1.Properties;
using System.Data.SqlClient;
namespace QLKTX1
{
    public partial class fadmin : Form
    {
        BindingSource roomList = new BindingSource();
        BindingSource studentsList = new BindingSource();
        BindingSource billList = new BindingSource();
        BindingSource receivelist = new BindingSource();
        BindingSource sendlist = new BindingSource();
        private Account loginAccount;
        public Account LoginAccount
        {
            get { return loginAccount; }
            set { loginAccount = value; ChangeAccount(); }
        }
        public fadmin(Account acc)
        {
            InitializeComponent();
            this.LoginAccount = acc;

        }
        void LoadStudent()
        {
            studentsList.DataSource = StudentsDAO.Instance.GetListStudents(Load_toa_nha());
        }

        void LoadComboboxRoomType()
        {
            cbRoomType.Items.Add("Phòng 2");
            cbRoomType.Text = cbRoomType.Items[0].ToString();
            cbRoomType.Items.Add("Phòng 4");
            cbRoomType.Items.Add("Phòng 6");
            cbRoomType.Items.Add("Phòng 8");
        }
        private void cbRoomType_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadComboboxRoomByType(cbRoomType.Text);
        }
        string Load_toa_nha()
        {
            DataTable toa = RoomDAO.Instance.Load_Building(LoginAccount.UserName);
            string toanha = toa.Rows[0]["Ten_toa_nha"].ToString();
            return toanha;
        }
        void LoadComboboxRoomByType(string x)
        {
            string toanha = Load_toa_nha();
            cbRoom.DataSource = RoomDAO.Instance.LoadRoomByType(x,toanha);
            cbRoom.DisplayMember = "Ten_phong";
        }
        void ChangeAccount()
        {
            thôngTinTàiKhoảnToolStripMenuItem.Text = "Thông tin tài khoản ";
            thôngTinTàiKhoảnToolStripMenuItem.Text += " (" + LoginAccount.Hovatendem + LoginAccount.Ten + ")";
        }
        private void fadmin_Load(object sender, EventArgs e)
        {
            // this.WindowState = FormWindowState.Maximized;
            dtgvDSPhong.DataSource = roomList;
            dtgvDSSV.DataSource = studentsList;
            //dtgvBill.DataSource = billList;
            LoadRoom();
            LoadComboboxRoomType();
            LoadStudent();
            LoadStudents();
            //LoadListBill();
            //LoadBillInfo();
            //LoadreceiveList();
            //LoadsendList();
            //txbSender.Text = this.LoginAccount.UserName;
            //radioButton1.Checked = true;
            //CultureInfo culture = new CultureInfo("vi-VN");
            //Thread.CurrentThread.CurrentCulture = culture;
            //dtgvBill.Columns["Tổng"].DefaultCellStyle.Format = "c";
            //dtgvBill.Columns["Tiền nước"].DefaultCellStyle.Format = "c";
            //dtgvBill.Columns["Tiền điện"].DefaultCellStyle.Format = "c";
        }
      
        
        private void đăngXuấtToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        private void fadmin_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (MessageBox.Show("Bạn có thực sự muốn đăng xuất ?", "Thông báo", MessageBoxButtons.OKCancel) != System.Windows.Forms.DialogResult.OK)
                e.Cancel = true;
        }
        void LoadData(string x)
        {
            LoadStudent();
            LoadStudents();
            ShowMem(x);
            LoadRoom();
        }
        #region load room
        public void LoadRoom()
        {
            flpType2.Controls.Clear();
            flpType4.Controls.Clear();
            flpType6.Controls.Clear();
            flpType8.Controls.Clear();

            List<Room> roomList = RoomDAO.Instance.LoadRoomList(Load_toa_nha());

            foreach (Room item in roomList)
            {
                Button btn = new Button() { Width = RoomDAO.RoomWidth, Height = RoomDAO.RoomHeight };
                btn.Text = item.Tenphong + Environment.NewLine + item.Tinhtrang + Environment.NewLine + item.Sosvdangco;
                btn.Click += btn_Click;
                btn.Tag = item;
                switch (item.Tinhtrang)
                {
                    case "Trống":
                        btn.BackColor = Color.Aquamarine; // đánh dấu phòng trống bằng màu
                        break;
                    case "Có người":
                        btn.BackColor = Color.Lime; // đánh dấu phòng trống bằng màu
                        break;
                    default:
                        btn.BackColor = Color.LightPink;
                        break;
                }
                if (string.Compare(item.Loaiphong, "Phòng 2") == 0)
                    flpType2.Controls.Add(btn);
                else if (string.Compare(item.Loaiphong, "Phòng 4") == 0)
                    flpType4.Controls.Add(btn);
                else if (string.Compare(item.Loaiphong, "Phòng 6") == 0)
                    flpType6.Controls.Add(btn);
                else
                    flpType8.Controls.Add(btn);
            }

        }
        public void btn_Click(object sender, EventArgs e)
        {
            string roomname = ((sender as Button).Tag as Room).Tenphong;
            dtgvDSPhong.Tag = (sender as Button).Tag;
            ShowMem(roomname);
        }
        void ShowMem(string roomname)
        {
            txbUser.DataBindings.Clear();
            txbUserName.DataBindings.Clear();
            txbRoomName.DataBindings.Clear();
            dtpkDOB.DataBindings.Clear();
            txbMSSV.DataBindings.Clear();
            txbSchool.DataBindings.Clear();
            txbSex.DataBindings.Clear();
            //txbPhoneNumber.DataBindings.Clear();
            //txbEmail.DataBindings.Clear();
            txbHomeLand.DataBindings.Clear();
            txbNationality.DataBindings.Clear();
            txbTen.DataBindings.Clear();
            txbTP.DataBindings.Clear();
            nmSVNam.DataBindings.Clear();
            txbCMND.DataBindings.Clear();
            dtgvDSPhong.DataSource = RoomDAO.Instance.LoadRoomMember(roomname,Load_toa_nha());
            txbUserName.DataBindings.Add(new Binding("Text", dtgvDSPhong.DataSource, "Hotendem", true, DataSourceUpdateMode.Never));
            txbUser.DataBindings.Add(new Binding("Text", dtgvDSPhong.DataSource, "Tendangnhap", true, DataSourceUpdateMode.Never));
            txbRoomName.DataBindings.Add(new Binding("Text", dtgvDSPhong.DataSource, "Tenphong", true, DataSourceUpdateMode.Never));
            dtpkDOB.DataBindings.Add(new Binding("Text", dtgvDSPhong.DataSource, "Ngaysinh", true, DataSourceUpdateMode.Never));
            txbMSSV.DataBindings.Add(new Binding("Text", dtgvDSPhong.DataSource, "Mssv", true, DataSourceUpdateMode.Never));
            txbSchool.DataBindings.Add(new Binding("Text", dtgvDSPhong.DataSource, "Truong", true, DataSourceUpdateMode.Never));
            txbSex.DataBindings.Add(new Binding("Text", dtgvDSPhong.DataSource, "Gioitinh", true, DataSourceUpdateMode.Never));
           // txbPhoneNumber.DataBindings.Add(new Binding("Text", dtgvDSPhong.DataSource, "SDT", true, DataSourceUpdateMode.Never));
            //txbEmail.DataBindings.Add(new Binding("Text", dtgvDSPhong.DataSource, "Email", true, DataSourceUpdateMode.Never));
            txbHomeLand.DataBindings.Add(new Binding("Text", dtgvDSPhong.DataSource, "Tentoanha", true, DataSourceUpdateMode.Never));
            txbNationality.DataBindings.Add(new Binding("Text", dtgvDSPhong.DataSource, "Quanhuyen", true, DataSourceUpdateMode.Never));
            nmSVNam.DataBindings.Add(new Binding("Text", dtgvDSPhong.DataSource, "Namthu", true, DataSourceUpdateMode.Never));
            txbTen.DataBindings.Add(new Binding("Text", dtgvDSPhong.DataSource, "Ten", true, DataSourceUpdateMode.Never));
            txbTP.DataBindings.Add(new Binding("Text", dtgvDSPhong.DataSource, "Tinhtp", true, DataSourceUpdateMode.Never));
            txbCMND.DataBindings.Add(new Binding("Text", dtgvDSPhong.DataSource, "CMND", true, DataSourceUpdateMode.Never));

        }

        void AddAccount(string userName, string displayName)
        {
            if (AccountDAO.Instance.InsertAccount(userName, displayName)) { }
            else
                MessageBox.Show("Thêm tài khoản thất bại");
        }
        void AddStudent(string tendangnhap, string hovatendem, string ten, string ngaysinh, string cmnd, string gioitinh, string quanhuyen, string tinh,string MSSV,string truong,int SVNam,string phong,string toanha)
        {
            if (StudentsDAO.Instance.InsertStudent(tendangnhap, hovatendem, ten,ngaysinh,  cmnd,gioitinh, quanhuyen, tinh, MSSV,truong,SVNam, phong, toanha))
                MessageBox.Show("Thêm sinh viên thành công");
            else
                MessageBox.Show("Thêm sinh viên thất bại");
        }
        private void btnAddAd_Click(object sender, EventArgs e)
        {
            StringBuilder errorMess = new StringBuilder();
            var confirmResult = MessageBox.Show("Bạn có chắc muốn thêm sinh viên này vao phòng ????", "Thêm thành công!!!!", MessageBoxButtons.YesNo);
            if (confirmResult == DialogResult.Yes)
            {
                try
                {
                    string tendangnhap = txbUser.Text;
                    string hovatendem = txbUserName.Text;
                    string ten = txbTen.Text;
                    string d = dtpkDOB.Value.ToString();
                    string ngaysinh = d.Substring(0, 10);
                    string cmnd = txbCMND.Text;
                    string gioitinh = txbSex.Text;
                    string quanhuyen = txbNationality.Text;
                    string tinh = txbTP.Text;
                    string MSSV = txbMSSV.Text;
                    string truong = txbSchool.Text;
                    int SVNam = Convert.ToInt32(nmSVNam.Text);
                    string phong = txbRoomName.Text;
                    string toanha = txbHomeLand.Text;
                    DataTable data = RoomDAO.Instance.LoadRoomType(phong, toanha);
                    string s = data.Rows[0]["Tinh_trang"].ToString();

                    if (string.Compare(s, "Đầy") == 0)// khac nhau
                        MessageBox.Show("Phòng " + phong + " đã đầy!");
                    else
                    {
                        bool rv = StudentsDAO.Instance.InsertStudent(tendangnhap, hovatendem, ten, ngaysinh, cmnd, gioitinh, quanhuyen, tinh, MSSV, truong, SVNam, phong, toanha);
                        if (rv)
                            MessageBox.Show("Thêm thành công!");
                        LoadData(phong);
                    }
                }
                catch (SqlException ex)
                {
                    errorMess.Append(ex.Errors[0].Message);
                    MessageBox.Show(errorMess.ToString());
                }
            }
           
        }
       
        

        private void btnDeleteAdmin_Click(object sender, EventArgs e)
        {
            StringBuilder errorMess = new StringBuilder();
            var confirmResult = MessageBox.Show("Bạn có chắc muốn xóa sinh viên này ra khỏi phòng ????", "", MessageBoxButtons.YesNo);
            if (confirmResult == DialogResult.Yes)
            {
                try
                {
                    string tdn = txbUser.Text;
                    string phong = txbRoomName.Text;
                    string toa = txbHomeLand.Text;
                    bool count = StudentsDAO.Instance.DeleteStudent(tdn, toa, phong);
                    if(count)
                        MessageBox.Show("Xóa thành công!");
                    LoadData(phong);
                }
                catch (SqlException ex)
                {
                    errorMess.Append(ex.Errors[0].Message);
                    MessageBox.Show(errorMess.ToString());
                }
            }
        }
        private void btnSwapAdmin_Click(object sender, EventArgs e)
        {
            StringBuilder errorMess = new StringBuilder();
            var confirmResult = MessageBox.Show(string.Format("Bạn có thật sự muốn chuyển phòng {0} sang phòng {1} và ngược lại ", (dtgvDSPhong.Tag as Room).Tenphong, cbRoom.Text), "", MessageBoxButtons.YesNo);
            if (confirmResult == DialogResult.Yes)
            {
                try
                {
                    Room curroom = dtgvDSPhong.Tag as Room;
                    string room = cbRoom.Text;
                    if (curroom == null)
                        MessageBox.Show("Click vào phòng cần chuyển đổi");
                    bool count = RoomDAO.Instance.SwitchRoom(curroom.Tenphong, room, Load_toa_nha());
                    if (count)
                        MessageBox.Show("Hoán đổi thành công!");
                    LoadData(room);
                }
                catch (SqlException ex)
                {
                    errorMess.Append(ex.Errors[0].Message);
                    MessageBox.Show(errorMess.ToString());
                }
            }
        }
        #endregion
        #region LoadStudents
        void LoadStudents()
        {
            dtgvDSSV.Controls.Clear();
            txbName1.DataBindings.Clear();
            txbUserName1.DataBindings.Clear();
            txbRoom1.DataBindings.Clear();
            dtpkDoB1.DataBindings.Clear();
            txbMSSV1.DataBindings.Clear();
            txbSchool1.DataBindings.Clear();
            txbSex1.DataBindings.Clear();
            //txbPhone1.DataBindings.Clear();
           // txbEmail1.DataBindings.Clear();
            txbHomeLand1.DataBindings.Clear();
            txbNationality1.DataBindings.Clear();
            nmTH1.DataBindings.Clear();
            txbtTen1.DataBindings.Clear();
            txbToaNha.DataBindings.Clear();
            txbCMND1.DataBindings.Clear();
            txbName1.DataBindings.Add(new Binding("Text", dtgvDSSV.DataSource, "Hotendem", true, DataSourceUpdateMode.Never));
            txbRoom1.DataBindings.Add(new Binding("Text", dtgvDSSV.DataSource, "Tenphong", true, DataSourceUpdateMode.Never));
            txbMSSV1.DataBindings.Add(new Binding("Text", dtgvDSSV.DataSource, "Mssv", true, DataSourceUpdateMode.Never));
            txbSchool1.DataBindings.Add(new Binding("Text", dtgvDSSV.DataSource, "Truong", true, DataSourceUpdateMode.Never));
            //txbPhone1.DataBindings.Add(new Binding("Text", dtgvDSSV.DataSource, "Sdt", true, DataSourceUpdateMode.Never));
            txbHomeLand1.DataBindings.Add(new Binding("Text", dtgvDSSV.DataSource, "Tinhtp", true, DataSourceUpdateMode.Never));
            txbSex1.DataBindings.Add(new Binding("Text", dtgvDSSV.DataSource, "Gioitinh", true, DataSourceUpdateMode.Never));
            //txbEmail1.DataBindings.Add(new Binding("Text", dtgvDSSV.DataSource, "Email", true, DataSourceUpdateMode.Never));
            txbNationality1.DataBindings.Add(new Binding("Text", dtgvDSSV.DataSource, "Quanhuyen", true, DataSourceUpdateMode.Never));
            nmTH1.DataBindings.Add(new Binding("Text", dtgvDSSV.DataSource, "Namthu", true, DataSourceUpdateMode.Never));
            dtpkDoB1.DataBindings.Add(new Binding("Text", dtgvDSSV.DataSource, "Ngaysinh", true, DataSourceUpdateMode.Never));
            txbUserName1.DataBindings.Add(new Binding("Text", dtgvDSSV.DataSource, "Tendangnhap", true, DataSourceUpdateMode.Never));
            txbtTen1.DataBindings.Add(new Binding("Text", dtgvDSSV.DataSource, "Ten", true, DataSourceUpdateMode.Never));
            txbToaNha.DataBindings.Add(new Binding("Text", dtgvDSSV.DataSource, "Tentoanha", true, DataSourceUpdateMode.Never));
            txbCMND1.DataBindings.Add(new Binding("Text", dtgvDSSV.DataSource, "CMND", true, DataSourceUpdateMode.Never));
        }





        #endregion
        #region tabcontrol2
        private void btnAdd1_Click(object sender, EventArgs e)
        {
            StringBuilder errorMess = new StringBuilder();
            var confirmResult = MessageBox.Show("Bạn có chắc muốn thêm sinh viên này vao phòng ????", "Thêm thành công!!!!", MessageBoxButtons.YesNo);
            if (confirmResult == DialogResult.Yes)
            {
                try
                {
                    string tendangnhap = txbUserName1.Text;
                    string hovatendem = txbName1.Text;
                    string ten = txbtTen1.Text;
                    string d = dtpkDoB1.Value.ToString();
                    string ngaysinh = d.Substring(0, 10);
                    string cmnd = txbCMND1.Text;
                    string gioitinh = txbSex1.Text;
                    string quanhuyen = txbNationality1.Text;
                    string tinh = txbHomeLand1.Text;
                    string MSSV = txbMSSV1.Text;
                    string truong = txbSchool1.Text;
                    int SVNam = Convert.ToInt32(nmTH1.Text);
                    string phong = txbRoom1.Text;
                    string toanha = txbToaNha.Text;
                    DataTable data = RoomDAO.Instance.LoadRoomType(phong, toanha);
                    string s = data.Rows[0]["Tinh_trang"].ToString();

                    if (string.Compare(s, "Đầy") == 0)// khac nhau
                        MessageBox.Show("Phòng " + phong + " đã đầy!");
                    else
                    {
                        bool rv = StudentsDAO.Instance.InsertStudent(tendangnhap, hovatendem, ten, ngaysinh, cmnd, gioitinh, quanhuyen, tinh, MSSV, truong, SVNam, phong, toanha);
                        if (rv)
                            MessageBox.Show("Thêm thành công!");
                        LoadData(phong);
                    }
                }
                catch (SqlException ex)
                {
                    errorMess.Append(ex.Errors[0].Message);
                    MessageBox.Show(errorMess.ToString());
                }
            }
        }

        private void btnEdit1_Click(object sender, EventArgs e)
        {
            //string username = txbUserName1.Text;
            //string name = txbName1.Text;
            //string room = txbRoom1.Text;
            //string d = dtpkDoB1.Value.ToString();
            //string date = d.Substring(0, 10);
            //string MSSV = txbMSSV1.Text;
            //string School = txbSchool1.Text;
            //string Sex = txbSex1.Text;
           
            //string homeland = txbHomeLand1.Text;
            //string nationality = txbNationality1.Text;
            //int SVNam = Convert.ToInt32(nmTH1.Text);
            //if (StudentsDAO.Instance.EditStudent(username, name, room, date, MSSV, School, Phone, homeland, Sex, Email, nationality, SVNam))
            //{
            //    if (AccountDAO.Instance.EditAccount(username, name, room))
            //        MessageBox.Show("Chỉnh sửa thành công!");
            //}
            //else
            //    MessageBox.Show("Chỉnh sửa thất bại, hãy thử lại");
            //LoadData(room);
        }

        private void btnDelete1_Click(object sender, EventArgs e)
        {
            StringBuilder errorMess = new StringBuilder();
            var confirmResult = MessageBox.Show("Bạn có chắc muốn xóa sinh viên này ra khỏi phòng ????", "Confirm Update!!!!", MessageBoxButtons.YesNo);
            if (confirmResult == DialogResult.Yes)
            {
                try
                {
                    string tdn = txbUserName1.Text;
                    string phong = txbRoom1.Text;
                    string toa = txbToaNha.Text;
                    bool count = StudentsDAO.Instance.DeleteStudent(tdn, toa, phong);
                    if (count)
                        MessageBox.Show("Xóa thành công!");
                    LoadData(phong);
                }
                catch (SqlException ex)
                {
                    errorMess.Append(ex.Errors[0].Message);
                    MessageBox.Show(errorMess.ToString());
                }
            }
        }


        private void btnResetPassword_Click(object sender, EventArgs e)
        {
            string username = txbUserName1.Text;

            if (AccountDAO.Instance.ResetPassword(username))
                MessageBox.Show("Reset Password thành công");
            else
                MessageBox.Show("Reset Password thất bại, hãy thử lại");

        }

        #endregion
        #region tabcontrol 3: bill
        void LoadListBill()
        {
            billList.DataSource = BillDAO.Instance.GetListBill();
        }
        void LoadBillInfo()
        {
            txbID.Controls.Clear();
            txbRoomB.Controls.Clear();
            txbMonth.Controls.Clear();
            txbPreWaterIndex.Controls.Clear();
            txbCurWaterIndex.Controls.Clear();
            txbPreElectricIndex.Controls.Clear();
            txbCurElectricIndex.Controls.Clear();
            txtBillStatus.Controls.Clear();
            dtpkPayDate.Controls.Clear();
            txbID.DataBindings.Add(new Binding("Text", dtgvBill.DataSource, "ID", true, DataSourceUpdateMode.Never));
            txbRoomB.DataBindings.Add(new Binding("Text", dtgvBill.DataSource, "Phòng", true, DataSourceUpdateMode.Never));
            txbMonth.DataBindings.Add(new Binding("Text", dtgvBill.DataSource, "Tháng", true, DataSourceUpdateMode.Never));
            txbPreWaterIndex.DataBindings.Add(new Binding("Text", dtgvBill.DataSource, "Chỉ số nước tháng trước", true, DataSourceUpdateMode.Never));
            txbCurWaterIndex.DataBindings.Add(new Binding("Text", dtgvBill.DataSource, "Chỉ số nước tháng này", true, DataSourceUpdateMode.Never));
            txbPreElectricIndex.DataBindings.Add(new Binding("Text", dtgvBill.DataSource, "Chỉ số điện thánng trước", true, DataSourceUpdateMode.Never));
            txbCurElectricIndex.DataBindings.Add(new Binding("Text", dtgvBill.DataSource, "Chỉ số điện tháng này", true, DataSourceUpdateMode.Never));
            txtBillStatus.DataBindings.Add(new Binding("Text", dtgvBill.DataSource, "Tình trạng", true, DataSourceUpdateMode.Never));
            dtpkPayDate.DataBindings.Add(new Binding("Text", dtgvBill.DataSource, "Ngày thanh toán", true, DataSourceUpdateMode.Never));



        }



        private void btnAddBill_Click(object sender, EventArgs e)
        {
            string Room = txbRoomB.Text;
            int month = Convert.ToInt32(txbMonth.Text);
            int PreWaterIndex = Convert.ToInt32(txbPreWaterIndex.Text);
            int CurWaterIndex = Convert.ToInt32(txbCurWaterIndex.Text);
            int PreElectricIndex = Convert.ToInt32(txbPreElectricIndex.Text);
            int CurElectricIndex = Convert.ToInt32(txbCurElectricIndex.Text);
            string Status = txtBillStatus.Text;
            if (BillDAO.Instance.InsertBill(Room, PreWaterIndex, CurWaterIndex, PreElectricIndex, CurElectricIndex, Status, month))
                MessageBox.Show("Thêm hóa đơn thành công");
            else
                MessageBox.Show("Thêm hóa đơn thất bại, hãy thử lại");
            LoadListBill();
        }

        private void btnEditBill_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(txbID.Text);
            string Room = txbRoomB.Text;
            int month = Convert.ToInt32(txbMonth.Text);
            int PreWaterIndex = Convert.ToInt32(txbPreWaterIndex.Text);
            int CurWaterIndex = Convert.ToInt32(txbCurWaterIndex.Text);
            int PreElectricIndex = Convert.ToInt32(txbPreElectricIndex.Text);
            int CurElectricIndex = Convert.ToInt32(txbCurElectricIndex.Text);
            string Status = txtBillStatus.Text;
            if (BillDAO.Instance.EditBill(id, Room, PreWaterIndex, CurWaterIndex, PreElectricIndex, CurElectricIndex, Status, month))
                MessageBox.Show("Chỉnh sửa hóa đơn thành công");
            else
                MessageBox.Show("Chỉnh sửa hóa đơn thất bại, hãy thử lại");
            LoadListBill();
        }

        private void btnDeleteBill_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(txbID.Text);
            if (BillDAO.Instance.DeleteBill(id))
                MessageBox.Show("Xóa hóa đơn thành công");
            else
                MessageBox.Show("Xóa hóa đơn thất bại, hãy thử lại");
            LoadListBill();
        }
        #endregion

        private void btnPay_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(txbID.Text);
            if (BillDAO.Instance.PayBill(id))
                MessageBox.Show("Thanh toán hóa đơn thành công");
            else
                MessageBox.Show("Thanh toán hóa đơn thất bại, hãy thử lại");
            LoadListBill();
        }

        

        private void thôngTinCáNhânToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fChangeInfo f = new fChangeInfo(LoginAccount);
            this.Hide();
            f.UpdateAccount += F_UpdateAccount;
            f.ShowDialog();// khi tắt showdialog thì show() hiện lên
            this.Show();


        }

        private void F_UpdateAccount(object sender, fChangeInfo.AccountEvent e)
        {
            thôngTinTàiKhoảnToolStripMenuItem.Text = "Thông tin tài khoản (" + e.Acc.Hovatendem + e.Acc.Ten + ")";
        }

       
    }
}
