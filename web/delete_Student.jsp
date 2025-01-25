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
                  String stuId = request.getParameter("stuId");
                  // 建立数据库连接
                  conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
                  // 准备 DELETE 语句
                  String sql = "DELETE FROM student WHERE 学号 = ?";
                  PreparedStatement pstmt = conn.prepareStatement(sql);
                  // 设置参数
                  int studentId = 1; // 假设要删除的学生 ID 为 1
                  pstmt.setString(1, stuId);
                  // 执行 DELETE 语句
                  int rowsAffected = pstmt.executeUpdate();
                  if (rowsAffected > 0) {
                      response.getWriter().println("<html><body>");
                      response.getWriter().println("<p>删除成功!</p>");
                      // 使用 JavaScript 实现等待 3 秒后重定向
                      response.getWriter().println("<script>");
                      response.getWriter().println("setTimeout(function() {");
                      response.getWriter().println("  window.location.href = 'main.jsp';");
                      response.getWriter().println("}, 3000);");
                      response.getWriter().println("</script>");
                      response.getWriter().println("</body></html>");
                      // 重定向到查询页面

                  } else {
                      response.getWriter().println("<html><body>");
                      response.getWriter().println("<p>未能删除!请重试...</p>");
                      // 使用 JavaScript 实现等待 3 秒后重定向
                      response.getWriter().println("<script>");
                      response.getWriter().println("setTimeout(function() {");
                      response.getWriter().println("  window.location.href = 'main.jsp';");
                      response.getWriter().println("}, 3000);");
                      response.getWriter().println("</script>");
                      response.getWriter().println("</body></html>");
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
