using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;
using System.Configuration;

/// <summary>
/// Summary description for VoterBLL
/// </summary>
public class VoterBLL
{

    #region Data Members

    //Voters Master
   
    public string name { get; set; }
    public string address { get; set; }
    public string comId { get; set; }
    public string boothId { get; set; }
    public string profilePic { get; set; }
    public string mobile1 { get; set; }
    public string mobile2 { get; set; }
    public string constId { get; set; }
    public string regId { get; set; }
    public string areaId { get; set; }
    public string voterId { get; set; }
    public DataTable dtExcelData { get; set; }

    //Community Master
    public string communityName { get; set; }

    //Area Master
    public string areaName { get; set; }

    #endregion

    DataAccessLayer dalObj = null;
    public string errMsg = string.Empty;

    public VoterBLL()
    {
        dalObj = new DataAccessLayer();
    }

    //getCommunityMaster
    public DataTable getCommunityMaster()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getCommunityMaster";
            cmd.Parameters.AddWithValue("_communityId", comId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }

    //getConstituencyMasterByID
    public DataTable getConstituencyMasterByID()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getConstituencyMasterByID";
            cmd.Parameters.AddWithValue("_constituencyId", constId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }
    public DataTable getRegionMaster()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getRegionByConstId";
            cmd.Parameters.AddWithValue("_constituencyId", constId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }
    
    //getVotersDetails
    public DataTable getVotersDetails()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getVotersDetails";
            cmd.Parameters.AddWithValue("_votersId", voterId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }

    //getRegionMasterByConstId
    public DataTable getRegionMasterByConstId()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getRegionMasterByConstId";
            cmd.Parameters.AddWithValue("_constId", constId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }

    //getAreaMasterByRegionId
    public DataTable getAreaMasterByRegionId()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getAreaMasterByRegionId";
            cmd.Parameters.AddWithValue("_regId", regId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }


    //getBoothMasterByAreaId
    public DataTable getBoothMasterByAreaId()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getBoothMasterByAreaId";
            cmd.Parameters.AddWithValue("_areaId", areaId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }

    //Add Voters
    public int saveVotersMaster(VoterBLL votObj)
    {
        try
        {
            int rec = 0; int cnt = 0;
            string query = "INSERT INTO votermaster (name,address,comId,boothId,profilePic,primaryContactNo,secondryContactNo,dateCreated,dateModified) VALUES\n";
            for (int i = 0; i < votObj.dtExcelData.Rows.Count; i++)
            {
                query = query + string.Format(@"('{0}','{1}',{2},{3},'default.png','{4}','{5}',NOW(),NOW()),",
                                                votObj.dtExcelData.Rows[i]["Name"], votObj.dtExcelData.Rows[i]["Address"],
                                                votObj.comId, votObj.boothId,
                                                votObj.dtExcelData.Rows[i]["Phone1"], votObj.dtExcelData.Rows[i]["Phone2"]);
                if ((i + 1) % 100 == 0)
                {
                    query = query.TrimEnd(',');
                    rec = executeQuery(query);
                    if (rec > 0)
                    {
                        cnt = cnt + rec;
                        query = "INSERT INTO votermaster (name,address,comId,boothId,profilePic,primaryContactNo,secondryContactNo,dateCreated,dateModified) VALUES\n";
                    }
                }
            }
            if (!string.IsNullOrEmpty(query))
            {
                query = query.TrimEnd(',');
                rec = executeQuery(query);
                if (rec > 0)
                    cnt = cnt + rec;
            }

            return cnt;
        }
        catch (Exception ex)
        {
            return 0;
        }
    }

    //getVotersDetailsById
    public DataTable getVotersDetailsById()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getVotersDetailsById";
            cmd.Parameters.AddWithValue("_votersId", voterId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }

    //deleteVotersById
    public bool deleteVotersById(VoterBLL votObj)
    {

        string qry = "DELETE FROM votermaster WHERE votersId in (" + votObj.voterId + ")";
        int rec = executeQuery(qry);
        if (rec > 0)
            return true;
        else
            return false;
    }

    //updateVoterMaster
    public bool updateVoterMaster(VoterBLL votObj)
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "updateVoterMaster";
            cmd.Parameters.AddWithValue("_votersId", voterId);
            cmd.Parameters.AddWithValue("_name", name);
            cmd.Parameters.AddWithValue("_address", address);
            cmd.Parameters.AddWithValue("_comId", comId);
            cmd.Parameters.AddWithValue("_boothId", boothId);
            cmd.Parameters.AddWithValue("_profilePic", profilePic);
            cmd.Parameters.AddWithValue("_primaryContactNo", mobile1);
            cmd.Parameters.AddWithValue("_secondryContactNo", mobile2);
            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }

    public int executeQuery(string qry)
    {
        MySqlConnection con = new MySqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString);
        MySqlCommand cmd = new MySqlCommand(qry, con);
        con.Open();
        int rec = cmd.ExecuteNonQuery();
        if (rec > 0)
            return rec;
        else
            return 0;
    }

}