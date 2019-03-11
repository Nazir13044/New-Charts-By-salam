<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DailySalesInvoiceNewMajorMinorIssues.aspx.cs" Inherits="Dealer_DailySalesInvoiceNewMajorMinorIssues" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ccl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="../Scripts/jquery-2.1.4.min.js" type="text/javascript"></script>
    <script src="../Scripts/moment.min.js" type="text/javascript"></script>
    <script src="../Scripts/bootstrap.min.js" type="text/javascript"></script>
    <script src="../Scripts/bootstrap-datepicker.min.js" type="text/javascript"></script>
    <link href="../Styles/custom.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="../Scripts/dataTables.bootstrap.js" type="text/javascript"></script>

    <script src="../Scripts/highcharts.js" type="text/javascript"></script>
    <script src="../Scripts/exporting.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">

    <div class="row">
        <div class="col-lg-1">
        </div>
        <div class="col-lg-10">
            <fieldset class="scheduler-border">
                <legend class="scheduler-border">Search</legend>

                <div class="row">
                    <div class="col-lg-2">
                    </div>
                    <div class="col-lg-2">
                        Model:
                    </div>
                    <div class="col-lg-2">
                        <asp:DropDownList ID="ddlModel" runat="server" AutoPostBack="true" CssClass="form-control"
                            AppendDataBoundItems="True" DataSourceID="SqlDataSource1"
                            DataTextField="Model" DataValueField="Model" ClientIDMode="Static"
                            OnSelectedIndexChanged="ddlModel_SelectedIndexChanged">
                            <asp:ListItem Value="0">Select Model</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-lg-2">
                    </div>
                    <div class="col-lg-2">
                        Order:
                    </div>
                    <div class="col-lg-2">

                        <asp:DropDownList ID="DropDownOrderList" runat="server" CssClass="form-control" AppendDataBoundItems="True">
                        </asp:DropDownList>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-lg-2">
                    </div>
                    <div class="col-lg-2">
                    </div>
                    <div class="col-lg-2">
                        <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn btn-info" OnClick="Button1_Click" />
                    </div>
                </div>



                <br />
                <%--  <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WSMSConnectionString %>"
            SelectCommand="Select distinct LTRIM(RTRIM(Model)) as Model from  RBSYNERGY.dbo.tblBarCodeInv  
            where Model in (select distinct Model from RBSYNERGY.dbo.tblCellPhoneDepriciationPrice  where ReleaseDate between '2016-01-01' and GETDATE()) and 
            DateAdded between '2016-01-01 00:00:00.000' and GETDATE() group by Model order by Model"></asp:SqlDataSource>--%>
                <%--     <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WSMSConnectionString %>"
            SelectCommand="Select distinct LTRIM(RTRIM(tb.Model)) as Model from  RBSYNERGY.dbo.tblBarCodeInv tb
