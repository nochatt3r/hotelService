<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script
	src="${pageContext.request.contextPath}/js/cryptojs/components/core-min.js"></script>
<script
	src="${pageContext.request.contextPath}/js/cryptojs/components/sha256-min.js"></script>
<!-- 수정했습니다. -->
<style>
form h4 {
	display: none
}

form label {
	font-size: 20px;
	/* 	background-color:yellow; */
}

.regist-wrap {
	width: 800px;
	margin: auto;
}

.cert_check{
 	display: none; 
}
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f6577d0e4ec93da30c028985f6927308&libraries=services"></script>
<script>


	$(function() {
		$("input[name=postcode_find]").click(findAddress);
	});

	function findAddress() { 
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					// 조합된 참고항목을 해당 필드에 넣는다.

				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				// document.querySelector('input[name=postcode]').value = data.zonecode;
				// document.querySelector("input[name=basicaddr]").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				// document.querySelector("input[name=detailaddr]").focus();

				// 이 코드는 jquery.js 를 먼저 불러온 경우만 사용 가능
				$("input[name=hotel_zip_code]").val(data.zonecode);
				$("input[name=hotel_basic_addr]").val(addr);
				var addr = $("input[name=hotel_basic_addr]").val();
				  var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = {
				        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				        level: 3 // 지도의 확대 레벨
				    };  

					// 지도를 생성합니다    
					var map = new kakao.maps.Map(mapContainer, mapOption); 
			
					// 주소-좌표 변환 객체를 생성합니다
					var geocoder = new kakao.maps.services.Geocoder();
			
					// 주소로 좌표를 검색합니다
						geocoder.addressSearch(addr, function(result, status) {
				
						    // 정상적으로 검색이 완료됐으면 
					     if (status === kakao.maps.services.Status.OK) {
			
					        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					        var longitude = result[0].y;
					        var latitude = result[0].x;
					        $("#h_longitude").val(longitude);
					        $("#h_latitude").val(latitude);
			
					        // 결과값으로 받은 위치를 마커로 표시합니다
					        var marker = new kakao.maps.Marker({
					            map: map,
					            position: coords
					        });
			
					        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					        map.setCenter(coords);
					    } 
					});

				
				$("input[name=hotel_detail_addr]").focus();
			}
		}).open();
	}

	//전화 번호 검사 후 형식에 안맞을시 보조메세지 출력
	function checkTel() {
		var h_tel = document.querySelector("#h_tel").value;
		var regex = /^0[0-9]{1,2}[0-9]{3,4}[0-9]{4}$/;

		//정규표현식으로 h_tel값 검사
		var result = regex.test(h_tel);

		var div = document.querySelector(".h_telD");

		if (result) {
			div.innerHTML = ""
		}

		//h_tel이 형식에 맞지 않으면 메세지 출력
		else {
			div.innerHTML = "<font color = 'gray' size = '2'> 숫자로 입력해주세요</font>"

		}
	}
</script>



<div class="regist-wrap" align="center">
	<br>
	<h1>가입 정보 입력</h1>
	<br>
	<form action="regist" method="post">
		<div>
			<table>
				<tbody>
					<tr>
						<td><label for="s_id">호텔 이름</label></td>
						<td>
							<input class="form-control" type="text" name="hotel_name" 
							id="h_name" required> 
						</td>
					</tr>
					<tr>
						<td><label for="h_tel">호텔 번호</label></td>
						<td><input class="form-control" onblur="checkTel();"
							type="tel" placeholder="-없이 번호만 입력하세요" name="hotel_tel" id="h_tel"
							pattern="^0[0-9]{1,2}[0-9]{3,4}[0-9]{4}$" required>
							<div class="h_telD"></div></td>
					</tr>
					<tr>
						<td><label for="h_addr">ADDRESS</label></td>
						<td><input class="form-control" type="text" style="display: inline-block;width: 40%"
								name="hotel_zip_code" placeholder="우편번호" required readonly>
							<input class="btn btn-danger" type="button" value="우편번호 찾기"
								name="postcode_find"><br> 
							<input class="form-control" type="text" name="hotel_basic_addr"
								placeholder="주소" required readonly>
							<input class="form-control" type="text" name="hotel_detail_addr"
								placeholder="상세주소">
						</td>
					</tr>
					<tr>
						<td>소개</td>
						<td>
							<textarea class="form-control" placeholder="호텔 소개글을 입력하세요" 
							name="hotel_content" id="h_content"></textarea>
						</td>
					</tr>
					<tr>
						<td>호텔 성급</td>
						<td>
							<select class="form-control" name="hotel_star" id="h_star" required>
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
								<option>5</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>옵션사항</td>
						<td>
							<input type="checkbox" name="hotel_parking" value="Y">주차가능<br>
							<input type="checkbox" name="hotel_fitness" value="Y">헬스장<br>
							<input type="checkbox" name="hotel_pool" value="Y">수영장<br>
							<input type="checkbox" name="hotel_sauna" value="Y">사우나<br>
							<input type="checkbox" name="hotel_lounge" value="Y">라운지<br>
							<input type="checkbox" name="hotel_bbq" value="Y">바베큐<br>
							<input type="checkbox" name="hotel_cafe" value="Y">카페<br>
							<input type="checkbox" name="hotel_convenience_store" value="Y">편의점<br>
							<input type="checkbox" name="hotel_karaoke" value="Y">노래방<br>
							<input type="checkbox" name="hotel_internet" value="Y">와이파이
						</td>
					</tr>
					<tr>
						<td colspan="2"><div id="map" style="width:100%;height:300px;"></div>
							<input type="hidden" id="h_longitude" name="hotel_longitude" value="">
							<input type="hidden" id="h_latitude" name="hotel_latitude" value="">
						</td>
					</tr>
					<tr>
						<td>
							<input type="file" name="hotel_title">
						</td>
					</tr>
					
					<tr>
						<td colspan="2"><input class="btn btn-danger btn-block"
							type="submit" style="margin-top: 30px;" value="등록하기" name="registbtn"></td>
					</tr>
				</tbody>
			</table>
		</div>
		
	</form>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>