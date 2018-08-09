using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;
using System.Configuration;

/// <summary>
/// Summary description for campaignBLL
/// </summary>
public class campaignBLL
{
    #region Data Members
    DataAccessLayer dalObj = null;
    public string campaignId { get; set; }
    public int voterId { get; set; }
    public int digit { get; set; }
    public string callfrom { get; set; }
    public string sId { get; set; }
    public string primaryContactNo { get; set; }
    public string errMsg = string.Empty;
    public string campTitle { get; set; }
    public string campDesc { get; set; }
    public string opt1 { get; set; }
    public string opt2 { get; set; }
    public string opt3 { get; set; }
    public string opt4 { get; set; }
    public string opt5 { get; set; }
    public string opt6 { get; set; }
    public string opt7 { get; set; }
    public string opt8 { get; set; }
    public string campaignType { get; set; }
    public string option { get; set; }
    public string comId { get; set; }
    public string boothid { get; set; }
    public string regid { get; set; }
    public string constid { get; set; }
    public string areaid { get; set; }
    public string recordedFile { get; set; }
    public int recordDuration { get; set; }
    public string callStatus { get; set; }

    //Community Master
    public string communityName { get; set; }

    //Area Master
    public string areaName { get; set; }
    #endregion

    public campaignBLL()
    {
        dalObj = new DataAccessLayer();
    }

    public bool SaveCampaignReports(campaignBLL cmpinObj)
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "saveCampaignReports";
            cmd.Parameters.AddWithValue("_campaignId", cmpinObj.campaignId);
            cmd.Parameters.AddWithValue("_primaryContactNo", cmpinObj.primaryContactNo);
            cmd.Parameters.AddWithValue("_digit", cmpinObj.digit);
            cmd.Parameters.AddWithValue("_callFrom", cmpinObj.callfrom);
            cmd.Parameters.AddWithValue("_sId", cmpinObj.sId);
            cmd.Parameters.AddWithValue("_dateCreated", DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss"));
            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }

