using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class windows_communityAdd : System.Web.UI.Page
{
    constituencyBLL constObj = new constituencyBLL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            BindCommunity();

        }

    }

    void BindCommunity()
    {
        constObj.communityId = "%";
        DataTable dtTemp = constObj.getCommunityDetails();
        rptCommunity.DataSource = dtTemp;
        rptCommunity.DataBind();

    }


    protected void lbEdit_Click(object sender, EventArgs e)
    {

        constObj.communityId = ((LinkButton)sender).CommandArgument;
        DataTable dt = constObj.getCommunityDetails();
        if (dt.Rows.Count > 0)
        {
            txt_Community.Text = dt.Rows[0]["communityName"].ToString();
            btn_Save.Text = "Update";
            btn_Save.CommandArgument = constObj.communityId;

        }

    }

    protected void lbDelete_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton comId = (LinkButton)sender;
            constObj.communityId = comId.CommandArgument;
            constObj.deletCommunityById();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "SavedSuccessfully('Deleted');", true);
            BindCommunity();

        }
        catch (Exception ex)
        { }
    }
    protected void btn_Save_Click(object sender, EventArgs e)
    {
        if (btn_Save.Text == "Save")
        {
            try
            {
                constObj.communityName = txt_Community.Text.Trim();
                if (constObj.saveCommunity())
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "SavedSuccessfully('Saved');", true);
                    txt_Community.Text = "";
                    BindCommunity();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "SavedSuccessfully('Failed to Saved');", true);
                }
            }
            catch (Exception ex)
            {
            }
        }
        else
        {
            constObj.communityId = btn_Save.CommandArgument;
            constObj.communityName = txt_Community.Text.Trim();
            if (constObj.updateCommunity())
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "SavedSuccessfully('Updated');", true);
                txt_Community.Text = "";
                btn_Save.Text = "Save";
                BindCommunity();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "SavedSuccessfully('Failed to Updates');", true);

            }

        }

    }
}