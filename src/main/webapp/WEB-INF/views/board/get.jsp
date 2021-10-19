<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix = "sec" %>
<%@include file="../includes/header.jsp"%>
<style>
 .chat {
 	list-style : none;
 	position : relative;
 	margin: 0px auto;
 }

 .pull-right {
  float : right;
 	text-align: right;
 	position : relative;
 	left : -30px;
 }
 
 textarea.autosize {
	min-height: 60px;
	overflow: hidden; 
	overflow-wrap: break-word;
	resize : none;
	border-radius: 6px;
	border-color : rgba(0, 0, 0, 0.1);
	padding: 16px 10px 10px 18px;
 }

 textarea:focus {
 	outline : none;
 }
 
 #addReplyBtn {
 	float : right;
 	text-align: right;
 }

 .modReplyBtn, .removeReplyBtn {
  height : 15px;
 	float : right;
 	position : relative;
 	top : -40px;
 	right : 15px;
 	font-size : 10px;
 	line-height: 1.5px;
 }
 
 .resetBtn, .modBtn {
 	float : right;
 	text-align: right;
 	position : relative;
 	top : -15px;
 	font-size : 13px;
 	color: #3a3b45;
  background-color: #f8f9fc;
  vertical-align: middle;
  border: 1px solid transparent;
  padding: .375rem .75rem;
  line-height: 1.5;
  border-radius: .35rem;
 }
 
 #rHeight {
 	height: 120px;
 }

 .pagination {
	justify-content: flex-end;
 }

 </style>

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
			<input class = "form-control" name = "writer" value = "<c:out value = "${board.writer}"/>" readonly = "readonly"/>
		</div>
		
		<sec:authentication property="principal" var = "pinfo"/>
			
			<sec:authorize access = "isAuthenticated()">
				<c:if test="${pinfo.username eq board.writer }">
					<button data-oper = 'modify' class = "btn btn-secondary btn-icon-split">수정</button>
				</c:if>
			</sec:authorize>
		<button data-oper = 'list' class = "btn btn-secondary btn-icon-split">목록</button>
		
		<form id = 'operForm' action = "/board/modify" method = "get">
				<input type = "hidden" id = "pageNum" name = "pageNum" value = '<c:out value = "${cri.pageNum}"/>'>
				<input type = "hidden" id = "amount" name = "amount" value = '<c:out value = "${cri.amount}"/>'>
				<input type = "hidden" id = "bno" name = "bno" value = '<c:out value = "${board.bno}"/>'>
				<input type = "hidden" id = "keyword" name = "keyword" value = '<c:out value = "${cri.keyword}"/>'>
				<input type = "hidden" id = "type" name = "type" value = '<c:out value = "${cri.type}"/>'>
		</form>
		
	</div>
	
	<div class="card-header py-3">
		<i class = "fa fa-comments fa-fw"></i>Reply
	</div>
	
	<div class = "card-body">
	
		<ul class = "chat">
			<!-- 댓글목록 -->
		
			<li id = "replyList" data-rno = "">
				<!-- 댓글 목록이 들어가는 곳 -->
			
					<div class = "header" data-replyer = "">
						<strong data-rno = ""></strong> <!-- 작성자  -->
						<small class = "pull-right"></small> <!-- 날짜 -->
					</div>
					<p></p> <!-- 댓글 -->
			</li>
		</ul>
		
		<div class="dataTables_paginate paging_simple_numbers chat-footer" id ="dataTable_paginate">
		
		</div>
		
		<div id = "replyBox" class = "reply-insert card shadow mb-4 replyValue">
			<textarea name = "reply" class = "autosize" rows = "1" onkeydown = "resize(this)" onkeyup="resize(this)" placeholder="댓글을 남겨보세요"></textarea>		
		</div>
		<div>
			<button type = "button" id = "addReplyBtn" class = "btn btn-light">등록</button>
		</div>
		
	</div>
	
	<div class = "replyValue">
		<input type = "hidden" name = "replyer" value = "<sec:authentication property = "principal.username"/>"/>
		<input type = "hidden" name = "reply_date" value = ""/>
	</div>
