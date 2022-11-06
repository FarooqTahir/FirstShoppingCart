<%@ Page Language="C#" Debug="true" %>
<%@ import Namespace="Westrans" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.OleDb" %>
<script runat="server">

    void Page_Load(Object sender, EventArgs e) {
        string strDb = Server.MapPath("\\westrans\\db\\example.mdb");
        string strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + strDb;
    
        Cart west = new Cart(strConn);
    
        dgCart.DataSource = west.GetCart(west.GetCartID());
        dgCart.DataBind();
    }
    
    void dgCart_ItemCommand(Object source, DataGridCommandEventArgs e) {
        if (((LinkButton)e.CommandSource).CommandName == "RemoveFromCart")
        {
    
        }
    }

</script>
<html>
<head>
    <title>Wes-T-Rans Parts and Service Department</title>
</head>
<body>
    <form runat="server">
        <table width="100%" border="0">
            <tbody>
                <tr>
                    <td colspan="3">
                        <p align="center">
                            <strong><font color="#0000c0" size="5">Wes-T-Rans Parts and Service Department</font></strong> 
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div align="left">
                            <asp:LinkButton id="lbtnCheckOut" runat="server">Checkout</asp:LinkButton>
                            &nbsp; 
                            <asp:HyperLink id="hlContinue" runat="server" NavigateUrl="default.aspx">Continue Shopping</asp:HyperLink>
                        </div>
                    </td>
                    <td>
                        <p align="right">
                            <asp:LinkButton id="btnLogin" runat="server">Login</asp:LinkButton>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <p>
                            <asp:DataGrid id="dgCart" runat="server" Width="100%" AllowPaging="True" AllowCustomPaging="True" OnItemCommand="dgCart_ItemCommand">
                                <HeaderStyle horizontalalign="Center" backcolor="Gray"></HeaderStyle>
                                <PagerStyle horizontalalign="Center" mode="NumericPages"></PagerStyle>
                                <AlternatingItemStyle backcolor="Silver"></AlternatingItemStyle>
                                <Columns>
                                    <asp:ButtonColumn Text="Remove" HeaderText="Remove From Cart" CommandName="RemoveFromCart">
                                        <ItemStyle horizontalalign="Center"></ItemStyle>
                                    </asp:ButtonColumn>
                                </Columns>
                            </asp:DataGrid>
                        </p>
                    </td>
                </tr>
            </tbody>
        </table>
        <asp:Label id="Message" runat="server"></asp:Label>
    </form>
</body>
</html>
