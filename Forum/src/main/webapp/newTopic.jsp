<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tạo chủ đề mới</title>
</head>
<body>
    <% 
        // Chặn truy cập trực tiếp nếu chưa đăng nhập
        if (session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        User u = (User) session.getAttribute("currentUser");
    %>

    <div style="text-align: right;">
        Chào <%= u.getUsername() %> | <a href="listTopics.jsp">Thoát</a>
    </div>

    <h3>Tạo chủ đề mới</h3>

    <form action="NewTopicServlet" method="post">
        <table border="0">
            <tr>
                <td>Tiêu đề:</td>
                <td><input type="text" name="title" size="50" required /></td>
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
                    <button type="submit" name="action" value="post">Gửi</button>
                    
                    <button type="submit" name="action" value="cancel" formnovalidate>Hủy bỏ</button>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>