<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Items.aspx.cs" Inherits="DotaData.Web.Index" %>
<%@ Register Src="~/UserControls/ItemManagement.ascx" TagPrefix="uc1" TagName="ItemManagement" %>
<%@ Register Src="~/UserControls/NavBar.ascx" TagPrefix="uc1" TagName="NavBar" %>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:NavBar runat="server" id="NavBar" />
    <uc1:ItemManagement runat="server" id="ItemManagement" />
</asp:Content>
