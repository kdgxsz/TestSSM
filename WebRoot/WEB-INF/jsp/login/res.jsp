<%@ page language="java" contentType="text/html; character=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>首页</title>
    <link type="text/css" rel="stylesheet" href="${ctx}/resource/user/css/style.css">
    <script src="${ctx}/resource/user/js/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/resource/user/js/jquery.luara.0.0.1.min.js"></script>
    <!--表单验证-->
    <script type="text/javascript">
        function validate()
        {
        var at=document.getElementById("email").value.indexOf("@")
        var password=document.getElementById("password").value
        var userName=document.getElementById("userName").value
        var realName=document.getElementById("realName").value
        var phone=document.getElementById("phone").value
        var address=document.getElementById("address").value
             submitOK="true"
            if (userName.length>8||userName.length<2)
            {
            alert("用户名必须是2 - 8 个字符。")
            submitOK="false"
            }
            if (password.length<3||password.length>10)
            {
            alert("密码必须是 3 - 10位 ")
            submitOK="false"
            }
            if (realName==null||realName=="")
            {
                alert("必须填写真实姓名")
                submitOK="false"
            }
            if (phone.length!=11)
            {
                alert("请填写正确手机号")
                submitOK="false"
            }
            if (address=="")
            {
                alert("请填写所在地址")
                submitOK="false"
            }
            if (at==-1)
            {
            alert("不是有效的电子邮件地址。")
            submitOK="false"
            }
            if (submitOK=="false")
            {
            return false
            }
        }
    </script>
    <style type="text/css">

    </style>
</head>
<body>
<div class="width100 hidden_yh" style="border-top: 1px solid #ddd;">
    <div class="width1200 hidden_yh center_yh" style="margin-top: 75px">
        <h3 class="tcenter font30 c_33" style="font-weight: 100;margin-top: 36px;margin-bottom: 36px">用户注册</h3>
        <form action="${ctx}/login/toRes" method="post" class="form-x" onsubmit="return validate()">
            <div class="center_yh hidden_yh" style="width: 475px;margin-bottom: 30px">
                <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;" class="left_yh block_yh tright">用户名:</span>
                <input type="text" id="userName" name="userName" placeholder="请输入您的用户名" style="border: 1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px" class="left_yh">
            </div>
            <div class="center_yh hidden_yh" style="width: 475px;margin-bottom: 30px">
                <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;" class="left_yh block_yh tright">设置密码:</span>
                <input type="text" id="password" name="passWord" placeholder="建议使用俩种字符组合" style="border: 1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px" class="left_yh">
            </div>
            <div class="center_yh hidden_yh" style="width: 475px;margin-bottom: 30px">
                <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;" class="left_yh block_yh tright">手机号:</span>
                <input type="text" id="phone" name="phone" placeholder="建议使用常用手机" style="border: 1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px" class="left_yh">
            </div>
            <div class="center_yh hidden_yh" style="width: 475px;margin-bottom: 30px">
                <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;" class="left_yh block_yh tright">电子邮箱:</span>
                <input type="text" id="email" name="email" placeholder="请输入邮箱" style="border: 1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px" class="left_yh">
            </div>
            <div class="center_yh hidden_yh" style="width: 475px;margin-bottom: 30px">
                <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;" class="left_yh block_yh tright">真实姓名:</span>
                <input type="text" id="realName" name="realName" placeholder="请输入真实姓名" style="border: 1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px" class="left_yh">
            </div>
            <div class="center_yh hidden_yh" style="width: 475px;margin-bottom: 30px;height: 42px;line-height: 42px;">
                <span style="margin-right: 40px;line-height: 42px;width: 100px;" class="left_yh block_yh tright">性别:</span>
                <input  type="radio" name="sex" value="男" checked>男 &nbsp
                <input  type="radio" name="sex" value="女">女
            </div>
            <div class="center_yh hidden_yh" style="width: 475px;margin-bottom: 30px">
                <span style="margin-right: 40px;height: 42px;line-height: 42px;width: 100px;" class="left_yh block_yh tright">住址:</span>
                <input type="text" id="address" name="address" placeholder="请输入住址" style="border: 1px solid #c9c9c9;width: 292px;height: 42px;font-size: 16px;text-indent: 22px" class="left_yh">
            </div>
            <p class="font14 c_66" style="text-indent: 500px;margin-top: 30px">
                <input type="checkbox" checked>我已阅读<a href="#" class="red">《会员注册协议》</a>和<a class="red"> 《隐私保护政策》</a>
            </p>
            <input type="submit" value="提交" class="ipt_tj" style="width: 295px;height: 44px;margin-left: 500px;">
            <div class="center_yh hidden_yh" style="text-indent: 500px;margin-top: 10px">
                <a style="color: #0e1db1;font-size: 14px;margin-left: 200px;" href="${ctx}/login/uLogin">已有账号去登录</a>&nbsp;
            </div>
        </form>
    </div>
</div>
<!--引入尾页面-->
<%@include file="/common/ufooter.jsp"%>
</body>
</html>