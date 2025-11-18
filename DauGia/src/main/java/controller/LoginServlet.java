package controller;

import model.User;
import service.AuctionService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private AuctionService service = new AuctionService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String u = request.getParameter("username");
        String p = request.getParameter("password");

        User user = service.authenticateUser(u, p);

        if (user != null) {
            // Đăng nhập thành công -> Lưu vào Session
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            response.sendRedirect("listItems.jsp");
        } else {
            // Thất bại -> Quay lại login và báo lỗi
            request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}