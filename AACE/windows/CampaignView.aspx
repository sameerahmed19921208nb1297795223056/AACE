<%@ Page Title="" Language="C#" MasterPageFile="~/windows/siteMaster.master" AutoEventWireup="true"
    CodeFile="CampaignView.aspx.cs" Inherits="windows_CampaignView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="app-content">
        <div class="app-title">
            <div>
                <h1>
                    <i class="fa fa-edit"></i>View Campaign</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <div class="row" id="div1" runat="server">
                            <table class="table table-hover table-bordered table-responsive-md" id="sampleTable">
                                <thead>
                                    <tr>
                                        <th>
                                            #
                                        </th>
                                        <th>
                                            Campaign Name
                                        </th>
                                        <th>
                                            campaignDescription
                                        </th>
                                        <th>
                                            Call
                                        </th>
                                        <th>
                                            Sms
                                        </th>
                                        <th>
                                            Actions
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptCampaignView" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <%#Container.ItemIndex+1 %>
                                                </td>
                                                <td>
                                                    <%#Eval("campaignTitle")%>
                                                    <td>
                                                        <%#Eval("campaignDescription")%>
                                                    </td>
                                                    <td>
                                                        <%--<asp:Button ID="btnCall" runat="server" Text="Call" CssClass="btn btn-container"
                                                            OnClientClick="loader()" CommandArgument='<%#Eval("campaignId") %>' OnClick="btnCall_Click" />--%>
                                                        <asp:LinkButton ID="btnCall" runat="server" Text="<i class='fa fa-phone fa-2x'></i>"
                                                            OnClientClick="loader()" CommandArgument='<%#Eval("campaignId") %>' class=" btn btn-default"
                                                            OnClick="btnCall_Click"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <%--  <asp:Button ID="btnSms" runat="server" Text="Sms" CssClass="btn btn-container" CommandArgument='<%#Eval("campaignId") %>'
                                                            OnClick="btnSms_Click" />--%>
                                                        <asp:LinkButton ID="btnSms" runat="server" Text="<i class='fa fa-envelope fa-2x'></i>"
                                                            CssClass="btn btn-default" CommandArgument='<%#Eval("campaignId") %>' OnClick="btnSms_Click"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <a class="btn btn-default btn-sm" href="#" onclick='getDetails(<%#Eval("campaignId")%>)'>
                                                            <i class='fa fa-eye'></i></a>
                                                        <asp:LinkButton ID="btn_Campaign_Delete" runat="server" ToolTip="Delete Details"
                                                            Text="<i class='fa fa-trash'></i>" CommandArgument='<%#Eval("campaignId") %>'
                                                            OnClick="btn_Campaign_Delete" CssClass="btn btn-default btn-sm" OnClientClick="return abc(this,event);"></asp:LinkButton>
                                                    </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                        <div class="row" id="div2" runat="server">
                            <td>
                                <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn btn-container"
                                    OnClick="btnBack_Click" />
                            </td>
                            <table class="table table-hover table-bordered" id="Table1" style="padding-left: 23px">
                                <thead>
                                    <tr>
                                        <th>
                                            #
                                        </th>
                                        <th>
                                            Campaign Name
                                        </th>
                                        <th>
                                            Campaign Description
                                        </th>
                                        <th>
                                            Option1
                                        </th>
                                        <th>
                                            Option2
                                        </th>
                                        <th>
                                            Option3
                                        </th>
                                        <th>
                                            Option4
                                        </th>
                                        <th>
                                            Option5
                                        </th>
                                        <th>
                                            Option6
                                        </th>
                                        <th>
                                            Option7
                                        </th>
                                        <th>
                                            Option8
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptCamDetailsView" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <%#Container.ItemIndex+1 %>
                                                </td>
                                                <td>
                                                    <%#Eval("campaignTitle")%>
                                                </td>
                                                <td style="width: 2px">
                                                    <%#Eval("campaignDescription")%>
                                                </td>
                                                <td>
                                                    <%#Eval("option1")%>
                                                </td>
                                                <td>
                                                    <%#Eval("option2")%>
                                                </td>
                                                <td>
                                                    <%#Eval("option3")%>
                                                </td>
                                                <td>
                                                    <%#Eval("option4")%>
                                                </td>
                                                <td>
                                                    <%#Eval("option5")%>
                                                </td>
                                                <td>
                                                    <%#Eval("option6")%>
                                                </td>
                                                <td>
                                                    <%#Eval("option7")%>
                                                </td>
                                                <td>
                                                    <%#Eval("option8")%>
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
        <!--Modal popup-->
        <div id="classModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="classInfo"
            aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <%--        <div class="modal-content" style="margin-top: 20%; background-color: black; color: white;
                    border-color: white;">--%>
                <div class="modal-content" style="margin-top: 20%;">
                    <div class="modal-header">
                        <h4 class="modal-title" id="classModalLabel">
                            Campaign Details
                        </h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            ×
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="divCampaignMaster">
                        </div>
                        <div id="divCampaignDetails">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="btnPrevious" class="btn btn-primary" onclick="getPreviousData()">
                            Previous
                        </button>
                        <button type="button" id="btnNext" class="btn btn-primary" onclick="getNextData()">
                            Next
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!--Modal popup-->
    </div>
    <style type="text/css">
        .loading
        {
            font-family: Arial;
            font-size: 10pt;
            width: 200px;
            height: 150px;
            display: none;
            position: fixed;
            background-color: White;
            z-index: 1;
        }
        .form-control-sm
        {
            height: 32px !important;
        }
        
        .modal-body
        {
            overflow-x: auto;
        }
    </style>
    <script type="text/javascript">
        function ShowProgress() {
            $('.app-content').fadeTo(0, 0.1);
            setTimeout(function () {
                var modal = $('<div />');
                modal.addClass("modal");
                $('body').append(modal);
                var loading = $(".loading");
                loading.show();
                var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
                var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
                loading.css({ top: top, left: left });
            }, 200);
        }
        function loader() {
            ShowProgress();
        }
    </script>
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
    </script>
    <script type="text/javascript">
        function SavedSuccessfully(status) {
            alertify.alert(status);
        }
    </script>
    <div class="loading" align="center">
        <img src="../images/loader.gif" alt="" /><br />
        <br />
        <h5>
            Processing.... Please wait.</h5>
    </div>
    <%--<link href="css/bootstrap.min.modalpopup.css" rel="stylesheet" type="text/css" />--%>
    <script type="text/javascript">
        function getDetails(id) {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/getCampaignMaster",
                data: "{ campaignId: '" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (sub) {
                    
                    if (sub.d !== "" && sub.d != null) {
                        $("#divCampaignMaster").empty();
                        $("#divCampaignMaster").html(sub.d);
                        $('#classModal').modal('show');
                        gettDat(id);
                    }
                },
                failure: function (msg) {
                    alert(msg);
                }
            });
        }

        function gettDat(val) {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/getCampaignDetails",
                data: "{ campaignId: '" + val + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (sub) {
                    $("#divCampaignDetails").empty();
                    if (sub.d !== "" && sub.d != null) {
                        $("#divCampaignDetails").html(sub.d);
                        $("#divCampaignDetails").hide();
                        $("#divCampaignMaster").show();
                        $("#btnNext").show();
                        $("#btnPrevious").hide();
                    }
                },
                failure: function (msg) {
                    alert(msg);
                }
            });
        }

        function getNextData() {
            $("#divCampaignDetails").show();
            $("#divCampaignMaster").hide();
            $("#btnNext").hide();
            $("#btnPrevious").show();
        }

        function getPreviousData() {
            $("#divCampaignDetails").hide();
            $("#divCampaignMaster").show();
            $("#btnPrevious").hide();
            $("#btnNext").show();
        }
    </script>
</asp:Content>
