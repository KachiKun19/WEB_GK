<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.ForumService" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <title>Xem chủ đề</title>
    <style>
        .post-container { border: 1px solid #ccc; margin-bottom: 10px; padding: 10px; }
        .header-info { background-color: #eee; padding: 5px; font-size: 0.9em; color: #555; }
        .content { padding: 10px 0; }
    </style>
</head>
<body>
    <%
        // 1. Lấy ID từ URL (ví dụ: showTopic.jsp?id=17319...)
        String idStr = request.getParameter("id");
        Topic topic = null;
        
        if (idStr != null) {
            try {
                long id = Long.parseLong(idStr); // Đổi String sang Long
                topic = ForumService.findTopicById(id); // Gọi hàm vừa sửa ở Bước 1
            } catch (NumberFormatException e) {
                // ID bị lỗi format
            }
        }
        
        // Kiểm tra nếu không tìm thấy topic
        if (topic == null) {
            out.println("<h3>Không tìm thấy chủ đề này! <a href='listTopics.jsp'>Quay lại</a></h3>");
            return; // Dừng xử lý
        }
        
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss a");
    %>

    <a href="listTopics.jsp">Danh sách chủ đề</a>
    <hr/>

    <h3>Chủ đề: <%= topic.getTitle() %></h3>
    <div class="post-container" style="background-color: #f9f9f9;">
        <div class="header-info">
            Gửi bởi: <b><%= topic.getCreator().getUsername() %></b> 
            vào lúc <%= sdf.format(topic.getCreatedTime()) %>
        </div>
        <div class="content">
            <%= topic.getContent() %>
        </div>
        
        <div style="text-align: right;">
            <% if (session.getAttribute("currentUser") != null) { %>
                <a href="replyTopic.jsp?id=<%= topic.getId() %>">Trả lời</a>
            <% } %>
        </div>
    </div>

    <%
        Stack<Message> messages = topic.getMessages();
        // Duyệt danh sách tin nhắn trả lời
        for (Message msg : messages) {
    %>
        <div class="post-container">
            <div class="header-info">
                <b><%= msg.getTitle() %></b> - 
                Gửi bởi: <b><%= msg.getCreator().getUsername() %></b>
                (<%= sdf.format(msg.getCreatedTime()) %>)
            </div>
            <div class="content">
                <%= msg.getContent() %>
            </div>
        </div>
    <% } %>

</body>
</html>