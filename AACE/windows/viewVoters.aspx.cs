using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class windows_viewVoters : System.Web.UI.Page
{
    VoterBLL votObj = new VoterBLL();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                bindVoters();
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (RepeaterItem item in rptVoters.Items)
            {
                CheckBox chk = (CheckBox)item.FindControl("chkRow");
                HiddenField hf = (HiddenField)item.FindControl("hfId");
                if (chk.Checked)
                {
                    votObj.voterId = votObj.voterId + hf.Value + ",";
                }
            }
            votObj.voterId = votObj.voterId.TrimEnd(',');
            if (votObj.deleteVotersById(votObj))
            {

                ScriptManager.RegisterStartupScript(this, GetType(), "script", "SavedSuccessfully('Record Deleted Successfully');", true);
                bindVoters();
            }
            else
            {
               
                ScriptManager.RegisterStartupScript(this, GetType(), "script", "SavedSuccessfully('Failed To Delete');", true);
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void btn_VotersEdit(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("editVoter.aspx?id=" + ((LinkButton)sender).CommandArgument);
        }
        catch (Exception ex)
        {

            throw;
        }
    }

    private void bindVoters()
    {
        votObj.voterId = "%";
        DataTable dtTemp = votObj.getVotersDetails();
        if (dtTemp.Rows.Count > 0)
        {
            rptVoters.DataSource = dtTemp;
            rptVoters.DataBind();
        }
        else
        {
            rptVoters.DataSource = null;
            rptVoters.DataBind();
        }
    }
}