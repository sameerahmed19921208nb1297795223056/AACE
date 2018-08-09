using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class windows_captureData : System.Web.UI.Page
{
    string xml = string.Empty;
    campaignBLL cmpObj = new campaignBLL();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (Request["event"] == "NewCall")
                {
                    xml = generateXML(0);//playing the message
                }
                else if (Request["event"] == "Record" || Request["event"] == "Hangup")//save recorded file URL
                {
                    saveRecordedFile();
                }
                else if (Request["event"] == "GotDTMF")
                {
                    if (Request["data"] == "9")//recording
                    {
                        xml = @"<?xml version=""1.0"" encoding=""UTF-8""?>
                                     <response sid=""" + Session["sid"].ToString() + @""">   
                                     <playtext>Please record your message</playtext>  
                                     <record format=""wav"" silence=""8"" maxduration=""30"" >" + DateTime.Now.ToString("ddMMyyhhmmssffftt") + "</record></response>";
                    }
                    else if (Request["data"] == "0")//call ending
                    {
                        xml = string.Format(@"<?xml version=""1.0"" encoding=""UTF-8""?>
                                          <response>
                                            <collectdtmf l=""1"" t=""-1"" o=""5000"">""
                                                        <playtext>Thank you</playtext>
                                            </collectdtmf>                                          	
                                          </response>
                                          <response>
                                            <hangup></hangup> 
                                          </response>");
                    }
                    else if (Request["data"] == null || Request["data"] == "") //repeat the message in the same call
                    {
                        xml = generateXML(1);
                    }
                    else//capturing the data parameter
                    {
                        Session["sid"] = Request["sid"].ToString();
                        SaveData();
                        xml = string.Format(@"<?xml version=""1.0"" encoding=""UTF-8""?>
                                          <response>
                                            <collectdtmf l=""1"" t=""-1"" o=""5000"">""                                                        
                                                        <playtext>Press 9 to register the complaint</playtext>
                                                        <playtext>Press 0 to end the call</playtext>
                                            </collectdtmf>                                          	
                                          </response>");
                    }
                }
                Response.Write(xml);
            }

        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    string generateXML(int extraText)
    {
        string buildXML = "";
        if (Application["campaign"] != null)
        {
            string[] campaignArr = (string[])Application["campaign"];
            buildXML = @"<?xml version=""1.0"" encoding=""UTF-8""?>
                        <response>
	                        <collectdtmf l=""1"" t=""-1"" o=""5000"">";
            //this condition is because when voter dont select anything then we are playing below mentioned text.
            if (extraText == 1)
            {
                buildXML += "<playtext>Please select any one option</playtext>";
            }
            for (int i = 0; i < campaignArr.Length; i++)
            {
                if (i == 0)
                {
                    buildXML += "<playtext>" + campaignArr[i].ToString() + "</playtext>";
                }
                else if (campaignArr[i].ToString() != "")
                {
                    buildXML += "<playtext>Press " + i + " for " + campaignArr[i].ToString() + "</playtext>";
                }
            }
            buildXML += "<playtext>Press 0 to end the call</playtext>";
            buildXML += @"</collectdtmf>
                        </response>";
        }
        return buildXML;
    }

    bool SaveData()
    {
        if (Application["campaignId"] != null)
        {
            cmpObj.campaignId = Application["campaignId"].ToString();
            cmpObj.primaryContactNo = Request["cid"].ToString();
            cmpObj.digit = Convert.ToInt16(Request["data"].ToString());
            cmpObj.callfrom = Request["called_number"].ToString();
            cmpObj.sId = Request["sid"].ToString();
            return cmpObj.SaveCampaignReports(cmpObj);
        }
        else
        {
            return false;
        }
    }

    void saveRecordedFile()
    {
        cmpObj.recordedFile = Request["data"].ToString();
        cmpObj.recordDuration = Convert.ToInt16(Request["record_duration"].ToString());
        cmpObj.sId = Request["sid"].ToString();
        cmpObj.saveRecordedFile(cmpObj);
    }
}