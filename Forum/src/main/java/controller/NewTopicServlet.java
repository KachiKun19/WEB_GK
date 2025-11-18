package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.*;
import service.ForumService;

@WebServlet("/NewTopicServlet")
public class NewTopicServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Quan trọng: Xử lý lỗi font tiếng Việt
        request.setCharacterEncoding("UTF-8");
        
        // 2. Kiểm tra xem người dùng đã đăng nhập chưa?
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        
        if (currentUser == null) {
            // Chưa đăng nhập mà đòi đăng bài -> Đá về trang login
            response.sendRedirect("login.jsp");
            return;
        }

        // 3. Lấy dữ liệu từ Form
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String action = request.getParameter("action"); // Kiểm tra nút bấm là Gửi hay Hủy

        // Nếu người dùng bấm nút "Hủy bỏ"
        if ("cancel".equals(action)) {
            response.sendRedirect("listTopics.jsp");
            return;
        }

        // 4. Tạo Topic mới và lưu
        if (title != null && content != null) {
            // Tạo đối tượng Topic (User lấy từ session)
            Topic newTopic = new Topic(title, content, currentUser);
            
            // Gọi Service để thêm vào danh sách
            ForumService.addTopic(newTopic);
            
            // 5. Thành công -> Quay về trang danh sách
            response.sendRedirect("listTopics.jsp");
        } else {
            // Nếu dữ liệu trống -> Báo lỗi (tùy chọn)
            response.sendRedirect("newTopic.jsp");
        }
    }
}