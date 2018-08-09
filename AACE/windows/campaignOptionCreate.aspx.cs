using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class windows_campaignOptionCreate : System.Web.UI.Page
{
    campaignBLL cmpinObj = new campaignBLL();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                bindRepeater();
            }
        }
        catch (Exception)
        {

        }
    }

    private void bindRepeater()
    {
        DataTable dtCampaignOptions = cmpinObj.getAllOptionsByCampaignType("%");
        rptCampaignOptions.DataSource = dtCampaignOptions;
        rptCampaignOptions.DataBind();
    }

    protected void btn_Save_Click(object sender, EventArgs e)
    {
        if (btn_Save.Text == "Save")
        {
            try
            {
                if (!string.IsNullOrEmpty(txt_Option.Text))
                {
                    cmpinObj.campaignType = ddlCampaigntype.SelectedItem.ToString();
                    cmpinObj.option = txt_Option.Text.Trim();
                    if (cmpinObj.SaveCampaignOption(cmpinObj))
                    {
                        txt_Option.Text = "";
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "SavedSuccessfully('Record Saved Successfully');", true);
                        bindRepeater();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "SavedSuccessfully('Failed To Save');", true);
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }
        else
        {

            if (!string.IsNullOrEmpty(txt_Option.Text))
            {
                cmpinObj.campaignId = btn_Save.CommandArgument;
                cmpinObj.campaignType = ddlCampaigntype.SelectedItem.ToString();
                cmpinObj.option = txt_Option.Text.Trim();
                if (cmpinObj.UpdateCampaignOption(cmpinObj))
                {
                    txt_Option.Text = "";
                    btn_Save.Text = "Save";
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "SavedSuccessfully('Recored Updated Successfully');", true);
                    bindRepeater();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "SavedSuccessfully('Failed to Updated');", true);
                }
            }
        }
    }

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        ddlCampaigntype.ClearSelection();
        txt_Option.Text = "";
    }

    protected void lbEdit_Click(object sender, EventArgs e)
    {
        cmpinObj.campaignId = ((LinkButton)sender).CommandArgument;
        DataTable dt = cmpinObj.editCampaignOption(cmpinObj);
        if (dt.Rows.Count > 0)
        {
            ddlCampaigntype.ClearSelection();
            ddlCampaigntype.Items.FindByText(dt.Rows[0]["campaignType"].ToString()).Selected = true;
            txt_Option.Text = dt.Rows[0]["campaignOption"].ToString();
            btn_Save.Text = "Update";
            btn_Save.CommandArgument = cmpinObj.campaignId;
        }
    }

    protected void lbDelete_Click(object sender, EventArgs e)
    {
        cmpinObj.campaignId = ((LinkButton)sender).CommandArgument;
        if (cmpinObj.deletecampaignOption(cmpinObj))
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "SavedSuccessfully('Record Deleted Successfully');", true);
            bindRepeater();
        }
        else
        {

        }
    }
}