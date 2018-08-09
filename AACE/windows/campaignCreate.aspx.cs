using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using Newtonsoft.Json;

public partial class windows_campaignCreate : System.Web.UI.Page
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

                LoadCommunity();

            }
        }
        catch (Exception)
        {

        }
    }

    void LoadCommunity()
    {
        votObj.comId = "%";
        DataTable dttemp = votObj.getCommunityMaster();
        ddlCommunity.DataSource = dttemp;
        ddlCommunity.DataTextField = "communityName";
        ddlCommunity.DataValueField = "communityId";
        ddlCommunity.DataBind();
        ddlCommunity.Items.Insert(0, new ListItem("All Communitys", string.Join(",", dttemp.AsEnumerable().Select(x => x.Field<int>("communityId").ToString()).ToArray())));
    }

    [WebMethod]
    public static string saveData(string options, string title, string description, string community, string constituency, string region, string area, string boothNo)
    {
        campaignBLL cmpinObj = new campaignBLL();
        List<string> val = options.Split(',').ToList();
        for (int i = val.Count; i < 8; i++)
        {
            val.Add("");
        }

        cmpinObj.opt1 = val[0];
        cmpinObj.opt2 = val[1];
        cmpinObj.opt3 = val[2];
        cmpinObj.opt4 = val[3];
        cmpinObj.opt5 = val[4];
        cmpinObj.opt6 = val[5];
        cmpinObj.opt7 = val[6];
        cmpinObj.opt8 = val[7];
        cmpinObj.opt8 = val[7];
        cmpinObj.campTitle = title;
        cmpinObj.campDesc = description;
        cmpinObj.comId = community;
        cmpinObj.constid = constituency;
        cmpinObj.regid = region;
        cmpinObj.areaid = area;
        cmpinObj.boothid = boothNo;
        cmpinObj.saveCampaignMasterAndDetails();

        return "";

    }

    [WebMethod]
    public static string getAllOptions(string rblCampaignType)
    {
        string JSON = "";
        campaignBLL cmpinObj = new campaignBLL();
        DataTable dtTemp = cmpinObj.getAllOptionsByCampaignType(rblCampaignType);
        JSON = JsonConvert.SerializeObject(dtTemp, Newtonsoft.Json.Formatting.Indented);
        return JSON;
    }

    [WebMethod]
    public static string LoadConstituency(string constId)
    {
        string JSON = "";
        VoterBLL voterObj = new VoterBLL();
        voterObj.constId = constId;
        DataTable dtTemp = voterObj.getConstituencyMasterByID();
        JSON = JsonConvert.SerializeObject(dtTemp, Newtonsoft.Json.Formatting.Indented);
        return JSON;
    }
    [WebMethod]
    public static string loadRegion(string constId)
    {
        string JSON = "";
        VoterBLL voterObj = new VoterBLL();
        voterObj.constId = constId;
        DataTable dtTemp = voterObj.getRegionMaster();
        JSON = JsonConvert.SerializeObject(dtTemp, Newtonsoft.Json.Formatting.Indented);
        return JSON;

    }
    [WebMethod]
    public static string loadArea(string regId)
    {
        string JSON = "";
        VoterBLL voterObj = new VoterBLL();
        voterObj.regId = regId;
        DataTable dtTemp = voterObj.getAreaMasterByRegionId();
        JSON = JsonConvert.SerializeObject(dtTemp, Newtonsoft.Json.Formatting.Indented);
        return JSON;


    }

    [WebMethod]
    public static string loadBooth(string areaId)
    {
        string JSON = "";
        VoterBLL voterObj = new VoterBLL();
        voterObj.areaId = areaId;
        DataTable dtTemp = voterObj.getBoothMasterByAreaId();
        JSON = JsonConvert.SerializeObject(dtTemp, Newtonsoft.Json.Formatting.Indented);
        return JSON;

    }


}