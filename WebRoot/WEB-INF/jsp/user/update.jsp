<%@page language="java" contentType="text/html; character=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>管理员后台</title>
    <link rel="stylesheet" href="${ctx}/resource/css/pintuer.css">
    <link rel="stylesheet" href="${ctx}/resource/css/admin.css">
    <script src="${ctx}/resource/js/jquery.js"></script>
    <script src="${ctx}/resource/js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head" id="add">
        <strong><span class="icon-pencil-square-o">修改用户</span></strong>
    </div>
    <div class="body-content">
        <form action="${ctx}/user/exUpdate" method="post" class="form-x">
            <input type="hidden" name="id" value="${obj.id}">
            <div class="form-group">
                <div class="label"><label>用户名:</label></div>
                <div class="field">
                    <input type="text" class="input w50" value="${obj.userName}" name="userName" data-validate="required:请输入用户名" />
                    <div class="tips"></div>
                </div>
            </div>
            <div class="form-group">
                <div class="label"><label>密码:</label></div>
                <div class="field">
                    <input type="text" class="input w50" value="${obj.passWord}" name="passWord" data-validate="required:请输入密码" />
                    <div class="tips"></div>
                </div>
            </div>
            <div class="form-group">
                <div class="label"><label>手机号:</label></div>
                <div class="field">
                    <input type="text" class="input w50" value="${obj.phone}" name="phone" data-validate="required:请输入手机号" />
                    <div class="tips"></div>
                </div>
            </div>
            <div class="form-group">
                <div class="label"><label>真实姓名:</label></div>
                <div class="field">
                    <input type="text" class="input w50" value="${obj.realName}" name="realName" data-validate="required:请输入真实姓名" />
                    <div class="tips"></div>
                </div>
            </div>
            <div class="form-group">
                <div class="label"><label>性别:</label></div>
                <div class="field">
                    <select style="outline: none;border: 1px solid #ddd;height: 30px;" name="sex">
                        <option value="男" ${obj.sex=='男'?'selected="selected"':''}>男</option>
                        <option value="女" ${obj.sex=='女'?'selected="selected"':''}>女</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="label"><label>住址:</label></div>
                <div class="field">
                    <input type="text" class="input w50" value="${obj.address}" name="address" data-validate="required:请输入住址" />
                    <div class="tips"></div>
                </div>
            </div>
            <div class="form-group">
                <div class="label"><label>邮箱:</label></div>
                <div class="field">
                    <input type="text" class="input w50" value="${obj.email}" name="email" data-validate="required:请输入邮箱" />
                    <div class="tips"></div>
                </div>
            </div>
            <div class="form-group">
                <div class="label"></div>
                <div class="field">
                    <button class="button bg-main icon-check-square-o" type="submit">提交</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>