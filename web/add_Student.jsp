<%--
  Created by IntelliJ IDEA.
  User: m1385
  Date: 2025/1/24
  Time: 17:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Title</title>
      <style>
        *{
            margin:0;
            padding:0;
        }
        body {
            font-family: Arial, sans-serif;
            height: 1200px; /* 让背景图片充满整个视口高度 */
            background-image: url('https://i.ibb.co/Z6CPsTT/preview.jpg'); /* 替换为你的背景图片地址 */
            background-size: cover; /* 背景图片自适应整个页面 */
            background-position: center; /* 背景图片居中 */
            background-repeat: no-repeat; /* 防止图片重复 */
            display: flex;
            flex-direction: column;
            /*justify-content: center;*/
            align-items: center;
        }
        .login-container {
            width:500px;
            height:1000px;
            border-radius: 8px;
            /*justify-content: center;*/
            align-items: center;
            display: flex;
            margin-top: 90px;
            flex-direction: column;
            border-top: 1px solid rgba(255,255,255,0.5);
            border-left: 1px solid rgba(255,255,255,0.5);
            border-right: 1px solid rgba(255,255,255,0.2);
            border-bottom: 1px solid rgba(255,255,255,0.2);
            backdrop-filter: blur(10px);
            /*border: 1px solid red;*/
        }
        .login-container form{
            margin-top: 80px;
            border:1px solid red;
            font-weight: bold;
        }
        .login-container input{
            width:350px;
            justify-content: center;
            align-items: center;
            display: flex;
            flex-direction: column;
            /*border:1px solid red;*/
        }
        .input-field {
            width: 80%;
            padding: 15px; /* 增加输入框的内边距，调高高度 */
            margin: 5px 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: start;
            /*border:1px solid red;*/
            border: 1px solid grey;
            border-radius: 4px;
            font-size: 16px; /* 增加字体大小 */
        }
        .button-container {
            width:100%;
            margin-top:30px;
            margin-left:auto;
            margin-right:auto;
            justify-content: center;
            align-items: center;
            display: flex;
            border:1px solid red;
        }
        .login-button {
            width: 40%;
            padding: 12px; /* 调整按钮高度 */
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px; /* 增加按钮文字大小 */
            cursor: pointer;
            margin-left:0px;
            /*border: 1px solid red;*/
        }

    </style>
  </head>
  <body>
    <div class="login-container">
        <form action="add_Student.do" method="POST">
            学号:<input type="number" class="input-field" name="stuId" placeholder="请输入你的学号" required><br>
            姓名:<input type="text" class="input-field" name="stuName" placeholder="请输入你的姓名" required><br>
            年龄:<input type="number" class="input-field" name="stuAge" placeholder="请输入你的年龄" required><br>
            性别:<input type="text" class="input-field" name="stuGender" placeholder="请输入你的性别" required><br>
            民族:<input type="text" class="input-field" name="stuNation" placeholder="请输入你的民族" required><br>
            省份:<input type="text" class="input-field" name="stuProvince" placeholder="请输入你的省份" required><br>
            专业:<input type="text" class="input-field" name="stuMajor" placeholder="请输入你的专业" required><br>
            班级:<input type="text" class="input-field" name="stuClass" placeholder="请输入你的班级" required><br>
            <div class="button-container">
                <button type="submit" class="login-button">添加学生</button>
            </div>
        </form>
    </div>
  </body>
</html>
