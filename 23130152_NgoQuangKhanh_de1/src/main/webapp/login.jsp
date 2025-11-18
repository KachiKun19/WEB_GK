<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Đăng nhập SimpleForum</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body class="d-flex align-items-center py-4 bg-body-tertiary"
	style="height: 100vh;">

	<main class="form-signin w-100 m-auto" style="max-width: 330px;">
		<div class="card shadow-sm">
			<div class="card-body p-4">
				<h3 class="text-center mb-3 text-primary">Đăng nhập</h3>

				<p class="text-danger text-center">${error}</p>

				<form action="LoginServlet" method="post">
					<div class="form-floating mb-3">
						<input type="text" class="form-control" id="floatingInput"
							name="username" placeholder="Tên đăng nhập"> <label
							for="floatingInput">Tên đăng nhập</label>
					</div>
					<div class="form-floating mb-3">
						<input type="password" class="form-control" id="floatingPassword"
							name="password" placeholder="Mật khẩu"> <label
							for="floatingPassword">Mật khẩu</label>
					</div>

					<button class="btn btn-primary w-100 py-2" type="submit">Đăng
						nhập ngay</button>
				</form>
			</div>
		</div>
	</main>
</body>
</html>