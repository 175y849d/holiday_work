package com.example;
import jakarta.servlet.http.HttpServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.*;
import java.sql.*;
public class deleteStudentServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/users?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String JDBC_USERNAME = "root"; // 数据库用户名
    private static final String JDBC_PASSWORD = "pddexas0"; // 数据库密码
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{

    }
}
