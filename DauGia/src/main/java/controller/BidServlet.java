package controller;
import model.User;
import service.AuctionService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/BidServlet")
public class BidServlet extends HttpServlet {
    private AuctionService service = new AuctionService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        // 1. Chặn nếu chưa đăng nhập
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String itemId = request.getParameter("itemId");
        String amountStr = request.getParameter("bidAmount");
        
        try {
            double amount = Double.parseDouble(amountStr);
            
            // 2. Gọi Service để xử lý đặt giá
            boolean success = service.placeBid(user, itemId, amount);

            if (success) {
                // Thành công -> Quay về danh sách
                response.sendRedirect("listItems.jsp");
            } else {
                // Thất bại (giá thấp) -> Quay lại trang chi tiết và báo lỗi
                request.setAttribute("errorMessage", "Giá đặt không hợp lệ! Phải cao hơn giá hiện tại cộng bước giá.");
                // Phải load lại item để hiển thị ở trang showTopic
                request.setAttribute("item", service.getAuctionItem(itemId)); 
                request.getRequestDispatcher("showTopic.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("listItems.jsp");
        }
    }
}