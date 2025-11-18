<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Đăng nhập</title></head>
<body>
    <center>
        <div style="width: 400px; border: 1px solid #ccc; padding: 20px;">
            <h2 style="background-color: #00FFFF; margin-top: 0;">Đăng nhập</h2>
            
            <form action="LoginServlet" method="post">
                <% if(request.getAttribute("errorMessage") != null) { %>
                    <p style="color:red; font-style:italic;"><%= request.getAttribute("errorMessage") %></p>
                <% } %>
                
                <table border="0">
                    <tr>
                        <td>Tên đăng nhập:</td>
                        <td><input type="text" name="username" required></td>
                    </tr>
                    <tr>
                        <td>Mật khẩu:</td>
                        <td><input type="password" name="password" required></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br><input type="submit" value="Đăng nhập">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </center>
</body>
</html>