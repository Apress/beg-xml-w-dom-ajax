<%@ Page Language="VB" %>
<%@ import Namespace="System.IO" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Xml" %>
<script runat="server">

    Sub Page_Load(Src As Object, E As EventArgs)
        Response.ContentType = "text/xml"

        Dim dv As DataView = CType(NewsDS.Select(DataSourceSelectArguments.Empty), DataView)

        Dim XMLFeed as XmlTextWriter = new XmlTextWriter(Response.OutputStream, Encoding.UTF8)
        XMLFeed.WriteStartDocument()
        XMLFeed.WriteStartElement("rss")
        XMLFeed.WriteAttributeString("version", "2.0")
        XMLFeed.WriteStartElement("channel")
        XMLFeed.WriteElementString("title", "XML Browser News")
        XMLFeed.WriteElementString("link", "http://www.apress.com")
        XMLFeed.WriteElementString("description", "The latest XML browser news.")


        For Each dr As DataRow In dv.Table.Rows
            XMLFeed.WriteStartElement("item")
            XMLFeed.WriteElementString("title", dr("newsTitle").ToString())
            XMLFeed.WriteElementString("description", dr("newsDescription").ToString())
            XMLFeed.WriteEndElement()
        Next

        XMLFeed.WriteEndElement()
        XMLFeed.WriteEndElement()
        XMLFeed.WriteEndDocument()
        XMLFeed.Flush()
        XMLFeed.Close()
        Response.End()
    End sub

</script>
<asp:AccessDataSource id="NewsDS" runat="server"
  DataSourceMode="DataSet"
  DataFile="App_Data/news.mdb"
  SelectCommand="SELECT news.newsTitle, news.newsDescription FROM news ORDER BY news.newsTitle"/>
