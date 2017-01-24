<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Heroes.aspx.cs" Inherits="DotaData.Web.Index" %>
<%@ Register Src="~/UserControls/HeroManagement.ascx" TagPrefix="uc1" TagName="HeroManagement" %>
<%@ Register Src="~/UserControls/NavBar.ascx" TagPrefix="uc1" TagName="NavBar" %>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:NavBar runat="server" id="NavBar" />
    <uc1:HeroManagement runat="server" id="HeroManagement" />
</asp:Content>
