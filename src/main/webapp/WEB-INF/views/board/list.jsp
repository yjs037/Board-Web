<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt"%>
<%@include file="../includes/header.jsp"%>
<style>
	#regBtn {
		float : right;
		text-align: right;
		position : relative;
		height: 30px;
		line-height: 15px;		
	}
	
	#dataTable {
		width : 100%; 
		border-spacing: 0px;
	}

</style>
<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800">Tables</h1>
<hr>
<!-- DataTales Example -->
<div class="card shadow mb-4">
	<div class="card-header py-3 font-weight-bold text-primary">Board List
	<button id = 'regBtn' type = "button" class = "btn btn-primary">Register New Board</button>
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<div id = "dataTable_wrapper" class = "dataTables_wrapper dt-bootstrap4">
				<table class="table table-bordered" id="dataTable">
					<thead>
						<tr>
							<th>#글번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th>#글번호</th>
							<th>제목</th>
							<th>작성자</th>
							
							<th>작성일</th>
							<th>수정일</th>
						</tr>
					</tfoot>
					<tbody>
					<c:forEach items = "${list}" var = "board">
						<tr>
							<td><c:out value = "${board.bno}" /></td>
							<td><a class = "move" href = '<c:out value = "${board.bno }"/>'><c:out value = "${board.title}"/></a></td>
							<td><c:out value = "${board.writer}"/></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value ="${board.reg_date}"/></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value ="${board.update_date}"/></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
						
				<!-- Paging  -->
							
					<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
						<ul class="pagination">
						
							<c:if test = "${pageMaker.prev }">
								<li class="paginate_button page-item previous" id="dataTable_previous">
									<a href="${pageMaker.startPage -1}" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a>
								</li>
							</c:if>
							
							<c:forEach var = "num" begin = "${pageMaker.startPage }" end ="${pageMaker.endPage }">
								<li class = "paginate_button page-item ${pageMaker.cri.pageNum == num ? "active":"" }">
									<a href = "${num }" aria-controls = "dataTable" data-dt-idx = "${num}" tabindex="0" class="page-link">${num}</a>
								</li>
							</c:forEach>
							
							<c:if test = "${pageMaker.next }">
								<li class="paginate_button page-item next" id="dataTable_next">
									<a href="${pageMaker.endPage +1 }" aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">Next</a>
								</li>
							</c:if>
													
						</ul>
					</div>

				<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
							    <h5 class="modal-title" id="exampleModalLabel">Register Success</h5>
							    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
							        <span aria-hidden="true">×</span>
							    </button>
							</div>
							<div class="modal-body">처리되었습니다.</div>
							<div class="modal-footer">
							    <button class="btn btn-secondary" type="button" data-dismiss="modal">확인</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div> <!-- end table-responsive -->
	</div>
</div>
<form id ="actionForm" action = "/board/list" method ="get">
	<input type = "hidden" name = "pageNum" value = "<c:out value = "${pageMaker.cri.pageNum}"/>"/>
	<input type = "hidden" name = "amount" value = "<c:out value = "${pageMaker.cri.amount}"/>"/>
</form>

<script type = "text/javascript">
	$(document).ready(function(){
		
		let result = '<c:out value = "${result}"/>';
		checkModal(result);
		history.replaceState({},null,null);
		
		// 게시글 등록Modal
		function checkModal(result) {
			if (result == '' || history.state) {
				return;
			}
			if (parseInt(result) > 0) {
				$(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다.");
			}
			$("#logoutModal").modal("show");
		}
		
		//게시글 등록버튼
		$("#regBtn").on("click", function(){
				self.location = "/board/register";
		});
		
		let actionForm = $("#actionForm");
		
		$(".paginate_button a").on("click", function(e){
		
			e.preventDefault();
			console.log('click');
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
			
		});
		
		$(".move").on("click", function(e){
			
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
			actionForm.attr("action", "/board/get");
			actionForm.submit();
		});
		
	});
</script>


<%@include file="../includes/footer.jsp"%>





