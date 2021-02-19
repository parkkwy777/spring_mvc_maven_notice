<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

#view{
	position:absolute;
	top:50%;
	left:50%;
	transform:translate(-50%,-50%);
	padding:20px;
	margin-bottom:20px;
	border:solid gray;
	text-align:center;
	width:450px;
	height:300px;
}
.center{
	position:absolute;
	top:50%;
	left:50%;
	transform:translate(-50%,-50%);
}
.cancle,.delete{
	margin:20px;
}
</style>
<script src="/webjars/jquery/3.2.1/dist/jquery.min.js"></script>
<script src="/webjars/jquery/3.2.1/dist/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>

<body>
	<div class="container">
		<br>
		<div id="view">
			<form method="post">
				<input type="hidden" name="no" value="${param.no}"/>
				<div class="form-group center">
					<h5>비밀번호를 입력하세요</h5>
					<br>
					<input type="password" class="form-control input"
						id="pass" name="pass">
					<button class="text-white bg-primary btn cancle">취소</button>
					<button class="text-white bg-danger btn delete">삭제</button>
				</div>
			</form>
			
		</div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		const no=${param.no};
		var result="${result}";
		$(".cancle").click(function(){
			$("form").attr("action", "/notice/detail?no="+no); 
			$("form").submit();
			
		});
		$(".delete").click(function(){
			if(confirm("정말 삭제 하시겠습니까?")){	
				$("form").attr("action", "/notice?method=delete");
				$("form").submit();
				
			}
		});
		
		if(result=="success"){
			alert(result);
			location.href="/notice/list"
		}
		else if(result=="cancle"){
			alert("비밀번호가 일치하지 않습니다.");
		}
	});
	
</script>

</html>