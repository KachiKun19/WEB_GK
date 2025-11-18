<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.TourService, model.Tour" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết Tour</title>
    <style>body { font-family: Arial, sans-serif; width: 80%; margin: 20px auto; }</style>
</head>
<body>
    <%
        String idStr = request.getParameter("id");
        if (idStr != null) {
            TourService service = new TourService();
            Tour t = service.getTour(Long.parseLong(idStr));
            if (t != null) {
    %>
        <h2 style="color: #b22222;"><%= t.getDescription() %></h2>
        <p>
            <b>Số ngày:</b> <%= t.getDays() %>. 
            <b>Phương tiện:</b> <%= t.getTransportation() %>. 
            <b>Lịch khởi hành:</b> <%= t.getDepartureSchedule() %>
        </p>
        <hr>
        <h3>Chương trình chi tiết:</h3>
        <p style="line-height: 1.6; text-align: justify;"><%= t.getDetailItinerary() %></p>
        
        <br>
        <a href="bookingTour.jsp?id=<%= t.getId() %>"><button style="padding: 10px 20px; background: blue; color: white; border: none; cursor: pointer;">ĐẶT TOUR NGAY</button></a>
        <br><br>
        <a href="listTours.jsp" style="text-decoration: none; color: blue; font-weight: bold;">CHƯƠNG TRÌNH TOUR</a>
    <%
            }
        }
    %>
</body>
</html>