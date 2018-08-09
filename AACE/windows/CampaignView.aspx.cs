using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Threading;
public partial class windows_CampaignView : System.Web.UI.Page
{
    VoterBLL votObj = new VoterBLL();
    generalClass gnrlObj = new generalClass();
    campaignBLL cmpinObj = new campaignBLL();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                bindCampaigns();
                div2.Visible = false;
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnCall_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btnCall = (LinkButton)sender;

            cmpinObj.campaignId = btnCall.CommandArgument;
            DataTable dtCmpinDetails = cmpinObj.getCampaignById(cmpinObj);
            for (int i = 0; i < dtCmpinDetails.Rows.Count; i++)
            {
                string[] campaign = new string[9];
                campaign[0] = dtCmpinDetails.Rows[i]["campaignDescription"].ToString();
                campaign[1] = dtCmpinDetails.Rows[i]["option1"].ToString();
                campaign[2] = dtCmpinDetails.Rows[i]["option2"].ToString();
                campaign[3] = dtCmpinDetails.Rows[i]["option3"].ToString();
                campaign[4] = dtCmpinDetails.Rows[i]["option4"].ToString();
                campaign[5] = dtCmpinDetails.Rows[i]["option5"].ToString();
                campaign[6] = dtCmpinDetails.Rows[i]["option6"].ToString();
                campaign[7] = dtCmpinDetails.Rows[i]["option7"].ToString();
                campaign[8] = dtCmpinDetails.Rows[i]["option8"].ToString();

                cmpinObj.comId = dtCmpinDetails.Rows[i]["comId"].ToString();
                cmpinObj.constid = dtCmpinDetails.Rows[i]["constid"].ToString();
                cmpinObj.regid = dtCmpinDetails.Rows[i]["regid"].ToString();
                cmpinObj.areaid = dtCmpinDetails.Rows[i]["areaid"].ToString();
                cmpinObj.boothid = dtCmpinDetails.Rows[i]["boothId"].ToString();
                DataTable dtTemp = cmpinObj.GetCampaignContacts();
                Application["campaign"] = campaign;
                Application["campaignId"] = Convert.ToInt16(btnCall.CommandArgument);
                if (dtTemp.Rows.Count > 0)
                {
                    for (int j = 0; j < dtTemp.Rows.Count; j++)
                    {
                        if (dtTemp.Rows[j]["primaryContactNo"].ToString() != "" && dtTemp.Rows[j]["primaryContactNo"].ToString() != null)
                        {
                            gnrlObj.sendVoiceMail(dtTemp.Rows[j]["primaryContactNo"].ToString());
                        }
                        else if (dtTemp.Rows[j]["secondryContactNo"].ToString() != "" && dtTemp.Rows[j]["secondryContactNo"].ToString() != null)
                        {
                            gnrlObj.sendVoiceMail(dtTemp.Rows[j]["secondryContactNo"].ToString());
                        }
                    }
                }
                else
                {

                }
            }
        }
        catch (Exception)
        {

        }
    }

    protected void btnSms_Click(object sender, EventArgs e)
    {

    }

    protected void btnViewCampaign_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton btnViewCampaign = (LinkButton)sender;
            cmpinObj.campaignId = btnViewCampaign.CommandArgument;
            div1.Visible = false;
            div2.Visible = true;
            cmpinObj.campaignId = btnViewCampaign.CommandArgument;
            DataTable dtTemp = cmpinObj.getCampaignDetailsForView();
            if (dtTemp.Rows.Count > 0)
            {
                rptCamDetailsView.DataSource = dtTemp;
                rptCamDetailsView.DataBind();
            }
            else
            {
                rptCampaignView.DataSource = null;
                rptCampaignView.DataBind();
            }

        }
        catch (Exception ex)
        {

            throw;
        }
    }

    private void bindCampaigns()
    {
        cmpinObj.campaignId = "%";
        DataTable dtTemp = cmpinObj.getCampaignDetails();
        if (dtTemp.Rows.Count > 0)
        {
            rptCampaignView.DataSource = dtTemp;
            rptCampaignView.DataBind();
        }
        else
        {
            rptCampaignView.DataSource = null;
            rptCampaignView.DataBind();
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        div1.Visible = true;
        div2.Visible = false;
    }

    protected void btn_Campaign_Delete(object sender, EventArgs e)
    {
        try
        {
            cmpinObj.campaignId = ((LinkButton)sender).CommandArgument;
            if (cmpinObj.deleteCampaignByCampaignId())
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "SavedSuccessfully('Record Deleted Successfully');", true);
                bindCampaigns();
            }
            else
            { }
        }
        catch (Exception ex)
        {
            ex.Message.ToString();
        }
    }
}