<%@ Page Language="VB" %>
<%@ Import Namespace="System.Configuration"%>
<%@ Import Namespace="System.Data"%>

<script runat="server">
	Sub Page_Load(Src As Object, E As EventArgs)
		dim productsDataSet as DataSet
		dim filePath as String = Server.MapPath("Products.xml")
		productsDataSet = new DataSet()

		productsDataSet.ReadXml(filePath)
		gridProducts.DataSource = productsDataSet.Tables(0).DefaultView
		gridProducts.DataBind()
	End sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
	<head runat="server">
	<title>Reading XML into a DataSet object </title>
	</head>

	<body>
	<form id="form1" runat="server">
	<div>
	<asp:GridView id="gridProducts" runat="server"
	AutoGenerateColumns="False" CellPadding="4"
	HeaderStyle-BackColor="blue" HeaderStyle-ForeColor="White"
	HeaderStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="True">
		<Columns>
		<asp:BoundField HeaderText="The ID" DataField="ProductID" />
		<asp:BoundField HeaderText="Price"
		DataField="UnitPrice" ItemStyle-HorizontalAlign="Right" />
		<asp:BoundField HeaderText="Name" DataField="ProductName" />
		<asp:BoundField HeaderText="Description"
		DataField="QuantityPerUnit" />
		</Columns>
	</asp:GridView>
	</div>
	</form>
	</body>
</html>