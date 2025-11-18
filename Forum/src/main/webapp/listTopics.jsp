<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.ForumService" %>
<%@ page import="model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <title>Danh sách chủ đề</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <%
        // Kiểm tra session để xem người dùng đã đăng nhập chưa
        User currentUser = (User) session.getAttribute("currentUser");
        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy hh:mm a");
    %>

    <div style="text-align: right;">
        <% if (currentUser != null) { %>
            Chào <%= currentUser.getUsername() %> | <a href="LoginServlet?action=logout">Thoát</a>
        <% } else { %>
            <a href="login.jsp">Đăng nhập</a>
        <% } %>
    </div>

    <h3>Diễn đàn: Chuyện học phí và các chính sách hỗ trợ học tập</h3>

    <% if (currentUser != null) { %>
        <button onclick="window.location.href='newTopic.jsp'">Gửi bài mới</button>
    <% } %>

    <br/><br/>

    <table>
        <tr>
            <th>Chủ đề</th>
            <th>Hồi âm</th>
        </tr>
        <%
            List<Topic> topics = ForumService.getTopics();
            for (Topic t : topics) {
                Message lastMsg = t.getNewMessage(); // Bài mới nhất (nếu có)
        %>
        <tr>
            <td>
                <a href="showTopic.jsp?id=<%= t.getCreatedTime().getTime() %>">
                    <%= t.getTitle() %>
                </a>
                <br/>
                <small>
                    Bài mới nhất bởi: 
                    <%= (lastMsg != null) ? lastMsg.getCreator().getUsername() : t.getCreator().getUsername() %>, 
                    <%= sdf.format((lastMsg != null) ? lastMsg.getCreatedTime() : t.getCreatedTime()) %>
                </small>
            </td>
            <td><%= t.getReplyCount() %></td>
        </tr>
        <% } %>
    </table>
</body>
</html>