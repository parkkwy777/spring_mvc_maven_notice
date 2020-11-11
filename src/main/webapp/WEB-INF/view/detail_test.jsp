<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="/webjars/bootstrap/4.5.2/css/bootstrap.min.css" />
<style>
#content {
	border: solid red;
	height: 500px;
	margin-bottom: 10px;
}

#titleDiv {
	margin-bottom: 50px;
}

.cloking {
	display: none;
}
</style>
<script src="/webjars/jquery/3.2.1/dist/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
	
	/* 	$(".inReple").click(function(){ */
		
		 $(document).on("click",".inReple",function(){
            // 동적으로 여러 태그가 생성된 경우라면 이런식으로 클릭된 객체를 this 키워드를 이용해서 잡아올 수 있다.
			 var no=${detail.no};
				$("[name=no]").val(no);
				
			var index= $(".inReple").index(this);

			var r_writer=$("[name=r_writer]").eq(index).val();
			var r_etc=$("[name=r_etc]").eq(index).val();
		

			if(r_writer==null||r_writer==""){
				alert("아이디 입력하세요");
				/* //동적으로 생성된 요소에 접근하기위해 document로 접근, 인덱스도 현재 클릭한 
				//인덱스로 처리
				$(document).find("[name=r_writer]").eq(index).focus(); */
				$("[name=r_writer]").eq(index).focus();
			}
			else if(r_etc==null||r_etc==""){
				alert("내용을 입력하세요");
				/* document.on 으로 처리했기때문 접근가능 
				$(document).find("[name=r_etc]").eq(index).focus(); */
				$("[name=r_etc]").eq(index).focus();
			}
			else{	
				
				alert(etc);
				$.ajax({
					type:"get",
					url:"/notice?method=insertRepleAjax",
					data:{no:num, repno:repno, r_writer:writer, r_etc:etc},
					dataType:"text",
					contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
					success:function(data){
						
						if(data=="true"||data.equals("true")){
							alert("등록성공");
						}
					},error:function(data){
						alert("실패");
					}
					
				});
			}	
			
				/*  동기식
				$("#reple").attr("action","/notice?method=insertReple");
				$("#reple").submit(); */
		});
		
		$(".cansle").click(function(){
			
			if(confirm("취소하시겠습니까?")){
				$("[name=r_writer]").val("");
				$("[name=r_etc]").val("");
				$("[name=r_writer]").focus();
			}
			
		});
		
		//클릭시에 댓글 추가창
		
		$(".updownInput").click(function(n){
			var html="";
			var length= $(".updownInput").length;
			var index= $(".updownInput").index(this);
			
		
			if($(".cloking").eq(index).css("display")=="none"){ 
				
				var repnoTemp= $("[name=temp]")[index].value;
				
				$("[name=repno]").val(repnoTemp);			
				
			html +=	'<td colspan="3">'
				    +'<div class="input-group mb-3"'
					+'style="box-sizing: border-box; width: 100%;">'
					+'<input type="text" name="r_writer" placeholder="아이디"'
					+'class="form-control" style="width: 10%;"> <input'
					+' type="text" class="form-control" name="r_etc"'
					+'placeholder="Something clever.." style="width: 60%;">'
					+'<div class="input-group-append" style="width: 30%;">'
					+'<button class="btn btn-primary inReple" type="button"'
							+'style="width: 50%">OK</button>'
						+'<button id="bb" class="btn btn-danger cansle" type="button"'
						+'style="width: 50%;">Cancel</button>'
					+'</div></div></td>';
				
			//다른 댓글누를때 이전 댓글 입력창 인덱스 숨기기. 
			// 클래스의 길만큼 반복하면서 현재 인덱스가 아니면 숨김처리.
			for(var i=0; i<length; i++){
				if(i!=index){
					$(".cloking").eq(i).empty();
					$(".cloking").eq(i).hide();
					}
			}
				//댓글 추가창 추가
				$(".cloking").eq(index).show();
				$(".cloking").eq(index).append(html);
				
			}
			else{
				$(".cloking").eq(index).empty();
				$(".cloking").eq(index).hide();
			}

		});

	});
	
	function refno(n){
		$("[name=repno]").val(n);
		
	}
	function goPage(no){
			
			$("[name=curPage]").val(no);
			//무조건get방식일때
			/* 	$(location).attr("href","/notice/list?curPage="+no); */
			$("form").submit();
	}
	
	function goDetail(n){			
	
	
		'<div class="input-group mb-3" style="box-sizing: border-box; width:100%;">'
		 +'<input type="text" name="r_writer" placeholder="아이디"'
		 +'class="form-control" style="width:10%;">'
				+'<input type="text" class="form-control" name="r_etc"'
				+'placeholder="Something clever.." style="width:60%;">'
				+'<div class="input-group-append" style="width:30%;">'
					+'<button onclick="inReple(${detail.no})" class="btn btn-primary" type="button" style="width:50%">OK</button>'
					+'<button onclick="" class="btn btn-danger" type="button" style="width:50%;">Cancel</button>'
				+'</div>'
		+'</div>'
	}
