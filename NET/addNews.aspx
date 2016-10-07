<%@ Page Language="VB" masterpagefile="template.master" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.Oledb" %>
<script runat="server">

    Sub Page_Load(Src As Object, E As EventArgs)
        if page.isPostBack then
            Dim strTitle as String = txtTitle.text
            Dim strDescription as String = txtDescription.text
            Dim dbConn as OleDbConnection
            dbConn=New OleDbConnection(ConfigurationSettings.AppSettings("connectionstring"))
            dbConn.Open()

            Dim sql As String = "INSERT INTO News (newsTitle, newsDescription) Values ('" & strTitle & "', '" & strDescription & "')"
            Dim objCmd As New OleDbCommand(sql, dbConn)
            objCmd.ExecuteNonQuery()
            dbConn.Close()

            response.redirect("manageNews.aspx")

        end if
    End sub

</script>
<asp:Content id="homeContent" ContentPlaceHolderID="PageContent" runat="server">
    <h1>Add news item</h1>
    <table>
    <tr>
        <td><asp:Label runat="server" id="lblTitle" cssClass="emphasis">Title</asp:Label></td>
        <td><asp:TextBox runat="server" id="txtTitle" width="400px"></asp:TextBox><br/>
        <asp:RequiredFieldValidator runat="server"
            ControlToValidate="txtTitle"
            ErrorMessage="Enter a title"
            Display="Dynamic"/>
        </td>
    </tr>
    <tr>
        <td><asp:Label runat="server" id="lblDescription" cssClass="emphasis">Description</asp:Label></td>
        <td><asp:TextBox runat="server" id="txtDescription"
                TextMode="MultiLine"
                Columns="75"
                Rows="2"/>
        <asp:Button runat="server" Text="Save"></asp:Button><br/>
        <asp:RequiredFieldValidator runat="server"
            ControlToValidate="txtDescription"
            ErrorMessage="Enter a Description"
            Display="Dynamic"/>

        </td>
    </tr>
    </table>

</asp:Content>
