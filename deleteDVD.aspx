<%@ Page Language="VB" %>
<%@ import Namespace="System.Xml" %>
<script runat="server">

    Dim intDVDID as integer
    Dim myXmlDocument as XmlDocument = new XmlDocument()
    Dim rootNode as XMLElement
    Dim selectedDVD as XMLElement
    
    Sub Page_Load(Src As Object, E As EventArgs)
        intDVDID = request.querystring("id")
        myXmlDocument.Load (server.mappath("dvd.xml"))
        rootNode = myXmlDocument.DocumentElement
        selectedDVD = rootNode.childNodes(intDVDID-1)
        if Not Page.IsPostBack then
            rootNode.RemoveChild(selectedDVD)
            myXmlDocument.Save(Server.Mappath("dvd.xml"))
            lblMessage.text = "You have successfully deleted the DVD"
        end if
    end sub

</script>
<html>
<head>
    <link href="styles.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <h1>Delete DVD
    </h1>
    <form runat="server">
        <div id="divMessage"><asp:Label id="lblMessage" runat="server"></asp:Label></div>
    </form>
</body>
</html>