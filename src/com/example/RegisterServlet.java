package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

////@WebServlet("/login") // Servlet 的 URL 映射
//public class RegisterServlet extends HttpServlet {
//
//    // MySQL 数据库连接配置
//    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/users?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
//    private static final String JDBC_USERNAME = "root"; // 数据库用户名
//    private static final String JDBC_PASSWORD = "pddexas0"; // 数据库密码
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//
//        // 获取表单提交的数据
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//
//        PrintWriter out = response.getWriter();
//
//        try {
//            // 加载 MySQL JDBC 驱动
//            Class.forName("com.mysql.cj.jdbc.Driver");
//
//            // 创建数据库连接
//            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
//
//            // 插入数据的 SQL 语句
//            String sql = "INSERT INTO admin (账户, 密码) VALUES (?, ?)";
//            PreparedStatement stmt = conn.prepareStatement(sql);
//            stmt.setString(1, username);
//            stmt.setString(2, password);
//
//            int rows = stmt.executeUpdate(); // 执行插入操作
//            if (rows > 0) {
//                out.println("admin:" + username);
//            } else {
//                out.println("<h3>注册失败，请重试。</h3>");
//            }
//
//            // 关闭资源
//            stmt.close();
//            conn.close();
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            out.println("<h3>发生错误：" + e.getMessage() + "</h3>");
//        }
//    }
//}

//import javax.servlet.*;
//import javax.servlet.http.*;
//import java.io.*;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.lang.*;

public class RegisterServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/users?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String JDBC_USERNAME = "root"; // 数据库用户名
    private static final String JDBC_PASSWORD = "pddexas0"; // 数据库密码
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 获取用户输入的用户名和密码
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (isUsernameExists(username)) {
            response.getWriter().println("<html><body>");
            response.getWriter().println("<p>该账户名已被注册过啦,即将跳转注册页面，请稍等...</p>");
            // 使用 JavaScript 实现等待 3 秒后重定向
            response.getWriter().println("<script>");
            response.getWriter().println("setTimeout(function() {");
            response.getWriter().println("  window.location.href = 'register.jsp';");
            response.getWriter().println("}, 3000);");
            response.getWriter().println("</script>");
            response.getWriter().println("</body></html>");
        } else {
            if (registerUser(username, password)) {
                response.getWriter().println("<html><body>");
                response.getWriter().println("<p>注册成功，即将跳转登录页面，请稍等...</p>");
                // 使用 JavaScript 实现等待 3 秒后重定向
                response.getWriter().println("<script>");
                response.getWriter().println("setTimeout(function() {");
                response.getWriter().println("  window.location.href = 'login.jsp';");
                response.getWriter().println("}, 3000);");
                response.getWriter().println("</script>");
                response.getWriter().println("</body></html>");
            } else {
                out.println("<html><body>");
                out.println("<h2>注册失败，请稍后再试。</h2>");
                out.println("</body></html>");
            }
        }
    }

    private boolean isUsernameExists(String username) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            // 加载数据库驱动
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 建立数据库连接
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
            // SQL 查询语句
            String sql = "SELECT * FROM admin WHERE 账户 = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
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

    private boolean registerUser(String username, String password) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            // 加载数据库驱动
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 建立数据库连接
            conn = DriverManager.getConnection(JDBC_URL,JDBC_USERNAME,JDBC_PASSWORD);
            // SQL 插入语句
            String sql = "INSERT INTO admin (账户, 密码) VALUES (?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
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

