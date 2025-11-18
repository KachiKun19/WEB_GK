<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="service.ForumService, model.*, java.util.List, java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<title>Diễn đàn sinh viên</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<%
	User currentUser = (User) session.getAttribute("currentUser");
	%>

	<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
		<div class="container">
			<a class="navbar-brand" href="listTopics.jsp">Simple<b>Forum</b></a>
			<div class="d-flex text-white">
				<%
				if (currentUser != null) {
				%>
				<span class="me-3 align-self-center">Xin chào, <b><%=currentUser.getUsername()%></b></span>
				<a href="LoginServlet?action=logout"
					class="btn btn-outline-light btn-sm">Thoát</a>
				<%
				} else {
				%>
				<a href="login.jsp" class="btn btn-light btn-sm">Đăng nhập</a>
				<%
				}
				%>
			</div>
		</div>
	</nav>

	<div class="container">
		<div class="d-flex justify-content-between align-items-center mb-3">
			<h2>  Chuyện học phí & Hỗ trợ</h2>
			<%
			if (currentUser != null) {
			%>
			<a href="newTopic.jsp" class="btn btn-success">+ Gửi bài mới</a>
			<%
			}
			%>
		</div>

		<div class="card shadow-sm">
			<table class="table table-hover mb-0">
				<thead class="table-light">
					<tr>
						<th style="width: 70%">Chủ đề</th>
						<th class="text-center">Phản hồi</th>
					</tr>
				</thead>
				<tbody>
					<%
					List<Topic> topics = ForumService.getTopics();
					SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
					for (Topic t : topics) {
						Message lastMsg = t.getNewMessage();
					%>
					<tr>
						<td><a href="showTopic.jsp?id=<%=t.getId()%>"
							class="text-decoration-none fw-bold fs-5"> <%=t.getTitle()%>
						</a>
							<div class="text-muted small mt-1">
								Đăng bởi: <b><%=t.getCreator().getUsername()%></b> <span
									class="mx-1">•</span>
								<%=sdf.format(t.getCreatedTime())%>
							</div></td>
						<td class="text-center align-middle"><span
							class="badge bg-secondary rounded-pill"><%=t.getReplyCount()%></span>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>