package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import service.ForumService;
import model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String u = request.getParameter("username");
        String p = request.getParameter("password");

        User user = ForumService.checkUser(u, p);

        if (user != null) {
            // Đăng nhập thành công -> Lưu vào Session
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            
            // Chuyển sang trang listTopics.jsp
            response.sendRedirect("listTopics.jsp");
        } else {
            // Thất bại -> Quay lại trang login kèm thông báo lỗi
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    // Xử lý Logout (Thoát)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if("logout".equals(action)){
            HttpSession session = request.getSession();
            session.invalidate(); // Hủy session
            response.sendRedirect("login.jsp");
        }
    }
}