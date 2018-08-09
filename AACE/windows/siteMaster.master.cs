using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Collections;

public partial class windows_siteMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (String.IsNullOrEmpty(Convert.ToString(Session["username"])) || String.IsNullOrEmpty(Convert.ToString(Session["password"])))
        {
            Response.Redirect("logInPage.aspx");
        }
    }
    protected void clearSessions(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("logInPage.aspx");

    }
}
