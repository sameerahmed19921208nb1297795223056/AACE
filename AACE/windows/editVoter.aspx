<%@ Page Title="" Language="C#" MasterPageFile="~/windows/siteMaster.master" AutoEventWireup="true"
    CodeFile="editVoter.aspx.cs" Inherits="windows_editVoter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="http://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function PreviewImage(Imagepath) {
            if (Imagepath.files && Imagepath.files[0]) {
                var Filerdr = new FileReader();
                Filerdr.onload = function (e) {
                    $('#ContentPlaceHolder1_imgProfilePic').attr('src', e.target.result);
                }
                Filerdr.readAsDataURL(Imagepath.files[0]);
            }
        }
    </script>
    <asp:ScriptManager runat="server" ID="ScriptManager">
    </asp:ScriptManager>
    <div class="app-content">
        <div class="app-title">
            <div>
                <h1>
                    <i class="fa fa-edit"></i>Voters Details</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <div class="form-group row">
                            <label class="control-label col-md-3">
                                Name</label>
                            <div class="col-md-3">
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <%--<h3><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName"
                                     Display="Dynamic" ErrorMessage="*" ForeColor="Red"
                                    SetFocusOnError="true" ValidationGroup="gp"></asp:RequiredFieldValidator></h3>--%>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="control-label col-md-3">
                            Address</label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <%--<h3><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtAddress"
                                 Display="Dynamic" ErrorMessage="*" ForeColor="Red"
                                SetFocusOnError="true" ValidationGroup="gp"></asp:RequiredFieldValidator></h3>--%>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="control-label col-md-3">
                            Community Name</label>
                        <div class="col-md-3">
                            <asp:DropDownList ID="ddlCommunity" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <h3>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlCommunity"
                                    Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="true" ValidationGroup="gp"
                                    InitialValue="0"></asp:RequiredFieldValidator></h3>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="control-label col-md-3">
                            Constituency</label>
                        <div class="col-md-3">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlConstituency" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlConstituency_SelectedIndexChanged"
                                        AutoPostBack="true">
                                    </asp:DropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <div class="col-md-6">
                            <h3>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlConstituency"
                                    Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="true" ValidationGroup="gp"
                                    InitialValue="0"></asp:RequiredFieldValidator></h3>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="control-label col-md-3">
                            Region</label>
                        <div class="col-md-3">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlRegion" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlRegion_SelectedIndexChanged"
                                        AutoPostBack="true">
                                    </asp:DropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <div class="col-md-6">
                            <h3>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlRegion"
                                    Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="true" ValidationGroup="gp"
                                    InitialValue="0"></asp:RequiredFieldValidator></h3>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="control-label col-md-3">
                            Area</label>
                        <div class="col-md-3">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel3">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlArea" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlArea_SelectedIndexChanged"
                                        AutoPostBack="true">
                                    </asp:DropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <div class="col-md-6">
                            <h3>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlArea"
                                    Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="true" ValidationGroup="gp"
                                    InitialValue="0"></asp:RequiredFieldValidator></h3>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="control-label col-md-3">
                            Booth No.</label>
                        <div class="col-md-3">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel4">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlBoothNo" runat="server" CssClass="form-control">
                                    </asp:DropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <div class="col-md-6">
                            <h3>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ddlBoothNo"
                                    Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="true" ValidationGroup="gp"
                                    InitialValue="0"></asp:RequiredFieldValidator></h3>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="control-label col-md-3">
                            Phone1</label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtMobile1" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <h3>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtMobile1"
                                    Display="Dynamic" ErrorMessage="*" ForeColor="Red" SetFocusOnError="true" ValidationGroup="gp"></asp:RequiredFieldValidator></h3>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="control-label col-md-3">
                            Phone2</label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtMobile2" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="control-label col-md-3">
                            Select File</label>
                        <div class="col-md-3">
                            <asp:Image ID="imgProfilePic" runat="server" Style="width: 40%;" class="form-control" />
                            <asp:FileUpload ID="flupload" class="form-control" runat="server" onchange="PreviewImage(this);" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click"
                                    class="btn btn-primary" ValidationGroup="gp" />
                                <asp:Button ID="btnCancel" runat="server" class="btn btn-primary" Text="Cancel" onclick="btnCancel_Click1" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
