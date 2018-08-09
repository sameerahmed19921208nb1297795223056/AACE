<%@ Page Title="" Language="C#" MasterPageFile="~/windows/siteMaster.master" AutoEventWireup="true"
    CodeFile="viewVoters.aspx.cs" Inherits="windows_viewVoters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>--%>
    <script type="text/javascript">
        $(function () {
            $("#sampleTable [id*=chkHeader]").click(function () {
                if ($(this).is(":checked")) {
                    $("#sampleTable [id*=chkRow]").prop("checked", "checked");
                } else {
                    $("#sampleTable [id*=chkRow]").prop("checked", false);
                }
            });
            $("#sampleTable [id*=chkRow]").click(function () {
                if ($("#sampleTable [id*=chkRow]").length == $("#sampleTable [id*=chkRow]:checked").length) {
                    $("#sampleTable [id*=chkHeader]").prop("checked", "checked");
                } else {
                    $("#sampleTable [id*=chkHeader]").prop("checked", false);
                }
            });
        });
    </script>
    <script type="text/javascript">
        function abc(ctl, event) {
            var defaultAction = $(ctl).prop('href');
            event.preventDefault();
            if ($("#sampleTable [id*=chkRow]:checked").length != 0) {
                alertify.confirm('Are you sure to Delete?', function (e) {
                    if (e) {
                        eval(defaultAction);
                    }
                    else {
                    }
                });
            }
            else {
                alertify.alert('Please Check At Least One..!');
            }
        }
    </script>
    <script type="text/javascript">
        function SavedSuccessfully(status) {
            alertify.alert(status);
        }
    </script>
    <div class="app-content">
        <div class="app-title">
            <div>
                <h1>
                    <i class="fa fa-edit"></i>View Voters</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <div class="row form-group">
                            <div class="col-md-12">
                                <asp:LinkButton ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger offset-5"
                                    OnClick="btnDelete_Click" OnClientClick="return abc(this,event);"></asp:LinkButton>
                            </div>
                        </div>
                        <div class="row">
                            <table class="table table-hover table-bordered table-responsive-md" id="sampleTable">
                                <thead>
                                    <tr>
                                        <th>
                                            <asp:CheckBox ID="chkHeader" runat="server" />
                                        </th>
                                        <th>
                                            #
                                        </th>
                                        <th>
                                            Pic
                                        </th>
                                        <th>
                                            Name
                                        </th>
                                        <th>
                                            Address
                                        </th>
                                        <th>
                                            Community
                                        </th>
                                        <th>
                                            Booth No.
                                        </th>
                                        <th>
                                            Phone1
                                        </th>
                                        <th>
                                            Phone2
                                        </th>
                                        <th>
                                            Action
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptVoters" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkRow" runat="server" />
                                                    <asp:HiddenField ID="hfId" runat="server" Value='<%#Eval("votersId") %>' />
                                                </td>
                                                <td>
                                                    <%#Container.ItemIndex+1 %>
                                                </td>
                                                <td>
                                                    <center>
                                                        <img id="imgProfilePic" src="../images/profilePics/<%# Eval("profilePic")%>" height="40px"
                                                            width="40px" /></center>
                                                </td>
                                                <td>
                                                    <%#Eval("name") %>
                                                </td>
                                                <td>
                                                    <%#Eval("address") %>
                                                </td>
                                                <td>
                                                    <%#Eval("communityName")%>
                                                </td>
                                                <td>
                                                    <%#Eval("boothNo")%>
                                                </td>
                                                <td>
                                                    <%#Eval("primaryContactNo")%>
                                                </td>
                                                <td>
                                                    <%#Eval("secondryContactNo")%>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="btn_VotersEdit" runat="server" Text="<i class='fa fa-edit'></i>"
                                                        CssClass="btn btn-default btn-sm" CommandArgument='<%#Eval("votersId") %>' OnClick="btn_VotersEdit"></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                        <div class="row form-group">
                            <div class="col-md-12">
                                <asp:LinkButton ID="btnDelete2" runat="server" Text="Delete" CssClass="btn btn-danger offset-5"
                                    OnClick="btnDelete_Click" OnClientClick="return abc(this,event);"></asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
