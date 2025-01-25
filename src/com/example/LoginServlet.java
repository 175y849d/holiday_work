package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class LoginServlet extends HttpServlet{
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/users?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String JDBC_USERNAME = "root"; // 数据库用户名
    private static final String JDBC_PASSWORD = "pddexas0"; // 数据库密码
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 获取用户输入的用户名和密码
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if (isUsernameOrPasswordExists(username, password)) {
//            response.getWriter().println("<html><body>");
//            response.getWriter().println("<p>登录成功,正在进入主页面,请稍等...</p>");
//            // 使用 JavaScript 实现等待 3 秒后重定向
//            response.getWriter().println("<script>");
//            response.getWriter().println("setTimeout(function() {");
//            response.getWriter().println("  window.location.href = 'main.jsp';");
//            response.getWriter().println("}, 3000);");
//            response.getWriter().println("</script>");
//            response.getWriter().println("</body></html>");
             HttpSession session = request.getSession();
             session.setAttribute("username", username);

            // 重定向到另一个 JSP 页面
             response.sendRedirect("main.jsp");

        } else {
            response.getWriter().println("<html><body>");
            response.getWriter().println("<p>登录失败,账户或密码错误,请重新输入...</p>");
            // 使用 JavaScript 实现等待 3 秒后重定向
            response.getWriter().println("<script>");
            response.getWriter().println("setTimeout(function() {");
            response.getWriter().println("  window.location.href = 'login.jsp';");
            response.getWriter().println("}, 3000);");
            response.getWriter().println("</script>");
            response.getWriter().println("</body></html>");
        }

    }
    private boolean isUsernameOrPasswordExists(String username,String password) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            // 加载数据库驱动
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 建立数据库连接
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
            // SQL 查询语句
            String sql = "SELECT * FROM admin WHERE 账户 = ? and 密码 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            rs = stmt.executeQuery();
            return rs.next();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
