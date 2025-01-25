<%--
  Created by IntelliJ IDEA.
  User: m1385
  Date: 2025/1/24
  Time: 22:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Title</title>
  </head>
  <body>
          <%
              final String JDBC_URL = "jdbc:mysql://localhost:3306/users?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
              final String JDBC_USERNAME = "root"; // 数据库用户名
              final String JDBC_PASSWORD = "pddexas0";// 数据库密码
              Connection conn = null;
              PreparedStatement stmt = null;
              ResultSet rs;
              try {
                  int stuId = Integer.parseInt(request.getParameter("stuId"));
                  // 建立数据库连接
                  conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
                  // 准备 DELETE 语句
                  String sql = "DELETE FROM student WHERE 学号 = ?";
                  PreparedStatement pstmt = conn.prepareStatement(sql);
                  // 设置参数
                  int studentId = 1; // 假设要删除的学生 ID 为 1
                  pstmt.setInt(1, stuId);
                  // 执行 DELETE 语句
                  int rowsAffected = pstmt.executeUpdate();
                  if (rowsAffected > 0) {
                      out.println("删除成功，受影响的行数: " + rowsAffected);
                  } else {
                      out.println("未找到要删除的记录");
                  }
                  // 关闭资源
                  pstmt.close();
                  conn.close();
              } catch (SQLException e) {
                  e.printStackTrace();
              }
          %>
  </body>
</html>
