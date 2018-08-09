using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Net;

/// <summary>
/// Summary description for generalClass
/// </summary>
public class generalClass
{
    public generalClass()
    {

    }

    public void sendVoiceMail(string phoneNo)
    {
        string api = string.Format(@"http://www.kookoo.in/outbound/outbound.php?phone_no={0}&api_key=KK7b048ab0914a0ef0714f77b077a4c1b4 &outbound_version=2&url=http://phoenix.bridgeparents.com/windows/captureData.aspx", phoneNo);
        WebClient client = new WebClient();
        Stream data = client.OpenRead(api);
        StreamReader reader = new StreamReader(data);
        string ret = reader.ReadToEnd();
    }
}