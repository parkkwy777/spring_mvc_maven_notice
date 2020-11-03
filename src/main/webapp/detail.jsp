<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/webjars/bootstrap/4.5.2/css/bootstrap.min.css"/>
<style>

#content{
	border:solid red;
	height:500px;
}
#titleDiv::after { content: ''; dispaly: table; clear: both; }

</style>
<script src="/webjars/jquery/3.2.1/dist/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
	});
</script>

</head>
<body>
	<div class="container">
		<h2>귀멸의 칼날 게시판</h2>
		<h5>제목</h5>
		<div id="titleDiv"></div>
		<div style="float:left;">
			<span>글쓴이: ${detail.writer}&nbsp;|&nbsp;작성시간: ${detail.tolist}</span>
		</div>
		<div style="float:right;">
			<span>조회수: ${detail.counting}&nbsp;|&nbsp;추천: ${detail.upPoint}&nbsp;|&nbsp;댓글수: </span>
		</div>
		
		<div id="content">
						
		</div>
		<form id="reple" method="post">
			<div id="repleDiv">
				<div class="input-group mb-3">
					<input type="text" class="form-control"
						placeholder="Something clever..">
					<div class="input-group-append">
						<button class="btn btn-primary" type="button">OK</button>
						<button class="btn btn-danger" type="button">Cancel</button>
					</div>
				</div>
				<!-- <r_writer> -->
			</div>
		</form>
	</div>
</body>
</html>