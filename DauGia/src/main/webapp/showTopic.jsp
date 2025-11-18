<%@ page import="service.AuctionService, model.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Chi tiết đấu giá</title></head>
<body>
    <% 
        User user = (User) session.getAttribute("currentUser");
        if(user == null) { response.sendRedirect("login.jsp"); return; }

        // Lấy item từ request (nếu có lỗi trả về) hoặc lấy mới từ ID
        AuctionItem item = (AuctionItem) request.getAttribute("item");
        if(item == null) {
             String id = request.getParameter("id");
             AuctionService service = new AuctionService();
             item = service.getAuctionItem(id);
        }
        
        // Tính giá gợi ý (Giá hiện tại + Bước giá)
        double nextPrice = item.getCurrentPrice() + item.getStepPrice();
    %>
    
    <div style="width: 80%; margin: auto;">
        <div style="text-align:right; background-color: #e0ffe0; padding: 5px;">
            Chào <%= user.getUsername() %> | <a href="LogoutServlet">Thoát</a>
        </div>

        <h3><%= item.getDescription() %></h3>
        
        <table border="0" width="100%">
            <tr style="background-color:#00FFFF">
                 <td style="padding: 5px;"><b>Thông tin đấu giá</b></td>
                 <td style="padding: 5px;"><b>Thông tin người bán</b></td>
            </tr>
            <tr>
                <td valign="top" width="60%">
                    <br>
                    Giá hiện tại: <b><%= String.format("%,.0f", item.getCurrentPrice()) %> VNĐ</b><br>
                    Giá khởi điểm: <%= String.format("%,.0f", item.getInitialPrice()) %> VNĐ<br>
                    Bước giá: <%= String.format("%,.0f", item.getStepPrice()) %> VNĐ<br>
                    
                    <hr>
                    
                    <form action="BidServlet" method="post">
                        <input type="hidden" name="itemId" value="<%= item.getId() %>">
                        
                        Giá đặt: 
                        <input type="number" name="bidAmount" value="<%= (long)nextPrice %>"> 
                        <input type="submit" value="Đặt giá">
                    </form>
                    
                    <% if(request.getAttribute("errorMessage") != null) { %>
                        <p style="color:red; font-weight: bold;">
                            <%= request.getAttribute("errorMessage") %>
                        </p>
                    <% } %>
                    
                    <br>
                    <a href="listItems.jsp">Danh sách đấu giá</a>
                </td>
                
                <td valign="top" style="background-color: #f9f9f9; padding: 10px;">
                    Tên tài khoản: <b>mrhuy</b><br>
                    Tên cửa hàng: Đỗ Cao Huy<br>
                    Điện thoại: 0983243936<br>
                    Email: <a href="#">traiitnhs@yahoo.com</a><br>
                    Địa chỉ: A75/6B/24 Phường 2 Quận Tân Bình, Tp.HCM
                </td>
            </tr>
        </table>
    </div>
</body>
</html>