</div><!-- end card shadow mb-4 -->
<script type = "text/javascript" src = "/resources/js/reply.js"></script>
<script type = "text/javascript">
//댓글CRUD
$(document).ready(function(){
	
	let bnoValue = '<c:out value = "${board.bno}"/>';
	let replyUL = $(".chat");
	
	let replyValue = $(".replyValue");	
	let replyText = $("#replyBox");
	
	let addReplyBtn = $("#addReplyBtn");
	let modReplyBtn = $(".modReplyBtn");
	let removeReplyBtn = $(".removeReplyBtn");
	
	let InputReply = replyText.find("textarea[name='reply']");
	let InputReplyer = replyValue.find("input[name='replyer']");
	console.log(InputReplyer.val());
		
	let InputReply_date = replyValue.find("input[name='reply_date']");
	
		
	let csrfHeaderName = "${_csrf.headerName}";
	let csrfTokenValue = "${_csrf.token}";
	
	let replyer = null;
	
	<sec:authorize access = "isAuthenticated()">
		replyer = '<sec:authentication property = "principal.username"/>'
	</sec:authorize>
	
	//Ajax spring security header....
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	showList(1);
	
	//댓글리스트 출력
	function showList(page) {
		
		console.log("show List " + page);
		
		replyService.getList({bno:bnoValue, page:page||1}, function(replyCnt, list) {
			
			console.log("Cnt : " + replyCnt);
			
			if(page == -1){
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);				
				console.log("pageNum " + pageNum);
				return;
			}

			let str = "";
			
			if(list == null || list.length == 0) {
				return;
			}
			
			
			//list만큼 출력
			for (let i =0, len = list.length || 0; i < len; i++) {
								
				str +="<li id = 'replyList"+list[i].rno+"' data-rno = '"+list[i].rno+"'>";
				str +=	"<div id = 'header"+list[i].rno+"' data-replyer = '"+list[i].replyer+"'>";
				str +=		"<strong>"+list[i].replyer+"</strong>";
				str +=	"</div>";
				str +=	"<small id = 'dateValue' class ='pull-right'>"+replyService.displayTime(list[i].reply_date)+"</small></div>";
				str +=	"<p>"+list[i].reply+"</p>";
				str +=	"<button type = 'button' class = 'btn btn-light removeReplyBtn'><small>삭제</small></button>";
				str +=	"<button type = 'button' class = 'btn btn-light modReplyBtn'><small>수정</small></button>";
				str +=	"<hr>";
				str +="</li>";
										
		}//for end
			
		
			replyUL.html(str);
			showReplyPage(replyCnt);
		});// getList end
	}// showList end
		
	//댓글등록
	addReplyBtn.on("click", function(e){
		
		let box = $('#replyBox');

		let reply = {
				
				reply : InputReply.val(),
				replyer : InputReplyer.val(),
				bno : bnoValue				
		};				
		
		replyService.add(reply, function(result){
			
			box.find('textarea').val("");
			showList(-1);

		});		
		
	});
	
	//댓글수정뷰
	$(document).on('click', '.modReplyBtn', function(){
		
		let repliesView = "";
		let rno = $(this).closest("li[data-rno]").attr('data-rno');
		let originalReplyer = $("#header"+rno).closest("div[data-replyer]").attr('data-replyer');
		let replyLI = $("#replyList"+rno);
		
		if(replyer != originalReplyer) {
			alert("자신이 작성한 댓글만 삭제가 가능합니다.");
			return;
		}

		replyService.get(rno, function(r){
			
			let rno = r.rno;
			let replyer = r.replyer;
			let reply_date = replyService.displayTime(r.reply_date);
			let reply = r.reply;
			
			repliesView +=	"<li id='replyList"+rno+"' data-rno='"+rno+"'>";
			repliesView += 		"<div id = 'header"+rno+"' data-replyer = '"+replyer+"'>";
			repliesView +=			"<strong>"+replyer+"</strong>";
			repliesView += 			"<small id='dateValue' class='pull-right'>'"+reply_date+"'</small>";
			repliesView += 		"</div>";
			repliesView +=		"<div id = 'rHeight'>";
			repliesView += 			"<div id = 'replyBox' class = 'reply-insert card shadow mb-4 replyValue'>";
			repliesView +=				"<textarea id = 'reply_content"+rno+"' name = 'reply' class = 'autosize' rows = '1' onkeydown = 'resize(this)' onkeyup='resize(this)' placeholder='댓글을 남겨보세요'>";
			repliesView +=					reply;	
			repliesView +=  			"</textarea>";
			repliesView +=			"</div>";
			repliesView +=			"<div>";
			repliesView +=				"<button type='button' class='btn btn-light resetBtn'><small>취소</small></button>";
			repliesView +=				"<button type='button' class='btn btn-light modBtn'><small>등록</small></button>";
			repliesView +=			"</div>";
			repliesView +=		"</div>";
			repliesView +=	"</li>";
			
			replyLI.replaceWith(repliesView);
			$('#reply_content'+rno).focus();
			
		});		
	});	
	
	//댓글수정버튼
	$(document).on('click', '.modBtn', function(){
		
		let rno = $(this).closest("li[data-rno]").attr('data-rno');
		let content = $('#reply_content'+rno).val();
		let reply = { rno :rno,	reply : content };
		
		replyService.update(reply, function(result){ 
			showList(pageNum);
			
		});
		
	});
	
	//댓글수정취소
	$(document).on('click', '.resetBtn', function(){
		
		showList(pageNum);
		
	});
	
	//댓글삭제
	$(document).on('click', '.removeReplyBtn', function(e){
		
		let rno = $(this).closest("li[data-rno]").attr('data-rno');
		let originalReplyer = $('#header'+rno).closest("div[data-replyer]").attr('data-replyer');
		
		console.log("ori"+originalReplyer);
		console.log("rep"+replyer);
				
		if(replyer != originalReplyer) {
			alert("자신이 작성한 댓글만 삭제가 가능합니다.");
			return;
		}
		
		replyService.remove(rno, originalReplyer, function(result){
			showList(pageNum);	
			
		});
		
	});
	
	let pageNum = 1;
	let replyPageFooter = $(".chat-footer");
	
	//댓글 페이징
	function showReplyPage(replyCnt) {
		
		let endNum = Math.ceil(pageNum / 10.0) * 10.0;
		let startNum = endNum - 9;
		
		let prev = startNum != 1;
		let next = false;
		
		if(endNum * 10 >= replyCnt) {
			endNum = Math.ceil(replyCnt/10.0);
		}
		
		if(endNum * 10 < replyCnt) {
			next = true;
		}
		
		let str = "<ul class='pagination'>";
		
		if(prev) {
			str += "<li class = 'paginate_button page-item previous'><a class = 'page-link' href = '"+(startNum -1)+"'>Previous</a></li>";
		}
		
		for (let i = startNum; i <= endNum; i++) {
			let active = pageNum == i? "active" : "";
			
			str += "<li class = 'paginate_button page-item previous "+active+"'><a class = 'page-link' href = '"+i+"'>"+i+"</a></li>";
		}
		
		if(next) {
			str += "<li class = 'paginate_button page-item next'><a class='page-link' href='"+(endNum +1)+"'>Next</a></li>";
		}
		
		str += "</ul>";
		
		replyPageFooter.html(str);
		
	}
	
	replyPageFooter.on("click", "li a", function(e){
		e.preventDefault();
		console.log("page click");
		
		let targetPageNum = $(this).attr("href");
		console.log("targetPageNum : " + targetPageNum);
		
		pageNum = targetPageNum;
		
		showList(pageNum);
	});
	
	
});
</script>
<script type = "text/javascript">
$(document).ready(function(){
	
	let operForm = $("#operForm");
	
	//조회->수정
	$("button[data-oper = 'modify']").on("click", function(e){
		
		operForm.attr("action", "/board/modify").submit();
	});
	
	//조회->목록
	$("button[data-oper = 'list']").on("click", function(e){
		
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list");
		operForm.submit();
	});
	
});
</script>
 <script>
 	//textarea높이 자동조절
 	function resize(obj) {
 		obj.style.height = "1px";
 		obj.style.height = (12+obj.scrollHeight)+"px"; 		
 	}
 </script>
<%@include file="../includes/footer.jsp"%>