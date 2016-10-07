<%@ Page Language="VB" MasterPageFile="template.master" %>
<%@ import Namespace="System.Xml" %>
<script runat="server">

    Sub Page_Load(Src As Object, E As EventArgs)
        showRSS("http://localhost/XML/NET/rss.aspx")
    End sub

    Sub showRSS(RSSURL as String)
        Dim RSSDoc as XmlDocument = new XmlDocument()
        RSSDoc.PreserveWhitespace = false
        RSSDOC.load(RSSURL)
        displayRSS.Document = RSSDoc
        displayRSS.TransformSource = "rss.xsl"
    End Sub

    Sub chooseRSS(sender As Object, e As System.EventArgs)
        Dim RSSURL as String = RSSList.SelectedItem.Value
        showRSS(RSSURL)
    End sub

    Sub showRSS2Feed(sender As Object, e As ImageClickEventArgs)
       response.redirect ("rss.aspx")
    End Sub

</script>
<asp:Content id="homeContent" ContentPlaceHolderID="PageContent" runat="server">

    <h1>Welcome to XML and Web news. <asp:ImageButton runat="server" ImageUrl="images/rss2.gif" OnClick="showRSS2Feed"/></h1>
    <p>You can see our latest news below as well as links to other news feeds.</p>

    <p>
    <asp:DropDownList id="RSSList" runat="server">
        <asp:ListItem value="http://alistapart.com/rss.xml">A List Apart</asp:ListItem>
        <asp:ListItem value="http://z.about.com/6/g/webdesign/b/rss2.xml">About Web Design/HTML articles</asp:ListItem>
        <asp:ListItem value="http://feeds.computerworld.com/Computerworld/XML/News">ComputerWorld XML News</asp:ListItem>
        <asp:ListItem value="http://www-128.ibm.com/developerworks/views/xml/rss/libraryview.jsp">IBM developerWorks XML Feed</asp:ListItem>
        <asp:ListItem value="http://feeds.lockergnome.com/rss/web.xml">LockerGnome</asp:ListItem>
        <asp:ListItem value="http://p.moreover.com/page?o=rss002&c=XML%20and%20metadata%20news">Moreover XML and MetaData News</asp:ListItem>
        <asp:ListItem value="http://localhost/XML/NET/rss.aspx" selected="True">XML Browser News</asp:ListItem>
    </asp:DropDownList>
    <asp:Button Text="Show" OnClick="chooseRSS" Runat="Server"/>
    </p>

    <asp:AccessDataSource id="NewsDS" runat="server"
        DataSourceMode="DataReader"
        DataFile="App_Data/news.mdb"
        SelectCommand="SELECT news.newsTitle, news.newsDescription FROM news ORDER BY news.newsTitle"/>
    <asp:Xml id="displayRSS" runat="server"/>
</asp:Content>
