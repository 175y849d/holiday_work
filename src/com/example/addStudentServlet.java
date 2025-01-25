package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class addStudentServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/users?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String JDBC_USERNAME = "root"; // 数据库用户名
    private static final String JDBC_PASSWORD = "pddexas0"; // 数据库密码
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 获取用户输入的用户名和密码
        String stuId = request.getParameter("stuId");
        String stuName = request.getParameter("stuName");
        int stuAge = Integer.parseInt(request.getParameter("stuAge"));
        String stuGender = request.getParameter("stuGender");
        String stuNation = request.getParameter("stuNation");
        String stuProvince = request.getParameter("stuProvince");
        String stuMajor = request.getParameter("stuMajor");
        String stuClass = request.getParameter("stuClass");

        if (isStuIdExists(stuId)) {
            response.getWriter().println("<html><body>");
            response.getWriter().println("<p>该学号已存在，请重新输入！</p>");
            // 使用 JavaScript 实现等待 3 秒后重定向
            response.getWriter().println("<script>");
            response.getWriter().println("setTimeout(function() {");
            response.getWriter().println("  window.location.href = 'add_Student.jsp';");
            response.getWriter().println("}, 3000);");
            response.getWriter().println("</script>");
            response.getWriter().println("</body></html>");
        } else {
            if (addStudentInfo(stuId, stuName, stuAge, stuGender, stuNation, stuProvince, stuMajor, stuClass)) {
                response.getWriter().println("<html><body>");
                response.getWriter().println("<p>登记成功!</p>");
                // 使用 JavaScript 实现等待 3 秒后重定向
                response.getWriter().println("<script>");
                response.getWriter().println("setTimeout(function() {");
                response.getWriter().println("  window.location.href = 'main.jsp';");
                response.getWriter().println("}, 3000);");
                response.getWriter().println("</script>");
                response.getWriter().println("</body></html>");
            } else {
                out.println("<html><body>");
                out.println("<h2>登记失败!请稍后再试.</h2>");
                out.println("</body></html>");
            }
        }
    }

    private boolean isStuIdExists(String StuId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            // 加载数据库驱动
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 建立数据库连接
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
            // SQL 查询语句
            String sql = "SELECT * FROM student WHERE 学号 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, StuId);
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

    private boolean addStudentInfo(String stuId, String stuName, int stuAge, String stuGender, String stuNation, String stuProvince, String stuMajor, String stuClass) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            // 加载数据库驱动
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 建立数据库连接
            conn = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD);
            // SQL 插入语句
            String sql = "INSERT INTO student (学号, 姓名, 年龄, 性别, 民族, 省份, 专业, 班级) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, stuId);
            stmt.setString(2, stuName);
            stmt.setInt(3, stuAge);
            stmt.setString(4, stuGender);
            stmt.setString(5, stuNation);
            stmt.setString(6, stuProvince);
            stmt.setString(7, stuMajor);
            stmt.setString(8, stuClass);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}
