<%@ Page Title="" Language="C#" MasterPageFile="~/windows/siteMaster.master" EnableEventValidation="false"
    AutoEventWireup="true" CodeFile="campaignCreate.aspx.cs" Inherits="windows_campaignCreate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        input[type="radio"]
        {
            -ms-transform: scale(1.5); /* IE 9 */
            -webkit-transform: scale(1.5); /* Chrome, Safari, Opera */
            transform: scale(1.5);
            width: 20px;
        }
        .divDynamic
        {
            border: 2px solid black;
            padding: 10px 0px 6px 10px;
            margin: 5px;
            background-color: #3f3e44;
            color: white;
            border-radius: 5px;
        }
        .text-right
        {
            float: right;
            font-size: large;
            cursor: pointer;
        }
        .btn-group
        {
            width: 100% !important;
        }
        .multiselect-container
        {
            width: 100%;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $("#ddlCampaignType").on('change', function () {
                
                var selected = $("#ddlCampaignType :selected").val();
                $("#div_Move").hide();
                $("#ContentPlaceHolder1_lb_Options").empty();
                if (selected != "0") {
                    $.ajax({
                        type: "POST",
                        url: "campaignCreate.aspx/getAllOptions",
                        data: '{rblCampaignType:"' + selected + '"}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {
                            if (msg.d != "[]" && msg.d != null)
                            { bindOptions(msg); } else {
                                $('.optionData').remove();
                            }
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            alert(textStatus);
                        }
                    });
                }
                else {
                    $("#ContentPlaceHolder1_lb_Options option").remove();
                    $("#ContentPlaceHolder1_lb_Options").multiselect('disable');
                }
            });
        });
        function bindOptions(message) {
            $('.optionData').remove();
            $("#ContentPlaceHolder1_lb_Options").empty();
            $(".divDynamic").remove();
            var obj = jQuery.parseJSON(message.d);
            $.each(obj, function (key, val) {
                $('#ContentPlaceHolder1_lb_Options').append('<option class="optionData" id="' + val.campOptionId + '">' + val.campaignOption + '</option>');
            });
            $('#ContentPlaceHolder1_lb_Options').multiselect('rebuild');
        }

        $(function () {
            $('#btn_Next').click(function () {
                var val1 = $('#ContentPlaceHolder1_txtTitle').val();
                var val2 = $('#ContentPlaceHolder1_txtDescription').val();
                var val3 = $('.multiselect-selected-text').text();
                var val4 = $("#ddlCampaignType :selected").val();
                ValidatorEnable(document.getElementById("ContentPlaceHolder1_rqCampaignType"), true);
                ValidatorEnable(document.getElementById("ContentPlaceHolder1_rqCampaignTiltle"), true);
                ValidatorEnable(document.getElementById("ContentPlaceHolder1_rqCampaignDescription"), true);
                ValidatorEnable(document.getElementById("ContentPlaceHolder1_rqLblOptions"), true);
                if (val1 != '' && val2 != '' && val4 != "0" && val3 != 'None selected') {
                    $('#div2').show();
                    $('#div1').hide();
                }
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#div2').hide();
            $("#ContentPlaceHolder1_ddlConstituency").append('<option value="%">Select All</option>');
            $("#ContentPlaceHolder1_ddlRegion").append('<option value="%">Select All</option>');
            $("#ContentPlaceHolder1_ddlArea").append('<option value="%">Select All</option>');
            $("#ContentPlaceHolder1_ddlBoothNo").append('<option value="%">Select All</option>');
            var constId = "%";
            var Com = $("ContentPlaceHolder1_ddlConstituency");
            $.ajax({
                type: "POST",
                url: "campaignCreate.aspx/LoadConstituency",
                data: '{constId:"' + constId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    BindConstituency(result);
                }
            });
            $('#ContentPlaceHolder1_lb_Options').multiselect({
                buttonWidth: '200px',
                includeSelectAllOption: false,
                maxHeight: 250,
                disableIfEmpty: true,
                inheritClass: true,
                numberDisplayed: 1,
                onChange: function (option, checked) {
                    // Get selected options.
                    var selectedOptions = $('#ContentPlaceHolder1_lb_Options option:selected');
                    if (selectedOptions.length >= 8) {
                        // Disable all other checkboxes.
                        var nonSelectedOptions = $('#ContentPlaceHolder1_lb_Options option').filter(function () {
                            return !$(this).is(':selected');
                        });

                        nonSelectedOptions.each(function () {
                            var input = $('input[value="' + $(this).val() + '"]');
                            input.prop('disabled', true);
                            input.parent('li').addClass('disabled');
                        });
                    }
                    else {
                        // Enable all checkboxes.
                        $('#ContentPlaceHolder1_lb_Options option').each(function () {
                            var input = $('input[value="' + $(this).val() + '"]');
                            input.prop('disabled', false);
                            input.parent('li').addClass('disabled');
                        });
                    }
                }
            });
        });
        function BindConstituency(res) {
            var obj = JSON.parse(res.d);
            $.each(obj, function (index, value) {
                $("#ContentPlaceHolder1_ddlConstituency").append($("<option value='" + value.constituencyId + "'>" + value.constituencyName + "</option>"));
            });
        }
    </script>
    <script type="text/javascript">

        $("#ContentPlaceHolder1_ddlConstituency").change(function () {
            $("#ContentPlaceHolder1_ddlRegion").empty();
            $("#ContentPlaceHolder1_ddlArea").empty();
            $("#ContentPlaceHolder1_ddlBoothNo").empty();
            $("#ContentPlaceHolder1_ddlRegion").append('<option value="%">Select All</option>');
            $("#ContentPlaceHolder1_ddlArea").append('<option value="%">Select All</option>');
            $("#ContentPlaceHolder1_ddlBoothNo").append('<option value="%">Select All</option>');
            var constId = $("#ContentPlaceHolder1_ddlConstituency option:selected").val();
            $.ajax({
                type: "POST",
                url: "campaignCreate.aspx/loadRegion",
                data: '{constId:"' + constId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    bindRegion(result);
                }
            });
        });
        function bindRegion(res) {
            $("#ContentPlaceHolder1_ddlRegion").empty();
            $("#ContentPlaceHolder1_ddlRegion").append('<option value="%">Select All</option>')
            var obj = JSON.parse(res.d);
            $.each(obj, function (index, value) {
                $("#ContentPlaceHolder1_ddlRegion").append($("<option value='" + value.regionId + "'>" + value.regName + "</option>"));
            });
        }
    </script>
    <div class="app-content">
        <div class="app-title">
            <div>
                <h1>
                    <i class="fa fa-edit"></i>Create Campaign</h1>
            </div>
        </div>
        <div class="row" id="div1">
            <div class="col-md-12">
                <div class="tile">
                    <div class="row">
                        <div class="col-md-4 offset-1">
                            <div class="form-group">
                            <label>
                                    Campaign Type</label>
                                <asp:DropDownList ID="ddlCampaignType" CssClass="form-control" runat="server" ClientIDMode="Static">
                                <asp:ListItem Value="0">Select Campaign Type</asp:ListItem>
                                <asp:ListItem Text="Election">Election</asp:ListItem>
                                    <asp:ListItem Text="Education">Education</asp:ListItem>
                                </asp:DropDownList>
                                <h3>
                                    <asp:RequiredFieldValidator ID="rqCampaignType" runat="server" ControlToValidate="ddlCampaignType" InitialValue="0"
                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" ValidationGroup="gp"></asp:RequiredFieldValidator></h3>
                            </div>
                            <div class="form-group">
                                <label>
                                    Campaign Title</label>
                                <asp:TextBox ID="txtTitle" class="form-control" placeholder="Enter Campaign Title"
                                    runat="server"></asp:TextBox>
                                <h3>
                                    <asp:RequiredFieldValidator ID="rqCampaignTiltle" runat="server" ControlToValidate="txtTitle"
                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" ValidationGroup="gp"></asp:RequiredFieldValidator></h3>
                            </div>
                            <div class="form-group">
                                <label>
                                    Campaign description</label>
                                <asp:TextBox ID="txtDescription" class="form-control" placeholder="Enter Campaign Description"
                                    runat="server"></asp:TextBox>
                                <h3>
                                    <asp:RequiredFieldValidator ID="rqCampaignDescription" runat="server" ControlToValidate="txtDescription"
                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" ValidationGroup="gp"></asp:RequiredFieldValidator></h3>
                            </div>
                            <div class="form-group">
                                <label>
                                    Options</label>
                                <asp:ListBox ID="lb_Options" runat="server" SelectionMode="Multiple"></asp:ListBox>
                                <h3>
                                    <asp:RequiredFieldValidator ID="rqLblOptions" runat="server" ControlToValidate="lb_Options"
                                        Display="Dynamic" ErrorMessage="*" ForeColor="Red" ValidationGroup="gp"></asp:RequiredFieldValidator></h3>
                            </div>
                        </div>
                        <div class="form-group col-md-5 offset-1">
                            <div id="divNote" class="form-group col-md-12" style="display: none;">
                                <span style="color: Orange; font-size: large;"><u><b>Note</b></u></span> : When
                                a user has answered the call the following options will be called out in the order
                                listed below, if you want you can re order the elements below by draging and dropping.
                            </div>
                            <div class="card-body slides" id="div_Move" style="background-color: rgba(220, 220, 220, 0.97);
                                display: none">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="modal-footer">
                                <button class="btn btn-primary " type="button" id="btn_Next">
                                    Next</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" id="div2" style="display: none">
            <div class="col-md-12">
                <div class="tile">
                    <div class="row">
                        <div class="col-lg-6 offset-1">
                            <div class="form-group row">
                                <label class="control-label col-md-6">
                                    Select Community
                                </label>
                                <div class="col-md-6">
                                    <asp:DropDownList ID="ddlCommunity" class="form-control" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="control-label col-md-6">
                                    Constituency</label>
                                <div class="col-md-6">
                                    <asp:DropDownList ID="ddlConstituency" class="form-control" runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="control-label col-md-6">
                                    Region</label>
                                <div class="col-md-6">
                                    <asp:DropDownList ID="ddlRegion" runat="server" class="form-control">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="control-label col-md-6">
                                    Area</label>
                                <div class="col-md-6">
                                    <asp:DropDownList ID="ddlArea" runat="server" class="form-control">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="control-label col-md-6">
                                    BoothNo</label>
                                <div class="col-md-6">
                                    <asp:DropDownList ID="ddlBoothNo" class="form-control" runat="server">
                                    </asp:DropDownList>
                                </div>
                                <div id="snackbar">
                                    <asp:Label ID="lbl_Success" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label>
                                </label>
                            </div>
                            <div class="form-group row">
                                <label>
                                </label>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="modal-footer">
                                <button class="btn btn-primary" type="button" id="btn_Prev">
                                    Previous</button>
                                <button id="btn_Save" class="btn btn-primary" onclick="btn_Save">
                                    Save</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $("#ContentPlaceHolder1_lb_Options").on("change", function () {
            $("#div_Move").empty();
            $("#divNote").show();
            var opVal = [];
            $('#ContentPlaceHolder1_lb_Options :selected').each(function (i, selected) {
                opVal[i] = $(selected).val();
            });

            var selMulti = $.map($("#ContentPlaceHolder1_lb_Options option:selected"), function (el, i) {
                return $(el).text();
            });
            for (var i = 1; i <= selMulti.length; i++) {
                $("#div_Move").show();
                $("#div_Move").append("<div value='" + selMulti[i - 1] + "' id='divv" + i + "'  class=\"divDynamic\">" + selMulti[i - 1] + "<span onclick='opDelete(this.id)' id='" + [i] + "|" + opVal[i - 1] + "' class=\"text-right\"><i class=\"fa fa-times\"></i></span></div>");
            }
        });
        function opDelete(id) {
            $('#ContentPlaceHolder1_lb_Options').multiselect('deselect', id.split('|')[1], true);
            $("#divv" + id.split('|')[0] + "").remove();
        }        
    </script>
    <script type="text/javascript">

        $(".slides").sortable({
            update: function (event, ui) {
                var order = $(this).sortable('serialize');
            },
            helper: 'clone'
        });
    </script>
    <script type="text/javascript">

        $("#ContentPlaceHolder1_ddlConstituency").change(function () {
            $("#ContentPlaceHolder1_ddlRegion").empty();
            $("#ContentPlaceHolder1_ddlArea").empty();
            $("#ContentPlaceHolder1_ddlBoothNo").empty();
            $("#ContentPlaceHolder1_ddlRegion").append('<option value="%">Select All</option>');
            $("#ContentPlaceHolder1_ddlArea").append('<option value="%">Select All</option>');
            $("#ContentPlaceHolder1_ddlBoothNo").append('<option value="%">Select All</option>');
            var constId = $("#ContentPlaceHolder1_ddlConstituency option:selected").val();
            $.ajax({
                type: "POST",
                url: "campaignCreate.aspx/loadRegion",
                data: '{constId:"' + constId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    bindRegion(result);
                }
            });
        });
        function bindRegion(res) {
            $("#ContentPlaceHolder1_ddlRegion").empty();
            $("#ContentPlaceHolder1_ddlRegion").append('<option value="%">Select All</option>')
            var obj = JSON.parse(res.d);
            $.each(obj, function (index, value) {
                $("#ContentPlaceHolder1_ddlRegion").append($("<option value='" + value.regionId + "'>" + value.regName + "</option>"));
            });
        }
    </script>
    <script type="text/javascript">
        $("#ContentPlaceHolder1_ddlArea").change(function () {
            $("#ContentPlaceHolder1_ddlBoothNo").empty();
            $("#ContentPlaceHolder1_ddlBoothNo").append('<option value="%">Select All</option>');
            var areaId = $("#ContentPlaceHolder1_ddlArea option:selected").val();
            $.ajax({
                type: "POST",
                url: "campaignCreate.aspx/loadBooth",
                data: '{areaId:"' + areaId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    bindBooth(result);
                }
            });
        });
        function bindBooth(res) {
            $("#ContentPlaceHolder1_ddlBoothNo").empty();
            $("#ContentPlaceHolder1_ddlBoothNo").append('<option value="%">Select All</option>')
            var obj = JSON.parse(res.d);
            $.each(obj, function (index, value) {
                $("#ContentPlaceHolder1_ddlBoothNo").append($("<option value='" + value.boothId + "'>" + value.boothNo + "</option>"));
            });
        }
    
    </script>
    <script type="text/javascript">
        $("#ContentPlaceHolder1_ddlRegion").change(function () {
            $("#ContentPlaceHolder1_ddlArea").empty();
            $("#ContentPlaceHolder1_ddlBoothNo").empty();
            $("#ContentPlaceHolder1_ddlArea").append('<option value="%">Select All</option>');
            $("#ContentPlaceHolder1_ddlBoothNo").append('<option value="%">Select All</option>');
            var regId = $("#ContentPlaceHolder1_ddlRegion option:selected").val();
            $.ajax({
                type: "POST",
                url: "campaignCreate.aspx/loadArea",
                data: '{regId:"' + regId + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    bindArea(result);
                }
            });
        });
        function bindArea(res) {
            $("#ContentPlaceHolder1_ddlArea").empty();
            $("#ContentPlaceHolder1_ddlArea").append('<option value="%">Select All</option>')
            var obj = JSON.parse(res.d);
            $.each(obj, function (index, value) {
                $("#ContentPlaceHolder1_ddlArea").append($("<option value='" + value.areaId + "'>" + value.areaName + "</option>"));
            });
        }
    </script>
    <script type="text/javascript">
        $(function () {
            $("#btn_Save").on("click", function () {
                var dd = $.map($(".divDynamic"), function (el, i) {
                    return $(el).text();
                });
                $.ajax({
                    type: "POST",
                    url: "campaignCreate.aspx/saveData",
                    data: '{options:"' + dd + '",title:"' + $("#ContentPlaceHolder1_txtTitle").val() + '",description:"' + $("#ContentPlaceHolder1_txtDescription").val() + '",community:"' + $("#ContentPlaceHolder1_ddlCommunity").val() + '",constituency:"' + $("#ContentPlaceHolder1_ddlConstituency").val() + '",region:"' + $("#ContentPlaceHolder1_ddlRegion").val() + '",area:"' + $("#ContentPlaceHolder1_ddlArea").val() + '",boothNo:"' + $("#ContentPlaceHolder1_ddlBoothNo").val() + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        clearControls();
                        SavedSuccessfully('Record Saved Successfully');
                    },
                    error: function (data) {
                        SavedSuccessfully('Failed To Save');
                    }
                });
                return false;
            });
        });
    </script>
    <script type="text/javascript">
        $('#btn_Prev').click(function () {
            $('#div1').show();
            $('#div2').hide();

        });
        function clearControls() {
            $('ddlCampaignType').val('0');
            $('#ContentPlaceHolder1_txtTitle').val("");
            $('#ContentPlaceHolder1_txtDescription').val("");
            $("#ContentPlaceHolder1_lb_Options").empty();
        }

    </script>
    <script type="text/javascript">
        function SavedSuccessfully(status) {
            alertify.alert(status);
        }
    </script>
</asp:Content>
