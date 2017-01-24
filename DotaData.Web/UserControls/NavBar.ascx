<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NavBar.ascx.cs" Inherits="DotaData.Web.UserControls.NavBar" %>
<div class="navbar navbar-inverse navbar-fixed-top" >
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" >Dota Inventory Builder</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="Heroes.aspx" >Heroes</a></li>
                <li><a href="Items.aspx" >Items</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right" >
                <li><a href="#">Register</a></li>
                <li><a href="#">Log In</a></li>
            </ul>
        </div>
    </div>
</div>