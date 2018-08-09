using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class windows_constituencyCreate : System.Web.UI.Page
{
    constituencyBLL conObj = new constituencyBLL();
    VoterBLL votObj = new VoterBLL();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                LoadConstituencys();
                BindConstituency();
                BindRegion();
                BindArea();
                BindBooth();
                LoadEmptyDDL();
            }
        }
        catch { }
    }
    private void LoadEmptyDDL()
    {
        ddl_RegInArea.Items.Insert(0, new ListItem("Select Region Name", "0"));
        ddl_RegInBooth.Items.Insert(0, new ListItem("Select Region Name", "0"));
        ddl_AreaInBooth.Items.Insert(0, new ListItem("Select Area Name", "0"));
    }
    public void BindConstituency()
    {
        conObj.constituencyId = "%";
        DataTable dtTemp = conObj.getConstituencyDetails();
        rptConstituency.DataSource = dtTemp;
        rptConstituency.DataBind();
    }
    public void BindRegion()
    {
        conObj.regId = "%";
        DataTable dtReg = conObj.getRegionDetails();

        rpt_Region.DataSource = dtReg;
        rpt_Region.DataBind();
    }
    public void BindArea()
    {
        conObj.areaId = "%";
        DataTable dtArea = conObj.getAreaDeatils();

        rpt_Area.DataSource = dtArea;
        rpt_Area.DataBind();
    }
    public void BindBooth()
    {
        conObj.boothId = "%";
        DataTable dtBooth = conObj.getBoothDetails();

        rpt_Booth.DataSource = dtBooth;
        rpt_Booth.DataBind();
    }
    public void LoadConstituencys()
    {
        votObj.constId = "%";
        ddl_ConstInReg.DataSource = votObj.getConstituencyMasterByID();
        ddl_ConstInReg.DataTextField = "constituencyName";
        ddl_ConstInReg.DataValueField = "constituencyId";
        ddl_ConstInReg.DataBind();
        ddl_ConstInReg.Items.Insert(0, new ListItem("Select Constituency Name", "0"));

        ddl_ConstInArea.DataSource = votObj.getConstituencyMasterByID();
        ddl_ConstInArea.DataTextField = "constituencyName";
        ddl_ConstInArea.DataValueField = "constituencyId";
        ddl_ConstInArea.DataBind();
        ddl_ConstInArea.Items.Insert(0, new ListItem("Select Constituency Name", "0"));

        ddl_ConstInBooth.DataSource = votObj.getConstituencyMasterByID();
        ddl_ConstInBooth.DataTextField = "constituencyName";
        ddl_ConstInBooth.DataValueField = "constituencyId";
        ddl_ConstInBooth.DataBind();
        ddl_ConstInBooth.Items.Insert(0, new ListItem("Select Constituency Name", "0"));
    }
    public void LoadRegions(string ConstituencyId, DropDownList Region)
    {
        votObj.constId = ConstituencyId;
        Region.DataSource = votObj.getRegionMaster();
        Region.DataTextField = "regName";
        Region.DataValueField = "regionId";
        Region.DataBind();
        Region.Items.Insert(0, new ListItem("Select Region Name", "0"));
    }
    public void LoadAreas(string RegionId, DropDownList Area)
    {
        votObj.regId = RegionId;
        Area.DataSource = votObj.getAreaMasterByRegionId();
        Area.DataTextField = "areaName";
        Area.DataValueField = "areaId";
        Area.DataBind();
        Area.Items.Insert(0, new ListItem("Select Area Name", "0"));
    }
    protected void BtnSave_Click1(object sender, EventArgs e)
    {
        conObj.constituencyName = txt_ConstituencyName.Text.Trim();
        if (BtnSave.Text == "Save")
        {
            conObj.SaveConstituency();
            txt_ConstituencyName.Text = "";
            hfActiveDiv.Value = "divReg";
            LoadConstituencys();
            BindConstituency();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divReg','1','Saved','Region Add','1','#divConst');", true);
        }
        else
        {
            conObj.constituencyId = ViewState["ConstituencyID"].ToString();
            conObj.constituencyName = txt_ConstituencyName.Text;
            conObj.UpdateConstituencyMaster();
            hfActiveDiv.Value = "divConst";
            BindConstituency();
            BindRegion();
            BindArea();
            BindBooth();
            txt_ConstituencyName.Text = "";
            BtnSave.Text = "Save";
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divConst','1','Updated','Constituency Add','1','#divConst');", true);
        }
    }
    public void btn_RegSave_Click(object sender, EventArgs e)
    {
        conObj.regionName = txt_RegionName.Text.Trim();
        conObj.constituencyName = ddl_ConstInReg.SelectedItem.Value;

        if (btn_RegSave.Text == "Save")
        {
            conObj.SaveRegion();
            hfActiveDiv.Value = "divArea";
            BindRegion();
            LoadConstituencys();
            txt_RegionName.Text = "";
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divArea','1','Saved','Area Add','1','#divReg');", true);
        }
        else
        {
            conObj.constituencyId = ddl_ConstInReg.SelectedValue;
            conObj.regId = ViewState["regId"].ToString();
            conObj.UpdateRegion();
            hfActiveDiv.Value = "divArea";
            BindRegion();
            BindArea();
            BindBooth();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divReg','1','Updated','Area Add','1','#divReg');", true);
            btn_RegSave.Text = "Save";
            txt_RegionName.Text = "";
            LoadConstituencys();
        }
    }
    public void btn_AreaSave_Click(object sender, EventArgs e)
    {
        conObj.areaName = txt_Area.Text.Trim();
        conObj.constituencyName = ddl_ConstInArea.SelectedValue;
        conObj.regionName = ddl_RegInArea.SelectedValue;
        if (btn_AreaSave.Text == "Save")
        {
            conObj.SaveArea();
            BindArea();

            hfActiveDiv.Value = "divBooth";
            txt_Area.Text = "";
            LoadConstituencys();
            ddl_RegInArea.Items.Clear();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divBooth','1','Saved','Booth Add','1','#divArea');", true);
        }
        else
        {
            conObj.regId = ddl_RegInArea.SelectedValue;
            conObj.areaId = ViewState["areaID"].ToString();
            conObj.UpdateArea();
            hfActiveDiv.Value = "divArea";
            BindArea();
            BindBooth();
            txt_Area.Text = "";
            LoadConstituencys();
            ddl_RegInArea.Items.Clear();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divArea','1','Updated','Area Add','1','#divArea');", true);
            btn_AreaSave.Text = "Save";
        }
        LoadEmptyDDL();
    }
    public void ddl_ConstInArea_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadRegions(ddl_ConstInArea.SelectedItem.Value, ddl_RegInArea);
        txt_Area.Text = "";
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divArea','0','','Area Add','0','#divArea');", true);
    }
    public void ddl_ConstInBooth_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadRegions(ddl_ConstInBooth.SelectedItem.Value, ddl_RegInBooth);
        txt_Booth.Text = "";
        ddl_AreaInBooth.Items.Clear();
        ddl_AreaInBooth.Items.Insert(0, new ListItem("Select Area Name", "0"));
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divBooth','0','','Booth Add','0','#divBooth');", true);

    }
    protected void ddl_RegInBooth_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadAreas(ddl_RegInBooth.SelectedItem.Value, ddl_AreaInBooth);
        txt_Booth.Text = "";
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divBooth','0','','Booth Add','0','#divBooth');", true);
    }
    public void btn_SaveBooth_Click(object sender, EventArgs e)
    {
        conObj.constituencyName = ddl_ConstInBooth.SelectedItem.Value;
        conObj.regionName = ddl_RegInBooth.SelectedItem.Value;
        conObj.areaName = ddl_AreaInBooth.SelectedValue;
        conObj.boothName = txt_Booth.Text.Trim();
        if (btn_SaveBooth.Text == "Save")
        {
            conObj.SaveBooth();
            BindBooth();
            txt_Booth.Text = "";
            LoadConstituencys();
            ddl_RegInBooth.Items.Clear();
            ddl_AreaInBooth.Items.Clear();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divBooth','1','Saved','Booth Add','1','');", true);
        }
        else
        {
            conObj.boothId = ViewState["boothId"].ToString();
            conObj.areaId = ddl_AreaInBooth.SelectedValue;
            conObj.UpdateBooth();
            BindBooth();
            btn_SaveBooth.Text = "Save";
            txt_Booth.Text = "";
            LoadConstituencys();
            ddl_RegInBooth.Items.Clear();
            ddl_AreaInBooth.Items.Clear();
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divBooth','0','Updated','Booth Add','1','');", true);
        }
        LoadEmptyDDL();
    }
    protected void ddl_ConstInReg_SelectedIndexChanged(object sender, EventArgs e)
    {
        txt_RegionName.Text = "";
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divReg','0','','Region Add','0','#divReg');", true);
    }
    public void btn_ConstituencyDelete(object sender, EventArgs e)
    {
        conObj.constituencyId = ((LinkButton)sender).CommandArgument;
        conObj.Constituency_Delete();
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divConst','1','Deleted','Constituency Add','1','#divConst');", true);
        BindConstituency();
        BindRegion();
        BindArea();
        BindBooth();
    }
    public void btn_ConstituencyEdit(object sender, EventArgs e)
    {
        var ID = ((LinkButton)sender).CommandArgument;
        txt_ConstituencyName.Text = ((LinkButton)sender).CommandName;
        BtnSave.Text = "Update";
        ViewState["ConstituencyID"] = ID;
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divConst','1','Updated','Constituency Add','0','#divConst');", true);
    }
    public void btn_RegionDelete(object sender, EventArgs e)
    {
        conObj.regId = ((LinkButton)sender).CommandArgument;
        conObj.Region_Del();
        hfActiveDiv.Value = "divReg";
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divReg','1','Deleted','Region Add','1','#divConst');", true);
        BindRegion();
        BindArea();
        BindBooth();
    }
    public void btn_RegionEdit(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        conObj.regId = btn.CommandArgument;
        DataTable dtReg = conObj.getRegionDetails();
        ddl_ConstInReg.SelectedValue = dtReg.Rows[0]["constituencyId"].ToString();
        txt_RegionName.Text = dtReg.Rows[0]["regName"].ToString();
        btn_RegSave.Text = "Update";
        ViewState["regId"] = btn.CommandArgument;
        hfActiveDiv.Value = "divReg";
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divReg','1','','Region Add','0','#divConst');", true);
    }
    public void btn_AreaDelete(object sender, EventArgs e)
    {
        conObj.areaId = ((LinkButton)sender).CommandArgument;
        conObj.Area_Del();
        hfActiveDiv.Value = "divArea";
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divArea','1','Deleted','Area Add','1','#divConst');", true);
        BindArea();
        BindBooth();
    }
    public void btn_AreaEdit(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        conObj.areaId = btn.CommandArgument;
        DataTable dtArea = conObj.getAreaDeatils();
        ddl_ConstInArea.SelectedValue = dtArea.Rows[0]["constituencyId"].ToString();
        LoadRegions(dtArea.Rows[0]["constituencyId"].ToString(), ddl_RegInArea);
        ddl_RegInArea.Items.FindByText(((LinkButton)sender).CommandName).Selected = true;
        txt_Area.Text = dtArea.Rows[0]["areaName"].ToString();
        btn_AreaSave.Text = "Update";
        ViewState["areaID"] = btn.CommandArgument;
        hfActiveDiv.Value = "divArea";
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divArea','1','Updated','Area Add','0','#divConst');", true);
    }
    public void btn_Booth_Del(object sender, EventArgs e)
    {
        conObj.boothId = ((LinkButton)sender).CommandArgument;
        conObj.Booth_Del();
        hfActiveDiv.Value = "divBooth";
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divBooth','1','Deleted','Booth Add','1','#divConst');", true);
        BindBooth();
    }
    public void btn_Booth_Edit(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        conObj.boothId = btn.CommandArgument;
        DataTable dtBooth = conObj.getBoothDetails();
        ddl_ConstInBooth.SelectedValue = dtBooth.Rows[0]["constituencyId"].ToString();
        LoadRegions(dtBooth.Rows[0]["constituencyId"].ToString(), ddl_RegInBooth);
        ddl_RegInBooth.Items.FindByText(((LinkButton)sender).CommandName).Selected = true;
        LoadAreas(dtBooth.Rows[0]["regionId"].ToString(), ddl_AreaInBooth);
        ddl_AreaInBooth.SelectedValue = dtBooth.Rows[0]["areaId"].ToString();
        txt_Booth.Text = dtBooth.Rows[0]["boothNo"].ToString();
        btn_SaveBooth.Text = "Update";
        ViewState["boothId"] = btn.CommandArgument;
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "tabActivation('divBooth','1','','Booth Add','0','#divConst');", true);
        hfActiveDiv.Value = "divBooth";
    }
    public string activeclass(string tabName)
    {
        return "";
    }

}