left join RBSYNERGY.dbo.tblCellPhoneDepriciationPrice tc on tb.Model=tc.Model
where tb.Model =tc.Model and
DateAdded between '2016-01-01 00:00:00.000' and GETDATE() group by tb.Model
having min(tc.ReleaseDate)>='2016-01-01 00:00:00.000' "></asp:SqlDataSource>--%>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WSMSConnectionString %>"
                    SelectCommand="Select distinct  LTRIM(RTRIM(tb.Model)) as Model from  RBSYNERGY.dbo.tblBarCodeInv tb group by tb.Model  "></asp:SqlDataSource>

                <br />
            </fieldset>
        </div>
    </div>
    <br />

    <div class="row">

        <div class="col-lg-12">
            <fieldset class="scheduler-border">
                <legend class="scheduler-border">All Searching Query</legend>
                <asp:GridView ID="GridView1" CssClass="col-lg-12" runat="server" EmptyDataText="No data found" AllowSorting="True"
                    AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None"
                    BorderWidth="1px" CellPadding="3" DataKeyNames="ModelName" ShowFooter="True"
                    ClientIDMode="Static" GridLines="Horizontal">
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                    <Columns>
                        <asp:TemplateField HeaderText="ModelName">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#"~/Dealer/DailySalesInvoice_ModelWiseIssueNew.aspx?Model="+Eval("ModelName")+"&Orders="+Eval("orders")+"&Flag=0" %>'
                                    Text='<%# Eval("ModelName") %>'></asp:HyperLink>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="Label1" runat="server" Text='Grand Total'></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="TotalReceive">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#"~/Dealer/DailySalesInvoice_ModelWiseIssueNew.aspx?Model="+Eval("ModelName")+"&Orders="+Eval("orders")+"&Flag=1" %>'
                                    Text='<%# Eval("TotalReceive") %>'></asp:HyperLink>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%#TotalReceiveCount%>'></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="NonWarranty">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#"~/Dealer/DailySalesInvoice_ModelWiseIssueNew.aspx?Model="+Eval("ModelName")+"&Orders="+Eval("orders")+"&Flag=2" %>'
                                    Text='<%# Eval("NonWarranty") %>'></asp:HyperLink>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%#NonWarrantyCount%>'></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Warranty">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#"~/Dealer/DailySalesInvoice_ModelWiseIssueNew.aspx?Model="+Eval("ModelName")+"&Orders="+Eval("orders")+"&Flag=3" %>'
                                    Text='<%# Eval("Warrenty") %>'></asp:HyperLink>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%#WarrentyCount%>'></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="SparePartsPending">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#"~/Dealer/DailySalesInvoice_ModelWiseIssueNew.aspx?Model="+Eval("ModelName")+"&Orders="+Eval("orders")+"&Flag=4" %>'
                                    Text='<%# Eval("SparePartsPending") %>'></asp:HyperLink>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%#SparePartsPendingCount%>'></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="WorkPending">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#"~/Dealer/DailySalesInvoice_ModelWiseIssueNew.aspx?Model="+Eval("ModelName")+"&Orders="+Eval("orders")+"&Flag=5" %>'
                                    Text='<%# Eval("WorkPending") %>'></asp:HyperLink>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%#WorkPendingCount%>'></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="TotalPending">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#"~/Dealer/DailySalesInvoice_ModelWiseIssueNew.aspx?Model="+Eval("ModelName")+"&Orders="+Eval("orders")+"&Flag=6" %>'
                                    Text='<%# Eval("TotalPending") %>'></asp:HyperLink>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%#TotalPendingCount%>'></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="TotalWorkDone">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#"~/Dealer/DailySalesInvoice_ModelWiseIssueNew.aspx?Model="+Eval("ModelName")+"&Orders="+Eval("orders")+"&Flag=7" %>'
                                    Text='<%# Eval("TotalWorkDone") %>'></asp:HyperLink>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%#TotalWorkDoneCount%>'></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <%--   <asp:BoundField DataField="AverageReturnTime" HeaderText="Average Return Time" 
                                            ItemStyle-Width="200px">
                                            <ItemStyle Width="200px"></ItemStyle>
                                             <FooterTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%#TotalAverageReturnTimeCount%>'></asp:Label>
                            </FooterTemplate>
                                        </asp:BoundField>--%>

                        <asp:TemplateField HeaderText="Average Return Time">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server"
                                    Text='<%# Eval("AverageReturnTime") %>'></asp:HyperLink>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%#TotalAverageReturnTimeCount%>'></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <SortedAscendingCellStyle BackColor="#F4F4FD" />
                    <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                    <SortedDescendingCellStyle BackColor="#D8D8F0" />
                    <SortedDescendingHeaderStyle BackColor="#3E3277" />
                </asp:GridView>
            </fieldset>
        </div>

    </div>

    <script type="text/javascript">

        $(document).ready(function () {

            var url = 'DailySalesInvoiceNewMajorMinorIssues.aspx/GetHighStockChartsByMonthWiseServiceQuantity';
            var urls = location.search.split('model=')[1];

            var model1 = urls.split('&')[0];
            console.log("model1 :" + model1);
            var model = model1.replace(/%20/g, " ");

            var orders1 = urls.split('=')[1];
            console.log("orders1 :" + orders1);
            var orders = orders1.replace(/%20/g, " ");

            $.ajax({
                type: "POST",
                url: url,
                data: JSON.stringify({ 'model': model, 'orders': orders }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    console.log(data.d);


                    //                    var majorProblemQTYArr = new Array();
                    //                    var issueTypeArr = new Array();
                    //                    // var qtyArr = new Array();     
                    //                    var j = 0;
                    //                    for ( j = 0; j < data.d.length; j++) {
                    //                        majorProblemQTYArr.push(([parseFloat(data.d[j].MajorProblemQTY)]));
                    //                        issueTypeArr.push(data.d[j].IssueType);
                    //                    }

                    //                    console.log("majorProblemQTYArr :" + majorProblemQTYArr);
                    //                    console.log("issueTypeArr :" + issueTypeArr);


                    //                    

                    //                    var browserData1 = [];

                    //                    for (j = 0; j < data.d.length; j++) {

                    //                        var minir = data.d[j].MinorProblemQTY;

                    //                        var result = minir.split(',');


                    //                        for (var i in result) {
                    //                            result[i] = parseInt(result[i], 10);

                    //                            result[i] = result[i] * 100 / (data.d[i].TotalProblem);

                    //                            console.log("kk  :" + result[i]);
                    //                            var n = result[i].toFixed(3);

                    //                            result[i] = parseFloat(n) +'%';

                    //                            console.log("result[i]  :" + result[i]);
                    //                        }


                    //                        browserData1.push({
                    //                            name: issueTypeArr[j],
                    //                            y: data.d[j].MajorProblemQTY,
                    //                            //drilldown:'Microft',
                    //                            y1: data.d[j].IssueName,
                    //                            y2: result,
                    //                            y3: data.d[j].TotalProblem
                    //                        });

                    //                        browserData1.push({
                    //                            name: issueTypeArr[j],
                    //                            y: data.d[j].MajorProblemQTY,
                    //                            y1: data.d[j].IssueName,
                    //                            y2: data.d[j].MinorProblemQTY,
                    //                            y3: data.d[j].TotalProblem
                    //                        });

                    var totalMajorProblemQtyArr = new Array();
                    var issueTypeArr = new Array();

                    var j = 0;
                    for (j = 0; j < data.d.length; j++) {
                        totalMajorProblemQtyArr.push(([parseFloat(data.d[j].TotalMajorProblemQTY)]));
                        issueTypeArr.push(data.d[j].IssueType);
                        //                         totalMajorProblemQtyArr.sort(function(a, b){
                        //                            return a.data < b.data ? 1 : -1;
                        //                               });
                        //    
                        //                        console.log("Sort totalMajorProblemQtyArr :"+totalMajorProblemQtyArr);
                    }


                    console.log("majorProblemQTYArr :" + totalMajorProblemQtyArr);
                    console.log("issueTypeArr :" + issueTypeArr);




                    var browserData1 = [];

                    for (j = 0; j < data.d.length; j++) {

                        var minir = data.d[j].TotalMinorProblemQTY;

                        var result = minir.split(',');
                        var TotalProblem = data.d[j].TotalProblem;

                        console.log("TotalProblem :" + TotalProblem);

                        for (var i in result) {

                            result[i] = parseInt(result[i], 10);

                            result[i] = result[i] * 100 / TotalProblem;

                            console.log("kk  :" + result[i]);
                            var n = result[i].toFixed(3);

                            result[i] = parseFloat(n) + '%';

                            console.log("result[i]  :" + result[i]);

                        }


                        browserData1.push({
                            name: issueTypeArr[j],
                            y: data.d[j].TotalMajorProblemQTY,
                            //drilldown:'Microft',
                            y1: data.d[j].IssueName,
                            y2: result,
                            y3: TotalProblem
                        });



                    }



                    var option = Highcharts.chart('container2', {
                        chart: {
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            plotShadow: false,
                            type: 'pie'
                        },
                        title: {
                            text: 'Total Major Problem'
                        },
                        tooltip: {
                            // pointFormat: '{series.name}: <b>{point.percentage:.3f}%</b>'
                            // pointFormat: '<b>Percentage :{ } </b> <b>{point.percentage:.3f}%</b>'
                            pointFormat: '<b>Total Major Quantity :{ } </b> <b>{point.percentage:.3f}%</b><br/><br/><b style="color:blue">Minor Problem :{ } </b> <b style="color:green">{point.y1}</b><br/><b style="color:blue">Minor Problem QTY :{ } </b> <b style="color:green">{point.y2}</b><br/><br/><b style="color:red">******Grand Total : {point.y3}</b>'

                            //pointFormat:browserData2
                            //pointFormat: ' <b>{point.percentage:.3f}%</b>'
                        },

                        legend: {
                            enabled: false
                        },


                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                                dataLabels: {
                                    enabled: true,
                                    //format: '<b>{point.name}</b>: {point.percentage:.3f} %',
                                    format: '<b style="color:red">{point.name}</b>: {point.percentage:.3f}%',
                                    style: {
                                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                                    }
                                }
                            }
                        },
                        series: [{
                            data: browserData1,

                        }]

                    });

                    ////end off option//
                }
            });
        });

        $(document).ready(function () {

            var url = 'DailySalesInvoiceNewMajorMinorIssues.aspx/GetHighStockChartsByMonthWiseSpareQuantity';
            var urls = location.search.split('model=')[1];

            var model1 = urls.split('&')[0];
            console.log("model1 :" + model1);
            var model = model1.replace(/%20/g, " ");

            var orders1 = urls.split('=')[1];
            console.log("orders1 :" + orders1);
            var orders = orders1.replace(/%20/g, " ");

            $.ajax({
                type: "POST",
                url: url,
                data: JSON.stringify({ 'model': model, 'orders': orders }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    console.log(data.d);


                    var totalSpareUsedMajorArr = new Array();
                    var itemDescArr = new Array();

                    var j = 0;
                    for (j = 0; j < data.d.length; j++) {
                        totalSpareUsedMajorArr.push(([parseFloat(data.d[j].TotalSpareUsedMajor)]));
                        itemDescArr.push(data.d[j].ItemDesc);
                    }

                    console.log("majorProblemQTYArr :" + totalSpareUsedMajorArr);
                    console.log("issueTypeArr :" + itemDescArr);




                    var browserData1 = [];

                    for (j = 0; j < data.d.length; j++) {

                        var minir = data.d[j].TotalSpareUsedMinor;

                        var result = minir.split(',');
                        var TotalProblem = data.d[j].TotalProblem;

                        console.log("TotalProblem :" + TotalProblem);

                        for (var i in result) {

                            result[i] = parseInt(result[i], 10);

                            result[i] = result[i] * 100 / TotalProblem;

                            console.log("kk  :" + result[i]);
                            var n = result[i].toFixed(3);

                            result[i] = parseFloat(n) + '%';

                            console.log("result[i]  :" + result[i]);
                        }


                        browserData1.push({
                            name: itemDescArr[j],
                            y: data.d[j].TotalSpareUsedMajor,
                            //drilldown:'Microft',
                            y1: data.d[j].ItemName,
                            y2: result,
                            y3: TotalProblem
                        });

                    }



                    var option = Highcharts.chart('container3', {
                        chart: {
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            plotShadow: false,
                            type: 'pie'
                        },
                        title: {
                            text: 'Total Spare Used'
                        },
                        tooltip: {
                            pointFormat: '<b>Total Major Quantity :{ } </b> <b>{point.percentage:.3f}%</b><br/><br/><b style="color:blue">Minor Problem :{ } </b> <b style="color:green">{point.y1}</b><br/><b style="color:blue">Minor Problem QTY :{ } </b> <b style="color:green">{point.y2}</b><br/><br/><b style="color:red">******Grand Total : {point.y3}</b>'

                        },

                        legend: {
                            enabled: false
                        },


                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                                dataLabels: {
                                    enabled: true,
                                    format: '<b style="color:red">{point.name}</b>: {point.percentage:.3f}%',
                                    style: {
                                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                                    }
                                }
                            }
                        },
                        series: [{
                            data: browserData1,

                        }]

                    });

                    ////end off option//
                }
            });
        });
        ////////////////////Total receive//////////////////////

        $(document).ready(function () {


            var url = 'DailySalesInvoiceNewMajorMinorIssues.aspx/GetHighChartDataListForTotalReceive';

            var urls = location.search.split('model=')[1];

            var model1 = urls.split('&')[0];
            console.log("model1 :" + model1);
            var model = model1.replace(/%20/g, " ");

            var orders1 = urls.split('=')[1];
            console.log("orders1 :" + orders1);
            var orders = orders1.replace(/%20/g, " ");

            $.ajax({
                type: "POST",
                url: url,
                data: JSON.stringify({ 'model': model, 'orders': orders }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    console.log(data.d);
                    var array2017 = new Array();

                    var categories = [];

                    for (var j = 0; j < data.d.length; j++) {
                        if (data.d[j].Month == "Jan" && data.d[j].MonthNum == "1") {
                            categories[j] = "Jan" + " (" + data.d[j].Year + ")";
                        }
                        if (data.d[j].Month == "Feb" && data.d[j].MonthNum == "2") {
                            categories[j] = "Feb" + " (" + data.d[j].Year + ")";
                        }
                        if (data.d[j].Month == "Mar" && data.d[j].MonthNum == "3") {
                            categories[j] = "Mar" + " (" + data.d[j].Year + ")";
                        }
                        if (data.d[j].Month == "Apr" && data.d[j].MonthNum == "4") {
                            categories[j] = "Apr" + " (" + data.d[j].Year + ")";
                        }
                        if (data.d[j].Month == "May" && data.d[j].MonthNum == "5") {
                            categories[j] = "May" + " (" + data.d[j].Year + ")";
                        }
                        if (data.d[j].Month == "Jun" && data.d[j].MonthNum == "6") {
                            categories[j] = "Jun" + " (" + data.d[j].Year + ")";
                        }
                        if (data.d[j].Month == "Jul" && data.d[j].MonthNum == "7") {
                            categories[j] = "Jul" + " (" + data.d[j].Year + ")";
                        }
                        if (data.d[j].Month == "Aug" && data.d[j].MonthNum == "8") {
                            categories[j] = "Aug" + " (" + data.d[j].Year + ")";
                        }
                        if (data.d[j].Month == "Sep" && data.d[j].MonthNum == "9") {
                            categories[j] = "Sep" + " (" + data.d[j].Year + ")";
                        }
                        if (data.d[j].Month == "Oct" && data.d[j].MonthNum == "10") {
                            categories[j] = "Oct" + " (" + data.d[j].Year + ")";
                        }
                        if (data.d[j].Month == "Nov" && data.d[j].MonthNum == "11") {
                            categories[j] = "Nov" + " (" + data.d[j].Year + ")";
                        }
                        if (data.d[j].Month == "Dec" && data.d[j].MonthNum == "12") {
                            categories[j] = "Dec" + " (" + data.d[j].Year + ")";

                        }

                        array2017.push([parseInt(data.d[j].ServiceQuantity)]);

                    }

                    console.log("array2017 :" + array2017);
                    console.log("categories :" + categories);

                    Highcharts.chart('container4', {
                        chart: {
                            type: 'line'
                        },
                        title: {
                            text: 'Monthly Service Quantity'
                        },

                        xAxis: {

                            categories: categories,
                            labels: {
                                formatter: function () {

                                    if (('Jan (2019)' === this.value) || ('Feb (2019)' === this.value) || ('Mar (2019)' === this.value) || ('Apr (2019)' === this.value) || ('May (2019)' === this.value) || ('Jun (2019)' === this.value)
                                        || ('Jul (2019)' === this.value) || ('Aug (2019)' === this.value) || ('Sep (2019)' === this.value) || ('Oct (2019)' === this.value) || ('Nov (2019)' === this.value) || ('Dec (2019)' === this.value)) {
                                        return '<span style="fill: orange;">' + this.value + '</span>';
                                    }

                                    if (('Jan (2018)' === this.value) || ('Feb (2018)' === this.value) || ('Mar (2018)' === this.value) || ('Apr (2018)' === this.value) || ('May (2018)' === this.value) || ('Jun (2018)' === this.value)
                                        || ('Jul (2018)' === this.value) || ('Aug (2018)' === this.value) || ('Sep (2018)' === this.value) || ('Oct (2018)' === this.value) || ('Nov (2018)' === this.value) || ('Dec (2018)' === this.value)) {
                                        return '<span style="fill: violet;">' + this.value + '</span>';
                                    }
                                    if (('Jan (2017)' === this.value) || ('Feb (2017)' === this.value) || ('Mar (2017)' === this.value) || ('Apr (2017)' === this.value) || ('May (2017)' === this.value) || ('Jun (2017)' === this.value)
                                        || ('Jul (2017)' === this.value) || ('Aug (2017)' === this.value) || ('Sep (2017)' === this.value) || ('Oct (2017)' === this.value) || ('Nov (2017)' === this.value) || ('Dec (2017)' === this.value)) {
                                        return '<span style="fill: red;">' + this.value + '</span>';
                                    }
                                    if (('Jan (2016)' === this.value) || ('Feb (2016)' === this.value) || ('Mar (2016)' === this.value) || ('Apr (2016)' === this.value) || ('May (2016)' === this.value) || ('Jun (2016)' === this.value)
                                        || ('Jul (2016)' === this.value) || ('Aug (2016)' === this.value) || ('Sep (2016)' === this.value) || ('Oct (2016)' === this.value) || ('Nov (2016)' === this.value) || ('Dec (2016)' === this.value)) {
                                        return '<span style="fill: green;">' + this.value + '</span>';
                                    }
                                    if (('Jan (2015)' === this.value) || ('Feb (2015)' === this.value) || ('Mar (2015)' === this.value) || ('Apr (2015)' === this.value) || ('May (2015)' === this.value) || ('Jun (2015)' === this.value)
                                        || ('Jul (2015)' === this.value) || ('Aug (2015)' === this.value) || ('Sep (2015)' === this.value) || ('Oct (2015)' === this.value) || ('Nov (2015)' === this.value) || ('Dec (2015)' === this.value)) {
                                        return '<span style="fill: Indigo;">' + this.value + '</span>';
                                    }
                                    if (('Jan (2014)' === this.value) || ('Feb (2014)' === this.value) || ('Mar (2014)' === this.value) || ('Apr (2014)' === this.value) || ('May (2014)' === this.value) || ('Jun (2014)' === this.value)
                                        || ('Jul (2014)' === this.value) || ('Aug (2014)' === this.value) || ('Sep (2014)' === this.value) || ('Oct (2014)' === this.value) || ('Nov (2014)' === this.value) || ('Dec (2014)' === this.value)) {
                                        return '<span style="fill: blue;">' + this.value + '</span>';
                                    }


                                }
                            }
                        },
                        yAxis: {
                            title: {
                                text: 'Service Qunatity'
                            }
                        },

                        plotOptions: {
                            line: {
                                dataLabels: {
                                    enabled: true
                                },
                                enableMouseTracking: false
                            }

                        },
                        series: [{

                            name: 'YEAR RANGE',
                            data: array2017

                        }]
                    });
                }

            });



            if (model != "0") {

                var secondUrl = 'DailySalesInvoiceNewMajorMinorIssues.aspx/GetHighStockChartsByDayWiseServiceQuantityFromLaunch';
                $.ajax({
                    type: "POST",
                    url: secondUrl,
                    data: JSON.stringify({ 'model': model, 'orders': orders }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {

                        console.log(data.d);


                        var processedJson2 = [];
                        processedJson2.push(parseInt(data.d[0].tendays));
                        processedJson2.push(parseInt(data.d[0].twentydays));
                        processedJson2.push(parseInt(data.d[0].fortydays));
                        processedJson2.push(parseInt(data.d[0].sixtydays));
                        processedJson2.push(parseInt(data.d[0].nintydays));
                        processedJson2.push(parseInt(data.d[0].oneEightydays));
                        processedJson2.push(parseInt(data.d[0].twoseventy));
                        processedJson2.push(parseInt(data.d[0].threeSixty));
                        processedJson2.push(parseInt(data.d[0].restoftheDays));


                        console.log('processedJson2:' + processedJson2);

                        var options = Highcharts.chart('container5', {
                            chart: {
                                type: 'column'
                            },
                            title: {
                                text: 'Service Quantity'
                            },

                            xAxis: {

                                categories: [
                                    '10 days',
                                    '20 days',
                                    '40 days',
                                    '60 days',
                                    '90 days',
                                    '180 days',
                                    '270 days',
                                    '365 days',
                                    'Rest of the days'
                                ],
                                crosshair: true
                            },
                            yAxis: {
                                min: 0,
                                max: 2000,
                                tickInterval: 100,
                                title: {
                                    text: 'Service Quantity'
                                }
                            },
                            tooltip: {
                                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                    '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
                                footerFormat: '</table>',
                                shared: true,
                                useHTML: true
                            },
                            plotOptions: {
                                column: {
                                    pointPadding: 0.4,
                                    borderWidth: 0
                                }
                            },
                            series: [{ data: processedJson2 }]
                        });


                    }
                });

            }



        });


    </script>

    <br />
    <div id="container1" style="height: 100%">
    </div>

    <fieldset class="scheduler-border">
        <legend class="scheduler-border">Major, Minor Problem and Spare chart</legend>
        <div id="container2" class="col-lg-6" style="border-color: blue;"></div>
        <div id="container3" class="col-lg-6" style="border-color: green; float: left;"></div>

    </fieldset>
    <fieldset class="scheduler-border">
        <legend class="scheduler-border">Total Receive chart</legend>
        <div id="container4" class="col-lg-12" style="border-color: green; float: left;"></div>
    </fieldset>
    <fieldset class="scheduler-border">
        <legend class="scheduler-border">Days Wise Receive chart</legend>
        <br />
        <asp:Button ID="exportToExcel" runat="server" Text="Export To Excel" OnClick="exportToExcel_Click" BackColor="#000099" Font-Bold="True" ForeColor="White" />
        <br /><br/>
        <asp:Button ID="exportIMEI" runat="server" Text="Export IMEI" OnClick="exportIMEI_Click" BackColor="#660066" Font-Bold="True" ForeColor="White" />
        <br />
        <div id="container5" class="col-lg-12" style="border-color: green; float: left;">
        </div>
    </fieldset>
    <asp:HiddenField ID="HiddenField1" runat="server" />
</asp:Content>
