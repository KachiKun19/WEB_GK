<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tạo chủ đề mới</title>	
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; }
    </style>
</head>
<body>
    <% 
        // Kiểm tra đăng nhập
        User u = (User) session.getAttribute("currentUser");
        if (u == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <nav class="navbar navbar-light bg-white shadow-sm mb-4">
        <div class="container">
            <span class="navbar-brand mb-0 h1 text-primary">Simple<b>Forum</b></span>
            <span class="text-muted">Xin chào, <b><%= u.getUsername() %></b></span>
        </div>
    </nav>

    <div class="container" style="max-width: 800px;">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-primary text-white py-3">
                <h4 class="mb-0"> Tạo chủ đề thảo luận mới</h4>
            </div>
            <div class="card-body p-4">
                
                <form action="NewTopicServlet" method="post">
                    <div class="mb-4">
                        <label for="title" class="form-label fw-bold">Tiêu đề bài viết:</label>
                        <input type="text" class="form-control form-control-lg" id="title" name="title" 
                               placeholder="Ví dụ: Hỏi về lịch thi cuối kỳ..." required>
                    </div>

                    <div class="mb-4">
                        <label for="content" class="form-label fw-bold">Nội dung chi tiết:</label>
                        <textarea class="form-control" id="content" name="content" rows="10" 
                                  placeholder="Nhập nội dung thảo luận của bạn tại đây..." required></textarea>
                    </div>

                    <div class="d-flex justify-content-between align-items-center">
                        <a href="listTopics.jsp" class="text-decoration-none text-secondary">
                            &larr; Hủy bỏ & Quay lại
                        </a>
                        <div>
                            <button type="reset" class="btn btn-light me-2 border">Nhập lại</button>
                            <button type="submit" name="action" value="post" class="btn btn-primary px-4">
                                 Đăng bài ngay
                            </button>
                        </div>
                    </div>
                </form>
                
            </div>
        </div>
    </div>
</body>
</html>	