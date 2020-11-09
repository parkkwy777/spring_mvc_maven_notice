<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
	
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<title>게시판</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/webjars/bootstrap/4.5.2/css/bootstrap.min.css"/>
<style>
html{
width:100%;
height:100%;
}

.imgOption{
width:100%;
height:400px;
margin:20px;
}

.float_right{


	float:right;
	overflow:hidden;
	margin-right:5px;
	margin-bottom:8px;
}
.float_right1{

	float:right;
}

.loding{

	display:none;
}
</style>
<script src="/webjars/jquery/3.2.1/dist/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<script type="text/javascript">
	$(document).ready(function(){
	
		var select = $("[name=sching]").val();
		
		$("[name=sching]").change(function(){
			select = $("[name=sching]").val();
			
			//검색하는 input의 name을 select가 선택한 값으로 설정.
			$(".schword").attr("name",select);
			
			$("[name="+select+"]").focus();
			
		});
		
		
		$("#schBtn").click(function(){
			$(".schword").attr("name",select);
			$("#firstForm").attr("action","/notice/list");
			$("#firstForm").submit();
			
		});
		$(".schword").keydown(function(key){
			if(key.keyCode==13){
				$(".schword").attr("name",select);
				$("#firstForm").attr("action","/notice/list");
				$("#firstForm").submit();
			}
			
		});
		
		
	/* 	$(".schword").keyup(function(){
			var word=$(".schword").val();
			
			$.ajax({
				type:"post",
				url:"/notice/ajaxList?title="+word,
				dataType:"json",
				success:function(data){
				
					var content="";
					
					for(var i=0; i<data.nlist.length;i++){
						content+="<tr>"
							+"<td>"+data.nlist[i].no+"</td>"
							+"<td>"+data.nlist[i].header+"</td>"
							+"<td>"+data.nlist[i].title+"</td>"
							+"<td>"+data.nlist[i].writer+"</td>"
							+"<td>"+data.nlist[i].today+"</td>"
							+"<td>"+data.nlist[i].counting+"</td>"
							+"<td>"+data.nlist[i].upPoint+"</td>"
							+"</tr>"
					}
					$("#data").html(content);
				},
				error:function(err){
					
					console.log(err);
				}
			});
		}); */
		
	});

	function goPage(no){
		
	
		$("[name=curPage]").val(no);
		
		$(location).attr("href","/notice/list?curPage="+no);
	/* 	$("form").focus();
		$("form").submit(); */
		
	}
	// 상세페이지로 이동
	function goDetail(no)
	{
		$(location).attr("href","/notice/detail?no="+no);
	}
</script>

</head>
<body>

<form id="firstForm" method="get">
	<input id="cc" type="hidden" name="curPage" value="0"/> 
	<!-- 좌우 공백 제거 no-gutters -->
	<div class="container">
	  <br>
	  <h2>귀멸의 칼날 게시판</h2>
	  <p>자유롭게 의견을 남겨주세요!</p>
	  <div style="text-align:center;">
	  <img src="/static/img/1597069796.jpg" class="rounded imgOption img-fluid">            
	  </div>
		
		  <div class="float_right1">
		  		<button id="schBtn" type="button" class="btn btn-success">검색
		  		<!-- <span class="spinner-border spinner-border-sm loding">로딩 중</span> -->
		  		</button>
		  </div>
		  <div class="float_right">
		  		<input type="text"  id="schword" class="schword form-control">
		  </div>
		  
		    <div class="float_right1">
			  <select class="form-control" name="sching">
			  	<option value="title">제목</option>
			  	<option value="writer">작성자</option>
			  </select>
		  </div>

			<table class="table table-bordered table-hover text-center">
				<colgroup>
					<col style="width: 10%;">
					<col style="width: 15%;">
					<col style="width: 35%">
					<col style="width: 10%;">
					<col style="width: 10%;">
					<col style="width: 10%;">
					<col style="width: 10%;">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>말머리</th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>작성일</th>
						<th>조회</th>
						<th>추천</th>
					</tr>
				</thead>
				<tbody id="data">
					<c:forEach items="${nlist}" var="notice">
						<tr class="text-center" 
						onclick="javascript:goDetail(${notice.no})">
							<td>${notice.no}</td>
							<td>${notice.header}</td>
							<td>${notice.title}</td>
							<td>${notice.writer}</td>
							<td>${notice.today}</td>
							<td>${notice.counting}</td>
							<td>${notice.upPoint}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		<div >
			<ul style="position: relative;" class="pagination justify-content-center">
				<li class="page-item">
					<a class="page-link" href="javascript:goPage(${nsch.startBlock-1})">이전</a>
				</li>
				<c:forEach var="cnt" begin="${nsch.startBlock}"
					end="${nsch.endBlock}">
					<li class="page-item ${nsch.curPage==cnt? 'active':''}">
						<a class="page-link" href="javascript:goPage(${cnt})">${cnt}</a></li>
				</c:forEach>
				<li class="page-item">
				<a class="page-link" href="javascript:goPage(${nsch.endBlock==nsch.pageCount?
															nsch.endBlock:nsch.endBlock+1 })">다음</a></li>
				<li class="page-item" style="position: absolute; right:0;">
					<a href="/notice/noticeInput"><button type="button" class="btn btn-success">글쓰기</button> </a>
				</li>
			</ul>
		</div>
	</div>
</form>
</body>
</html>

