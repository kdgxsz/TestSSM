<%@page language="java" contentType="text/html; character=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglibs.jsp" %>
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
    <form action="${ctx}/item/findBySql" id="listForm" method="post">
        <div class="padding border-bottom">
            <ul class="search" style="padding-left: 10px;">
                <li>
                    <input type="text" placeholder="请输入商品名称" name="name" class="input" value="${obj.name}"
                           style="width: 250px;line-height: 17px;display: inline-block">
                    <a href="javascript:void(0)" onclick="changeSearch()" class="button border-main icon-search">搜索</a>
                </li>
                <li>
                    <a class="button border-main icon-plus-square-o" href="${ctx}/item/add"><span>添加商品</span> </a>
                </li>
            </ul>
        </div>
    </form>

    <table class="table table-hover text-center">
        <tr>
            <th>商品名称</th>
            <th>商品主图</th>
            <th>商品价格</th>
            <th>商品一级分类</th>
            <th>商品二级分类</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${pagers.datas}" var="data" varStatus="l">
            <tr>
                <td>${data.name}</td>
                <td><img src="${data.url1}" alt="" style="width: 100px;height: 100px"></td>
                <td>${data.price}</td>
                <td>${data.yiJi.name}</td>
                <td>${data.erJi.name}</td>
                <td>
                    <div class="button-group">
                        <a class="button border-main" href="${ctx}/item/update?id=${data.id}"><span
                                class="icon-edit">修改</span> </a>
                        <a class="button border-red" href="${ctx}/item/delete?id=${data.id}"><span
                                class="icon-trash-o">下架</span> </a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan="8">
                <div class="pagelist">
                    <!--分页开始-->
                    <!--maxIndexPages 最大输出页码数 maxPageItems 每页显示的行数(默认是10)-->
                    <pg:pager url="${ctx}/item/findBySql" maxIndexPages="5" items="${pagers.total}"
                              maxPageItems="15" export="curPage=pageNumber">
                        <pg:last>
                            共${pagers.total}记录，共${pageNumber}页，
                        </pg:last>
                        当前第${curPage}页
                        <pg:first>
                            <a href="${pageUrl}">首页</a>
                        </pg:first>
                        <pg:prev>
                            <a href="${pageUrl}">上一页</a>
                        </pg:prev>
                        <pg:pages>
                            <c:choose>
                                <c:when test="${curPage eq pageNumber}">
                                    <font color="red">[${pageNumber}]</font>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageUrl}">${pageNumber}</a>
                                </c:otherwise>
                            </c:choose>
                        </pg:pages>
                        <pg:next>
                            <a href="${pageUrl}">下一页</a>
                        </pg:next>
                        <pg:last>
                            <c:choose>
                                <c:when test="${curPage eq pageNumber}">
                                    <font color="red">尾页</font>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageUrl}">尾页</a>
                                </c:otherwise>
                            </c:choose>
                        </pg:last>
                    </pg:pager>
                </div>
            </td>
        </tr>
    </table>
</div>

<script type="text/javascript">
    function changeSearch() {
        $("#listForm").
        submit();
    }
</script>

</body>
</html>