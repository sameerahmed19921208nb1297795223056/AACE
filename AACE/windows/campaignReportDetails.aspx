<%@ Page Title="" Language="C#" MasterPageFile="~/windows/siteMaster.master" AutoEventWireup="true"
    CodeFile="campaignReportDetails.aspx.cs" Inherits="windows_campaignReportDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<script>
        window.onload = function () {
            
            var url = window.location.href;
            var requestedData = url.split('?')[1];
            var campaignId = requestedData.split('&')[0];
            campaignId = campaignId.split('=')[1];
            var campaignTitle = requestedData.split('&')[1];
            campaignTitle = campaignTitle.split('=')[1];           
            campaignTitle = campaignTitle.replace(/%20/gi, ' ');
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/getDataForPaiChart",
                data: "{'cmpnId':" + campaignId + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    generateGraph(response, campaignTitle);
                },
                failure: function (msg) {
                    alert(msg);
                }
            });


        }

        function generateGraph(response, campaignTitle) {
            var issues = [];
            issues = jQuery.parseJSON(response.d);
            var options = {
                title: {
                    text: campaignTitle
                },
                subtitles: [{
                    text: "Statistics on Issuees"
                }],
                animationEnabled: true,
                data: [{
                    type: "pie",
                    startAngle: 40,
                    toolTipContent: "<b>{label}</b>: {y}%",
                    showInLegend: "true",
                    legendText: "{label}",
                    indexLabelFontSize: 16,
                    indexLabel: "{label} - {y}%",
                    dataPoints: issues
                }]
            };
            $("#chartContainer").CanvasJSChart(options);
        }

        function goBack() {
            window.history.back()
        }
    </script>--%>
    <script type="text/javascript">
        window.onload = function () {

            var url = window.location.href;
            var requestedData = url.split('?')[1];
            var campaignId = requestedData.split('&')[0];
            campaignId = campaignId.split('=')[1];
            var campaignTitle = requestedData.split('&')[1];
            campaignTitle = campaignTitle.split('=')[1];
            campaignTitle = campaignTitle.replace(/%20/gi, ' ');
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/getDataForPaiChart",
                data: "{'cmpnId':" + campaignId + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    generateGraph(response, campaignTitle);
                },
                failure: function (msg) {
                    alert(msg);
                }
            });

            function generateGraph(response, campaignTitle) {
                var issues = [];
                var dat = [];
                issues = jQuery.parseJSON(response.d);
                for (var i = 0; i < issues.length; i++) {
                    dat.push([issues[i].label, issues[i].y]);
                }

                Highcharts.chart('container', {
                    chart: {
                        type: 'pie',
                        options3d: {
                            enabled: true,
                            alpha: 45,
                            beta: 0
                        }
                    },
                    title: {
                        text: campaignTitle
                    },
                    tooltip: {
                        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                    },
                    plotOptions: {
                        pie: {
                            allowPointSelect: true,
                            cursor: 'pointer',
                            depth: 35,
                            dataLabels: {
                                enabled: true,
                                format: '{point.name}'
                            }
                        }
                    },
                    series: [{
                        type: 'pie',
                        name: 'Percentage',
                        data: dat
                    }]
                });
            }
        }
        function goBack() {
            window.history.back()
        }
    </script>
    <div class="app-content">
        <div class="app-title">
            <div>
                <h1>
                    <i class="fa fa-edit"></i>Campaign Reports</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <%--<div id="chartContainer" style="height: 500px; width: 100%;">--%>
                        <div id="container" style="height: 400px">
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-md-12">
                            <input type="button" id="btnClose" class="btn btn-primary pull-right" value="Close"
                                onclick="goBack()" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="js/highcharts-3d.js" type="text/javascript"></script>
</asp:Content>
