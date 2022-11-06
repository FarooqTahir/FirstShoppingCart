<%@ Page Language="C#" Debug="true" %>
<%@ import Namespace="Westrans" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.OleDb" %>
<script runat="server">

    string strConn;
    
    void Page_Load(Object sender, EventArgs e) {
        string strDb = Server.MapPath("\\westrans\\db\\example.mdb");
               strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="+strDb+";";
    
        OleDbConnection oleConn = new OleDbConnection(strConn);
        OleDbCommand oleComm = new OleDbCommand("qryGetProducts", oleConn);
    
        oleComm.CommandType = CommandType.StoredProcedure;
    
        oleConn.Open();
    
        OleDbDataReader dr = oleComm.ExecuteReader();
    
        dgProducts.DataSource = dr;
        dgProducts.VirtualItemCount = 10;
        dgProducts.DataBind();
    
        oleConn.Close();
    }
    
    void dgProducts_ItemCommand(Object source, DataGridCommandEventArgs e) {
        if (((LinkButton)e.CommandSource).CommandName == "AddToCart")
        {
            Cart west = new Cart(strConn);
            
            TableCell prodCell = e.Item.Cells[0];
            string strProd = prodCell.Text;
            string strCartID = west.GetCartID();
    
            west.AddItem(strCartID, Int32.Parse(strProd), 1);
        }
    }

</script>
<html>
<head>
    <title>Wes-T-rans Parts and Service Department</title>
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
                            <asp:HyperLink id="hlViewCart" runat="server" NavigateUrl="viewcart.aspx">View Cart</asp:HyperLink>
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
                            <asp:DataGrid id="dgProducts" runat="server" Width="100%" AllowPaging="True" AutoGenerateColumns="False" AllowCustomPaging="True" OnItemCommand="dgProducts_ItemCommand">
                                <HeaderStyle horizontalalign="Center" backcolor="Gray"></HeaderStyle>
                                <PagerStyle horizontalalign="Center" mode="NumericPages"></PagerStyle>
                                <AlternatingItemStyle backcolor="Silver"></AlternatingItemStyle>
                                <Columns>
                                    <asp:BoundColumn Visible="False" DataField="fldProdID" SortExpression="fldProdID" HeaderText="fldProdID"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="fldDescription" SortExpression="fldDescription" HeaderText="Description"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="fldPrice" SortExpression="fldPrice" HeaderText="Price" DataFormatString="{0:c}">
                                        <ItemStyle horizontalalign="Center"></ItemStyle>
                                    </asp:BoundColumn>
                                    <asp:ButtonColumn Text="Add" HeaderText="Add To Cart" CommandName="AddToCart">
                                        <ItemStyle horizontalalign="Center"></ItemStyle>
                                    </asp:ButtonColumn>
                                </Columns>
                            </asp:DataGrid>
                        </p>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
    <asp:Label id="Message" runat="server"></asp:Label>
</body>
</html>
