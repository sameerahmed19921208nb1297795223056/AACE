using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ClosedXML;
using System.IO;

public partial class windows_campaignReport : System.Web.UI.Page
{

    campaignBLL cmpObj = new campaignBLL();
    VoterBLL votObj = new VoterBLL();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                bindCommunity();
                bindConstituency();
                ddlRegion.Items.Insert(0, new ListItem("All Region", "%"));
                ddlArea.Items.Insert(0, new ListItem("All Area", "%"));
                ddlBoothNo.Items.Insert(0, new ListItem("All Booth No", "%"));
                LoadCampaignReports();
            }
        }
        catch (Exception ex)
        {

        }
    }

    void LoadCampaignReports()
    {
        cmpObj.comId = ddlCommunity.SelectedValue;
        cmpObj.constid = ddlConstituency.SelectedValue;
        cmpObj.regid = ddlRegion.SelectedValue;
        cmpObj.areaid = ddlArea.SelectedValue;
        cmpObj.boothid = ddlBoothNo.SelectedValue;
        DataTable dtReport = cmpObj.getCampaignReports();
        if (dtReport.Rows.Count > 0)
        {
            rptCampaignReports.DataSource = cmpObj.getCampaignReports();
            rptCampaignReports.DataBind();
        }
        else
        {
            rptCampaignReports.DataSource = null;
            rptCampaignReports.DataBind();
        }

    }

    protected void lbViewReports_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lbView = (LinkButton)sender;
            Response.Redirect("campaignReportDetails.aspx?Id=" + lbView.CommandArgument + "&Title=" + lbView.CommandName);
        }
        catch (Exception)
        {

        }
    }

    void bindCommunity()
    {
        votObj.comId = "%";
        ddlCommunity.DataSource = votObj.getCommunityMaster();
        ddlCommunity.DataValueField = "CommunityId";
        ddlCommunity.DataTextField = "communityName";
        ddlCommunity.DataBind();
        ddlCommunity.Items.Insert(0, new ListItem("All Community", "%"));
    }

    void bindConstituency()
    {
        votObj.constId = "%";
        ddlConstituency.DataSource = votObj.getConstituencyMasterByID();
        ddlConstituency.DataValueField = "constituencyId";
        ddlConstituency.DataTextField = "constituencyName";
        ddlConstituency.DataBind();
        ddlConstituency.Items.Insert(0, new ListItem("All Constituency", "%"));

    }

    void bindRegion(string constituencyId)
    {
        votObj.constId = constituencyId;
        ddlRegion.DataSource = votObj.getRegionMasterByConstId();
        ddlRegion.DataValueField = "regionId";
        ddlRegion.DataTextField = "regName";
        ddlRegion.DataBind();
        ddlRegion.Items.Insert(0, new ListItem("All Region", "%"));
    }

    void bindArea(string regionId)
    {
        votObj.regId = regionId;
        ddlArea.DataSource = votObj.getAreaMasterByRegionId();
        ddlArea.DataValueField = "areaId";
        ddlArea.DataTextField = "areaName";
        ddlArea.DataBind();
        ddlArea.Items.Insert(0, new ListItem("All Area", "%"));
    }

    void bindBooth(string areaId)
    {
        votObj.areaId = areaId;
        ddlBoothNo.DataSource = votObj.getBoothMasterByAreaId();
        ddlBoothNo.DataValueField = "boothId";
        ddlBoothNo.DataTextField = "boothNo";
        ddlBoothNo.DataBind();
        ddlBoothNo.Items.Insert(0, new ListItem("All Booth No", "%"));
    }

    protected void ddlConstituency_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            bindRegion(ddlConstituency.SelectedValue);
            ddlArea.Items.Clear();
            ddlArea.Items.Insert(0, new ListItem("All Area", "%"));
            ddlBoothNo.Items.Clear();
            ddlBoothNo.Items.Insert(0, new ListItem("All Booth No", "%"));
        }
        catch (Exception ex)
        { }
    }

    protected void ddlRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            bindArea(ddlRegion.SelectedValue);
            ddlBoothNo.Items.Clear();
            ddlBoothNo.Items.Insert(0, new ListItem("All Booth No", "%"));
        }
        catch (Exception ex)
        { }
    }

    protected void ddlArea_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            bindBooth(ddlArea.SelectedValue);
        }
        catch (Exception ex)
        { }
    }

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        try
        {
            LoadCampaignReports();
        }
        catch (Exception ex)
        { }
    }

    protected void exportToExcel_Click(object sender, EventArgs e)
    {
        LinkButton btnOption = (LinkButton)sender;
        var value = btnOption.CommandArgument;
        var Opt = btnOption.CommandName;
        cmpObj.campaignId = value.ToString();
        cmpObj.option = Opt.ToString();
        DataTable dtTemp = cmpObj.getCampaignReportDetailsByCampaignId(cmpObj);
        if (dtTemp.Rows.Count > 0)
        {
            dtTemp.Columns["VoterName"].SetOrdinal(0);
            dtTemp.Columns["Issues"].SetOrdinal(1);
            dtTemp.Columns["Complaint"].SetOrdinal(2);

            ClosedXML.Excel.XLWorkbook wbook = new ClosedXML.Excel.XLWorkbook();
            wbook.Worksheets.Add(dtTemp, "tab1");
            // Prepare the response
            HttpResponse httpResponse = Response;
            httpResponse.Clear();
            httpResponse.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            //Provide you file name here
            httpResponse.AddHeader("content-disposition", "attachment;filename=\"CampaignReportIssues.xlsx\"");

            // Flush the workbook to the Response.OutputStream
            using (MemoryStream memoryStream = new MemoryStream())
            {
                wbook.SaveAs(memoryStream);
                memoryStream.WriteTo(httpResponse.OutputStream);
                memoryStream.Close();
            }
            httpResponse.End();
        }

    }
}