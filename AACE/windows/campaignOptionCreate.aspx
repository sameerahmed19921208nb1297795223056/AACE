<%@ Page Title="" Language="C#" MasterPageFile="~/windows/siteMaster.master" AutoEventWireup="true"
    CodeFile="campaignOptionCreate.aspx.cs" Inherits="windows_campaignOptionCreate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        if (prm != null) {
            prm.add_endRequest(function (sender, e) {
                if (sender._postBackSettings.panelsToUpdate != null) {
                    $('#sampleTable').dataTable();
                }
            });
        };
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="app-content">
        <div class="app-title">
            <div>
                <h1>
                    <i class="fa fa-edit"></i>Create Campaign Options</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>
                                    Campaign Type
                                </label>
                                <asp:UpdatePanel ID="updatepanel1" runat="server">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="ddlCampaigntype" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="0">Select Campaign Type</asp:ListItem>
                                            <asp:ListItem Value="1">Election</asp:ListItem>
                                            <asp:ListItem Value="2">Education</asp:ListItem>
                                        </asp:DropDownList>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <h3>
                                    <asp:RequiredFieldValidator ID="rqCampaignType" runat="server" ControlToValidate="ddlCampaigntype"
                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="true" InitialValue="0"
                                        ValidationGroup="gp"></asp:RequiredFieldValidator></h3>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>
                                    Campaign Option
                                </label>
                                <asp:UpdatePanel ID="UpdatePanel100" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txt_Option" runat="server" CssClass="form-control" placeholder="Enter Option"></asp:TextBox>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <h3>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic"
                                        ControlToValidate="txt_Option" ErrorMessage="*" ForeColor="Red" SetFocusOnError="true"
                                        ValidationGroup="gp"></asp:RequiredFieldValidator></h3>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group mt-4">
                                <asp:UpdatePanel ID="updatepanel2" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btn_Save" runat="server" Text="Save" ValidationGroup="gp" class="btn btn-primary"
                                            OnClick="btn_Save_Click" />
                                        <asp:Button ID="btn_Cancel" runat="server" Text="Cancel" OnClick="btn_Cancel_Click"
                                            class="btn btn-primary" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile-footer">
                                <asp:UpdatePanel ID="updatepanel4" runat="server">
                                    <ContentTemplate>
                                        <table class="table table-hover table-bordered" id="sampleTable">
                                            <thead>
                                                <tr>
                                                    <th>
                                                        #
                                                    </th>
                                                    <th>
                                                        Campaign Type
                                                    </th>
                                                    <th>
                                                        Campaign Option
                                                    </th>
                                                    <th>
                                                        Action
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rptCampaignOptions" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <%#Container.ItemIndex+1 %>
                                                            </td>
                                                            <td>
                                                                <%#Eval("campaignType")%>
                                                            </td>
                                                            <td>
                                                                <%#Eval("campaignOption") %>
                                                            </td>
                                                            <td>
                                                                <div class="btn-group">
                                                                    <asp:LinkButton ID="lbEdit" runat="server" Text="<i class='fa fa-edit'></i>" ToolTip="Edit"
                                                                        CssClass="btn btn-default btn-sm" CommandArgument='<%#Eval("campOptionId") %>'
                                                                        OnClick="lbEdit_Click"></asp:LinkButton>
                                                                    <asp:LinkButton ID="lbDelete" runat="server" Text="<i class='fa fa-trash'></i>" ToolTip="Delete"
                                                                        CommandArgument='<%#Eval("campOptionId") %>' CssClass="btn btn-default btn-sm"
                                                                        OnClick="lbDelete_Click" OnClientClick="return abc(this,event);"></asp:LinkButton>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function abc(ctrl, event) {
            var defaultAction = $(ctrl).prop('href');
            event.preventDefault();
            alertify.confirm('Are you sure to Delete?', function (e) {
                if (e) {
                    eval(defaultAction);
                }
                else {
                }
            });
        }
        function SavedSuccessfully(status) {
            alertify.alert(status);
        }
    </script>
</asp:Content>
