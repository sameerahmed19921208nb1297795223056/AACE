using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using Newtonsoft.Json;
using MySql.Data.MySqlClient;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{
    campaignBLL cmpnObj = new campaignBLL();
    DataAccessLayer dalObj;
    string errMsg = string.Empty;
    public WebService()
    {
        dalObj = new DataAccessLayer();
    }

    [WebMethod]
    public string getDataForPaiChart(int cmpnId)
    {
        try
        {
            string json = "";
            cmpnObj.campaignId = cmpnId.ToString();
            DataTable dtTemp = cmpnObj.getCampaignDetailsForView();
            DataTable dtCmpnReport = new DataTable();
            string qry = "";
            int cnt = 1;
            for (int i = 3; i < dtTemp.Columns.Count; i++)
            {
                if (dtTemp.Rows[0][i].ToString() != "")
                {
                    if (i == 3)
                    {
                        qry += string.Format(@"select count(case when digit={0} then 1 end)y ,Option{0} label
from campaignmaster cm, campaignReports cp where cm.campaignId=cp.campaignId and cm.campaignId={1}", cnt, cmpnId);
                    }
                    else
                    {
                        qry += string.Format(@" union select count(case when digit={0} then 1 end)y ,Option{0} label
from campaignmaster cm, campaignReports cp where cm.campaignId=cp.campaignId and cm.campaignId={1}", cnt, cmpnId);
                    }
                }
                cnt++;
            }
            if (dtTemp.Columns.Count > 0)
            {
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    cmd.CommandText = qry;
                    dtCmpnReport = dalObj.getSelectDataByInlineQuery(cmd, out errMsg);
                }
            }
            if (dtCmpnReport.Rows.Count > 0)
            {
                json = JsonConvert.SerializeObject(dtCmpnReport, Newtonsoft.Json.Formatting.Indented);
                return json;
            }
            else
            {
                return json;
            }
        }
        catch (Exception)
        {
            return "";
        }
    }

    [WebMethod]
    public string votersDetialsBarGraph()
    {
        string json = string.Empty;
        DataSet dsBarGraph = cmpnObj.getAllBarGraphData();
        if (dsBarGraph.Tables[0].Rows.Count > 0)
        {
            json = JsonConvert.SerializeObject(dsBarGraph, Newtonsoft.Json.Formatting.Indented);
            return json;
        }
        else
        {
            return json;
        }
    }

    [WebMethod]
    public string getCampaignMaster(string campaignId)
    {
        cmpnObj.campaignId = campaignId;
        DataTable dtTemp = cmpnObj.getCampaignDetailsForView();
        string[] tblcolumns = { "Campaign Name", "Campaign Description", "Option 1", "Option 2", "Option 3", "Option 4", "Option 5", "Option 6", "Option 7", "Option 8" };
        string tbl = "<table id='classTable' class='table table-bordered table-responsive-md'>";
        for (int i = 1; i < dtTemp.Columns.Count; i++)
        {
            if (!string.IsNullOrEmpty(dtTemp.Rows[0][dtTemp.Columns[i].ColumnName].ToString()))
                tbl += "<tr><td><b>" + tblcolumns[i - 1] + "</b></td><td>" + dtTemp.Rows[0][dtTemp.Columns[i].ColumnName].ToString() + "</td></tr>";
        }
        tbl += "</table>";
        return tbl;
    }

    [WebMethod]
    public string getCampaignDetails(string campaignId)
    {
        cmpnObj.campaignId = campaignId;
        DataTable dtTemp = cmpnObj.getCampaignDetailsByCampId();
        string[] tblColumns = { "<b>Campaign Name</b>", "<b>Constituency Name</b>", "<b>Community Name</b>", "<b>Region Name</b>", "<b>Area Name</b>", "<b>Booth No</b>" };
        string tbl = "<table id='classTable' class='table table-bordered table-responsive-md'><tr>";
        for (int i = 0; i <= dtTemp.Rows.Count; i++)
        {
            for (int j = 0; j < dtTemp.Columns.Count; j++)
            {
                if (i == 0)
                {
                    tbl += "<td>" + tblColumns[j] + "</td>";
                }
                else
                {
                    if (j == 0)
                        tbl += "</tr><tr>";
                    tbl += "<td>" + dtTemp.Rows[i - 1][j].ToString() + "</td>";
                }
            }
        }
        tbl += "</tr></table>";
        return tbl;
    }

}
