﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/admin/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="${pageContext.request.contextPath}/js/cryptojs/components/core-min.js"></script>
<script src="${pageContext.request.contextPath}/js/cryptojs/components/sha256-min.js"></script>


<script> 
	$(function(){
		$("#deleteBtn").click(function(){
			var pw = $("input[name=pw]").val();
			var encPw = CryptoJS.SHA256(pw).toString();
			
			$.ajax({
// 				url : "../check_pw_attraction",
				url : "${pageContext.request.contextPath}/admin/check_pw_attraction",
				type: "post",
				data : {
					pw : encPw
				},
				dataType : "text",
				success : function(resp) {
					if (resp == "Y") {
						location.href="${pageContext.request.contextPath}/admin/attraction/exit?no=${adto.attraction_no}"
					}
					else {
						window.alert("비밀번호가 일치하지 않습니다")
					}
				}
			});
		});
		
	});
	
</script>

<style>
	.table_ny_one tbody {
		color:black;
	}
	
	.detail_wrap > .table_ny_one {
		margin-top : 50px;
		border-top: 3px solid #432c10;
  		border-bottom: 3px solid #432c10;
   		border-left: none;
  		border-right: none;
  		max-width: 1100px;
	}
	
	.detail_wrap > .table_ny_one > thead > tr > th,
	.detail_wrap > .table_ny_one > thead > tr > td,
	.detail_wrap > .table_ny_one > tbody > tr > th,
	.detail_wrap > .table_ny_one > tbody > tr > td,
	.detail_wrap > .table_ny_one > tfoot > tr > th,
	.detail_wrap > .table_ny_one > tfoot > tr > td {
		border: 1px solid #432c10;
		border-left: none;
  		border-right: none;
  		padding:10px 10px;
	}
	
	.headtit{
		border-bottom: #432c10 solid 10px;
		width:1100px;
		margin:auto;
	}
	
	.content-line{
		margin-top:100px;
		border: 5px solid white;
		max-width: 1200px;
		margin: auto;
		padding: 20px 10px;
		box-shadow: 2px 2px 10px #EAEAEA;
	}
	
	.td-line{
		width: 950px;
		text-align: right;
	}
	
	.table_ny_one .btn{
		width: 50px;
		height: 40px;
		padding: 0px;
	}
	
	@media (max-width:1224px) {
		.td-line{
			text-align: left;
		}
	}
</style>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f6577d0e4ec93da30c028985f6927308&libraries=services"></script>

<script>
        $(function(){
        	var markerPosition  = new kakao.maps.LatLng(${adto.attraction_lat}, ${adto.attraction_lng}); 

        	// 이미지 지도에 표시할 마커입니다
        	// 이미지 지도에 표시할 마커는 Object 형태입니다
        	var marker = {
        	    position: markerPosition
        	};

        	var staticMapContainer  = document.getElementById('staticMap'), // 이미지 지도를 표시할 div  
        	    staticMapOption = { 
        	        center: new kakao.maps.LatLng(${adto.attraction_lat}, ${adto.attraction_lng}), // 이미지 지도의 중심좌표
        	        level: 3, // 이미지 지도의 확대 레벨
        	        marker: marker // 이미지 지도에 표시할 마커 
        	    };    

        	// 이미지 지도를 생성합니다
        	var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
        });
        
        
    </script>
    

<c:forEach var="afdto" items="${afdtolist}" varStatus="status">
	<input type="hidden" name="attraction_file_no${status.count}" value="${afdto.attraction_file_no}">
</c:forEach>
<div style="height: 100px;"></div>
<div class="content-line">
<div class="detail_wrap">
<div class="headtit">
<h3>${adto.attraction_name}</h3>
</div>
	<table class="table_ny_one" align="center" >
		<tbody>
			<tr>
				<td colspan="2">
					[주소]&emsp; ${adto.attraction_addr1} ${adto.attraction_addr2}
				</td>
			</tr>
			<tr height="300">
				<td valign="top" colspan="2">
				<c:if test="${not empty afdtolist[0]}">
					<img height="100px;" src="${pageContext.request.contextPath}/img_v/1?img_name=${afdtolist[0].attraction_file_name}">
				</c:if>
				<c:if test="${not empty afdtolist[1]}">
					<img height="100px;" src="${pageContext.request.contextPath}/img_v/1?img_name=${afdtolist[1].attraction_file_name}">
				</c:if>
				<c:if test="${not empty afdtolist[2]}">
					<img height="100px;" src="${pageContext.request.contextPath}/img_v/1?img_name=${afdtolist[2].attraction_file_name}">
				</c:if>
				<br>
				<br>
					${adto.attraction_info}
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="staticMap" style="width:100%;height:300px;"></div>
					<input type="hidden" id="attraction_lng" name="attraction_lng" value="">
					<input type="hidden" id="attraction_lat" name="attraction_lat" value="">
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td class="td-line" colspan="2">
					<a href ="edit?no=${adto.attraction_no}"><input type="button" value="수정" name="edit" class="btn btn-danger"></a>
					<button type="button" name="exitbtn"  class="btn btn-danger exitbtn" data-toggle="modal" data-target="#deleteCheckModal">삭제</button>
					<a href ="list"><input type="button" value="목록" name="list" class="btn btn-danger"></a>
				</td>
			</tr>
		</tfoot>
	</table>
</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

<!-- 삭제할 때 삭제할건지 확인하는 모달 시작 -->
<!--modal 참고 url : https://getbootstrap.com/docs/4.0/components/modal/ -->
<div class="modal" id="deleteCheckModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">비밀번호 확인</h5>
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
			<div class="modal-body">
			비밀번호를 입력후 확인을 누르시면 삭제됩니다
			<!--해당 글 삭제하는 주소값받는 input 태그-->
				<input type="password" class="form-control" name="pw" id="pw" placeholder="PASSWORD를 입력하세요" required>
				<img id="deleteUrl" src="">
			
			</div>
			<div class="modal-footer">
			
				<button type="button" class="btn btn-primary" id="deleteBtn">확인</button>
				
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>