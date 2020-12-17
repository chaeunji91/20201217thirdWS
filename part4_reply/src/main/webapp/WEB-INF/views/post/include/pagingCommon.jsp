<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<form id='frmPaging' action='/post/listPost' method="get">
	<button id="btnGotoList" class="btn btn-info">목록</button>
	<input type="hidden" name="boardId" value="${boardId}">
	<input type="hidden" name="pageNum" value="${criteria.pageNum}">
</form>

<script type="text/javascript">
	$(document).ready(function() {
		var frmPaging = $("#frmPaging");
		$("#btnGotoList").on("click", function(e) {
			e.preventDefault();
			frmPaging.submit();
		});
	})
	
</script>