using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class windows_logInPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void submitUser(object sender, EventArgs e)
    {
        if (txtUserName.Text == "admin" && txtPassword.Text == "admin")
        {
            Session["username"] = Session["password"] = txtUserName.Text;
            Response.Redirect("dashboard.aspx");
        }
    }
    protected void forgetEmail(object sender, EventArgs e)
    {

    }
}