    public bool saveRecordedFile(campaignBLL cmpinObj)
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "saveRecordedFile";
            cmd.Parameters.AddWithValue("_recordedFile", cmpinObj.recordedFile);
            cmd.Parameters.AddWithValue("_recordDuration", cmpinObj.recordDuration);
            cmd.Parameters.AddWithValue("_callStatus", cmpinObj.callStatus);
            cmd.Parameters.AddWithValue("_sId", cmpinObj.sId);
            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }

    //created by pavan but not being used 
    public DataTable getCompaignDetailsById()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getCompaignDetailsById";
            cmd.Parameters.AddWithValue("_campaignId", campaignId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }

    public DataTable getAllCampaigns()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getAllCampaigns";
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }

    public DataTable GetCampaignContacts()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getCampaignContacts";
            cmd.Parameters.AddWithValue("_comId", comId);
            cmd.Parameters.AddWithValue("_boothid", boothid);
            cmd.Parameters.AddWithValue("_regid", regid);
            cmd.Parameters.AddWithValue("_constid", constid);
            cmd.Parameters.AddWithValue("_areaid", areaid);

            return dalObj.getSelectData(cmd, out errMsg);

        }
    }

    public DataTable getAllOptionsByCampaignType(string rblCampaignType)
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getAlloptionsByCampaignType";
            cmd.Parameters.AddWithValue("_campaignType", rblCampaignType);
            return dalObj.getSelectData(cmd, out errMsg);

        }
    }

    public bool SaveCampaignOption(campaignBLL cmpinObj)
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "saveCampaignOptions";
            cmd.Parameters.AddWithValue("_campaignType", campaignType);
            cmd.Parameters.AddWithValue("_option", option);

            return dalObj.getExecuteData(cmd, out errMsg);
        }

    }

    //Update create campaign details pooja
    public bool updateCampaignMaster(campaignBLL cmpinObj)
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "updateCampaignMaster";
            cmd.Parameters.AddWithValue("_campaignId", campaignId);
            cmd.Parameters.AddWithValue("_campTitle", campTitle);
            cmd.Parameters.AddWithValue("_campDesc", campDesc);
            cmd.Parameters.AddWithValue("_opt1", opt1);
            cmd.Parameters.AddWithValue("_opt2", opt2);
            cmd.Parameters.AddWithValue("_opt3", opt3);
            cmd.Parameters.AddWithValue("_opt4", opt4);
            cmd.Parameters.AddWithValue("_opt5", opt5);
            cmd.Parameters.AddWithValue("_opt6", opt6);
            cmd.Parameters.AddWithValue("_opt7", opt7);
            cmd.Parameters.AddWithValue("_opt8", opt8);
            cmd.Parameters.AddWithValue("_comId", comId);
            cmd.Parameters.AddWithValue("_boothId", boothid);
            cmd.Parameters.AddWithValue("_regId", regid);
            cmd.Parameters.AddWithValue("_constid", constid);
            cmd.Parameters.AddWithValue("_areaid", areaid);

            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }

    //getCampaignDetailsByIdForEdit pooja
    public DataTable getCampaignDetailsByIdForEdit()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getCampaignDetailsByIdForEdit";
            cmd.Parameters.AddWithValue("_campaignId", campaignId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }

    //getCampaignDetails pooja
    public DataTable getCampaignDetails()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getCampaignDetails";
            cmd.Parameters.AddWithValue("_campaignid", campaignId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }

    //getCampaignDetailsForView pooja
    public DataTable getCampaignDetailsForView()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getCampaignDetailsForView";
            cmd.Parameters.AddWithValue("_campaignid", campaignId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }

    public DataTable getCampaignById(campaignBLL cmpinObj)
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getCampaignById";
            cmd.Parameters.AddWithValue("_campaignId", cmpinObj.campaignId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }

    public DataTable getCampaignReports()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getCampaignReports";
            cmd.Parameters.Add("_CommunityId", comId);
            cmd.Parameters.Add("_constituencyId", constid);
            cmd.Parameters.Add("_regionId", regid);
            cmd.Parameters.Add("_areaId", areaid);
            cmd.Parameters.Add("_boothId", boothid);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }

    public bool saveCampaignMasterAndDetails()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "saveCampaignMasterAndDetails";
            cmd.Parameters.AddWithValue("_option1", opt1);
            cmd.Parameters.AddWithValue("_option2", opt2);
            cmd.Parameters.AddWithValue("_option3", opt3);
            cmd.Parameters.AddWithValue("_option4", opt4);
            cmd.Parameters.AddWithValue("_option5", opt5);
            cmd.Parameters.AddWithValue("_option6", opt6);
            cmd.Parameters.AddWithValue("_option7", opt7);
            cmd.Parameters.AddWithValue("_option8", opt8);
            cmd.Parameters.AddWithValue("_campaignTitle", campTitle);
            cmd.Parameters.AddWithValue("_campaignDescription", campDesc);
            cmd.Parameters.AddWithValue("_communityId", comId);
            cmd.Parameters.AddWithValue("_constituencyIds", constid);
            cmd.Parameters.AddWithValue("_regionIds", regid);
            cmd.Parameters.AddWithValue("_areaIds", areaid);
            cmd.Parameters.AddWithValue("_boothIds", boothid);
            return dalObj.getExecuteData(cmd, out errMsg);

        }

    }

    //getAllBarGraphData
    public DataSet getAllBarGraphData()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getAllBarGraphData";
            return dalObj.getSelectDataSet(cmd, out errMsg);
        }
    }

    //deleteCampaignByCampaignId
    public bool deleteCampaignByCampaignId()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "deleteCampaignByCampaignId";
            cmd.Parameters.AddWithValue("_campaignId", campaignId);
            return dalObj.getExecuteData(cmd, out errMsg);

        }

    }

    //deleteCampaignOptionById
    public bool deletecampaignOption(campaignBLL cmpinObj)
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "deleteCampaignOption";
            cmd.Parameters.AddWithValue("_campOptionId", campaignId);
            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }

    //editCampaignOptionById
    public DataTable editCampaignOption(campaignBLL cmpinObj)
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "editCampaignOption";
            cmd.Parameters.AddWithValue("_campOptionId", campaignId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }

    //UpdateCampaignOptionById
    public bool UpdateCampaignOption(campaignBLL cmpinObj)
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "updateCampaignOption";
            cmd.Parameters.AddWithValue("_campOptionId", campaignId);
            cmd.Parameters.AddWithValue("_campaignType", campaignType);
            cmd.Parameters.AddWithValue("_option", option);
            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }

    //getCampaignDetailsByCampId
    public DataTable getCampaignDetailsByCampId()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getCampaignDetailsByCampId";
            cmd.Parameters.AddWithValue("_campaignId", campaignId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }
    //getCampaignReportDetailsByCampaignId

    public DataTable getCampaignReportDetailsByCampaignId(campaignBLL cmpObj)
    {

        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getCampaignReportDetailsByCampaignId";
            cmd.Parameters.AddWithValue("_campaignId", campaignId);
            cmd.Parameters.AddWithValue("_option", option);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }
}