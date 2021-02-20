<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
.imgView{
 margin:20px 0px 20px 0px;

}
.inline-block{
display:inline-block;
width:40%;
}
</style>
<script src="/webjars/jquery/3.2.1/dist/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
		var inputSuccess="${inputSuccess}";
		
		if(inputSuccess=="true"){
			$(location).attr("href","/notice/list");
		}
		
		$(".btn-success").click(function(){

			if($("[name=writer]").val()==null||$("[name=writer]").val()==""){
				alert("작성자명을 입력하세요");
				$("[name=writer]").focus();
			}
			else if($("[name=pass]").val()==null || $("[name=pass]").val()==""){
				alert("비밀번호를 입력하세요");
				$("[name=pass]").focus();
			}
			else if($("[name=title]").val()==null||$("[name=title]").val()==""){
				alert("제목을 입력하세요");
				$("[name=title]").focus();
			}
			else if($("[name=etc]").val()==null||$("[name=etc]").val()==""){
				alert("내용을 입력하세요");
				$("[name=etc]").focus();
			}
			else{	
				
/* 				 //form이 post여도 get방식처럼 쿼리스트링으로 값을 전송할수있다.
				$("form").attr("action","/notice/nono1?writer=wwqewee");
				 */
				$("form").submit();
			}	
		});
			
		$(".custom-file-input").on("change",function(){
			
			var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf|JPG|JPEG|PNG|GIF|BMP|PDF)$/;
			var index=	$(".custom-file-input").index(this);
		
			if($(this).val().match(fileForm)){
				$(".imgView").eq(index).empty();
				$(this).next(".custom-file-label").text($(this).val());
				fileView(this,index);
				
			}
			else{
					
					alert("이미지 파일이 아닙니다");
			}
		});
		
		$("#select").val(`${detail.header}`).prop("selected",true);
	});
function fileView(file,index){
		 var reader = new FileReader();
		  var img ="";
		  	img+='<img class="img" style="max-width:500px; max-height:200px;"/>';
		  	
		  	$(".imgView").eq(index).append(img);
		  reader.onload = function (e) {
			  $(".imgView").eq(index).children(".img").attr('src', e.target.result);  
		  }
		  
		  reader.readAsDataURL(file.files[0]);
		  
	}
	
</script>

</head>
<body>

	<form method="post" action="/notice?method=input" enctype="multipart/form-data">
		<div class="container">
			<br>
			<h2>공부 게시판</h2>
			<br>
			<div class="form-group">
			작성자 : <input type="text"
					class="form-control inline-block" id="writer" name="writer" value="${detail.writer}">
			비밀번호 : <input type="password"
					class="form-control inline-block" id="pass" name="pass" value="${detail.pass} plac">
			</div>
			<div class="form-group">
				<label for="title">제목:</label> <input type="text"
					class="form-control" id="title" name="title" value="${detail.title}">
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
				<textarea name="etc" class="form-control" rows="10" id="comment">${detail.etc}</textarea>
			</div>
		
		<c:forEach begin="1"
				end="${fn:length(detail.fnames)>1? (fn:length(detail.fnames)-1):(fn:length(detail.fnames))}"
				varStatus="sts">
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">첨부 파일${sts.count}</span>
					</div>
					<div class="custom-file">
						<input type="file" name="report"
							value="${detail.fnames[sts.index-1]}" class="custom-file-input"
							id="file01" /> <label class="custom-file-label" for="file01">
							${detail.fnames[sts.index-1]!=null?detail.fnames[sts.index-1]:"파일이 존재하지않습니다!!"}</label>
					</div>
				</div>
				<div class="imgView changeImg">
					<c:if test="${detail.fnames[sts.index-1]!=null}">
						<img class="img" src="/upload/${detail.fnames[sts.index-1]}"
							style="max-width: 500px; max-height: 200px;" />
					</c:if>
				</div>
			</c:forEach>
			
			<c:forEach begin="1" end="${fn:length(detail.fnames)>=1? (3-(fn:length(detail.fnames))):3}">
			 	<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text">첨부 파일</span>
						</div>
					<div class="custom-file">
						<input type="file" name="report" value="" class="custom-file-input"
							id="file01" /> 
							<label class="custom-file-label" for="file01">
								파일을 선택하세요!!</label>
					</div>
						
				</div>
				<div class="imgView">
						
				</div> 
			</c:forEach>
		
			<div class="form-group" style="margin:20px 0px 20px 0px;">
				<div class="float_right">
					<button type="button" class="btn btn-danger">취소</button>
				</div>
				<div class="float_right">
					<button type="button" class="btn btn-success">확인</button>
				</div>
			</div>		
		</div> 	
	</form>
</body>
<script type="text/javascript">


</script>
</html>