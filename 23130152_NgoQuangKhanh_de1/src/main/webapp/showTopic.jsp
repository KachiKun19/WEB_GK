<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="service.ForumService"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<title>Xem chi tiết chủ đề</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f4f6f9;
}

.topic-card {
	border-top: 4px solid #0d6efd;
}
.reply-card {
	border-left: 4px solid #6c757d;
	background-color: #fff;
} /* Viền xám cho hồi âm */
.avatar-placeholder {
	width: 40px;
	height: 40px;
	background-color: #e9ecef;
	border-radius: 50%;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	font-weight: bold;
}
</style>
</head>
<body>

	<%
	String idParam = request.getParameter("id");
	Topic topic = null;

	if (idParam != null && !idParam.isEmpty()) {
		try {
			long id = Long.parseLong(idParam);
			topic = ForumService.findTopicById(id);
		} catch (NumberFormatException e) {
		}
	}

	User currentUser = (User) session.getAttribute("currentUser");
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy 'lúc' HH:mm");
	%>

	<div class="container my-4" style="max-width: 900px;">

		<div class="mb-3">
			<a href="listTopics.jsp"
				class="btn btn-outline-secondary text-decoration-none"> &larr;
				Quay lại danh sách </a>
		</div>

		<%
		if (topic == null) {
		%>
		<div class="alert alert-danger text-center p-5 shadow-sm">
			<h3>⚠️ Rất tiếc!</h3>
			<p>Chủ đề này không tồn tại hoặc đã bị xóa.</p>
			<a href="listTopics.jsp" class="btn btn-primary mt-2">Về trang
				chủ</a>
		</div>
		<%
		} else {
		%>

		<div class="card shadow mb-4 topic-card">
			<div
				class="card-header bg-white d-flex justify-content-between align-items-center py-3">
				<div class="d-flex align-items-center">
					<div class="avatar-placeholder text-primary me-2">
						<%=topic.getCreator().getUsername().substring(0, 1).toUpperCase()%>
					</div>
					<div>
						<div class="fw-bold text-primary"><%=topic.getCreator().getUsername()%></div>
						<small class="text-muted">Đăng ngày: <%=sdf.format(topic.getCreatedTime())%></small>
					</div>
				</div>
				<span class="badge bg-primary">Chủ đề</span>
			</div>

			<div class="card-body p-4">
				<h2 class="card-title mb-3"><%=topic.getTitle()%></h2>
				<hr class="text-secondary opacity-25">
				<p class="card-text fs-5" style="white-space: pre-wrap;"><%=topic.getContent()%></p>
			</div>

			<%
			if (currentUser != null) {
			%>
			<div class="card-footer bg-light text-end">
				<a href="replyTopic.jsp?id=<%=topic.getId()%>"
					class="btn btn-primary">  Viết trả lời </a>
			</div>
			<%
			} else {
			%>
			<div class="card-footer bg-light text-end">
				<small class="text-muted me-2">Đăng nhập để trả lời</small> <a
					href="login.jsp" class="btn btn-sm btn-outline-primary">Đăng
					nhập</a>
			</div>
			<%
			}
			%>
		</div>

		<%
		if (!topic.getMessages().isEmpty()) {
		%>
		<h5 class="mb-3 ms-2 text-secondary">
			Các phản hồi (<%=topic.getReplyCount()%>)
		</h5>
		<%
		} else {
		%>
		<p class="text-center text-muted fst-italic mt-5">Chưa có phản hồi
			nào. Hãy là người đầu tiên!</p>
		<%
		}
		%>

		<%
		// Duyệt qua Stack tin nhắn để hiển thị
		Stack<Message> messages = topic.getMessages();
		for (Message msg : messages) {
		%>
		<div class="card shadow-sm mb-3 ms-md-5 reply-card">
			<div class="card-body">
				<div class="d-flex justify-content-between mb-2">
					<div class="d-flex align-items-center">
						<div class="avatar-placeholder text-secondary me-2"
							style="width: 32px; height: 32px; font-size: 0.8em;">
							<%=msg.getCreator().getUsername().substring(0, 1).toUpperCase()%>
						</div>
						<div>
							<strong><%=msg.getCreator().getUsername()%></strong> <span
								class="text-muted mx-1">•</span> <small class="text-muted"><%=sdf.format(msg.getCreatedTime())%></small>
						</div>
					</div>
				</div>
				<div class="mt-2">
					<p class="card-text"><%=msg.getContent()%></p>
				</div>
			</div>
		</div>
		<%
		}
		%>

		<%
		} // Kết thúc else (tìm thấy bài)
		%>

	</div>
</body>
</html>