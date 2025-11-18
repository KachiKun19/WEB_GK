package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.*;
import service.ForumService;

@WebServlet("/NewTopicServlet")
public class NewTopicServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession();
		User currentUser = (User) session.getAttribute("currentUser");

		if (currentUser == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String action = request.getParameter("action");

		if ("cancel".equals(action)) {
			response.sendRedirect("listTopics.jsp");
			return;
		}

		if (title != null && content != null) {
			Topic newTopic = new Topic(title, content, currentUser);

			ForumService.addTopic(newTopic);

			response.sendRedirect("listTopics.jsp");
		} else {
			response.sendRedirect("newTopic.jsp");
		}
	}
}