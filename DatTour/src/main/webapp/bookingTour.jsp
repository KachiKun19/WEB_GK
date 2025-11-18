<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.TourService, model.Tour" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt Tour</title>
    <style>
        body { font-family: Arial, sans-serif; width: 60%; margin: 20px auto; border: 1px solid #ccc; padding: 20px; box-shadow: 2px 2px 10px #aaa; }
        .row { margin-bottom: 15px; display: flex; }
        .label { width: 150px; font-weight: bold; }
        input[type="text"], input[type="email"], input[type="date"], input[type="number"] { flex: 1; padding: 5px; }
        .btn-group { text-align: center; margin-top: 20px; }
        h3 { text-align: center; }
    </style>
</head>
<body>
    <%
        String idStr = request.getParameter("id");
        Tour t = null;
        if (idStr != null) {
            TourService service = new TourService();
            t = service.getTour(Long.parseLong(idStr));
        }
    %>
    
    <% if (t != null) { %>
    <form action="confirm.jsp" method="post">
        <input type="hidden" name="tourId" value="<%= t.getId() %>">

        <h3>Đặt tour: <%= t.getDescription() %> <%= t.getDays() %></h3>
        
        <h4>Thông tin khách hàng</h4>
        <div class="row"><span class="label">Họ tên: (*)</span> <input type="text" name="hoten" required></div>
        <div class="row"><span class="label">Địa chỉ:</span> <input type="text" name="diachi"></div>
        <div class="row"><span class="label">E-mail: (*)</span> <input type="email" name="email" required></div>
        <div class="row"><span class="label">Điện thoại:</span> <input type="text" name="dienthoai"></div>

        <h4>Thông tin chuyến đi:</h4>
        <div class="row"><span class="label">Ngày khởi hành: (*)</span> <input type="date" name="ngaykhoihanh" required></div>
        <div class="row"><span class="label">Số người lớn: (*)</span> <input type="number" name="nguoilon" value="1" min="1" required></div>
        <div class="row"><span class="label">Số trẻ em:</span> <input type="number" name="treem" value="0" min="0"></div>

        <div class="btn-group">
            <input type="submit" value="Gửi" style="padding: 5px 20px;">
            <input type="button" value="Hủy" onclick="window.location.href='listTours.jsp'" style="padding: 5px 20px;">
        </div>
    </form>
    <% } else { out.print("Không tìm thấy thông tin tour."); } %>
</body>
</html>