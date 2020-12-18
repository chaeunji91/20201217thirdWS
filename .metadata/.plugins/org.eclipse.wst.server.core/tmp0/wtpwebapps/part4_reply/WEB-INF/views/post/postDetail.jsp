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
				<div id="replyPagination" class="panel-footer">
			
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
			</div>		<!-- End of modal-header -->
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label> 
					<input class="form-control" name='replyContent' value='New Reply!!!!'>
				</div>
				<div class="form-group">
					<label>Replyer</label> 
					<input class="form-control" name='replyer' value='replyer' readonly="readonly">
				</div>
				<div class="form-group">
					<label>Reply Date</label> 
					<input class="form-control" name='replyDate' value=''>
				</div>
			</div>		<!-- End of modal-body -->
			<div class="modal-footer">
				<button id='btnModifyReply' type="button" class="btn btn-warning">Modify</button>
				<button id='btnRemoveReply' type="button" class="btn btn-danger">Remove</button>
				<button id='btnRegisterReply' type="button" class="btn btn-primary">Register</button>
				<button id='btnCloseModal' type="button" class="btn btn-default">Close</button>
			</div>		<!-- End of modal-footer -->
		</div>		<!-- End of modal-content -->
	</div>		<!-- End of modal-dialog -->
</div>

<!-- End of 댓글 입력 모달창 -->
<%@include file="../includes/footer.jsp"%>
<script type="text/javascript" src="\resources\js\util\dateGapDisplayService.js"></script>
<script type="text/javascript" src="\resources\js\reply\replyService.js"></script>
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

		var originalId = "${post.id}";
		var listReplyUL = $("#listReply");
		var replyCurPageNum = 1;
		
		showReplyList(replyCurPageNum, originalId);
			
		//댓글 목록조회 및 출력
		function showReplyList(pageNum, originalId) {
			replyCurPageNum = pageNum;
			replyService.listReply(
				{originalId:originalId, page:(pageNum || 1)},
				function(pairOfCriteriaListReply){
					var listReply = pairOfCriteriaListReply.second;
					//pairOfCriteriaListReply.first.totalDataCount;
					//프레임워크에서 pair구조를 끌어와서, 공지사항에 있던 댓글 수를 카운트해서 보여줌(ReplyController.java에서 조정)
					
					var strReplyLi = "";
					for (var i = 0, len = listReply.length || 0; i < len; i++) {
						strReplyLi += "<li class='left clearfix' data-id='"
							+ listReply[i].id + "'>";
						strReplyLi += "<div><div class='header'><strong class='primary-font'>"
							+ listReply[i].writer.name + "</strong>";
						strReplyLi += "<small class='pull-right text-muted'>"
							+ dateGapDisplayService.displayTime(listReply[i].updateDate) + "</small></div>";
						strReplyLi += "<p>" + listReply[i].content + "</p>";
						if (listReply[i].countOfReply > 0) {
							strReplyLi += "<a href='" + listReply[i].id + "'>댓글 개수는" + listReply[i].countOfReply + "</a>";
						}
						strReplyLi += "</div></li>";
					}
					listReplyUL.html(strReplyLi);
					showReplyPagination(pairOfCriteriaListReply.first);
					//pairOfCriteriaListReply.first.totalDataCount;
					//프레임워크에서 pair구조를 끌어와서, 공지사항에 있던 댓글 수를 카운트해서 보여줌(ReplyController.java에서 조정)
				},
				function(erMsg){
					alert(erMsg);
				}
			);
		}
		
		/** 댓글 관련 이벤트 처리*/
		var modalReply = $("#modalReply");
		var replyDate = modalReply.find("input[name='replyDate']");
		var btnModifyReply = $("#btnModifyReply");
		var btnRemoveReply = $("#btnRemoveReply");
		var btnRegisterReply = $("#btnRegisterReply");
		var btnCloseModal = $("#btnCloseModal");

		//댓글에 대한 상세 조회 할거야(이벤트 위임)
		$("#listReply").on("click", "li", function(e) {
			e.preventDefault();
			var choosenLi = $(this);
			//data-id listReply[i].id
			var replyId = choosenLi.data("id"); 
			replyService.showReply(
				replyId,
				function(reply){
					modalReply.find("input[name='replyContent']").val(reply.content);
					modalReply.find("input[name='replyer']").val(reply.writer.name);
					modalReply.find("input[name='replyDate']")
					.val(dateGapDisplayService.displayTime(reply.updateDate))
					.attr("readonly", "readonly");
					//수정 또는 삭제시 댓글 아이디 전달용도로 사용합니다.
					modalReply.data("id", replyId);

					//버튼 활성화 관리
					btnModifyReply.show();
					btnRemoveReply.show();
					btnRegisterReply.hide();
					btnCloseModal.show();

					modalReply.modal("show");
				},
				function(erMsg){
					alert(erMsg);
				}
			);	
		});
		//등록할 수 있도록 화면 열어 주세요.
		$("#btnAddReply").on("click", function(e) {
			e.preventDefault();
			// 신규 댓글 모달창 띄우기 전에 기존에 입력된 값 청소
			modalReply.find("input").val("");
			// 신규 댓글 등록시 작성일자는 현재 시간이 DB에서 자동으로 채워지기에 입력 받을 필요 없음
			replyDate.closest("div").hide();
			// 버튼 4종류(수정, 삭제, 등록, 닫기) 중 등록으로 뜨면, register close는 show 나머지는 hide
			btnModifyReply.hide();
			btnRemoveReply.hide();
			btnRegisterReply.show();
			btnCloseModal.show();

			modalReply.modal("show");
		});
		btnCloseModal.on("click", function(e) {
			
			modalReply.modal("hide");
			
		});
		//등록 합니다.
		btnRegisterReply.on("click", function(e) {
			e.preventDefault();
			// 자바스크립트에서 객체만들기
			var reply = {originalId:originalId, 
					content:modalReply.find("input[name='replyContent']").val()};
			replyService.registerReply(reply, function(result){
				alert(result);
				modalReply.modal("hide");	
				showReplyList(1, originalId);
			});
		});
		//댓글 수정합니다.
		btnModifyReply.on("click", function(e) {
			e.preventDefault();
			
			var reply = {id:modalReply.data("id"), 
					content:modalReply.find("input[name='replyContent']").val()};
			replyService.updateReply(reply, function(result){
				alert(result);
				modalReply.modal("hide");	
				showReplyList(replyCurPageNum, originalId); 
			});	
		});
		//댓글 삭제 이벤트 처리
		btnRemoveReply.on("click", function(e) {
			e.preventDefault();
		
			replyService.deleteReply(modalReply.data("id"), function(result){
				alert(result);
				modalReply.modal("hide");	
				showReplyList(replyCurPageNum, originalId);
			});	
		});
		/** 댓글 페이징 처리 출력하기 및 이벤트 처리 영역 */
		
		var replyPageFooter = $("#replyPagination");
		function showReplyPagination(criteria) {
			var ulHtml = "<ul class='pagination fa-pull-right'>";
			if (criteria.hasPrev) {
				ulHtml += "<li class='page-item previous'>";
				ulHtml += "<a class='page-link' href='" + (criteria.startPage - 1) + "'>&lt;&lt;</a>";
				ulHtml += "</li>";
			}
			for(var i=criteria.startPage; i<=criteria.endPage; i++) {
				var active = criteria.pageNum == i ? "active" : "";
				ulHtml += "<li class='page-item " + active + "'>";
				ulHtml += "<a class='page-link' href='" + i + "'>" + i + "</a></li>";
			}
			if (criteria.hasNext) {
				ulHtml += "<li class='page-item next'>";
				ulHtml += "<a class='page-link' href='" + (criteria.endPage + 1) + "'>&gt;&gt;</a>";
				ulHtml += "</li>";
			}	
			ulHtml += "</ul>";
			
			replyPageFooter.html(ulHtml);
		}
		//댓글 해당 페이지 클릭에 따른 점프
		replyPageFooter.on("click", "li a", function(e) {
			e.preventDefault();
			var targetPageNum = $(this).attr("href");
			showReplyList(targetPageNum, originalId);
		});
		/** 대댓글 관련 처리 */
		$("#listReply").on("click", "li a", function(e) {
			e.preventDefault();
			var choosenAnchor = $(this);
			var openTargetReplyId= choosenAnchor.attr("href");
			alert(openTargetReplyId);
		});
	})
</script>