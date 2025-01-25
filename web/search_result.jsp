<%@ page import="java.sql.Connection" %><%@ page import="java.sql.PreparedStatement" %><%@ page
        import="java.sql.ResultSet" %><%@ page import="java.sql.DriverManager" %><%--
  Created by IntelliJ IDEA.
  User: m1385
  Date: 2025/1/24
  Time: 21:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Title</title>
      <style>
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
      </style>
  </head>
  <body>
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
                      int stuId = Integer.parseInt(request.getParameter("stuId"));
//                      String stuName = null;
//                      int stuAge = 0;
//                      String stuGender = null;
//                      String stuNation = null;
//                      String stuProvince = null;
//                      String stuMajor = null;
//                      String stuClass = null;
                      // 加载数据库驱动
                      Class.forName("com.mysql.cj.jdbc.Driver");
                      // 建立数据库连接
                      conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
                      // SQL 查询语句
                      String sql = "SELECT * FROM student where 学号 = ?";
                      stmt = conn.prepareStatement(sql);
                      stmt.setInt(1, stuId);
                      rs = stmt.executeQuery();
                      while (rs.next()) {
                          out.println("<tbody>");
                          out.println("<tr>");
                          out.println("<td>" + stuId + "</td>");
                          out.println("<td>" + rs.getString("姓名") + "</td>");
                          out.println("<td>" + rs.getInt("年龄") + "</td>");
                          out.println("<td>" + rs.getString("性别") + "</td>");
                          out.println("<td>" + rs.getString("民族") + "</td>");
                          out.println("<td>" + rs.getString("省份") + "</td>");
                          out.println("<td>" + rs.getString("专业") + "</td>");
                          out.println("<td>" + rs.getString("班级") + "</td>");
                          out.println("<td><a href='edit_Student.jsp?stuId=" + stuId + "'>编辑</a>");
                          out.println("<a href='delete_Student.jsp?stuId=" + stuId + "'>删除</a></td>");
                          out.println("</tr>");
                          out.println("</tbody>");
                      }
                      conn.close();
                      rs.close();
                      stmt.close();
              %>
    </table>
  </body>
</html>
