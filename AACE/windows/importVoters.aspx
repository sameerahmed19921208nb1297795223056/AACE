<%@ Page Title="" Language="C#" MasterPageFile="~/windows/siteMaster.master" AutoEventWireup="true"
    CodeFile="importVoters.aspx.cs" Inherits="windows_importVoters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script type="text/javascript">
    function SavedSuccessfully(status) {
        alertify.alert(status);
    }
</script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="app-content">
        <div class="app-title">
            <div>
                <h1>
                    <i class="fa fa-edit"></i>Import Voters</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile" id="divControls" runat="server">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tile">
                                <div class="tile-body">
                                    <h5>
                                        <span style="color: Orange;">Note</span> : Please
                                        <asp:LinkButton ID="lnkDownload" runat="server" Text="Click hear" OnClick="lnkDownload_Click"></asp:LinkButton>
                                        to download Excel format to import data.
                                    </h5>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group row">
                                <label class="control-label col-md-3">
                                    Select Community :</label>
                                <div class="col-md-3">
                                    <asp:DropDownList ID="ddlCommunity" class="form-control" runat="server">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6">
                                    <h3>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlCommunity"
                                            Display="Dynamic" ErrorMessage="*" ForeColor="Red" ValidationGroup="gp" InitialValue="0"></asp:RequiredFieldValidator></h3>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="control-label col-md-3">
                                    Select Constituency :</label>
                                <div class="col-md-3">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddlConstituency" runat="server" OnSelectedIndexChanged="ddlConstituency_SelectedIndexChanged"
                                                AutoPostBack="true" class="form-control">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="col-md-6">
                                    <h3>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlBoothNo"
                                            Display="Dynamic" ErrorMessage="*" ForeColor="Red" ValidationGroup="gp" InitialValue="0"></asp:RequiredFieldValidator></h3>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="control-label col-md-3">
                                    Select Region :</label>
                                <div class="col-md-3">
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddlRegion" runat="server" OnSelectedIndexChanged="ddlRegion_SelectedIndexChanged"
                                                AutoPostBack="true" class="form-control">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="col-md-6">
                                    <h3>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlBoothNo"
                                            Display="Dynamic" ErrorMessage="*" ForeColor="Red" ValidationGroup="gp" InitialValue="0"></asp:RequiredFieldValidator></h3>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="control-label col-md-3">
                                    Select Area :</label>
                                <div class="col-md-3">
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddlArea" runat="server" OnSelectedIndexChanged="ddlArea_SelectedIndexChanged"
                                                AutoPostBack="true" class="form-control">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="col-md-6">
                                    <h3>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlBoothNo"
                                            Display="Dynamic" ErrorMessage="*" ForeColor="Red" ValidationGroup="gp" InitialValue="0"></asp:RequiredFieldValidator></h3>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="control-label col-md-3">
                                    Select BoothNo :</label>
                                <div class="col-md-3">
                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddlBoothNo" runat="server" class="form-control">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="col-md-6">
                                    <h3>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlBoothNo"
                                            Display="Dynamic" ErrorMessage="*" ForeColor="Red" ValidationGroup="gp" InitialValue="0"></asp:RequiredFieldValidator></h3>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="control-label col-md-3">
                                    Select File</label>
                                <div class="col-md-3">
                                    <asp:FileUpload ID="FileUpload1" class="form-control" runat="server" />
                                </div>
                                <div class="col-md-6">
                                    <h3>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="FileUpload1"
                                            Display="Dynamic" ErrorMessage="*" ForeColor="Red" ValidationGroup="gp"></asp:RequiredFieldValidator></h3>
                                </div>
                            </div>
                            <div class="tile-footer">
                                <div class="row">
                                    <div class="offset-10">
                                        <asp:Button ID="btnUpload" class="btn btn-primary" runat="server" Text="Upload" OnClick="btnUpload_Click"
                                            ValidationGroup="gp" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="tile" id="divTableData" runat="server">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="col-md-12" id="divExcelData" runat="server">
                                <div class="tile">
                                    <div class="tile-body">
                                        <div class="form-group col-md-12 text-center">
                                            <asp:Button ID="btnConfirm" class="btn btn-primary" runat="server" Text="Confirm"
                                                OnClick="btnConfirm_Click" Visible="false" />
                                            <asp:Button ID="btnCancel" runat="server" class="btn btn-primary" Text="Cancel" OnClick="btnCancel_Click" />
                                        </div>
                                        <table class="table table-hover table-bordered" id="sampleTable">
                                            <thead>
                                                <tr>
                                                    <th>
                                                        Sl no.
                                                    </th>
                                                    <th>
                                                        Name
                                                    </th>
                                                    <th>
                                                        Address
                                                    </th>
                                                    <th>
                                                        Phone1
                                                    </th>
                                                    <th>
                                                        Phone2
                                                    </th>
                                                </tr>
                                            </thead>
                                            <asp:Repeater ID="rptVotersExcelData" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <%#Container.ItemIndex+1%>
                                                        </td>
                                                        <td>
                                                            <%# Eval("Name")%>
                                                        </td>
                                                        <td>
                                                            <%# Eval("Address")%>
                                                        </td>
                                                        <td>
                                                            <%# Eval("Phone1")%>
                                                        </td>
                                                        <td>
                                                            <%# Eval("Phone2")%>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
