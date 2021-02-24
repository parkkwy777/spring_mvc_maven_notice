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

.cloking {
	display: none;
}
.imgView{
 margin:20px 0px 20px 0px;

}
#view{
	padding:20px;
	margin-bottom:20px;
	border:solid gray;
}
.bottom_button{
	text-align:right;
}
</style>
<script src="/webjars/jquery/3.2.1/dist/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		 getReple();
		//동적으로 생성한 요소도 탐색 가능 $(document)
		$(document).on("click",".inReple",function(){

			var length=$(".inReple").length;
			 // 동적으로 여러 태그가 생성된 경우라면 이런식으로 클릭된 객체를 this 키워드를 이용해서 잡아올 수 있다.
            var index= $(".inReple").index(this);
			var r_writer=$("[name=r_writer]").eq(index).val();
			var r_etc=$("[name=r_etc]").eq(index).val();
			var repno;
			
			if($(".inReple").eq(index).attr("id")=="first"){
				$("[name=repno]").val(0);
			}
	
			
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
				
				 
				/* //post일때는 현재 url에 form에있는 값이 r_etc가 url에있는 값 + ,(form r_etc값) 으로 더해진다. 
				$("#reple").attr("action","/notice/nono?r_etc=asdssad"); */
				for(var i=0; i<length; i++){
					if(i!=index){

						$("[name=r_writer]").eq(i).val("");
						$("[name=r_etc]").eq(i).val("");
						$("[name=pass]").eq(i).val("");
					}
				}
				
				$.ajax({
					type:"post",
					url:"/notice?method=insertRepleAjax",
					data:$("form").serialize(),/* {no:no, repno:repno, r_writer:r_writer, r_etc:r_etc} */
					dataType:"json",
					contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
					success:function(data){
						console.log(data);
						getReple();
					},
				    error:function(){
				      	alert("실패");
				    }
				});
			
			}	 

		});
		
		$(".cansle").click(function(){
			
			if(confirm("취소하시겠습니까?")){
				$("[name=r_writer]").val("");
				$("[name=r_etc]").val("");
				$("[name=r_writer]").focus();
			}
			
		});
		
		//클릭시에 댓글 추가창
		
		$(document).on("click",".updownInput",function(){
			
			var html="";
			var length= $(".updownInput").length;
			var index= $(".updownInput").index(this);
	
			
			if($(".cloking").eq(index).css("display")=="none"){ 
				
		
				//반복문으로 temp값 배열로 받아서 해당 클릭한 부분의 repno로쓸 값 받음.
			
				var repnoTemp= $("[name=temp]").val().split(",");
					
					$("[name=repno]").val(repnoTemp[index]);			
					
			html +=	'<td colspan="3">'
				    +'<div class="input-group mb-3"'
					+'style="box-sizing: border-box; width: 100%;">'
					+'<input type="text" name="r_writer" placeholder="아이디"'
					+'class="form-control" style="width: 15%;"/> <input '
					+'type="password" name="pass" placeholder="비밀번호" class="form-control"'
					+'style="width: 10%;"/> <input type="text" class="form-control" name="r_etc"'
					+'placeholder="Something clever.." style="width: 55%;"/>'
					+'<div class="input-group-append" style="width: 20%;">'
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

	
		$(".input").click(function(){
			location.href="/notice/noticeInput";
		});
		$(".delete").click(function(){
			var address="/notice/noticeDelete?no="+${detail.no};
			console.log(address);
			location.href=address;
		});
		$(".update").click(function(){
			location.href="/notice/noticeUpdate?no="+${detail.no};
		});
		$(".fileInfo").click(function(){
			var fname=$(".custom-file-label").text().trim();
			if(confirm("다운로드 하시겠습니까?")){
				console.log(fname);
				$(location).attr("href","/notice?method=download&fname="+fname);
			}
			
		});
	});
	
	//댓글 조회 에이작스처리


	function getReple() {
			var no=$("[name=no]").val();
			var curPage=$("[name=curPage]").val();
		
				$.ajax({
					type : "post",
					url : "/notice?method=repleAjax",
					data :{no:no,curPage:curPage},
					dataType : "json",
					contentType : 'application/x-www-form-urlencoded; charset=euc-kr',
					success : function(data) {
						$("[name=r_writer]").val("");
						$("[name=r_etc]").val("");
						$("[name=pass]").val("");
						//조회할때 data 내용 초기화
						$("#data").empty();
				
						var content = "";
						var temp=[];
						for ( var i in data.reples) {
						
			
							temp[i]=data.reples[i].repno;
				
							var r_tolist = moment(data.reples[i].r_tolist)
									.format("YYYY-MM-DD HH:mm:ss");
							content += '<tr class="updownInput" style="font-weight:bold;">';
							if (data.reples[i].r_level == 0) {
								
								content += '<td>' + data.reples[i].r_writer
										+ '</td>' + '<td>'
										+ data.reples[i].r_etc + '</td>'
										+ '<td style="text-align: center;">'
										+ r_tolist + '</td></tr>';
							}
							if (data.reples[i].r_level > 0) {
								
								content += '<tr>' + '<td>┗ '
										+ data.reples[i].r_writer + '</td>'
										+ '<td>' + data.reples[i].r_etc
										+ '</td>'
										+ '<td style="text-align: center;">'
										+ r_tolist + '</td></tr>';
							}
							content +='<tr class="cloking">'
									+ '</tr>';
						
						}
						$("[name=temp]").val(temp);
						$("#data").append(content);
						
						//페이징 ajax
						$(".pagination").empty();
						var content2="";
					
							content2+='<li class="page-item"><a class="page-link" href="javascript:goPage('+(data.nsch.startBlock-1)+')">이전</a></li>';
					
						for(var i=data.nsch.startBlock; i<=data.nsch.endBlock; i++){
							content2+='<li class="page-item'+ (data.nsch.curPage==i? " active":"")+'">'
							+'<a class="page-link" href="javascript:goPage('+i+')">'+i+'</a></li>';
						}
							content2+='<li class="page-item"><a class="page-link" href="javascript:goPage('
									+(data.nsch.endBlock==data.nsch.pageCount? data.nsch.endBlock:data.nsch.endBlock+1)+')">다음</a></li>';
							
							$(".pagination").append(content2);
					},
					error : function() {
						alert("조회실패");
					}
				});
	}

	function goPage(no) {

		var detail = ${detail.no};
		$("[name=curPage]").val(no);
		getReple();
	}
</script>

</head>
<body>
	<div class="container">
		<br>
		<div id="view">
			<h2>공부 게시판</h2>
			<br>
			<h5>${detail.title}</h5>

			<div id="titleDiv">
				<div style="float: left;">
					<span>글쓴이: ${detail.writer}&nbsp;|&nbsp;작성시간: <fmt:formatDate
							value="${detail.tolist}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
				</div>
				<div style="float: right;">
					<span>조회수: ${detail.counting}&nbsp;|&nbsp;추천:
						${detail.upPoint}&nbsp;|&nbsp; 댓글수: ${repleCount} </span>
				</div>
			</div>
			<div id="content">${detail.etc}</div>

			<c:forEach begin="1"
				end="${fn:length(detail.fnames)>1? (fn:length(detail.fnames)-1):(fn:length(detail.fnames))}"
				varStatus="sts">
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">첨부 파일${sts.count}</span>
					</div>
					<div class="custom-file">
						<a class="fileInfo"><input type="file" name="report"
							value="${detail.fnames[sts.index-1]}" class="custom-file-input" disabled="disabled"
							id="file01" /> <label class="custom-file-label" for="file01">
							${detail.fnames[sts.index-1]!=null?detail.fnames[sts.index-1]:"파일이 존재하지않습니다!!"}</label>
						</a>
					</div>

				</div>
				<div class="imgView">
					<c:if test="${detail.fnames[sts.index-1]!=null}">
						<img class="img" src="/upload/${detail.fnames[sts.index-1]}"
							style="max-width: 500px; max-height: 200px;" />
					</c:if>
				</div>
			</c:forEach>
			<div class="bottom_button">
				<button class="text-white bg-primary btn update">수정</button>
				<button class="text-white bg-danger btn delete">삭제</button>
				<button class="text-white bg-success btn input">글쓰기</button>
			</div>
		</div>
		<form id="reple" method="post" autocomplete="off">
			<input type="hidden" name="curPage" value="0"/> 
			<input type="hidden" name="no" value="${detail.no}" />
			<input type="hidden" name="repno" value="0"/>
			<input type="hidden" name="temp" value="" disabled />


			<div id="repleDiv">
				<div id="repleContent">

					<table class="table table-bordered table-hover">
						<colgroup>
							<col style="width: 30%;">
							<col style="width: 50%;">
							<col style="width: 20%">
						</colgroup>
						<thead>
							<tr>
								<th>글쓴이</th>
								<th>내용</th>
								<th>작성일</th>

							</tr>
						</thead>
						<tbody id="data">

						

						</tbody>
					</table>

				</div>




				<div class="input-group mb-3"
					style="box-sizing: border-box; width: 100%;">

					<input type="text" name="r_writer" placeholder="아이디"
						class="form-control" style="width: 15%;" />
					<input type="password" name="pass" placeholder="비밀번호"
						class="form-control" style="width: 10%;" /> <input
						type="text" class="form-control" name="r_etc"
						placeholder="Something clever.." style="width: 55%;"/>
					<div class="input-group-append" style="width: 20%;">
						<button class="btn btn-primary inReple" id="first" type="button"
							style="width: 50%">OK</button>
						<button class="btn btn-danger cansle" type="button"
							style="width: 50%;">Cancel</button>
					</div>
			
				</div>

				<ul class="pagination justify-content-center">

				</ul>

			</div>
		</form>
	</div>
</body>
<script type="text/javascript"></script>
</html>