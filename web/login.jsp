<%--
  Created by IntelliJ IDEA.
  User: m1385
  Date: 2025/1/2
  Time: 18:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户登录</title>
    <style>
        *{
            margin:0;
            padding:0;
        }

        canvas {
            display: block;
            position: fixed; /* 固定定位，覆盖整个页面 */
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1; /* 置于底层 */
        }
        .login-container {
            width: 500px;
            height:500px;
            border-radius: 8px;
            justify-content: center;
            align-items: center;
            display: flex;
            flex-direction: column;
            border-top: 1px solid rgba(255,255,255,0.5);
            border-left: 1px solid rgba(255,255,255,0.5);
            border-right: 1px solid rgba(255,255,255,0.2);
            border-bottom: 1px solid rgba(255,255,255,0.2);
            backdrop-filter: blur(10px);
            position: absolute; /* 绝对定位 */
            top: 50%; /* 垂直居中 */
            left: 50%; /* 水平居中 */
            transform: translate(-50%, -50%); /* 精确居中 */
            z-index: 1; /* 置于 canvas 之上 */
        }
        .login-container h2{
            font-size: 33px;
            font-weight: bold;
            color: white;
        }
        .login-container form{
            margin-top: 30px;
            color: white;
        }
        .login-container input{
            width:350px;
            justify-content: center;
            align-items: center;
            display: flex;
            flex-direction: column;
        }
        .input-field {
            width: 80%;
            padding: 15px; /* 增加输入框的内边距，调高高度 */
            margin: 10px 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: start;
            border: 1px solid grey;
            border-radius: 4px;
            font-size: 16px; /* 增加字体大小 */
        }
        .button-container {
            width:100%;
            margin-top:30px;
            margin-left:auto;
            margin-right:auto;
        }
        .login-button {
            width: 40%;
            padding: 12px; /* 调整按钮高度 */
            cursor: pointer;
            margin-left:0px;
        }

        /* From Uiverse.io by barisdogansutcu */
        button {
            padding: 17px 40px;
            border-radius: 50px;
            cursor: pointer;
            border: 0;
            background-color: white;
            box-shadow: rgb(0 0 0 / 5%) 0 0 8px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            font-size: 15px;
            transition: all 0.5s ease;
        }

        button:hover {
            letter-spacing: 3px;
            /* 修改悬停状态下的背景颜色为更深的粉色 */
            background-color: #FF69B4;
            color: hsl(0, 0%, 100%);
            box-shadow: rgb(255 105 180) 0px 7px 29px 0px; /* 阴影颜色也对应调整为粉色系 */
        }

        button:active {
            letter-spacing: 3px;
            background-color: #FF69B4;
            color: hsl(0, 0%, 100%);
            box-shadow: rgb(255 105 180) 0px 0px 0px 0px;
            transform: translateY(10px);
            transition: 100ms;
        }

        .login-register {
            width: 40%;
            padding: 12px; /* 调整按钮高度 */
            cursor: pointer;
            margin-left:60px;
        }
    </style>
    <script>
        // 清除本地存储的敏感信息
        localStorage.clear();
        sessionStorage.clear();
    </script>
</head>
<body>
    <canvas id="main1"></canvas>
    <div class="login-container">
        <h2>用户登录</h2>
        <form action="login.do" method="POST">
            账号:<input type="text" class="input-field" name="username" placeholder="请输入您的账号" required><br>
            密码:<input type="password" class="input-field" name="password" placeholder="请输入您的密码" required><br>
            <div class="button-container">
                <button type="submit" class="login-button">登录</button>
                <a href="register.jsp"><button type="button" class="login-register">注册</button></a>
            </div>
        </form>
    </div>
    <script>
        var main1 = document.getElementById("main1");
        var ctx = main1.getContext("2d");

        //making the canvas full screen | 让画布全屏
        main1.height = window.innerHeight;
        main1.width = window.innerWidth;

        //chinese characters - taken from the unicode charset | 汉字 - 取自unicode字符集
        var chinese =
            "田由甲申甴电甶男甸甹町画甼甽甾甿畀畁畂畃畄畅畆畇畈畉畊畋界畍畎畏畐畑";
        //converting the string into an array of single characters | 将字符串转换为单个字符数组
        chinese = chinese.split("");

        var font_size = 10;
        var columns = main1.width / font_size; //number of columns for the rain | 雨水柱数
        //an array of drops - one per column | 雨滴的阵列 - 每列一个
        var drops = [];
        //x below is the x coordinate | 下面的x是x坐标
        //1 = y co-ordinate of the drop(same for every drop initially) | 雨滴的y坐标(最初每一滴相同)
        for (var x = 0; x < columns; x++) drops[x] = 1;

        //drawing the characters | 绘制字符
        function draw() {
            //Black BG for the canvas | 画布黑色背景
            //translucent BG to show trail | 半透明背景显示轨迹
            ctx.fillStyle = "rgba(0, 0, 0, 0.05)";
            ctx.fillRect(0, 0, main1.width, main1.height);

            ctx.fillStyle = "#0F0"; //green text
            ctx.font = font_size + "px arial";
            //looping over drops | 在雨滴上循环
            for (var i = 0; i < drops.length; i++) {
                //a random chinese character to print | 要打印的随机汉字
                var text = chinese[Math.floor(Math.random() * chinese.length)];
                //x = i*font_size, y = value of drops[i]*font_size
                ctx.fillText(text, i * font_size, drops[i] * font_size);

                //sending the drop back to the top randomly after it has crossed the screen | 在水滴越过屏幕后，将其随机发送回顶部
                //adding a randomness to the reset to make the drops scattered on the Y axis | 将随机性添加到重置，以使液滴分散在Y轴上
                if (drops[i] * font_size > main1.height && Math.random() > 0.975)
                    drops[i] = 0;

                //incrementing Y coordinate | 递增Y坐标
                drops[i]++;
            }
        }

        setInterval(draw, 33);
    </script>
</body>
</html>