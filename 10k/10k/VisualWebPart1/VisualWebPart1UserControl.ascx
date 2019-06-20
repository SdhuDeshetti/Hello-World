<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VisualWebPart1UserControl.ascx.cs" Inherits="_10k.VisualWebPart1.VisualWebPart1UserControl" %>

<link href="../../../../_layouts/15/jquery-ui.css" rel="stylesheet" />
<link rel="stylesheet" href="../../../../_layouts/15/bootstrap.css" />
<script src="../../../../_layouts/15/jquery-1.11.3.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<style>
        .lblstyle {
        /*font-family: "Segoe UI","Segoe",Tahoma,Helvetica,Arial,sans-serif;*/
        font-family: Arial;
        font-size: 13px;
        font-weight: normal;
    }
    .contstyle {
        /*font-family: "Segoe UI","Segoe",Tahoma,Helvetica,Arial,sans-serif;*/
        font-family: Arial;
        font-size: 14px;
        font-weight: normal;
    }

    .hdstyle {
        /*font-family: "Segoe UI","Segoe",Tahoma,Helvetica,Arial,sans-serif;*/
        font-family: Arial;
        font-size: 13px;
        font-weight: bold;
    }

    input[type=checkbox], input[type=radio] {
        vertical-align: middle;
        position: relative;
        bottom: 1px;
        margin: 0px 5px 3px 6px;
    }

    .tabradio input[type=radio] {
        vertical-align: middle;
        position: relative;
        bottom: 1px;
        margin: 0px 60px 3px 6px;
    }

    .vmboxstyle {
        font-family: Arial;
        font-size: 12px !important;
        font-weight: normal !important;
        width: 150px;
        margin-left: 20px;
    }

    .btnstyle {
        /*font-family: "Segoe UI","Segoe",Tahoma,Helvetica,Arial,sans-serif;*/
        font-family: Arial;
        font-size: 12px;
        font-weight: normal;
    }

    label {
        font-weight: normal !important;
    }
    </style>
<script type="text/javascript">
    function ValidateErrorMsg() {
        var vamid = $('.txtVAMID').text();
        var size = $('.rbSize').find('input:checked').val();
        if ((vamid == "" || vamid == undefined) || (size == "" || size == undefined)) {
            $('.lblErrorMessage').text("Please enter * mandatory fields.");
            $('.lblErrorMessage').css('color', 'red');
            return false;
        }
    }
</script>

<table id="tbl10k" class="table table-bordered" style="width: 80%">
    <tr>
        <td style="text-align: center; background-color: #EFEFEF;" colspan="6">
            <div style="background: url(../Project%20Documents/Images/erp-header-bg.png); background-repeat: no-repeat; background-color: #507CD1">
                <div style="font-weight: bold; font-size: 15px; padding-left: 15px; padding-top: 5px; padding-bottom: 5px; background-color: #507CD1; color: white;">
                    Enrollment for 10K Run
                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td style="width: 15%;">
            <asp:Label ID="lblVAMID" Text="VAMID :" runat="server" Font-Bold="true" Style="border-color: white" CssClass="uslblstyle"></asp:Label>
            <span style="color: red">*</span>
        </td>
        <td style="width: 15%">
            <asp:Label ID="txtVAMID" runat="server" Style="border-color: white" CssClass="uslblstyle txtVAMID"></asp:Label>
        </td>
        <td style="width: 15%">
            <asp:Label ID="lblName" Text="Name :" runat="server" Font-Bold="true" Style="border-color: white" CssClass="uslblstyle"></asp:Label>
        </td>
        <td style="width: 20%" colspan="2">
            <asp:Label ID="txtName" runat="server" CssClass="uslblstyle "></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblDesignation" runat="server" CssClass="uslblstyle" Font-Bold="true" Text="Designation"></asp:Label>
        </td>
        <td>
            <asp:Label ID="txtdesignation" runat="server" Style="border-color: white" CssClass="uslblstyle "></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblDepartment" Text="Department :" runat="server" Font-Bold="true" Style="border-color: white" CssClass="uslblstyle"></asp:Label>
        </td>
        <td colspan="2">
            <asp:Label ID="txtDepartment" runat="server" CssClass="uslblstyle "></asp:Label>
        </td>
    </tr>

    <tr>
        <td>
            <asp:Label ID="lblAccount" runat="server" CssClass="uslblstyle" Font-Bold="true" Text="Account"></asp:Label>
        </td>
        <td>
            <asp:Label ID="txtAccount" runat="server" Style="border-color: white" CssClass="uslblstyle "></asp:Label>
        </td>
        <td>
            <asp:Label ID="lblSize" runat="server" CssClass="uslblstyle" Font-Bold="true" Text="Size"></asp:Label>
            <span style="color: red">*</span>
        </td>
        <td colspan="3">
            <asp:RadioButtonList ID="rbSize" EnableViewState="true" CssClass="rbSize" RepeatDirection="Horizontal" runat="server" Font-Bold="false">
                <asp:ListItem Text="Small" Value="Small"></asp:ListItem>
                <asp:ListItem Text="Medium" Value="Medium"></asp:ListItem>
                <asp:ListItem Text="Large" Value="Large"></asp:ListItem>
                <asp:ListItem Text="XL" Value="XL"></asp:ListItem>
                <asp:ListItem Text="XXL" Value="XXL"></asp:ListItem>
            </asp:RadioButtonList>
        </td>
        
    </tr>

    <tr style="border-color: black">
        <td colspan="5" style="text-align: center">
            <asp:Label ID="lblErrorMessage" Text="" runat="server" align="center" CssClass="lblErrorMessage" ForeColor="Red"></asp:Label>
        </td>
    </tr>

    <tr style="border-color: black">
        <td colspan="5" style="text-align: center">
            <asp:Button ID="btnsave" runat="server" Text="Save" Height="30px" Width="65px" OnClientClick="return ValidateErrorMsg();" OnClick="btnsave_Click" />&nbsp;&nbsp; 
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" Height="30px" Width="65px" OnClick="btnCancel_Click" />
        </td>
    </tr>
</table>
