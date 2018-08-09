using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;

public partial class windows_editVoter : System.Web.UI.Page
{
    VoterBLL votObj = new VoterBLL();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                LoadConstituencys();
                LoadCommunity();
                LoadVoterDetails();
            }
        }
        catch (Exception ex)
        {

        }
    }

    void LoadCommunity()
    {
        votObj.comId = "%";
        ddlCommunity.DataSource = votObj.getCommunityMaster();
        ddlCommunity.DataTextField = "communityName";
        ddlCommunity.DataValueField = "communityId";
        ddlCommunity.DataBind();
        ddlCommunity.Items.Insert(0, new ListItem("Select Community", "0"));
    }


    public void LoadVoterDetails()
    {
        if (Request.QueryString["id"] != null && Request.QueryString["id"] != "")
        {
            votObj.voterId = Request.QueryString["id"];
            DataTable dtVoterDetails = votObj.getVotersDetailsById();
            if (dtVoterDetails.Rows.Count > 0)
            {
                txtName.Text = dtVoterDetails.Rows[0]["name"].ToString();
                txtAddress.Text = dtVoterDetails.Rows[0]["address"].ToString();
                ddlCommunity.SelectedValue = dtVoterDetails.Rows[0]["communityId"].ToString();
                txtMobile1.Text = dtVoterDetails.Rows[0]["primaryContactNo"].ToString();
                txtMobile2.Text = dtVoterDetails.Rows[0]["secondryContactNo"].ToString();
                imgProfilePic.ImageUrl = "~/images/profilePics/" + dtVoterDetails.Rows[0]["profilePic"].ToString();
                ddlConstituency.SelectedValue = dtVoterDetails.Rows[0]["constituencyid"].ToString();
                LoadRegions();
                ddlRegion.SelectedValue = dtVoterDetails.Rows[0]["regionid"].ToString();
                LoadAreas();
                ddlArea.SelectedValue = dtVoterDetails.Rows[0]["areaId"].ToString();
                LoadBooths();
                ddlBoothNo.SelectedValue = dtVoterDetails.Rows[0]["boothid"].ToString();

            }
        }
    }




    public void LoadConstituencys()
    {
        votObj.constId = "%";
        ddlConstituency.DataSource = votObj.getConstituencyMasterByID();
        ddlConstituency.DataTextField = "constituencyName";
        ddlConstituency.DataValueField = "constituencyId";
        ddlConstituency.DataBind();
        ddlConstituency.Items.Insert(0, new ListItem("Select Constituency Name", "0"));

    }
    public void LoadRegions()
    {
        votObj.constId = ddlConstituency.SelectedValue;
        ddlRegion.DataSource = votObj.getRegionMaster();
        ddlRegion.DataTextField = "regName";
        ddlRegion.DataValueField = "regionId";
        ddlRegion.DataBind();
        ddlRegion.Items.Insert(0, new ListItem("Select Region Name", "0"));

    }
    public void LoadAreas()
    {
        votObj.regId = ddlRegion.SelectedValue;
        ddlArea.DataSource = votObj.getAreaMasterByRegionId();
        ddlArea.DataTextField = "areaName";
        ddlArea.DataValueField = "areaId";
        ddlArea.DataBind();
        ddlArea.Items.Insert(0, new ListItem("Select Area Name", "0"));
    }

    void LoadBooths()
    {
        votObj.areaId = ddlArea.SelectedValue;
        ddlBoothNo.DataSource = votObj.getBoothMasterByAreaId();
        ddlBoothNo.DataTextField = "boothNo";
        ddlBoothNo.DataValueField = "boothId";
        ddlBoothNo.DataBind();
        ddlBoothNo.Items.Insert(0, new ListItem("Select Booth No", "0"));
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            votObj.voterId = Request.QueryString["id"];
            votObj.name = txtName.Text;
            votObj.address = txtAddress.Text;
            votObj.comId = ddlCommunity.SelectedValue;
            votObj.boothId = ddlBoothNo.SelectedValue;
            votObj.mobile1 = txtMobile1.Text;
            votObj.mobile2 = txtMobile2.Text;
            votObj.profilePic = FileUploaded();
            if (votObj.updateVoterMaster(votObj))
            {
                Response.Redirect("viewVoters.aspx");
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("viewVoters.aspx");
        }
        catch (Exception ex)
        {

        }
    }

    string FileUploaded()
    {
        string _filename = string.Empty;
        try
        {
            if (flupload.HasFile)
            {
                if (flupload.PostedFile.ContentType.Equals("image/jpg") || flupload.PostedFile.ContentType.Equals("image/jpeg") || flupload.PostedFile.ContentType.Equals("image/png") || flupload.PostedFile.ContentType.Equals("image/bmp") || flupload.PostedFile.ContentType.Equals("image/gif"))
                {
                    string fname = votObj.voterId + Path.GetExtension(flupload.FileName);
                    flupload.SaveAs(Server.MapPath("~/images/profilePics/") + fname);
                    _filename = fname;
                }
                else
                {
                    _filename = imgProfilePic.ImageUrl.Replace("~/images/profilePics/", "").Trim();
                }
            }
            else
            {
                _filename = imgProfilePic.ImageUrl.Replace("~/images/profilePics/", "").Trim();
            }

            return _filename;
        }
        catch (Exception ex)
        {
            return _filename = "";
        }
    }
    protected void ddlConstituency_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadRegions();
        ddlArea.Items.Clear();
        ddlBoothNo.Items.Clear();
        ddlArea.Items.Insert(0, new ListItem("Select Area Name", "0"));
        ddlBoothNo.Items.Insert(0, new ListItem("Select Booth No", "0"));
    }
    protected void ddlRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadAreas();
        ddlBoothNo.Items.Clear();
        ddlBoothNo.Items.Insert(0, new ListItem("Select Booth No", "0"));
    }
    protected void ddlArea_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadBooths();
    }
    protected void btnCancel_Click1(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("viewVoters.aspx");
        }
        catch (Exception ex)
        {

            throw;
        }
    }



}