<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.ForumService" %>
<%@ page import="model.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Trả lời chủ đề</title>
</head>
<body>
    <%
        // 1. Kiểm tra đăng nhập
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Lấy thông tin chủ đề đang muốn trả lời
        String idStr = request.getParameter("id");
        Topic currentTopic = null;
        try {
            long id = Long.parseLong(idStr);
            currentTopic = ForumService.findTopicById(id);
        } catch (Exception e) {}

        if (currentTopic == null) {
            out.println("Chủ đề không tồn tại!");
            return;
        }
    %>

    <h3>Trả lời cho chủ đề: <%= currentTopic.getTitle() %></h3>

    <form action="ReplyServlet" method="post">
        <input type="hidden" name="topicId" value="<%= currentTopic.getId() %>" />

        <table border="0">
            <tr>
                <td>Tiêu đề:</td>
                <td>
                    <input type="text" name="title" size="50" 
                           value="Re: <%= currentTopic.getTitle() %>" required />
                </td>
            </tr>
            <tr>
                <td valign="top">Nội dung:</td>
                <td>
                    <textarea name="content" rows="10" cols="50" required></textarea>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <button type="submit">Gửi trả lời</button>
                    <button type="button" onclick="history.back()">Hủy bỏ</button>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>