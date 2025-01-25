<%--
  Created by IntelliJ IDEA.
  User: m1385
  Date: 2025/1/2
  Time: 22:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户登录</title>
    <style>
        /*body {*/
        /*    width: 100%;*/
        /*    height: 100%;*/
        /*    font-family: Arial, sans-serif;*/
        /*    margin:0;*/
        /*    padding:0;*/
        /*    height: 100vh; !* 让背景图片充满整个视口高度 *!*/
        /*    background-image: url('https://i.ibb.co/Z6CPsTT/preview.jpg'); !* 替换为你的背景图片地址 *!*/
        /*    background-size: cover; !* 背景图片自适应整个页面 *!*/
        /*    background-position: center; !* 背景图片居中 *!*/
        /*    background-repeat: no-repeat; !* 防止图片重复 *!*/
        /*    display: flex;*/
        /*}*/
        body {
            font-family: Arial, sans-serif;
            height: 100vh; /* 让背景图片充满整个视口高度 */
            background-image: url('https://i.ibb.co/Z6CPsTT/preview.jpg'); /* 替换为你的背景图片地址 */
            background-size: cover; /* 背景图片自适应整个页面 */
            background-position: center; /* 背景图片居中 */
            background-repeat: no-repeat; /* 防止图片重复 */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .main{
            width: 100%;
            height: 100%;
            display: flex;
            /*border:1px solid red;*/
        }
        .login-container {
            width:550px;
            height:365px;
            background-color: white;
            margin-left: auto;
            margin-right: auto;
            margin-top: 130px;
            border-radius: 8px;
            text-align: center;
            justify-content: center;
            align-items: center;
            /*border: 1px solid red;*/
        }
        .login-container h2{
            font-size: 33px;
            font-weight: bold;
        }
        .login-container form{
            width:350px;
            margin-left:auto;
            margin-right:auto;
            align-items: center;
            justify-content: center;
            /*border:1px solid red;*/
        }
        .input-field {
            width: 80%;
            padding: 15px; /* 增加输入框的内边距，调高高度 */
            margin: 10px 0;
            border: 1px solid grey;
            border-radius: 4px;
            font-size: 16px; /* 增加字体大小 */
        }
        .button-container {
            width:100%;
            margin-top:20px;
            margin-left:auto;
            margin-right:auto;
            /*border:1px solid red;*/
        }
        .login-register {
            width: 25%;
            padding: 12px; /* 调整按钮高度 */
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            /*border: 1px solid red;*/
            font-size: 16px; /* 增加按钮文字大小 */
            cursor: pointer;
            margin-left:40px;
        }

    </style>
</head>
<body>
<div class="main">
    <div class="login-container">
        <h2>用户登录</h2>
        <form action="register.do" method="POST">
            账号:<input type="text" class="input-field" name="username" placeholder="请输入您的账号" required><br>
            密码:<input type="password" class="input-field" name="password" placeholder="请输入您的密码" required><br>
            <div class="button-container">
                <button type="submit" class="login-register">注册</button>
            </div>
        </form>
    </div>
</div>
<script>

</script>
</body>
</html>