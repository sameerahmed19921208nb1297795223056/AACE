<%@ Page Title="" Language="C#" MasterPageFile="~/windows/siteMaster.master" AutoEventWireup="true"
    CodeFile="communityAdd.aspx.cs" Inherits="windows_communityAdd" %>

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
    <asp:ScriptManager ID="scriptmanager" runat="server">
    </asp:ScriptManager>
    <div class="app-content">
        <div class="app-title">
            <div>
                <h1>
                    <i class="fa fa-edit"></i>Create Community</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <asp:UpdatePanel ID="updatepanel1" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>
                                            Community Name
                                        </label>
                                        <asp:TextBox ID="txt_Community" runat="server" CssClass="form-control"></asp:TextBox>
                                        <h3>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic"
                                                ControlToValidate="txt_Community" ErrorMessage="*" ForeColor="Red" SetFocusOnError="true"
                                                ValidationGroup="gp"></asp:RequiredFieldValidator></h3>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group mt-4">
                                        <asp:Button ID="btn_Save" runat="server" Text="Save" ValidationGroup="gp" class="btn btn-primary"
                                            OnClick="btn_Save_Click" />
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile-footer">
                                <asp:UpdatePanel ID="updatepanel2" runat="server">
                                    <ContentTemplate>
                                        <table class="table table-hover table-bordered" id="sampleTable">
                                            <thead>
                                                <tr>
                                                    <th>
                                                        #
                                                    </th>
                                                    <th>
                                                        Community Name
                                                    </th>
                                                    <th>
                                                        Action
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rptCommunity" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <%#Container.ItemIndex+1 %>
                                                            </td>
                                                            <td>
                                                                <%#Eval("communityName") %>
                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="lbEdit" runat="server" Text="<i class='fa fa-edit'></i>" ToolTip="Edit Community"
                                                                    class=" btn btn-default" CommandArgument='<%#Eval("CommunityId") %>' OnClick="lbEdit_Click"></asp:LinkButton>
                                                                <asp:LinkButton ID="lbDelete" runat="server" Text="<i class='fa fa-trash'></i>" ToolTip="Delete Community"
                                                                    CommandArgument='<%#Eval("CommunityId") %>' CssClass="btn btn-default btn-sm"
                                                                    OnClick="lbDelete_Click" OnClientClick="return abc(this,event);"></asp:LinkButton>
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
         function abc(ctl, event) {
             var defaultAction = $(ctl).prop('href');
             event.preventDefault();
             alertify.confirm('The records will be deleted. Are you sure to Delete?', function (e) {
                 if (e) {
                     eval(defaultAction);
                 }
                 else {
                 }
             });
         }
    </script>
    <script type="text/javascript">
        function SavedSuccessfully(status) {
            alertify.alert(status);
        }
    </script>
</asp:Content>
