<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="/common/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>加载中...</title>
		<meta content="3;url=${ctx}/login/uIndex" http-equiv="refresh">
		<style type="text/css">
			*{
				margin: 0;
				padding: 0;
			}
			body{
				height: 100%;
				background: #FFFFFF;

			}
			.wrap{
				width: 100px;
				background: lightblue;
				position: absolute;
				bottom: 120px;
				margin-left: -50px;
			}
			.red{
				left: 25%;
			}
			.green{
				left: 50%;
			}
			.blue{
				left: 75%;
			}
			.ball{
				width: 50px;
				height: 50px;
				border-radius: 100%;
				margin: auto;
				position: absolute;
				left: 0;
				right: 0;
				top: 0;

				animation: ballMove 300ms infinite alternate;
			}
			.red .ball{
				background: linear-gradient(#e55,#b00);
			}
			.green .ball{
				background: linear-gradient(#5d5,#0a0);
			}
			.blue .ball{
				background: linear-gradient(#59e,#04b);
			}

			.shadow{
				width: 75px;
				height: 25px;
				background: #000000;
				border-radius: 100%;
				margin: auto;
				position: absolute;
				left: 0;
				right: 0;
				top: 0;
				bottom: -100px;

				animation: shadowMove 300ms infinite alternate;
			}

			.red .ball,.red .shadow{
				animation-delay: -300ms;/*动画啥时候开始*/
			}

			.green .ball,.green .shadow{
				animation-delay: -200ms;
			}

			.blue .ball,.blue .shadow{
				animation-delay: 0ms;
			}

			@keyframes ballMove{
				0%{
					transform: translateY(0);
				}
				100%{
					transform: translateY(-200px);
				}
			}
			@keyframes shadowMove{
				0%{
					opacity: 0.15;/*透明度*/
					transform: scale(0.6);/*2D缩放转换*/
				}
				100%{
					opacity: 0.5;
					transform: scale(0.8);
				}
			}
		</style>
	</head>
	<body>
		<div class="wrap red">
			<div class="ball"></div>
			<div class="shadow"></div>
		</div>
		<div class="wrap green">
			<div class="ball"></div>
			<div class="shadow"></div>
		</div>
		<div class="wrap blue">
			<div class="ball"></div>
			<div class="shadow"></div>
		</div>
	</body>
</html>
