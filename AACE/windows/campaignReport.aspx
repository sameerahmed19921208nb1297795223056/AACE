<%@ Page Title="" Language="C#" MasterPageFile="~/windows/siteMaster.master" AutoEventWireup="true"
    CodeFile="campaignReport.aspx.cs" Inherits="windows_campaignReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="app-content">
        <div class="app-title">
            <div>
                <h1>
                    <i class="fa fa-edit"></i>Campaign Report</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-2">
                                    <label>
                                        Community</label>
                                    <asp:DropDownList ID="ddlCommunity" runat="server" CssClass="form-control">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-2">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <label>
                                                Constituency</label>
                                            <asp:DropDownList ID="ddlConstituency" runat="server" CssClass="form-control" AutoPostBack="True"
                                                OnSelectedIndexChanged="ddlConstituency_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="col-md-2">
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <label>
                                                Region</label>
                                            <asp:DropDownList ID="ddlRegion" runat="server" CssClass="form-control" AutoPostBack="True"
                                                OnSelectedIndexChanged="ddlRegion_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="col-md-2">
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <label>
                                                Area</label>
                                            <asp:DropDownList ID="ddlArea" runat="server" CssClass="form-control" AutoPostBack="True"
                                                OnSelectedIndexChanged="ddlArea_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="col-md-2">
                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                        <ContentTemplate>
                                            <label>
                                                Booth No</label>
                                            <asp:DropDownList ID="ddlBoothNo" runat="server" CssClass="form-control">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="col-md-1 mt-4">
                                    <asp:Button ID="btnFilter" runat="server" CssClass="btn btn-primary" Text="Filter"
                                        OnClick="btnFilter_Click" />
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="row">
                                <div class="col-md-12">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <table class="table table-hover table-bordered table-responsive-md" id="sampleTable">
                                <thead>
                                    <tr>
                                        <th>
                                            #
                                        </th>
                                        <th>
                                            Campaign
                                        </th>
                                        <th>
                                            Total Voters
                                        </th>
                                        <th>
                                            Issues
                                        </th>
                                        <th>
                                            Opt 1
                                        </th>
                                        <th>
                                            Opt 2
                                        </th>
                                        <th>
                                            Opt 3
                                        </th>
                                        <th>
                                            Opt 4
                                        </th>
                                        <th>
                                            Opt 5
                                        </th>
                                        <th>
                                            Opt 6
                                        </th>
                                        <th>
                                            Opt 7
                                        </th>
                                        <th>
                                            Opt 8
                                        </th>
                                        <th>
                                            Compaints
                                        </th>
                                        <th>
                                            View
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptCampaignReports" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <%#Container.ItemIndex+1 %>
                                                </td>
                                                <td>
                                                    <%#Eval("campaignTitle")%>
                                                </td>
                                                <td>
                                                    <%#Eval("totalVoters")%>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lb_feedback" runat="server" CommandArgument='<%#Eval("campaignId")%>'
                                                        Enabled='<%#Eval("feedBacks").ToString() == "0" ? false : true%>' Text='<%#Eval("feedBacks")%>'
                                                        OnClick="exportToExcel_Click" CommandName="%" ToolTip="Click to Download"></asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lb_Opt1" runat="server" CommandArgument='<%#Eval("campaignId")%>'
                                                        Enabled='<%#Eval("opt1").ToString() == "0" ? false : true%>' Text='<%#Eval("opt1")%>'
                                                        CommandName="1" OnClick="exportToExcel_Click" ToolTip="Click to Download"></asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lb_Opt2" runat="server" CommandArgument='<%#Eval("campaignId")%>'
                                                        Enabled='<%#Eval("opt2").ToString() == "0" ? false : true%>' Text='<%#Eval("opt2")%>'
                                                        CommandName="2" OnClick="exportToExcel_Click" ToolTip="Click to Download"></asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lb_Opt3" runat="server" CommandArgument='<%#Eval("campaignId")%>'
                                                        Enabled='<%#Eval("opt3").ToString() == "0" ? false : true%>' Text='<%#Eval("opt3")%>'
                                                        CommandName="3" OnClick="exportToExcel_Click" ToolTip="Click to Download"></asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lb_Opt4" runat="server" CommandArgument='<%#Eval("campaignId")%>'
                                                        Enabled='<%#Eval("opt4").ToString() == "0" ? false : true%>' Text='<%#Eval("opt4")%>'
                                                        CommandName="4" OnClick="exportToExcel_Click" ToolTip="Click to Download"></asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lb_Opt5" runat="server" CommandArgument='<%#Eval("campaignId")%>'
                                                        Enabled='<%#Eval("opt5").ToString() == "0" ? false : true%>' Text='<%#Eval("opt5")%>'
                                                        CommandName="5" OnClick="exportToExcel_Click" ToolTip="Click to Download"></asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lb_Opt6" runat="server" CommandArgument='<%#Eval("campaignId")%>'
                                                        Enabled='<%#Eval("opt6").ToString() == "0" ? false : true%>' Text='<%#Eval("opt6")%>'
                                                        CommandName="6" OnClick="exportToExcel_Click" ToolTip="Click to Download"></asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lb_Opt7" runat="server" CommandArgument='<%#Eval("campaignId")%>'
                                                        Enabled='<%#Eval("opt7").ToString() == "0" ? false : true%>' Text='<%#Eval("opt7")%>'
                                                        CommandName="7" OnClick="exportToExcel_Click" ToolTip="Click to Download"></asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lb_Opt8" runat="server" CommandArgument='<%#Eval("campaignId")%>'
                                                        Enabled='<%#Eval("opt8").ToString() == "0" ? false : true%>' Text='<%#Eval("opt8")%>'
                                                        CommandName="8" OnClick="exportToExcel_Click" ToolTip="Click to Download"></asp:LinkButton>
                                                </td>
                                                <td>
                                                    <%#Eval("recordedFile")%>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="lbViewReports" runat="server" ToolTip="View Details" CommandArgument='<%#Eval("campaignId")%>'
                                                        CommandName='<%#Eval("campaignTitle")%>' OnClick="lbViewReports_Click"><i class="fa fa-eye" ></i></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
