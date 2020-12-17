<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="false"%>
<%@ page import="www.dream.com.framework.display.*"%>
<%@ page import="www.dream.com.board.model.*"%>

<%@include file="../includes/header.jsp"%>

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-2 text-gray-800">Tables</h1>

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-body">
			<div class="table-responsive">

				<form id='frmPaging' action='/post/listPost' method="get">
					<input type="text" name="search" value="${search}">
					<input type="hidden" name="boardId" value="${boardId}">
					<input type="hidden" name="pageNum" value="${criteria.pageNum}">
					<button type="submit" class="btn btn-primary">검색</button>
				</form>

				<button id='btnRegisterPost' type="button" class="btn btn-primary">Register
					New Post</button>
				<table class="table table-bordered" id="dataTable" width="100%"
					cellspacing="0">
					<thead>
						<%=TableDisplayer.displayHeader(PostVO.class)%>
					</thead>
					<tbody>
						<c:forEach var="post" items="${listPost}">
							<tr>
								<td><a class='move2PostDetail' href='${post.id}'>${post.title}</a></td>
								<td>${post.writer.name}</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${post.regDate}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${post.updateDate}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<!-- Pagination -->
				<div class='pull-right'>
					<ul class='pagination'>
						<c:if test="${criteria.hasPrev}">
							<li class="paginate_button previous">
								<a href="${criteria.startPage - 1}">&lt;&lt;</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${criteria.startPage}" end="${criteria.endPage}">
							<li class='paginate_button ${criteria.pageNum == num ? "active" : ""}'>
								<a href="${num}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${criteria.hasNext}">
							<li class="paginate_button next">
								<a href="${criteria.endPage + 1}">&gt;&gt;</a>
							</li>
						</c:if>
					</ul>
				</div>
				<!-- End Pagination -->

				<!-- Modal -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">Modal title</h4>
							</div>
							<div class="modal-body">처리가 완료 되었습니다.</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
								<button type="button" class="btn btn-primary">Save
									changes</button>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->

			</div>
		</div>
	</div>
</div>
<!-- /.container-fluid -->
<%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		var result = '<c:out value="${result}"/>';

		checkModal(result);

		history.replaceState({}, null, null);

		function checkModal(result) {
			if (result === '' || history.state) {
				return;
			}
			$(".modal-body").html("게시글 " + result + "번이 등록되었습니다.");
			$("#myModal").modal("show");
		}

		var frmPaging = $("#frmPaging");

		$("#btnRegisterPost").on("click", function(e) {
			e.preventDefault();
			frmPaging.attr("action", "/post/registerPost");
			frmPaging.submit();
		});

		$(".paginate_button a").on("click", function(e) {
			e.preventDefault();
			$("input[name='pageNum']").val($(this).attr("href"));
			frmPaging.submit();
		});

		$(".move2PostDetail").on("click", function(e) {
			e.preventDefault();
			frmPaging.append("<input type='hidden' name='id' value='" + $(this).attr("href") + "'>");
			frmPaging.attr("action", "/post/postDetail");
			frmPaging.submit();
		});
		
	})
</script>
