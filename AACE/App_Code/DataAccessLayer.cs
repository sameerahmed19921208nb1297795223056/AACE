using System;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data;
using MySql.Data;
using MySql.Data.MySqlClient;
using System.IO;


/// <summary>
/// DataAccessLayer: Basic Methods to connect to Database
/// </summary>
public class DataAccessLayer
{
    #region Data Members
    string _conStr = string.Empty;
    MySqlConnection con = null;
    string _conStrcommon = string.Empty;
    MySqlConnection conCommon = null;
    #endregion

    #region Constructor
    public DataAccessLayer()
    {
        _conStr = ConfigurationManager.ConnectionStrings["constr"].ToString();
        con = new MySqlConnection(_conStr);
    }
    #endregion

    #region testConnection
    public string testConnection(out string errMsg)
    {
        try
        {
            con.Open();
            errMsg = "Connection Successed!";
            return "Success";
        }
        catch (Exception ex)
        {
            errMsg = ex.Message;
            return "Fail";
        }
        finally
        {
            con.Close();
        }
    }
    #endregion

    #region getExecuteData
    public bool getExecuteData(MySqlCommand cmd, out string errMsg)
    {
        try
        {
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            int recd = cmd.ExecuteNonQuery();
            if (recd > 0)
            {
                errMsg = recd.ToString() + " row(s) affected!";
                return true;
            }
            else
            {
                errMsg = "Error: " + recd.ToString() + " row(s) affected!";
                return false;
            }
        }
        catch (Exception ex)
        {
            errMsg = ex.Message;
            return false;
        }
        finally
        {
            con.Close();
        }
    }
    #endregion

    #region getScalarData
    public double getScalarData(MySqlCommand cmd, out string errMsg, CommandType cmdType = CommandType.StoredProcedure)
    {
        try
        {
            cmd.Connection = con;
            cmd.CommandType = cmdType;
            con.Open();
            string rst = cmd.ExecuteScalar().ToString();
            errMsg = rst + " record(s) returned.";
            return double.Parse(rst);
        }
        catch (Exception ex)
        {
            errMsg = ex.Message;
            return 0;
        }
        finally
        {
            con.Close();
        }
    }
    #endregion

    #region getSelectData
    public DataTable getSelectData(MySqlCommand cmd, out string errMsg, CommandType cmdType = CommandType.StoredProcedure)
    {
        DataTable tempDb = new DataTable();
        try
        {
            cmd.Connection = con;
            cmd.CommandType = cmdType;

            MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
            adp.SelectCommand.CommandTimeout = 120;  // seconds
            tempDb.Clear();
            adp.Fill(tempDb);
            errMsg = tempDb.Rows.Count.ToString() + " record(s) returned.";
            return tempDb;
        }
        catch (Exception ex)
        {
            errMsg = ex.Message;
            tempDb.Clear();
            return tempDb;
        }
    }
    #endregion


    //Ganesh
    #region getSelectDataByInlineQuery
    public DataTable getSelectDataByInlineQuery(MySqlCommand cmd, out string errMsg)
    {
        DataTable tempDb = new DataTable();
        try
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;

            MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
            tempDb.Clear();
            adp.Fill(tempDb);
            errMsg = tempDb.Rows.Count.ToString() + " record(s) returned.";
            con.Close();
            return tempDb;
        }
        catch (Exception ex)
        {
            con.Close();
            errMsg = ex.Message;
            tempDb.Clear();
            return tempDb;
        }
    }



    #endregion


    #region getSelectDataSet
    public DataSet getSelectDataSet(MySqlCommand cmd, out string errMsg)
    {
        DataSet tempDs = new DataSet();
        try
        {
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure;
            MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
            tempDs.Clear();
            adp.Fill(tempDs);
            errMsg = tempDs.Tables.Count + " table(s) returned!";
            return tempDs;
        }
        catch (Exception ex)
        {
            errMsg = ex.Message;
            tempDs.Clear();
            return tempDs;
        }
    }
    #endregion


    #region InsertSQL
    public double SQLQueryInsert(string sqlQuery, out string errMsg)
    {
        try
        {
            using (MySqlCommand cmd = new MySqlCommand())
            {
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = sqlQuery;
                con.Open();
                double recd = cmd.ExecuteNonQuery();
                if (recd > 0)
                {
                    errMsg = recd.ToString() + " row(s) affected!";
                    return recd;
                }
                else
                {
                    errMsg = "Error: " + recd.ToString() + " row(s) affected!";
                    return recd;
                }
            }
        }
        catch (Exception ex)
        {
            errMsg = ex.Message;
            return -1;
        }
        finally
        {
            con.Close();
        }
    }
    #endregion
}
