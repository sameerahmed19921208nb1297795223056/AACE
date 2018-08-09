<%@ Page Language="C#" AutoEventWireup="true" CodeFile="logInPage.aspx.cs" Inherits="windows_logInPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>AACE</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
    <!-- The javascript plugin to display page loading on top-->
    <%--<script src="js/plugins/pace.min.js"></script>--%>
</head>
<body>
    <form runat="server">
    <section class="material-half-bg">
      <div class="cover"></div>
    </section>
    <section class="login-content">
      <div class="logo">
        <h1>AACE</h1>
      </div>
      <div class="login-box">
        <div class="login-form">
          <h3 class="login-head"><i class="fa fa-lg fa-fw fa-user"></i>SIGN IN</h3>
          <div class="form-group">
            <label class="control-label">USERNAME</label>
            <asp:TextBox ID="txtUserName" class="form-control" runat="server" placeholder="UserName" required></asp:TextBox>
          </div>
          <div class="form-group">
            <label class="control-label">PASSWORD</label>
            <asp:TextBox ID="txtPassword" class="form-control" runat="server" TextMode="Password" placeholder="Password" required="true"></asp:TextBox>
          </div>
          <div class="form-group">
            <div class="utility">
              <%--<div class="animated-checkbox">
                <label>
                  <input type="checkbox"><span class="label-text">Stay Signed in</span>
                </label>
              </div>--%>
              <p class="semibold-text mb-2"><a href="#" data-toggle="flip">Forgot Password ?</a></p>
            </div>
          </div>
          <div class="form-group btn-container">
          <asp:Button ID="btnSubmit" runat="server" Text="SUBMIT" OnClick="submitUser" class="btn btn-primary btn-block"/>
          <%--<button runat="server" id="btnSubmit" onserverclick="submitUser" class="btn btn-primary btn-block">
    <i class="fa fa-sign-in fa-lg fa-fw"></i> SIGN IN</button>--%>
          </div>
        </div>
        <div class="forget-form">
          <h3 class="login-head"><i class="fa fa-lg fa-fw fa-lock"></i>Forgot Password ?</h3>
          <div class="form-group">
            <label class="control-label">EMAIL</label>
            <asp:TextBox ID="txtForgetUserName" class="form-control" runat="server" placeholder="Email"></asp:TextBox>
          </div>
          <div class="form-group btn-container">
             <button runat="server" id="btnForgotPassword" onserverclick="forgetEmail" class="btn btn-primary btn-block">
    <i class="fa fa-unlock fa-lg fa-fw"></i> RESET
</button>
          </div>
          <div class="form-group mt-3">
            <p class="semibold-text mb-0"><a href="#" data-toggle="flip"><i class="fa fa-angle-left fa-fw"></i> Back to Login</a></p>
          </div>
      </div>
    </section>
    </form>
</body>
</html>
<script type="text/javascript">
    // Login Page Flipbox control
    $('.login-content [data-toggle="flip"]').click(function () {
        $('.login-box').toggleClass('flipped');
        return false;
    });
</script>
