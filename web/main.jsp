<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>学生列表分页展示</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            height: 760px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .container {
            width: 100%;
            height: 765px;
            border: 1px solid #000;
        }

        .top-container {
            width: 100%;
            height: 4%;
            margin-top: 10px;
            text-align: center;
            border: 1px solid red;
            display: flex;
        }

        .name-container {
            width: 15%;
            height: 30px;
            display: flex;
            align-items: center;
            text-align: center;
            justify-content: center;
        }

        .name {
            font-size: 20px;
        }

        .button-container {
            width: 100px;
            height: 30px;
            margin-left: auto;
            display: flex;
            align-items: center;
            text-align: center;
            justify-content: center;
            border-radius: 5px;
        }

        button {
            font-size: 16px;
            padding: 5px 10px;
            text-decoration: none;
            background-color: pink;
            border-radius: 5px;
            cursor: pointer;
            border: none;
            display: flex;
            outline: none;
        }

        .form {
            height: 600px;
            flex-direction: column;
            align-items: center;
            display: flex;
            border: 1px solid red;
        }

        table {
            width: 60%;
            height: 500px;
            border-collapse: collapse;
            border-radius: 10px;
            border: 1px solid #ddd;
        }

        table thead {
            font-weight: bold;
        }

        table tbody {
            border-top: 1px solid rgba(255, 255, 255, 0.5);
            border-left: 1px solid rgba(255, 255, 255, 0.5);
            border-right: 1px solid rgba(255, 255, 255, 0.2);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            background-color: transparent;
            box-shadow: none;
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        h2 {
            text-align: center;
            height: 3%;
        }

        .container form {
            margin-top: 30px;
            text-align: center;
            justify-content: center;
            align-items: center;
            display: flex;
            /*border: 1px solid blue;*/
            font-weight: bold;
        }

        .container input {
            width: 350px;
            justify-content: center;
            align-items: center;
            display: flex;
        }

        .input-field {
            width: 80%;
            font-weight: bold;
            padding: 15px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: start;
            border: 1px solid grey;
            border-radius: 4px;
            font-size: 16px;
        }

        .button-container1 {
            width: 10%;
            height: 48px;
            display: flex;
            border: 1px solid red;
        }

        .Search-button {
            width: 60%;
            height: 100%;
            background-color: pink;
            color: white;
            border: none;
            border-radius: 4px;
            display: flex;
            font-size: 16px;
            cursor: pointer;
            justify-content: center;
            align-items: center;
            text-align: center;
            margin: 0 auto;
        }

        .pagination {
            margin-top: 20px;
            border: 1px solid red;
        }

        .pagination a {
            color: black;
            float: left;
            padding: 8px 16px;
            text-decoration: none;
            transition: background-color .3s;
            border: 1px solid #ddd;
            margin: 0 4px;
        }

        .pagination a.active {
            background-color: #4CAF50;
            color: white;
            border: 1px solid #4CAF50;
        }

        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }

        .next {
            border: 1px solid red;
            display: flex;
        }

        .prev {
            border: 1px solid red;
            display: flex;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="top-container">
            <div class="name-container">
                <div class="name">
                    <%// 获取会话对象
                        session = request.getSession();
                        // 从会话中获取用户名
                        String username = (String) session.getAttribute("username");
                        if (username != null) {
                            out.print("欢迎您, " + username + "!");
                        }%>
                </div>
            </div>
            <div class="button-container">
                <button id='logoutButton'>安全退出</button>
            </div>
        </div>
        <h2>学生列表</h2>
        <form action="search_result.jsp" method="post">
            请输入学号:
            <input type="number" name="stuId" class="input-field" placeholder="输入学生的学号">
            <div class="button-container1">
                <button type="submit" class="Search-button">搜索</button>
            </div>
        </form>
        <!-- 添加页码输入框和跳转按钮 -->

        <div class="form">
            <table>
                <thead>
                    <tr>
                        <th>学号</th>
                        <th>姓名</th>
                        <th>年龄</th>
                        <th>性别</th>
                        <th>民族</th>
                        <th>省份</th>
                        <th>专业</th>
                        <th>班级</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <%// 数据库连接信息
                        final String JDBC_URL = "jdbc:mysql://localhost:3306/users?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
                        final String JDBC_USERNAME = "root";
                        final String JDBC_PASSWORD = "pddexas0";
                        Connection conn = null;
                        PreparedStatement stmt = null;
                        ResultSet rs = null;
                        // 每页显示的记录数
                        int pageSize = 5;
                        // 获取当前页码，默认为第 1 页
                        int currentPage = 1;
                        String pageParam = request.getParameter("page");
                        if (pageParam != null && !pageParam.isEmpty()) {
                            try {
                                currentPage = Integer.parseInt(pageParam);
                                if (currentPage < 1) {
                                    currentPage = 1;
                                }
                            } catch (NumberFormatException e) {
                                currentPage = 1;
                            }
                        }
                        int totalPages = 0;
                        try {
                            // 加载数据库驱动
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            // 建立数据库连接
                            conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
                            // 查询总记录数
                            String countSql = "SELECT COUNT(*) as total FROM student";
                            stmt = conn.prepareStatement(countSql);
                            rs = stmt.executeQuery();
                            int totalRecords = 0;
                            if (rs.next()) {
                                totalRecords = rs.getInt("total");
                            }
                            rs.close();
                            stmt.close();
                            // 计算总页数
                            totalPages = (int) Math.ceil((double) totalRecords / pageSize);
                            // 处理当前页码超出范围的情况
                            if (currentPage > totalPages && totalPages > 0) {
                                currentPage = totalPages;
                            }
                            // 计算当前页的起始记录索引
                            int startIndex = (currentPage - 1) * pageSize;
                            // 修改 SQL 查询语句，使用 LIMIT 实现分页
                            String sql = "SELECT * FROM student LIMIT ?, ?";
                            stmt = conn.prepareStatement(sql);
                            stmt.setInt(1, startIndex);
                            stmt.setInt(2, pageSize);
                            rs = stmt.executeQuery();
                            while (rs.next()) {
                                String stuId = rs.getString("学号");
                                String stuName = rs.getString("姓名");
                                int stuAge = rs.getInt("年龄");
                                String stuGender = rs.getString("性别");
                                String stuNation = rs.getString("民族");
                                String stuProvince = rs.getString("省份");
                                String stuMajor = rs.getString("专业");
                                String stuClass = rs.getString("班级");
                                out.println("<tr>");
                                out.println("<td>" + stuId + "</td>");
                                out.println("<td>" + stuName + "</td>");
                                out.println("<td>" + stuAge + "</td>");
                                out.println("<td>" + stuGender + "</td>");
                                out.println("<td>" + stuNation + "</td>");
                                out.println("<td>" + stuProvince + "</td>");
                                out.println("<td>" + stuMajor + "</td>");
                                out.println("<td>" + stuClass + "</td>");
                                out.println("<td><a href='update_Student1.jsp?stuId=" + stuId + "'>更新</a>");
                                out.println("<a href='delete_Student.jsp?stuId=" + stuId + "'>删除</a></td>");
                                out.println("</tr>");
                            }
                        } catch (ClassNotFoundException | SQLException e) {
                            e.printStackTrace();
                            out.println("<tr><td colspan='9'>数据查询出错，请稍后重试。</td></tr>");
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }%>
                </tbody>
            </table>
            <div class="addButton">
                <a href="add_Student.jsp">添加学生</a>
            </div>
            <!-- 分页导航 -->
            <div class="pagination">
                <div class="prev" border: 1px solid red;>
                     <%for (int i = 1; i <= totalPages; i++) {
                         if (i == currentPage) {%>
                        <a href="#" class="active" onclick="goToPage(<%=i%>)"><%=i%></a>
                    <%} else {%>
                            <a href="#" onclick="goToPage(<%=i%>)"><%=i%></a>
                    <%}
                    }%>
                </div>
                <div style="margin-top: 10px;" class="next" border: 1px solid red;>
                    <input type="number" id="pageInput" placeholder="输入页码">
                    <button onclick="goToPageByInput()">跳转</button>
                </div>
            </div>

        </div>
    </div>
    <script>
        document.getElementById('logoutButton').addEventListener('click', function () {
            if (confirm('确定要退出吗？')) {
                window.location.href = 'logout.do';
            }
        });

        function goToPage(page) {
            window.location.href = "<%=request.getRequestURI()%>?page=" + page;
        }

        function goToPageByInput() {
            var pageInput = document.getElementById('pageInput').value;
            if (pageInput) {
                var page = parseInt(pageInput);
                if (!isNaN(page) && page > 0) {
                    goToPage(page);
                } else {
                    alert('请输入有效的页码');
                }
            } else {
                alert('请输入页码');
            }
        }
    </script>
</body>
</html>