<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="service.ForumService, model.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Trả lời chủ đề</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f4f6f9;
}

.original-topic-info {
	background-color: #e9ecef;
	border-left: 5px solid #0d6efd;
}
</style>
</head>
<body>
	<%
	User currentUser = (User) session.getAttribute("currentUser");
	if (currentUser == null) {
		response.sendRedirect("login.jsp");
		return;
	}

	String idStr = request.getParameter("id");
	Topic currentTopic = null;
	try {
		long id = Long.parseLong(idStr);
		currentTopic = ForumService.findTopicById(id);
	} catch (Exception e) {
	}

	if (currentTopic == null) {
		out.println("<div class='container mt-5 alert alert-danger'>Không tìm thấy chủ đề!</div>");
		return;
	}
	%>

	<div class="container mt-5" style="max-width: 800px;">

		<div class="original-topic-info p-3 mb-4 rounded">
			<small class="text-muted text-uppercase fw-bold">Bạn đang trả
				lời chủ đề:</small>
			<h5 class="mb-0 mt-1 text-primary"><%=currentTopic.getTitle()%></h5>
		</div>

		<div class="card shadow border-0">
			<div class="card-body p-4">
				<h4 class="card-title mb-4">Viết phản hồi của bạn</h4>

				<form action="ReplyServlet" method="post">
					<input type="hidden" name="topicId"
						value="<%=currentTopic.getId()%>" />

					<div class="mb-3">
						<label class="form-label fw-bold">Tiêu đề phản hồi:</label> <input
							type="text" class="form-control bg-light" name="title"
							value="Re: <%=currentTopic.getTitle()%>" required />
					</div>

					<div class="mb-4">
						<label class="form-label fw-bold">Nội dung:</label>
						<textarea class="form-control" name="content" rows="8" required
							autofocus></textarea>
					</div>

					<div class="d-flex justify-content-end">
						<a href="showTopic.jsp?id=<%=currentTopic.getId()%>"
							class="btn btn-outline-secondary me-2">Hủy bỏ</a>
						<button type="submit" class="btn btn-primary px-4">Gửi
							trả lời</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>