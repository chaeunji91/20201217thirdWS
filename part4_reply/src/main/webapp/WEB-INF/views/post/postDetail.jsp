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
	<h1 class="h3 mb-2 text-gray-800">게시글 상세 조회</h1>

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-body">
			<%@include file="./include/postCommon.jsp"%>

			<!-- data : 요소에 추가적으로 변수와 정보를 마음대로 넣을 수 있는 장치. *** 주의사항:웹은 대소문자 구분 없어 -->
			<button id="modify" data-id="${post.id}" class="btn btn-default">수정</button>
			<%@include file="./include/pagingCommon.jsp"%>
		</div>
	</div>
	
	<!-- 댓글 목록 표시 구간 -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-comments fa-fw">Reply</i>
					<button id="btnAddReply" class="btn btn-primary btn-xs fa-pull-right">댓글달기</button>
				</div>
				<div class="panel-body">
					<ul id="listReply">
						<!-- 프로그램에서 처리 "", 스타일 처리 ''  -->
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- End of 댓글 목록 표시 구간 -->
</div>
<!-- /.container-fluid -->
<!-- 댓글 입력 모달창 -->
<div id="modalReply" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

	<div class="modal-dialog">
			<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
					</div> <!-- End of modal-header -->
					<div class="modal-body">
						<div class="form-group">
							<label>Reply</label> 
							<input class="form-control" name='reply' value='New Reply!!!!'>
						</div>
						<div class="form-group">
							<label>Replyer</label> 
							<input class="form-control" name='replyer' value='replyer'>
						</div>
						<div class="form-group">
							<label>Reply Date</label> 
							<input class="form-control" name='replyDate' value=''>
						</div>
					</div> <!-- End of modal-body -->
					<div class="modal-footer">
						<button id="btnModifyReply" class="btn btn-warning" type="button">Modify</button>
						<button id="btnRemoveReply" class="btn btn-danger" type="button">Remove</button>
						<button id="btnRegisterReply" class="btn btn-primary" type="button" data-dismiss="modal">Register</button>
						<button id="btnCloseReply" class="btn btn-default" type="button" data-dismiss="modal">Close</button>
					</div> <!-- End of modal-footer -->
			</div> <!-- End of modal-content -->
	</div> <!-- End of modal-dialog -->
	
</div>

<!-- End of 댓글 입력 모달창 -->
<%@include file="../includes/footer.jsp"%>
<script type="text/javascript" src="\resources\js\util\dateGapDisplayService.js"></script>
<script type="text/javascript">

<script type="text/javascript">
	$(document).ready(function() {
		//create read update
		setOprationMode("read");

		var frmPaging = $("#frmPaging");
		$("#modify").on("click", function(e) {
			e.preventDefault();

			frmPaging.append("<input type='hidden' name='id' value='" + $(this).data("id") + "'>");
			frmPaging.attr("action", "/post/modifyPost");
			frmPaging.submit();
		});
		/** 댓글 목록 조회 및 출력 영역 */
		var originalId = "${post.id}";
		var listReplyUL = $("#listReply");
		showReplyList(1);
		
		function showReplyList(pageNum) {
			replyService.listReply(
				{originalId:originalId, page:(pageNum || 1)},
				function(listReply){
					var strReplyLi = "";
					for (var i = 0, len = listReply.length || 0; i < len; i++) {
						strReplyLi += "<li class='left clearfix' data-id='" + listReply[i].id + "'>";
						strReplyLi += "<div><div class='header'><strong class='primary-font'>" 
							+ listReply[i].writer.name + "</strong>";
						strReplyLi += "<small class='pull-right text-muted'>" 
							+ dataGapDisplayService.displayTime(listReply[i].updateDate) 
							+ "</small></div>";
						strReplyLi += "<p>" + listReply[i].content + "</p></div></li>";
					}
					listReplyUL.html(strReplyLi);
				},
				function(erMsg){
					alert(erMsg);
				}
			);
		}
		
		/** 댓글 관련 이벤트 처리 영역 */
		var modalReply = $("#modalReply");
		var replyDate = modalReply.find("input[name='replyDate']");
		
		var btnModifyReply = $("#btnModifyReply");
		var btnRemoveReply = $("#btnRemoveReply");
		var btnRegisterReply = $("#modalReply");
		var btnCloseReply = $("#modalReply");
	
		$("#btnAddReply").on("click", function(e) {
			e.preventDefault();
			//신규 댓글 모달창 띄우기 전에 기존에 입력된 값 청소
			modalReply.find("input").val("");
			//신규 댓글 등록시 작성 일자는 현재 시간이 db에서 자동으로 채워지니까 입력받을 필요는 없지요
			replyDate.closest("div").hide();
			
			btnModifyReply.hide(); 
			btnRemoveReply.hide(); 
			btnRegisterReply.show(); 
			btnCloseReply.show();  

			modalReply.modal("show");			
		});
		
	})
</script>

<script type="text/javascript" src="\resources\js\reply\replyService.js"></script>
<script type="text/javascript">
	var originalId = "${post.id}";

	replyService.showReply(
			3,
			function(reply){
				alert(reply);
			},
			function(erMsg){
				alert(erMsg);
			}
		);
	
	replyService.updateReply(
		{id:3, content:"프로그램으로 자동 변경하기"},
		function(result){
			alert(result);
		},
		function(erMsg){
			alert(erMsg);
		}
	);
		
</script>
