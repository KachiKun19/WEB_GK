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
        request.setCharacterEncoding("UTF-8");

        String u = request.getParameter("username");
        String p = request.getParameter("password");

        if (u == null || u.trim().isEmpty() || p == null || p.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ Tên đăng nhập và Mật khẩu!");

            request.setAttribute("usernameValue", u); 
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        User user = ForumService.checkUser(u, p);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            response.sendRedirect("listTopics.jsp");
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác!");
            request.setAttribute("usernameValue", u);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("logout".equals(action)) {
			HttpSession session = request.getSession();
			session.invalidate();
			response.sendRedirect("login.jsp");
		}
	}
}