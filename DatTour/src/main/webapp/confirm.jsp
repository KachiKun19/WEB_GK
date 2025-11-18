<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.TourService" %>
<%@ page import="model.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Xác nhận</title>
    <style>body { font-family: Arial, sans-serif; width: 60%; margin: 20px auto; text-align: center; }</style>
</head>
<body>
    <%
        // 1. Thiết lập mã hóa UTF-8 để nhận tiếng Việt
        request.setCharacterEncoding("UTF-8");

        // 2. Lấy dữ liệu từ form bookingTour.jsp
        try {
            String tourIdStr = request.getParameter("tourId");
            String hoTen = request.getParameter("hoten");
            String diaChi = request.getParameter("diachi");
            String email = request.getParameter("email");
            String dienThoai = request.getParameter("dienthoai");
            
            String ngayKhoiHanhStr = request.getParameter("ngaykhoihanh"); // Format yyyy-MM-dd
            int nguoilon = Integer.parseInt(request.getParameter("nguoilon"));
            int treem = Integer.parseInt(request.getParameter("treem"));

            // 3. Xử lý Logic với Service (Model)
            TourService service = new TourService();
            Tour tour = service.getTour(Long.parseLong(tourIdStr));

            // Tạo đối tượng Customer và lưu
            long newCustId = System.currentTimeMillis(); // Tạo ID ngẫu nhiên
            Customer cus = new Customer(newCustId, hoTen, diaChi, email, dienThoai);
            service.saveCustomer(cus);

            // Xử lý ngày tháng
            SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat sdfOutput = new SimpleDateFormat("dd/MM/yyyy");
            Date deptDate = sdfInput.parse(ngayKhoiHanhStr);

            // Tạo đối tượng Booking và lưu
            long newBookingId = System.currentTimeMillis() + 1;
            Booking booking = new Booking(newBookingId, cus, tour, deptDate, nguoilon, treem);
            service.saveBooking(booking);

            // 4. Hiển thị thông tin xác nhận (View)
    %>
            <h2 style="color: green;">ĐẶT TOUR THÀNH CÔNG!</h2>
            <p>Hệ thống đã ghi nhận thông tin của quý khách.</p>
            
            <div style="border: 1px solid green; padding: 20px; text-align: left; display: inline-block;">
                <h3>Thông tin khách hàng</h3>
                <ul>
                    <li>Họ tên: <b><%= cus.getName() %></b></li>
                    <li>Email: <%= cus.getEmail() %></li>
                    <li>Điện thoại: <%= cus.getPhone() %></li>
                </ul>

                <h3>Thông tin Tour</h3>
                <ul>
                    <li>Tour: <b><%= tour.getDescription() %></b></li>
                    <li>Ngày khởi hành: <%= sdfOutput.format(booking.getDepartureDate()) %></li>
                    <li>Số khách: <%= booking.getNoAdults() %> Người lớn, <%= booking.getNoChildren() %> Trẻ em</li>
                </ul>
            </div>
            <br><br>
            <form action="listTours.jsp">
                <input type="submit" value="Về trang chủ" style="padding: 10px 20px; cursor: pointer;">
            </form>

    <%
        } catch (Exception e) {
            out.print("<h3 style='color:red'>Có lỗi xảy ra: " + e.getMessage() + "</h3>");
            e.printStackTrace();
        }
    %>
</body>
</html>