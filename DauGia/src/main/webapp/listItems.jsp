<%@ page import="service.AuctionService, model.*, java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Danh sách đấu giá</title></head>
<body>
    <% 
        // Kiểm tra session
        User user = (User) session.getAttribute("currentUser");
        if(user == null) { response.sendRedirect("login.jsp"); return; }
    %>
    
    <div style="width: 80%; margin: auto;">
        <div style="text-align:right; background-color: #e0ffe0; padding: 5px;">
            Chào mừng <b><%= user.getUsername() %></b> | <a href="LogoutServlet">Thoát</a>
        </div>

        <h3>Danh mục các mặt hàng đấu giá</h3>
        <table border="1" width="100%" cellspacing="0" cellpadding="5">
            <tr style="background-color:#00FFFF">
                <th>Mặt hàng</th>
                <th>Giá</th>
            </tr>
            <% 
                AuctionService service = new AuctionService();
                List<AuctionItem> list = service.getAllAuctionItems();
                for(AuctionItem item : list) {
            %>
            <tr>
                <td>
                    <a href="showTopic.jsp?id=<%= item.getId() %>" style="text-decoration: none; color: blue;">
                        <%= item.getDescription() %>
                    </a>
                </td>
                <td>
                    Giá khởi đầu: <%= String.format("%,.0f", item.getInitialPrice()) %> VNĐ<br>
                    <% if(item.getBidCount() > 0) { %>
                        Giá hiện tại: <b><%= String.format("%,.0f", item.getCurrentPrice()) %> VNĐ</b><br>
                        <span style="color:gray">(<%= item.getBidCount() %> lời đặt giá)</span>
                    <% } else { %>
                        <span style="color:gray">(Chưa có lời đặt giá nào)</span>
                    <% } %>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
</body>
</html>