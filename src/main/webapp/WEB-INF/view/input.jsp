<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/webjars/bootstrap/4.5.2/css/bootstrap.min.css"/>
<style>
#content{
	overflow: auto;
	border:solid gray;

}
.float_right{


	float:right;
	overflow:hidden;
	margin-right:5px;
	margin-bottom:8px;
}

</style>
<script src="/webjars/jquery/3.2.1/dist/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
		$(".btn-success").click(function(){

			$("#ss").attr("action","/notice?method=input");
			$("#ss").submit();
			
			
		});
			

	});
</script>

</head>
<body>
	<form id="ss" method="post">
		<div class="container">
			<br>
			<h2>귀멸의 칼날 게시판</h2>
			<br>
			<div class="form-group" style="width: 20%;">
				<label for="writer">작성자:</label> <input type="text"
					class="form-control" id="writer" name="writer">
			</div>
			<div class="form-group">
				<label for="title">제목:</label> <input type="text"
					class="form-control" id="title" name="title">
			</div>

			<div class="form-group">
				<label for=select>말머리</label> <select name="header" id="select">
					<option value="잡담">잡담</option>
					<option value="질문">질문</option>
					<option value="정보/팁">정보/팁</option>
				</select>
			</div>


			<div class="form-group" style="overflow: auto;">
				<label for="comment">Comment:</label>
				<textarea name="etc" class="form-control" rows="10" id="comment"></textarea>
			</div>
			
			<div class="float_right">
		  		<button type="button" class="btn btn-danger">취소</button>
		  	</div>
			<div class="float_right">
		  		<button type="button" class="btn btn-success">확인</button>
		 	</div>
		</div>
	</form>
</body>
</html>