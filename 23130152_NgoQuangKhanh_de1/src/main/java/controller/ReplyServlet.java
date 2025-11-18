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
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String topicIdStr = request.getParameter("topicId");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        try {
            long topicId = Long.parseLong(topicIdStr);
            
            Topic topic = ForumService.findTopicById(topicId);
            
            if (topic != null) {
                Message replyMsg = new Message(title, content, currentUser);
                
                topic.addMessage(replyMsg);

                response.sendRedirect("showTopic.jsp?id=" + topicId);
            } else {
                response.getWriter().print("Lỗi: Không tìm thấy chủ đề để trả lời.");
            }
            
        } catch (NumberFormatException e) {
            response.getWriter().print("Lỗi định dạng ID.");
        }
    }
}