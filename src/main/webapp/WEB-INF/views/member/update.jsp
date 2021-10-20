<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix = "sec" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Register</title>
<style>
	label {	font-weight: bold; }
	
	.id_ok { color : green;	display : none; }
	 
	.id_already {	color : red; display : none;	}
</style>

<!-- Custom fonts for this template-->
<link href="/resources/vendor/fontawesome-free/css/all.min.css"	rel="stylesheet" type="text/css">
<link	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

	<div class="container">

		<div class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body p-0">
				<!-- Nested Row within Card Body -->
				<div class="row">
					<div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
					<div class="col-lg-7">
						<div class="p-5">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
							</div>
							
							<form role = "form" class="user" action = "/member/update" method = "post">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							
								<div class="form-group">
									<label for ="mem_name">이름</label>
									<input type="text" class="form-control form-control-user" value = "<c:out value = "${member.mem_name}"/>" id="mem_name" name = "mem_name" placeholder="Name" autocomplete="off"/>
									<div id = "name_check"></div>
								</div>
								
								<div class="form-group">
									<label for ="mem_id">아이디</label>
									<input type="text" class="form-control form-control-user" value = "<c:out value = "${member.mem_id}"/>" id="mem_id" name = "mem_id" oninput = "checkId()" placeholder="ID" autocomplete="off" readonly = "readonly"/>
								</div>
								
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<label for ="mem_pw">비밀번호</label>
										<input type="password" class="form-control form-control-user" id="mem_pw" name = "mem_pw" placeholder="Password" autocomplete="off" />
										<div id = "pw_check"></div>
									</div>
									<div class="col-sm-6">
										<label for ="mem_pw2">비밀번호 확인</label>
										<input type="password" class="form-control form-control-user" id="mem_pw2" name = "mem_pw2" placeholder="Repeat Password" autocomplete="off"/>
										<div id = "pw2_check"></div>
									</div>
								</div>
								
								<div class="form-group">
									<label for ="mem_birth">생년월일</label>
									<input type="text" class="form-control form-control-user" value = "<c:out value = "${member.mem_birth}"/>"id="mem_birth" name ="mem_birth" placeholder="ex) 19990101" autocomplete="off"/>
									<div id = "birth_check"></div>
								</div>
								
								<div class="form-group">
									<label for ="mem_phone">휴대폰 번호('-'없이 번호만 입력해주세요)</label>
									<input type="text" class="form-control form-control-user" value = "<c:out value = "${member.mem_phone}"/>"  id="mem_phone" name ="mem_phone" placeholder="Phone-Number" autocomplete="off"/>
									<div id = "phone_check"></div>
								</div>
																					
								<button type = "submit" id = "accuontBtn" class="btn btn-primary btn-user btn-block">	수정완료 </button>
								<hr>
							</form>
							
							<form id = "deleteForm" action = "/member/delete" method = "post">
								<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>							
								<input type = "hidden" name = "mem_id" value = "<sec:authentication property = "principal.username"/>">
							</form>
							
							<div class="text-center">
								<a id = "deleteAccountBtn" class="small" href="/">회원탈퇴</a>
							</div>
							
							<div class="text-center">
								<a class="small" href="/board/list">취소</a>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>

	<!-- Bootstrap core JavaScript-->
	<script src="/resources/vendor/jquery/jquery.min.js"></script>
	<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="/resources/js/sb-admin-2.js"></script>
	
	<script type="text/javascript">
	
	$(document).ready(function(){
		
		let csrfHeaderName = "${_csrf.headerName}";
		let csrfTokenValue = "${_csrf.token}";
		
		//Ajax spring security header....
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		
		//정규식
		let name = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/; // 한글 2~4자이내 (특수기호, 공백사용 불가)
		let pw =/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/; // 8~16자 영문 대 소문자, 숫자, 특수문자를 입력하세요.
		let phone = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/; // -를 생략한 전화번호
		
			
		//pw 정규식
		$("#mem_pw").keyup(function(){
			if(pw.test($("#mem_pw").val())) {
				$("#pw_check").text("사용가능한 비밀번호입니다.");
				$("#pw_check").css("color", "green");
			} else {
				$("#pw_check").text("8~16자 영문 대 소문자, 숫자, 특수문자를 입력하세요.");
				$("#pw_check").css("color", "red");
			}
		});
		
		//pw, pw2 패스워드 일치 확인
		$("#mem_pw2").keyup(function(){
			if($("#mem_pw").val() != $(this).val()) {
				$("#pw2_check").text("비밀번호가 일치하지 않습니다.");
				$("#pw2_check").css("color", "red");
			} else {
				$("#pw2_check").text("비밀번호가 일치합니다.");
				$("#pw2_check").css("color", "green");
			}
		});
		+
		
		//name 정규식
		$("#mem_name").keyup(function(){
			if(name.test($("#mem_name").val())) {
				$("#name_check").text("멋진 이름이네요!");
				$("#name_check").css("color", "green");
			} else {
				$("#name_check").text("한글 이름 2~4자 이내로 입력하세요.");
				$("#name_check").css("color", "red");
			}
		});
		
		//phone 정규식
		$("#mem_phone").keyup(function(){
			if(phone.test($("#mem_phone").val())) {
				$("#phone_check").text("");
			} else {
				$("#phone_check").text("휴대폰 번호를 확인하세요.");
				$("#phone_check").css("color", "red");
			}
		});
	 
		//공백확인
		$("#accuontBtn").click(function(){
			if(name.test(($("#mem_name").val())) == "") {
				alert("이름을 입력해주세요.");
				$("#mem_name").focus();
				return false;
				
			} else if (pw.test(($("#mem_pw").val())) == "") {
				alert("비밀번호를 입력해주세요.");
				$("#mem_pw").focus();
				return false;	
			
			} else if (phone.test(($("#mem_phone").val())) == "") {
				alert("전화번호를 입력해주세요.");
				$("#mem_phone").focus();
				return false;
	
			} 				
		});
		
		//회원탈퇴
		$("#deleteAccountBtn").on("click", function(e){
			e.preventDefault();
			let deleteForm = $("#deleteForm");
			deleteForm.submit();
		});
	
	});


	</script>

</body>

</html>