package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.*;
import service.ForumService;

@WebServlet("/ReplyServlet")
public class ReplyServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Xử lý font tiếng Việt
        request.setCharacterEncoding("UTF-8");
        
        // 2. Kiểm tra session
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 3. Lấy dữ liệu từ form
        String topicIdStr = request.getParameter("topicId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        try {
            long topicId = Long.parseLong(topicIdStr);
            
            // 4. Tìm chủ đề gốc
            Topic topic = ForumService.findTopicById(topicId);
            
            if (topic != null) {
                // 5. Tạo Message mới (Lớp Message bạn đã có ở các phần trước)
                Message replyMsg = new Message(title, content, currentUser);
                
                // 6. Thêm tin nhắn vào chủ đề
                topic.addMessage(replyMsg);
                
                // 7. Quay lại trang xem chi tiết chủ đề đó
                response.sendRedirect("showTopic.jsp?id=" + topicId);
            } else {
                response.getWriter().print("Lỗi: Không tìm thấy chủ đề để trả lời.");
            }
            
        } catch (NumberFormatException e) {
            response.getWriter().print("Lỗi định dạng ID.");
        }
    }
}