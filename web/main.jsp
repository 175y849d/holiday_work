<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: m1385
  Date: 2025/1/24
  Time: 13:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
  <head>
    <title>Title</title>
    <style>
      /*body {*/
      /*  font-family: Arial, sans-serif;*/
      /*  height: 100vh; !* 让背景图片充满整个视口高度 *!*/
      /*  background-image: url('https://i.ibb.co/Z6CPsTT/preview.jpg'); !* 替换为你的背景图片地址 *!*/
      /*  background-size: cover; !* 背景图片自适应整个页面 *!*/
      /*  background-position: center; !* 背景图片居中 *!*/
      /*  background-repeat: no-repeat; !* 防止图片重复 *!*/
      /*  display: flex;*/
      /*  flex-direction: column;*/
      /*  justify-content: center;*/
      /*  align-items: center;*/
      /*}*/
      .container{
        width: 100%;
        height: 100vh;
        /*display: flex;*/
        border:1px solid #000;
      }

      .top-container{
        width: 100%;
        height: 4%;
        margin-top: 10px;
        text-align: center;
        border: 1px solid red;
        display: flex;
      }
      .name-container{
        width:15%;
        height:30px;
        display: flex;
        /*border: 1px solid red;*/
        align-items: center;
        text-align: center;
        justify-content: center;
      }
      .name{
        font-size: 20px;
      }
      .button-container{
        width:100px;
        height:30px;
        margin-left: 1250px;
        display: flex;
        /*border: 1px solid red;*/
        align-items: center;
        text-align: center;
        justify-content: center;
        radius: 5px;

      }
      button{
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

      .form{
          height: 100%;
        flex-direction: column;
        align-items: center;
          display:flex;
        border: 1px solid blue;
      }
      table {
          width: 60%;
          height: 200px;
          border-collapse: collapse;
      }
      table thead {
          background-color: #f2f2f2;
          font-weight: bold;
      }
      table tbody {
          background-color: #fff;
      }
      table th, table td {
          border: 1px solid #ddd;
          padding: 8px;
          text-align: center;
      }
      h2 {
          text-align: center;
          height:3%;
      }
      .container form{
          margin-top: 30px;
          text-align: center;
          justify-content: center;
          align-items: center;
          display: flex;
          border: 1px solid blue;
          font-weight: bold;
      }
      .container input{
          width:350px;
          justify-content: center;
          align-items: center;
          display: flex;
          /*flex-direction: column;*/
          /*border:1px solid red;*/
      }
      .input-field {
          width: 80%;
          font-weight: bold;
          padding: 15px; /* 增加输入框的内边距，调高高度 */
          display: flex;
          flex-direction: column;
          justify-content: center;
          align-items: start;
          /*border:1px solid red;*/
          border: 1px solid grey;
          border-radius: 4px;
          font-size: 16px; /* 增加字体大小 */
      }
      .button-container1 {
          width:10%;
          height:48px;
          display: flex;
          border:1px solid red;
      }
      .Search-button {
          width: 60%; /* 调整按钮高度 */
          height:100%;
          background-color: pink;
          color: white;
          border: none;
          border-radius: 4px;
          display: flex;
          font-size: 16px; /* 增加按钮文字大小 */
          cursor: pointer;
          justify-content: center;
          align-items: center;
          text-align: center;
          margin:0 auto;
          /*border: 1px solid red;*/
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="top-container">
        <div class="name-container">
            <div class="name">
              <%
                HttpSession mySession = request.getSession();
                if (session != null) {
                  String username = (String) mySession.getAttribute("username");
                  if (username != null) {
                    out.println("欢迎您," + username + "!");
                  }
                }
              %>
            </div>
        </div>
        <div class="button-container">
            <button id='logoutButton'>安全退出</button>
        </div>
      </div>
      <h2>学生列表</h2>
        <form action="search_result.jsp" method="post">
            请输入学号:  <input type="number" name="stuId" class="input-field" placeholder="输入学生的学号">
            <div class="button-container1">
                <button type="submit" class="Search-button">搜索</button>
            </div>
        </form>
        <div class="form">
            <table height="200px">
              <thread>
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
              </thread>
              <%
                  final String JDBC_URL = "jdbc:mysql://localhost:3306/users?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
                  final String JDBC_USERNAME = "root"; // 数据库用户名
                  final String JDBC_PASSWORD = "pddexas0";// 数据库密码
                  Connection conn = null;
                  PreparedStatement stmt = null;
                  ResultSet rs = null;
                  // 加载数据库驱动
                  Class.forName("com.mysql.cj.jdbc.Driver");
                  // 建立数据库连接
                  conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
                  // SQL 查询语句
                  String sql = "SELECT * FROM student";
                  stmt = conn.prepareStatement(sql);
                  rs = stmt.executeQuery();
                  while (rs.next()) {
                      int stuId = 0;
                      try {
                          stuId = rs.getInt("学号");
                      } catch (SQLException e) {
                          throw new RuntimeException(e);
                      }
                      String stuName = null;
                      try {
                          stuName = rs.getString("姓名");
                      } catch (SQLException e) {
                          throw new RuntimeException(e);
                      }
                      int stuAge = 0;
                      try {
                          stuAge = rs.getInt("年龄");
                      } catch (SQLException e) {
                          throw new RuntimeException(e);
                      }
                      String stuGender = null;
                      try {
                          stuGender = rs.getString("性别");
                      } catch (SQLException e) {
                          throw new RuntimeException(e);
                      }
                      String stuNation = null;
                      try {
                          stuNation = rs.getString("民族");
                      } catch (SQLException e) {
                          throw new RuntimeException(e);
                      }
                      String stuProvince = null;
                      try {
                          stuProvince = rs.getString("省份");
                      } catch (SQLException e) {
                          throw new RuntimeException(e);
                      }
                      String stuMajor = null;
                      try {
                          stuMajor = rs.getString("专业");
                      } catch (SQLException e) {
                          throw new RuntimeException(e);
                      }
                      String stuClass = null;
                      try {
                          stuClass = rs.getString("班级");
                      } catch (SQLException e) {
                          throw new RuntimeException(e);
                      }
                      out.println("<tbody>");
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
                      out.println("</tbody>");
                  }
                  rs.close();
                  stmt.close();
    //            private boolean isStuIdExists() {
    //              Connection conn = null;
    //              PreparedStatement stmt = null;
    //              ResultSet rs = null;
    //              try {
    //              // 加载数据库驱动
    //                Class.forName("com.mysql.cj.jdbc.Driver");
    //                // 建立数据库连接
    //                conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
    //                // SQL 查询语句
    //                String sql = "SELECT * FROM student";
    //                stmt = conn.prepareStatement(sql);
    //                rs = stmt.executeQuery();
    //                out.println(rs);
    //              } catch (ClassNotFoundException | SQLException e) {
    //                e.printStackTrace();
    //              } finally {
    //                try {
    //                  if (rs != null) rs.close();
    //                  if (stmt != null) stmt.close();
    //                  if (conn != null) conn.close();
    //                } catch (SQLException e) {
    //                  e.printStackTrace();
    //                }
    //              }

              %>
            </table>
            <div class="addButton">
                <a href="add_Student.jsp">添加学生</a>
            </div>
        </div>
        </div>
      </div>
    </div>
<%--    <script>--%>
<%--        document.getElementById('logoutButton').addEventListener('click', function () {--%>
<%--          // 发送退出请求到服务器--%>
<%--          window.location.href = 'logout.do';--%>
<%--        });--%>
<%--    </script>--%>
    <script>
        document.getElementById('logoutButton').addEventListener('click', function () {
          if (confirm('确定要退出吗？')) {
            window.location.href = 'logout.do';
          }
        });
    </script>
  </body>
</html>
