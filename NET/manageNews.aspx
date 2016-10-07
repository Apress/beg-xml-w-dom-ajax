<%@ Page Language="VB" masterpagefile="template.master" %>
<script runat="server">

    Sub GridViewUpdated(ByVal s As Object, ByVal e As GridViewUpdatedEventArgs)
        If Not e.Exception Is Nothing Then
            lblError.Text = "<br/>&nbsp;&nbsp;Error: Could not update row"
            e.ExceptionHandled = True
        End If
    End Sub
    
    Sub GridViewDeleted(ByVal s As Object, ByVal e As GridViewDeletedEventArgs)
        If Not e.Exception Is Nothing Then
            lblError.Text = "<br/>&nbsp;&nbsp;Error: Could not delete row"
            e.ExceptionHandled = True
        End If
    End Sub
    
    Sub addNews(sender As Object, e As System.EventArgs)
        response.redirect("addNews.aspx")
    end sub

</script>
<asp:Content id="homeContent" ContentPlaceHolderID="PageContent" runat="server">
    <asp:Button runat="server" Text="Add News" OnClick="addNews"/>
    <asp:Label runat="server" id="lblError" cssClass="error"/>

    <asp:AccessDataSource id="NewsDS" runat="server"
        DataSourceMode="DataSet"
        DataFile="App_Data/news.mdb"
        SelectCommand="SELECT * FROM news ORDER BY news.newsTitle"
        UpdateCommand="UPDATE news SET newsTitle=?,newsDescription=? WHERE newsID=@newsID"
        DeleteCommand="DELETE FROM news WHERE newsID=@newsID">
        <UpdateParameters>
            <asp:Parameter Type="String" Name="newsTitle"/>
            <asp:Parameter Type="String" Name="newsDescription"/>
        </UpdateParameters>
    </asp:accessdatasource>
    <asp:GridView ID="NewsGV" runat="server"
        AutoGenerateColumns="False"
        DataKeyNames="newsID"
        DataSourceID="NewsDS"
        AllowSorting="true"
        OnRowUpdated="GridViewUpdated"
        OnRowDeleted="GridViewDeleted">
        <Columns>
            <asp:BoundField HeaderText="ID" DataField="newsID" SortExpression="newsID" ReadOnly="True"/>
            <asp:TemplateField HeaderText="Title" SortExpression="newsTitle">
                <ItemTemplate><%#Eval("newsTitle")%></ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" id="txtTitle"
                        Text='<%#Bind("newsTitle")%>'
                        Width="175px"/><br/>
                    <asp:RequiredFieldValidator runat="server" id="TitleRequiredValidator"
                    ControlToValidate="txtTitle"
                    Display="Dynamic"
                    Text="Please enter a title" />
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField headertext="Description" SortExpression="newsDescription">
               <ItemTemplate><%#Eval("newsDescription")%></ItemTemplate>
               <EditItemTemplate>
                    <asp:TextBox runat="server" id="txtDescription"
                        Text='<%#Bind("newsDescription")%>'
                        TextMode="MultiLine"
                        Columns="100"
                        Rows="2"/><br/>
                    <asp:RequiredFieldValidator runat="server" id="DescriptionRequiredValidator"
                    ControlToValidate="txtDescription"
                    Display="Dynamic"
                    Text="Please enter a description" />
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:CommandField EditText="Edit" ShowEditButton="True"/>
            <asp:CommandField DeleteText="Delete" ShowDeleteButton="True"/>

        </Columns>
    </asp:GridView>
</asp:Content>