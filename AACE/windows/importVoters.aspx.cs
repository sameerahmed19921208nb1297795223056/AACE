using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using System.Text.RegularExpressions;

public partial class windows_importVoters : System.Web.UI.Page
{
    VoterBLL votObj = new VoterBLL();

    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            if (!IsPostBack)
            {
                bindCommunity();
                bindConstituency();
                ddlRegion.Items.Insert(0, new ListItem("Select Region", "0"));
                ddlArea.Items.Insert(0, new ListItem("Select Area", "0"));
                ddlBoothNo.Items.Insert(0, new ListItem("Select Booth No", "0"));
                divExcelData.Visible = false;
                divTableData.Visible = false;
            }
        }
        catch (Exception ex)
        {

        }

    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        try
        {
            bool flg = true;
            DataTable dtTemp = new DataTable();
            if (FileUpload1.FileName.ToString() != "")
            {
                FileUpload1.SaveAs(Server.MapPath("~/excelfiles/" + FileUpload1.FileName.ToString()));
                string fileName = Server.MapPath("~/excelfiles/" + FileUpload1.FileName.ToString());
                string SourceConstr = "";
                string ext = "";
                ext = System.IO.Path.GetExtension(FileUpload1.FileName);
                if ((ext == ".xls") || (ext == ".xlsx"))
                {
                    if (ext == ".xls")
                        SourceConstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + fileName + ";Extended Properties=Excel 8.0;";
                    else if (ext == ".xlsx")
                        SourceConstr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + fileName + ";Extended Properties=Excel 12.0;";

                    using (System.Data.OleDb.OleDbConnection con = new System.Data.OleDb.OleDbConnection(SourceConstr))
                    {
                        con.Open();
                        System.Data.OleDb.OleDbCommand com = new System.Data.OleDb.OleDbCommand("Select * from [Sheet1$]", con);
                        OleDbDataAdapter oda = new OleDbDataAdapter(com);
                        oda.Fill(dtTemp);

                        string[] arrColumns = new string[dtTemp.Columns.Count];
                        arrColumns = "Name,Address,Phone1,Phone2".Split(',');
                        for (int i = 0; i < arrColumns.Length; i++)
                        {
                            if (dtTemp.Columns[i].ColumnName != arrColumns[i])
                            {
                                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "SavedSuccessfully('" + dtTemp.Columns[i].ColumnName + " is unknown Column');", true);
                                flg = false;
                                break;
                            }
                        }

                        //Checks any empty row in phone1 column
                        if (dtTemp.Rows.OfType<DataRow>().Any(r => r.IsNull("Phone1")))
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "SavedSuccessfully('Phone1 cant be empty!');", true);
                            flg = false;
                        }

                        if (flg)
                        {
                            votObj.voterId = "%";
                            DataTable dtDbVoters = votObj.getVotersDetails();

                            for (int i = 0; i < dtTemp.Rows.Count; i++)
                            {
                                //Checks any other thing other than numbers from 0-9 in Phone1
                                string Phone1 = dtTemp.Rows[i]["Phone1"].ToString().Trim();
                                if (Phone1 != "" && !Regex.IsMatch(Phone1, "^[0-9]+$", RegexOptions.Compiled))
                                {
                                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "SavedSuccessfully('In line no. " + Convert.ToInt16(i + 1) + " Phone1 contains characte(s). Please remove the character(s)!');", true);
                                    flg = false;
                                    break;
                                }

                                //Checks any other thing other than numbers from 0-9 in Phone2
                                string Phone2 = dtTemp.Rows[i]["Phone2"].ToString().Trim();
                                if (Phone2 != "" && !Regex.IsMatch(Phone2, "^[0-9]+$", RegexOptions.Compiled))
                                {
                                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "SavedSuccessfully('In line no. " + Convert.ToInt16(i + 1) + " Phone2 contains characte(s). Please remove the character(s)!');", true);
                                    flg = false;
                                    break;
                                }

                                //Checks any number in identical or not in phone1
                                DataView dvExcelPhone1 = new DataView(dtTemp);
                                dvExcelPhone1.RowFilter = "[Phone1] = '" + dtTemp.Rows[i]["Phone1"].ToString().Trim() + "'";
                                if (dvExcelPhone1.ToTable().Rows.Count > 1)
                                {
                                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "SavedSuccessfully('" + dtTemp.Rows[i]["Phone1"].ToString().Trim() + " is identical in Excel Sheet!.');", true);
                                    flg = false;
                                    break;
                                }

                                //Checks number already exist in DB or not for phone1.
                                DataView dvDBPhone1 = new DataView(dtDbVoters);
                                dvDBPhone1.RowFilter = "[primaryContactNo] = '" + dtTemp.Rows[i]["Phone1"].ToString().Trim() + "'";
                                if (dvDBPhone1.ToTable().Rows.Count > 0)
                                {
                                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "SavedSuccessfully('" + dtTemp.Rows[i]["Phone1"].ToString().Trim() + " Already exist!.');", true);
                                    flg = false;
                                    break;
                                }
                            }
                        }

                        if (flg)
                        {
                            rptVotersExcelData.DataSource = dtTemp;
                            rptVotersExcelData.DataBind();
                            ViewState["ExcelData"] = dtTemp;
                            btnUpload.Visible = false;
                            btnConfirm.Visible = true;
                            rptVotersExcelData.Visible = true;
                            divExcelData.Visible = true;
                            divControls.Visible = false;
                            divTableData.Visible = true;
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        try
        {
            votObj.dtExcelData = (DataTable)ViewState["ExcelData"];
            votObj.comId = ddlCommunity.SelectedValue;
            votObj.boothId = ddlBoothNo.SelectedValue;
            if (votObj.dtExcelData.Rows.Count > 0)
            {
                int insert = votObj.saveVotersMaster(votObj);
                if (insert > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "SavedSuccessfully('Record Saved Successfully');", true);
                    clearControls();
                    divTableData.Visible = false;
                    divControls.Visible = true;
                }
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "SavedSuccessfully('Failed To Save','red');", true);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            clearControls();
            divTableData.Visible = false;
            divControls.Visible = true;
        }
        catch (Exception ex)
        {

        }
    }

    protected void ddlConstituency_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            bindRegion(ddlConstituency.SelectedValue);
            ddlArea.Items.Clear();
            ddlBoothNo.Items.Clear();
            ddlArea.Items.Insert(0, new ListItem("Select Area", "0"));
            ddlBoothNo.Items.Insert(0, new ListItem("Select Booth No", "0"));
        }
        catch (Exception)
        {

        }

    }

    protected void ddlRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            bindArea(ddlRegion.SelectedValue);
            ddlBoothNo.Items.Clear();
            ddlBoothNo.Items.Insert(0, new ListItem("Select Booth No", "0"));
        }
        catch (Exception ex)
        {

        }
    }

    protected void ddlArea_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            bindboothNo(ddlArea.SelectedValue);
        }
        catch (Exception ex)
        {

        }
    }

    void bindCommunity()
    {
        votObj.comId = "%";
        ddlCommunity.DataSource = votObj.getCommunityMaster();
        ddlCommunity.DataTextField = "communityName";
        ddlCommunity.DataValueField = "communityId";
        ddlCommunity.DataBind();
        ddlCommunity.Items.Insert(0, new ListItem("Select Community", "0"));
    }

    void bindConstituency()
    {
        votObj.constId = "%";
        ddlConstituency.DataSource = votObj.getConstituencyMasterByID();
        ddlConstituency.DataTextField = "constituencyName";
        ddlConstituency.DataValueField = "constituencyId";
        ddlConstituency.DataBind();
        ddlConstituency.Items.Insert(0, new ListItem("Select Constituency", "0"));
    }

    void bindRegion(string constId)
    {
        votObj.constId = constId;
        ddlRegion.DataSource = votObj.getRegionMasterByConstId();
        ddlRegion.DataTextField = "regName";
        ddlRegion.DataValueField = "regionId";
        ddlRegion.DataBind();
        ddlRegion.Items.Insert(0, new ListItem("Select Region", "0"));
    }

    void bindArea(string regionId)
    {
        votObj.regId = regionId;
        ddlArea.DataSource = votObj.getAreaMasterByRegionId();
        ddlArea.DataTextField = "areaName";
        ddlArea.DataValueField = "areaId";
        ddlArea.DataBind();
        ddlArea.Items.Insert(0, new ListItem("Select Area", "0"));
    }

    void bindboothNo(string areatId)
    {
        votObj.areaId = areatId;
        ddlBoothNo.DataSource = votObj.getBoothMasterByAreaId();
        ddlBoothNo.DataTextField = "boothNo";
        ddlBoothNo.DataValueField = "boothId";
        ddlBoothNo.DataBind();
        ddlBoothNo.Items.Insert(0, new ListItem("Select Booth No", "0"));
    }

    public void clearControls()
    {
        btnUpload.Visible = true;
        btnConfirm.Visible = false;
        rptVotersExcelData.Visible = false;
        ddlCommunity.SelectedValue = "0";
        ddlBoothNo.SelectedValue = "0";
        ddlArea.SelectedValue = "0";
        ddlConstituency.SelectedValue = "0";
        ddlRegion.SelectedValue = "0";
        divExcelData.Visible = false;
        ((DataTable)ViewState["ExcelData"]).Clear();
    }

    protected void lnkDownload_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("~/Download/Voters Details Format.xlsx");
        }
        catch (Exception ex)
        {

        }
    }
}