<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.TourService, model.Tour, java.util.List, java.text.NumberFormat, java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách Tour</title>
    <style>
        body { font-family: Arial, sans-serif; width: 80%; margin: 0 auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; text-align: center; font-weight: bold; }
        .price { color: red; font-weight: bold; text-align: right;}
        .book-btn { display: inline-block; background: #007bff; color: #fff; padding: 5px 10px; text-decoration: none; border-radius: 3px; }
        h2 { color: navy; border-bottom: 2px solid navy; padding-bottom: 10px;}
    </style>
</head>
<body>
    <h2>Các Chương trình DU LỊCH</h2>
    <%
        TourService service = new TourService();
        List<Tour> list = service.getAllTours();
        NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
    %>
    <table>
        <tr style="background-color: #ccc;">
            <th>Chương trình</th>
            <th>Lịch Khởi hành</th>
            <th>Giá</th>
            <th>Đặt</th>
        </tr>
        <% for (Tour t : list) { %>
        <tr>
            <td>
                <a href="tourDetails.jsp?id=<%= t.getId() %>" style="font-weight:bold; color:blue; text-decoration:none">
                    <%= t.getDescription() %>
                </a>
                <br>
                <span style="font-size: 0.9em; color: gray;"><%= t.getDays() %></span>
            </td>
            <td><%= t.getDepartureSchedule() %></td>
            <td class="price"><%= nf.format(t.getPrice()) %> VNĐ</td>
            <td style="text-align: center;">
                <a href="bookingTour.jsp?id=<%= t.getId() %>"><img src="https://i.imgur.com/wB7qSjL.png" alt="Đặt tour" height="25"></a>
                </td>
        </tr>
        <% } %>
    </table>
</body>
</html>