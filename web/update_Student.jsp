<%--
  Created by IntelliJ IDEA.
  User: m1385
  Date: 2025/1/24
  Time: 22:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Title</title>
  </head>

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
          String stuName = request.getParameter("stuName");
          int stuAge = 0;
          stuAge = Integer.parseInt(request.getParameter("stuAge"));
          String stuGender = request.getParameter("stuGender");
          String stuNation = request.getParameter("stuNation");
          String stuProvince = request.getParameter("stuProvince");
          String stuMajor = request.getParameter("stuMajor");
          String stuClass = request.getParameter("stuClass");
          // 建立数据库连接
          conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
          // 准备 DELETE 语句
          String sql = "UPDATE student SET 姓名 = ?, 年龄 = ?, 性别 = ?, 民族 = ?, 省份 = ?, 专业 = ?, 班级 = ? WHERE 学号 = ?";
          PreparedStatement pstmt = conn.prepareStatement(sql);
          // 设置参数
          pstmt.setString(1, stuName);
          pstmt.setInt(2, stuAge);
          pstmt.setString(3, stuGender);
          pstmt.setString(4, stuNation);
          pstmt.setString(5, stuProvince);
          pstmt.setString(6, stuMajor);
          pstmt.setString(7, stuClass);
          pstmt.setString(8, stuId);
          // 执行 DELETE 语句
          int rowsAffected = pstmt.executeUpdate();
          if (rowsAffected > 0) {
              response.getWriter().println("<html><body>");
              response.getWriter().println("<p>更新成功！稍后自动跳转到主页...</p>");
              // 使用 JavaScript 实现等待 3 秒后重定向
              response.getWriter().println("<script>");
              response.getWriter().println("setTimeout(function() {");
              response.getWriter().println("  window.location.href = 'main.jsp';");
              response.getWriter().println("}, 3000);");
              response.getWriter().println("</script>");
              response.getWriter().println("</body></html>");
          } else {
              response.getWriter().println("<html><body>");
              response.getWriter().println("<p>更新失败！请检查输入是否正确！</p>");
              // 使用 JavaScript 实现等待 3 秒后重定向
              response.getWriter().println("<script>");
              response.getWriter().println("setTimeout(function() {");
              response.getWriter().println("  window.location.href = 'update_Student1.jsp?stuId=" + stuId + "';");
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
