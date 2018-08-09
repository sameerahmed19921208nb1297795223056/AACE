<%@ Page Title="" Language="C#" MasterPageFile="~/windows/siteMaster.master" AutoEventWireup="true"
    CodeFile="constituencyCreate.aspx.cs" Inherits="windows_constituencyCreate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            
            $('table.display').DataTable({
                bStateSave: true,
                stateSave: true,
                "bDestroy": true,
                fnStateSave: function (settings, data) {
                    localStorage.setItem("dataTables_state", JSON.stringify(data));
                },
                fnStateLoad: function (settings) {
                    return JSON.parse(localStorage.getItem("dataTables_state"));
                }
            });

            var activeDiv = $("#hfActiveDiv").val();
            if (activeDiv == "") {
                $("#divReg").hide();
                $("#divArea").hide();
                $("#divBooth").hide();
            }
            else {
                $("#divConst").hide();
                $("#divReg").hide();
                $("#divArea").hide();
                $("#divBooth").hide();
                $("#" + activeDiv).show();

            }
        });
        function tabActivation(divId, val1, val2, val3, val4, tab) {
            
            $("#divConst").hide();
            $("#divReg").hide();
            $("#divArea").hide();
            $("#divBooth").hide();
            $("#" + divId).show();
            $('table.display').DataTable({
                bStateSave: true,
                stateSave: true,
                "bDestroy": true,
                fnStateSave: function (settings, data) {
                    localStorage.setItem("dataTables_state", JSON.stringify(data));
                },
                fnStateLoad: function (settings) {
                    return JSON.parse(localStorage.getItem("dataTables_state"));
                }
            });



            if (val1 == 1) {
                $('a[href="' + tab + '"]').removeClass("active");
                $('a[href="#divConst"]').removeClass("active");
                $('a[href="#divReg"]').removeClass("active");
                $('a[href="#divArea"]').removeClass("active");
                $('a[href="#divBooth"]').removeClass("active");
                $('a[href="#' + divId + '"]').addClass("active");
                $("#heading").text(val3);
                $("#heading").addClass('fa fa-edit');
                if (val4 == 1) {
                  SavedSuccessfully(val2);
                }
            }
        };
    </script>
    <div class="app-content">
        <div class="app-title">
            <div>
                <h1 id="heading" class="fa fa-edit">
                    Constituency Add</h1>
            </div>
            <div id="tabs">
                <ul class="nav nav-tabs tabs">
                    <li class="nav-item"><a data-toggle="tab" class="nav-link active %>" href="#divConst"
                        onclick="tabActivation('divConst','1','','Constituency Add','','')">Constituency</a>
                    </li>
                    <li class="nav-item"><a data-toggle="tab" class="nav-link" href="#divReg" onclick="tabActivation('divReg','1','','Region Add','','#divConst')">
                        Region</a> </li>
                    <li class="nav-item"><a data-toggle="tab" class="nav-link" href="#divArea" onclick="tabActivation('divArea','1','','Area Add','','#divConst')">
                        Area</a> </li>
                    <li class="nav-item"><a data-toggle="tab" class="nav-link" href="#divBooth" onclick="tabActivation('divBooth','1','','Booth Add','','#divConst')">
                        Booth</a> </li>
                </ul>
            </div>
        </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UP_Const" runat="server">
            <ContentTemplate>
                <div class="row active" id="divConst">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="tile-body">
                                <div class="row">
                                    <div class="col-md-3">
                                        <label>
                                            Constituency</label>
                                        <asp:TextBox ID="txt_ConstituencyName" runat="server" CssClass="form-control" placeholder="Enter the constituency Name"></asp:TextBox>
                                        <h3>
                                            <asp:RequiredFieldValidator ID="req_ConstName" runat="server" ControlToValidate="txt_ConstituencyName"
                                                ErrorMessage="*" ForeColor="Red" ValidationGroup="gp"></asp:RequiredFieldValidator></h3>
                                    </div>
                                    <div class="col-md-2 mt-4">
                                        <asp:Button ID="BtnSave" runat="server" Text="Save" class="btn btn-primary add_submit"
                                            ValidationGroup="gp" OnClick="BtnSave_Click1" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="tile-footer">
                                        <table class="table table-hover table-bordered display table-responsive-md" id="">
                                            <thead>
                                                <tr>
                                                    <th>
                                                        #
                                                    </th>
                                                    <th>
                                                        Constituency Name
                                                    </th>
                                                    <th>
                                                        Actions
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rptConstituency" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <%#Container.ItemIndex+1 %>
                                                            </td>
                                                            <td>
                                                                <%#Eval("constituencyName")%>
                                                            </td>
                                                            <td>
                                                                <div class="btn-group">
                                                                    <asp:LinkButton ID="btn_ConstituencyEdit" runat="server" Text="<i class='fa fa-edit'></i>"
                                                                        ToolTip="Edit" CssClass="btn btn-default btn-sm" CommandArgument='<%#Eval("constituencyId") %>'
                                                                        CommandName='<%#Eval("constituencyName") %>' OnClick="btn_ConstituencyEdit"></asp:LinkButton>
                                                                    <asp:LinkButton ID="btn_ConstituencyDelete" runat="server" Text="<i class='fa fa-trash'></i>"
                                                                        ToolTip="Delete" CommandArgument='<%#Eval("constituencyId") %>' CommandName='<%#Eval("constituencyName") %>'
                                                                        OnClick="btn_ConstituencyDelete" CssClass="btn btn-default btn-sm" OnClientClick="return abc(this,event);"></asp:LinkButton>
                                                                </div>
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
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UP_Reg" runat="server">
            <ContentTemplate>
                <div class="row" id="divReg" style="display: none">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="tile-body">
                                <div class="row">
                                    <div class="col-md-3">
                                        <label>
                                            Constituency :</label>
                                        <asp:DropDownList ID="ddl_ConstInReg" runat="server" CssClass="form-control" AutoPostBack="true"
                                            OnSelectedIndexChanged="ddl_ConstInReg_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <h3>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddl_ConstInReg"
                                                ErrorMessage="*" ForeColor="Red" InitialValue="0" ValidationGroup="reg"></asp:RequiredFieldValidator></h3>
                                    </div>
                                    <div class="col-md-3">
                                        <label>
                                            Region :</label>
                                        <asp:TextBox ID="txt_RegionName" runat="server" CssClass="form-control" placeholder="Enter the Region Name"></asp:TextBox>
                                        <h3>
                                            <asp:RequiredFieldValidator ID="req_RegionName" runat="server" ControlToValidate="txt_RegionName"
                                                Display="Dynamic" ErrorMessage="*" ForeColor="Red" ValidationGroup="reg"></asp:RequiredFieldValidator></h3>
                                    </div>
                                    <div class="col-md-2 mt-4">
                                        <asp:Button ID="btn_RegSave" runat="server" Text="Save" class="btn btn-primary" ValidationGroup="reg"
                                            OnClick="btn_RegSave_Click" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="tile-footer">
                                        <table class="table table-hover table-bordered display table-responsive-md" id="">
                                            <thead>
                                                <tr>
                                                    <th>
                                                        #
                                                    </th>
                                                    <th>
                                                        Constituency Name
                                                    </th>
                                                    <th>
                                                        Region Name
                                                    </th>
                                                    <th>
                                                        Actions
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rpt_Region" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <%#Container.ItemIndex+1 %>
                                                            </td>
                                                            <td>
                                                                <%#Eval("constituencyName")%>
                                                            </td>
                                                            <td>
                                                                <%#Eval("regName")%>
                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="btn_RegionEdit" runat="server" Text="<i class='fa fa-edit'></i>"
                                                                    ToolTip="Edit" CssClass="btn btn-default btn-sm" CommandArgument='<%#Eval("regionId") %>'
                                                                    CommandName='<%#Eval("regName") %>' OnClick="btn_RegionEdit"></asp:LinkButton>
                                                                <asp:LinkButton ID="btn_RegionDelete" runat="server" Text="<i class='fa fa-trash'></i>"
                                                                    ToolTip="Delete" CommandArgument='<%#Eval("regionId") %>' CommandName='<%#Eval("regName") %>'
                                                                    OnClick="btn_RegionDelete" CssClass="btn btn-default btn-sm" OnClientClick="return abc(this,event);"></asp:LinkButton>
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
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UP_Area" runat="server">
            <ContentTemplate>
                <div class="row" id="divArea" style="display: none">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="tile-body">
                                <div class="row">
                                    <div class="col-md-3">
                                        <label>
                                            Constituency</label>
                                        <asp:DropDownList ID="ddl_ConstInArea" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddl_ConstInArea_SelectedIndexChanged"
                                            AutoPostBack="true">
                                        </asp:DropDownList>
                                        <h3>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddl_ConstInArea"
                                                ErrorMessage="*" ForeColor="Red" InitialValue="0" ValidationGroup="Area"></asp:RequiredFieldValidator></h3>
                                    </div>
                                    <div class="col-md-3">
                                        <label>
                                            Region</label>
                                        <asp:DropDownList ID="ddl_RegInArea" runat="server" CssClass="form-control">
                                        </asp:DropDownList>
                                        <h3>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddl_RegInArea"
                                                Display="Dynamic" ErrorMessage="*" ForeColor="Red" InitialValue="0" ValidationGroup="Area"></asp:RequiredFieldValidator></h3>
                                    </div>
                                    <div class="col-md-3">
                                        <label>
                                            Area</label>
                                        <asp:TextBox ID="txt_Area" runat="server" CssClass="form-control" placeholder="Enter the Area Name"></asp:TextBox>
                                        <h3>
                                            <asp:RequiredFieldValidator ID="reg_Area" runat="server" ControlToValidate="txt_Area"
                                                Display="Dynamic" ErrorMessage="*" ForeColor="Red" ValidationGroup="Area"></asp:RequiredFieldValidator></h3>
                                    </div>
                                    <div class="col-md-2 mt-4">
                                        <asp:Button ID="btn_AreaSave" runat="server" Text="Save" class="btn btn-primary"
                                            ValidationGroup="Area" OnClick="btn_AreaSave_Click" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="tile-footer">
                                        <table class="table table-hover table-bordered display table-responsive-md" id="">
                                            <thead>
                                                <tr>
                                                    <th>
                                                        #
                                                    </th>
                                                    <th>
                                                        Constituency Name
                                                    </th>
                                                    <th>
                                                        Region Name
                                                    </th>
                                                    <th>
                                                        Area Name
                                                    </th>
                                                    <th>
                                                        Actions
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rpt_Area" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <%#Container.ItemIndex+1 %>
                                                            </td>
                                                            <td>
                                                                <%#Eval("constituencyName")%>
                                                            </td>
                                                            <td>
                                                                <%#Eval("regName")%>
                                                            </td>
                                                            <td>
                                                                <%#Eval("areaName")%>
                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="btn_AreaEdit" runat="server" Text="<i class='fa fa-edit'></i>"
                                                                    ToolTip="Edit" CssClass="btn btn-default btn-sm" CommandArgument='<%#Eval("areaId") %>'
                                                                    CommandName='<%#Eval("regName") %>' OnClick="btn_AreaEdit"></asp:LinkButton>
                                                                <asp:LinkButton ID="btn_AreaDelete" runat="server" Text="<i class='fa fa-trash'></i>"
                                                                    ToolTip="Delete" CommandArgument='<%#Eval("areaId") %>' CommandName='<%#Eval("regName") %>'
                                                                    OnClick="btn_AreaDelete" CssClass="btn btn-default btn-sm" OnClientClick="return abc(this,event);"></asp:LinkButton>
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
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UP_Booth" runat="server">
            <ContentTemplate>
                <div class="row hide" id="divBooth" style="display: none">
                    <div class="col-md-12">
                        <div class="tile">
                            <div class="tile-body">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>
                                                    Constituency</label>
                                                <asp:DropDownList ID="ddl_ConstInBooth" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddl_ConstInBooth_SelectedIndexChanged"
                                                    AutoPostBack="true">
                                                </asp:DropDownList>
                                                <h3>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddl_ConstInBooth"
                                                        ErrorMessage="*" ForeColor="Red" InitialValue="0" ValidationGroup="Booth"></asp:RequiredFieldValidator></h3>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>
                                                    Region</label>
                                                <asp:DropDownList ID="ddl_RegInBooth" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddl_RegInBooth_SelectedIndexChanged"
                                                    AutoPostBack="true">
                                                </asp:DropDownList>
                                                <h3>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddl_RegInBooth"
                                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" InitialValue="0" ValidationGroup="Booth"></asp:RequiredFieldValidator></h3>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>
                                                    Area</label>
                                                <asp:DropDownList ID="ddl_AreaInBooth" runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                                <h3>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddl_AreaInBooth"
                                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" InitialValue="0" ValidationGroup="Booth"></asp:RequiredFieldValidator></h3>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>
                                                    Booth</label>
                                                <asp:TextBox ID="txt_Booth" runat="server" CssClass="form-control" placeholder="Enter the Booth Name"></asp:TextBox>
                                                <h3>
                                                    <asp:RequiredFieldValidator ID="req_booth" runat="server" ControlToValidate="txt_Booth"
                                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" ValidationGroup="Booth"></asp:RequiredFieldValidator></h3>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="modal-footer">
                                                <asp:Button ID="btn_SaveBooth" runat="server" Text="Save" class="btn btn-primary"
                                                    ValidationGroup="Booth" OnClick="btn_SaveBooth_Click" /></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="tile-footer">
                                            <table class="table table-hover table-bordered display table-responsive-md" id="">
                                                <thead>
                                                    <tr>
                                                        <th>
                                                            #
                                                        </th>
                                                        <th>
                                                            Constituency Name
                                                        </th>
                                                        <th>
                                                            Region Name
                                                        </th>
                                                        <th>
                                                            Area Name
                                                        </th>
                                                        <th>
                                                            Booth No
                                                        </th>
                                                        <th>
                                                            Actions
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:Repeater ID="rpt_Booth" runat="server">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td>
                                                                    <%#Container.ItemIndex+1 %>
                                                                </td>
                                                                <td>
                                                                    <%#Eval("constituencyName")%>
                                                                </td>
                                                                <td>
                                                                    <%#Eval("regName")%>
                                                                </td>
                                                                <td>
                                                                    <%#Eval("areaName")%>
                                                                </td>
                                                                <td>
                                                                    <%#Eval("boothNo")%>
                                                                </td>
                                                                <td>
                                                                    <asp:LinkButton ID="btn_Booth_Edit" runat="server" Text="<i class='fa fa-edit'></i>"
                                                                        CssClass="btn btn-default btn-sm" CommandArgument='<%#Eval("boothId") %>' CommandName='<%#Eval("regName") %>'
                                                                        OnClick="btn_Booth_Edit"></asp:LinkButton>
                                                                    <asp:LinkButton ID="btn_Booth_Del" runat="server" Text="<i class='fa fa-trash'></i>"
                                                                        CommandArgument='<%#Eval("boothId") %>' OnClick="btn_Booth_Del" CssClass="btn btn-default btn-sm"
                                                                        OnClientClick="return abc(this,event);"></asp:LinkButton>
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
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:HiddenField ID="hfActiveDiv" runat="server" ClientIDMode="Static" />
    </div>
    <%-- <script type="text/javascript">
        function abc(ctl, event) {
            
            var defaultAction = $(ctl).prop('href');
            event.preventDefault();

            $.confirm({
                title: 'Confirmation',
                content: 'All the Related records will also be deleted! Are you Sure to Delete?',
                theme: 'material',
                closeIcon: true,
                buttons: {
                    specialKey: {
                        text: 'Yes',
                        action: function () {
                            eval(defaultAction);
                        }
                    },
                    alphabet: {
                        text: 'NO',
                        action: function () {
                        }
                    }
                },
                animation: 'scale',
                closeAnimation: 'zoom',
                type: 'green'
            });


        }
    </script>
    <script type="text/javascript">
        function SavedSuccessfully(status) {

            
            $.alert({
                title: 'Confirmation',
                content: 'Record ' + status + ' Successfully...!',
                theme: 'material',
                closeIcon: true,
                animation: 'scale',
                closeAnimation: 'zoom',
                type: 'green'
            });
        }
    </script>--%>
    <script type="text/javascript">
        function abc(ctl, event) {
            var defaultAction = $(ctl).prop('href');
            event.preventDefault();
            alertify.confirm('The related records will also be deleted. Are you sure to Delete?', function (e) {
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
