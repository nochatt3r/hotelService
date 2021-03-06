<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/admin/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

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
        	var markerPosition  = new kakao.maps.LatLng(${pdto.partner_latitude}, ${pdto.partner_longitude}); 

        	// 이미지 지도에 표시할 마커입니다
        	// 이미지 지도에 표시할 마커는 Object 형태입니다
        	var marker = {
        	    position: markerPosition
        	};

        	var staticMapContainer  = document.getElementById('staticMap'), // 이미지 지도를 표시할 div  
        	    staticMapOption = { 
        	        center: new kakao.maps.LatLng(${pdto.partner_latitude}, ${pdto.partner_longitude}), // 이미지 지도의 중심좌표
        	        level: 3, // 이미지 지도의 확대 레벨
        	        marker: marker // 이미지 지도에 표시할 마커 
        	    };    

        	// 이미지 지도를 생성합니다
        	var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
        });
        
        
    </script>
    

<%-- <c:forEach var="cdto" items="${afdtolist}" varStatus="status"> --%>
<%-- 	<input type="hidden" name="attraction_file_no${status.count}" value="${afdto.attraction_file_no}"> --%>
<%-- </c:forEach> --%>
<div style="height: 100px;"></div>
<div class="content-line">
<div class="detail_wrap">
<div class="headtit">
<h3>${pdto.partner_name}</h3>
</div>
	<table class="table_ny_one" align="center" >
		<tbody>
			<tr>
				<td>
					[주소]&emsp; ${pdto.partner_basic_addr} ${pdto.partner_detail_addr}
				</td>
				<td style="text-align:right;margin-right:10px;">
					현재 승인 상태 : [ ${pdto.partner_type} ]
				</td>
			</tr>
			<tr height="300">
				<td valign="top" colspan="2">
				<c:if test="${not empty pfdtolist[0]}">
					<img height="100px;" src="${pageContext.request.contextPath}/img_v/5?img_name=${pfdtolist[0].p_file_name}">
				</c:if>
				<c:if test="${not empty pfdtolist[1]}">
					<img height="100px;" src="${pageContext.request.contextPath}/img_v/5?img_name=${pfdtolist[1].p_file_name}">
				</c:if>
				<c:if test="${not empty pfdtolist[2]}">
					<img height="100px;" src="${pageContext.request.contextPath}/img_v/5?img_name=${pfdtolist[2].p_file_name}">
				</c:if>
				<br>
				<br>
					${pdto.partner_content}
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="staticMap" style="width:100%;height:300px;"></div>
					<input type="hidden" id="partner_longitude" name="partner_longitude" value="">
					<input type="hidden" id="partner_latitude" name="partner_latitude" value="">
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td class="td-line" colspan="2">
					<a href ="edit?no=${pdto.partner_no}"><input type="button" value="수정" name="edit" class="btn btn-danger"></a>
					<a href ="${link}"><input type="button" value="목록" name="list" class="btn btn-danger"></a>
				</td>
			</tr>
		</tfoot>
	</table>
</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>