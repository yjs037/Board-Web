<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt"%>
<%@include file="../includes/header.jsp"%>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800">Board Read</h1>
<hr>
<!-- DataTales Example -->
<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">Board Read</h6>
	</div>
	
	<div class="card-body">
	
			<div class = "form-group">
					<label>글번호</label>
					<input class = "form-control" name = "bno" value = "<c:out value = "${board.bno}"/>" readonly = "readonly"/>
				</div>
				
				<div class = "form-group">
					<label>제목</label>
					<input class = "form-control" name = "title" value = "<c:out value = "${board.title}"/>" readonly = "readonly"/>
				</div>
				
				<div class = "form-group">
					<label>내용</label>
					<textarea class = "form-control" rows = "6" name = "content" readonly = "readonly"><c:out value = "${board.content}"/></textarea>
				</div>

				<div class = "form-group">
					<label>작성자</label>
					<input class = "form-control" name = "writer" value = "<c:out value = "${board.content}"/>" readonly = "readonly"/>
				</div>
				
				<button data-oper = 'modify' class = "btn btn-secondary btn-icon-split">수정</button>
				<button data-oper = 'list' class = "btn btn-secondary btn-icon-split">목록</button>
				
				<form id = 'operForm' action = "/board/modify" method = "get">
						<input type = "hidden" id = "pageNum" name = "pageNum" value = '<c:out value = "${cri.pageNum}"/>'>
						<input type = "hidden" id = "amount" name = "amount" value = '<c:out value = "${cri.amount}"/>'>
						<input type = "hidden" id = "bno" name = "bno" value = '<c:out value = "${board.bno}"/>'>
						<input type = "hidden" id = "keyword" name = "keyword" value = '<c:out value = "${cri.keyword}"/>'>
						<input type = "hidden" id = "type" name = "type" value = '<c:out value = "${cri.type}"/>'>
				</form>
		
	</div>
	
</div><!-- end card shadow mb-4 -->
<script type = "text/javascript" src = "/resources/js/reply.js"></script>
<script type = "text/javascript">
$(document).ready(function(){
	
	let operForm = $("#operForm");
	
	$("button[data-oper = 'modify']").on("click", function(e){
		
		operForm.attr("action", "/board/modify").submit();
	});
	
	$("button[data-oper = 'list']").on("click", function(e){
		
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list")
		operForm.submit();
	});
	
});
</script>
<script type="text/javascript">
$(document).ready(function(){
	
	console.log("===============");
	console.log("JS TEST");
	
	let bnoValue = '<c:out value = "${board.bno}"/>';
	
	replyService.add({reply : "JS TEST", replyer : "tester", bno : bnoValue }, 
		
		function(result){
			alert("RESULT : " + result);
		});
		
	replyService.getList({bno:bnoValue, page:1 },
		
		function(list){
			for(let i = 0, len = list.length||0; i < len; i++){
				console.log(list[i]);
			}
		});	
	
	replyService.remove(24, function(count){
		
		console.log("count : " + count);
		
		if(count === "success") {
			alert("Remove");
		}
	}, function(err){
			alert("Error...");
	});
	
	replyService.update({
		rno : 22,
		bno : bnoValue,
		reply : "Modified Reply...."
	}, function(result){
		
		alert("수정 완료...");		
	});
	
	replyService.get(10, function(data){
		console.log(data);
	});
		
		
});
</script>


<%@include file="../includes/footer.jsp"%>












