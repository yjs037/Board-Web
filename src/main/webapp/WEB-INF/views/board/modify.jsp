<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt"%>
<%@include file="../includes/header.jsp"%>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800">Board Modify</h1>
<hr>
<!-- DataTales Example -->
<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">Board Modify</h6>
	</div>
	
	<div class="card-body">
				
		<form role = "form" action = "/board/modify" method = "post">
				
			<input type = "hidden" name ="pageNum" value = "<c:out value = "${cri.pageNum}"/>">		
			<input type = "hidden" name ="amount" value = "<c:out value = "${cri.amount}"/>">		
			<input type = "hidden" id = "keyword" name = "keyword" value = '<c:out value = "${cri.keyword}"/>'>
			<input type = "hidden" id = "type" name = "type" value = '<c:out value = "${cri.type}"/>'>	
		
			<div class = "form-group">
				<label>글번호</label>
				<input class = "form-control" name = "bno" value = "<c:out value = "${board.bno}"/>" readonly = "readonly"/>
			</div>
			
			<div class = "form-group">
				<label>제목</label>
				<input class = "form-control" name = "title" value = "<c:out value = "${board.title}"/>"/>
			</div>
			
			<div class = "form-group">
				<label>내용</label>
				<textarea class = "form-control" rows = "6" name = "content"><c:out value = "${board.content}"/></textarea>
			</div>
	
			<div class = "form-group">
				<label>작성자</label>
				<input class = "form-control" name = "writer" value = "<c:out value = "${board.writer}"/>" readonly = "readonly"/>
			</div>
								
			<button data-oper = 'modify' class = "btn btn-secondary btn-icon-split">수정</button>
			<button data-oper = 'remove' class = "btn btn-danger btn-icon-split">삭제</button>
			<button data-oper = 'list' class = "btn btn-primary btn-icon-split">목록</button>
			
		</form>

	</div>
	
</div><!-- end card shadow mb-4 -->
<script type="text/javascript">
	$(document).ready(function(){
		
		let formObj = $("form");
		
		//data- 속성에따라 수정, 삭제, 목록
		$('button').on("click", function(e){
			e.preventDefault();
			
			let operation = $(this).data("oper");
			
			if(operation == 'remove') {
				formObj.attr("action", "/board/remove");
								
			} else if (operation == 'list') {
				formObj.attr("action", "/board/list").attr("method", "get");
				
				let pageNumTag = $("input[name='pageNum']").clone();
				let amountTag = $("input[name='amount']").clone();
				let keywordTag = $("input[name='keyword']").clone();
				let typeTag = $("input[name='type']").clone();
				
				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
			}
			formObj.submit();
			
		});
		
		
	});
</script>


<%@include file="../includes/footer.jsp"%>


















