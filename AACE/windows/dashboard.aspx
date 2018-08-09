<%@ Page Title="" Language="C#" MasterPageFile="~/windows/siteMaster.master" AutoEventWireup="true"
    CodeFile="dashboard.aspx.cs" Inherits="windows_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/votersDetialsBarGraph",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (sub) {
                    bargraph(sub);
                },
                failure: function (msg) {
                    alert(msg);
                }
            });
        })

        function bargraph(res) {
            
            var graphObj = "";
            if (res.d != null && res.d != "") {
                graphObj = jQuery.parseJSON(res.d);
            }

            var chart = new CanvasJS.Chart("chartContainer", {
                animationEnabled: true,
                theme: "light2",
                title: {
                    text: "All Campaign Results"
                },
                axisX: {
                    title: ""
                },
                axisY: {
                    prefix: "",
                    labelFormatter: addSymbols
                },
                toolTip: {
                    shared: true
                },
                legend: {
                    cursor: "pointer",
                    itemclick: toggleDataSeries
                },
                data: [
	{
	    type: "column",
	    name: "Total Voters",
	    showInLegend: true,
	    xValueFormatString: "Actual Voters, Attended ",
	    yValueFormatString: "#,##0",
	    dataPoints: graphObj.Table
	},
    {
        type: "area",
        name: "Responded",
        markerBorderColor: "white",
        markerBorderThickness: 2,
        showInLegend: true,
        yValueFormatString: "#,##0",
        dataPoints: graphObj.Table1
    }]
            });
            chart.render();

            function addSymbols(e) {
                
                var suffixes = ["", "K", "M", "B"];
                var order = Math.max(Math.floor(Math.log(e.value) / Math.log(1000)), 0);

                if (order > suffixes.length - 1)
                    order = suffixes.length - 1;

                var suffix = suffixes[order];
                return CanvasJS.formatNumber(e.value / Math.pow(1000, order)) + suffix;
            }

            function toggleDataSeries(e) {
                if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
                    e.dataSeries.visible = false;
                } else {
                    e.dataSeries.visible = true;
                }
                e.chart.render();
            }
        }
    </script>--%>
    <script src="../js/highcharts/series-label.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/votersDetialsBarGraph",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (sub) {
                    bargraph(sub);
                },
                failure: function (msg) {
                    alert(msg);
                }
            });
        })

        function bargraph(res) {

            var barGraph = [];
            var lineGraph = [];
            var campaignName = [];
            var graphObj = "";
            if (res.d != null && res.d != "") {
                graphObj = jQuery.parseJSON(res.d);
                for (var i = 0; i < graphObj.Table.length; i++) {
                    barGraph.push(graphObj.Table[i].y);
                    campaignName.push(graphObj.Table[i].label);
                }
                for (var i = 0; i < graphObj.Table1.length; i++) {
                    lineGraph.push(graphObj.Table1[i].y);
                }
            }

            Highcharts.chart('container', {
                title: {
                    text: 'All Campaign Results'
                },
                xAxis: {
                    categories: campaignName
                },
                labels: {
                    items: [{
                        html: '',
                        style: {
                            left: '50px',
                            top: '18px',
                            color: (Highcharts.theme && Highcharts.theme.textColor) || 'black'
                        }
                    }]
                },
                series: [{
                    type: 'column',
                    name: 'Total Voters',
                    color: '#336699',
                    data: barGraph
                }, {
                    type: 'area',
                    name: 'Responded',
                    color: '#9fdf9f',
                    data: lineGraph,
                    marker: {
                        lineWidth: 2,
                        lineColor: Highcharts.getOptions().colors[3],
                        fillColor: 'white'
                    }
                }]
            });


        }
    </script>
    <div class="app-content">
        <div class="app-title">
            <div>
                <h1>
                    <i class="fa fa-dashboard"></i>Dash Board</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="tile">
                    <div class="tile-body">
                        <div class="form-group row">
                            <%--<div id="chartContainer" style="height: 370px; width: 100%;">
                                <script src="js/canvasCharts.js" type="text/javascript"></script>
                            </div>--%>
                            <div id="container" style="width: 100%; height: 400px; margin: 0 auto">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