</script>

</head>
<body>
	<div class="container">
		<br>
		<h2>공부 게시판h2>
		<br>
		<h5>${detail.title}</h5>

		<div id="titleDiv">
			<div style="float: left;">
				<span>글쓴이: ${detail.writer}&nbsp;|&nbsp;작성시간: <fmt:formatDate
						value="${detail.tolist}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
			</div>
			<div style="float: right;">
				<span>조회수: ${detail.counting}&nbsp;|&nbsp;추천:
					${detail.upPoint}&nbsp;|&nbsp; 댓글수: </span>
			</div>
		</div>
		<div id="content">${detail.etc}</div>
		<form id="reple" method="post" autocomplete="off">
			<input type="hidden" name="curPage" /> <input type="hidden"
				name="no" />


			<div id="repleDiv">
				<div id="repleContent">

					<table class="table table-bordered table-hover">
						<colgroup>
							<col style="width: 30%;">
							<col style="width: 50%;">
							<col style="width: 20%">
						</colgroup>
						<thead>
							<tr style="border-top: solid red;">
								<th>글쓴이</th>
								<th>내용</th>
								<th>작성일</th>

							</tr>
						</thead>
						<tbody id="data">

							<c:forEach items="${reples}" var="reple">
								<input type="hidden" name="temp" value="${reple.repno}" />
								<tr class="updownInput" style="border-bottom: solid red;">
									<c:if test="${reple.r_level==0}">
										<td>${reple.r_writer}</td>
										<td>${reple.r_etc}</td>

										<td style="text-align: center;"><fmt:formatDate
												value="${reple.r_tolist}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
									</c:if>
									<c:if test="${reple.r_level>0}">
										<tr>

											<td>└ ${reple.r_writer}</td>
											<td>${reple.r_etc}</td>
											<td style="text-align: center;"><fmt:formatDate
													value="${reple.r_tolist}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
										</tr>
									</c:if>
								</tr>
								<tr class="cloking">
								</tr>
							</c:forEach>

						</tbody>
					</table>

				</div>

				<div class="input-group mb-3"
					style="box-sizing: border-box; width: 100%;">

					<input type="text" name="r_writer" placeholder="아이디"
						class="form-control" style="width: 10%;"> <input
						type="text" class="form-control" name="r_etc"
						placeholder="Something clever.." style="width: 60%;">
					<div class="input-group-append" style="width: 30%;">
						<button class="btn btn-primary inReple" type="button"
							style="width: 50%">OK</button>
						<button class="btn btn-danger cansle" type="button"
							style="width: 50%;">Cancel</button>
					</div>
				</div>

				<ul class="pagination justify-content-center">
					<li class="page-item"><a class="page-link"
						href="javascript:goPage(${nsch.startBlock-1})">이전</a></li>
					<c:forEach var="cnt" begin="${nsch.startBlock}"
						end="${nsch.endBlock}">
						<li class="page-item ${nsch.curPage==cnt? 'active':''}"><a
							class="page-link" href="javascript:goPage(${cnt})">${cnt}</a></li>
					</c:forEach>
					<li class="page-item"><a class="page-link"
						href="javascript:goPage(${nsch.endBlock==nsch.pageCount?
															nsch.endBlock:nsch.endBlock+1 })">다음</a></li>

				</ul>

			</div>
		</form>
	</div>
</body>
</html>