using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Data;

/// <summary>
/// Summary description for constituencyBLL
/// </summary>
public class constituencyBLL
{
    #region Data Members
    DataAccessLayer dalObj = null;
    public string constituencyName { get; set; }
    public string communityId { get; set; }
    public string communityName { get; set; }
    public string regionName { get; set; }
    public string areaName { get; set; }
    public string boothName { get; set; }
    public string constituencyId { get; set; }
    public string regId { get; set; }
    public string areaId { get; set; }
    public string boothId { get; set; }

    public string errMsg = string.Empty;
    #endregion
    public constituencyBLL()
    {
        dalObj = new DataAccessLayer();
    }
    public bool SaveConstituency()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "saveConstituency";
            cmd.Parameters.AddWithValue("_ConstituencyName", constituencyName);
            return dalObj.getExecuteData(cmd, out errMsg);

        }
    }
    public bool SaveRegion()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "saveRegion";
            cmd.Parameters.AddWithValue("_RegionName", regionName);
            cmd.Parameters.AddWithValue("_ConstituencyId", constituencyName);
            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }
    public bool UpdateRegion()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "updateRegion";
            cmd.Parameters.AddWithValue("_RegionName", regionName);
            cmd.Parameters.AddWithValue("_ConstituencyId", constituencyName);
            cmd.Parameters.AddWithValue("_regId", regId);
            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }

    public bool SaveArea()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "saveArea";
            cmd.Parameters.AddWithValue("_RegionId", regionName);
            cmd.Parameters.AddWithValue("_AreaName", areaName);
            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }
    public bool SaveBooth()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "saveBooth";
            cmd.Parameters.AddWithValue("_AreaId", areaName);
            cmd.Parameters.AddWithValue("_BoothName", boothName);
            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }
    public DataTable getConstituencyDetails()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getConstituencyMasterByID";
            cmd.Parameters.AddWithValue("_constituencyId", constituencyId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }

    public bool Constituency_Delete()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "constituency_Delete";
            cmd.Parameters.AddWithValue("_constituencyId", constituencyId);
            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }

    public bool UpdateConstituencyMaster()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "update_ConstituencyMaster";
            cmd.Parameters.AddWithValue("_constituencyId", constituencyId);
            cmd.Parameters.AddWithValue("_constituencyName", constituencyName);
            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }



    public DataTable getRegionDetails()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getRegionMasterDetails";
            cmd.Parameters.AddWithValue("_regId", regId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }
    public bool Region_Del()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "region_delete";
            cmd.Parameters.AddWithValue("_regId", regId);
            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }
    public DataTable getAreaDeatils()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getAreaDetails";
            cmd.Parameters.AddWithValue("_areaId", areaId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }
    public DataTable getBoothDetails()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getBoothDetails";
            cmd.Parameters.AddWithValue("_boothId", boothId);
            return dalObj.getSelectData(cmd, out errMsg);
        }
    }
    public bool Area_Del()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "area_delete";
            cmd.Parameters.AddWithValue("_areaId", areaId);
            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }
    public bool UpdateArea()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "update_Area";
            cmd.Parameters.AddWithValue("_areaId", areaId);
            cmd.Parameters.AddWithValue("_areaName", areaName);
            cmd.Parameters.AddWithValue("_regId", regId);
            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }
    public bool Booth_Del()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "booth_delete";
            cmd.Parameters.AddWithValue("_boothId", boothId);
            return dalObj.getExecuteData(cmd, out errMsg);
        }

    }
    public bool UpdateBooth()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "update_Booth";
            cmd.Parameters.AddWithValue("_boothId", boothId);
            cmd.Parameters.AddWithValue("_boothNo", boothName);
            cmd.Parameters.AddWithValue("_areaId", areaId);
            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }

    public bool saveCommunity()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "saveCommunityMaster";
            cmd.Parameters.AddWithValue("_communityName", communityName);
            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }

    public bool updateCommunity()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "updateCommuntyMaster";
            cmd.Parameters.AddWithValue("_communityId", communityId);
            cmd.Parameters.AddWithValue("_communityName", communityName);
            return dalObj.getExecuteData(cmd, out errMsg);
        }
    }

    public bool deletCommunityById()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "deleteCommunityById";
            cmd.Parameters.AddWithValue("_communityId", communityId);
            return dalObj.getExecuteData(cmd, out errMsg);

        }
    }

    public DataTable getCommunityDetails()
    {
        using (MySqlCommand cmd = new MySqlCommand())
        {
            cmd.CommandText = "getAllCommunity";
            cmd.Parameters.AddWithValue("_communityId", communityId);
            return dalObj.getSelectData(cmd, out errMsg);

        }


    }
}