<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="container pt-4">
	<div class="font2 my-3">주문서</div>
	<div class="d-flex justify-content-between">
		<!-- 주문서 -->
		<div class="order-div">
			<!-- 1. 주문 고객 정보 -->
			<div class="font1">1. 주문 고객 정보</div>
			<hr class="bg-dark">
			<div class="my-2 font5">
				<b>이름 : </b>${orderView.user.name}</div>
			<div class="my-2 font5">
				<b>전화번호 : </b>${orderView.user.phoneNumber}</div>
			<div class="my-2 font5">
				<b>이메일 : </b>${orderView.user.email}</div>

			<!-- 2. 배송지 정보 정보 -->
			<div class="font1 mt-5">2. 배송지 정보</div>
			<hr class="bg-dark">
			<div>
				<div class="d-flex">
					<div class="custom-control custom-radio">
						<input type="radio" id="addressList" name="addressType"
							class="form-check-input" value="list" checked> <label
							for="addressList" class="mytrend-font3">배송지 목록</label>
					</div>
					<div class="custom-control custom-radio ml-5">
						<input type="radio" id="newAddress" name="addressType"
							class="form-check-input" value="create"> <label
							for="newAddress" class="mytrend-font3">배송지 생성</label>
					</div>
				</div>

				<!-- 배송지 목록 -->
				<div id="adlist" class="address-list mt-2">
					<c:forEach items="${orderView.addressList}" var="defualtAddress">
						<c:if test="${defualtAddress.defaultAddress eq true}">
							<div class="font1 mb-2">기본 배송지</div>
							<button type="button" class="address-btn d-flex mb-3"
								data-address-id="${defualtAddress.id}">
								<div class="address-table">
									<div>이름</div>
									<div class="mt-1">휴대폰 번호</div>
									<div class="mt-1">추가 연락처</div>
									<div class="mt-1">주소</div>
								</div>
								<div class="address-data">
									<div>${defualAddress.name}</div>
									<div class="mt-1">${defualtAddress.phoneNumber}</div>
									<c:if test="${not empty defualtAddress.extraPhoneNumber}">
										<div class="mt-1">${defualtAddress.extraPhoneNumber}</div>
									</c:if>
									<c:if test="${empty defualtAddress.extraPhoneNumber}">
										<div class="mt-1">추가 연락처가 없습니다.</div>
									</c:if>
									<div class="mt-1">${defualtAddress.address}
										${defualtAddress.detailedAddress}</div>
								</div>
							</button>
						</c:if>
					</c:forEach>

					<div class="mytrend-font2 mt-4 mb-2">배송지 목록</div>
					<c:forEach items="${orderView.addressList}" var="address">
						<button type="button" class="address-btn d-flex mb-3"
							data-address-id="${address.id}">
							<div class="address-table">
								<div>이름</div>
								<div class="mt-1">휴대폰 번호</div>
								<div class="mt-1">추가 연락처</div>
								<div class="mt-1">주소</div>
							</div>
							<div class="address-data">
								<div>${address.name}</div>
								<div class="mt-1">${address.phoneNumber }</div>
								<c:if test="${not empty address.extraPhoneNumber}">
									<div class="mt-1">${address.extraPhoneNumber}</div>
								</c:if>
								<c:if test="${empty address.extraPhoneNumber}">
									<div class="mt-1">추가 연락처가 없습니다.</div>
								</c:if>
								<div class="mt-1">${address.address}
									${address.detailedAddress}</div>
							</div>
						</button>
					</c:forEach>
					<div class="d-flex mt-3">
						<input type="button" id="addressBtn" value="확인"
							class="mytrend-btn">
					</div>
				</div>

				<!-- 배송지 새로 입력 -->
				<div id="newad" class="new-address mt-4 d-none">
					<div>
						<div class="mytrend-font2">이름</div>
						<div class="mytrend-input">
							<input type="text" id="name">
						</div>
					</div>
					<div class="mt-2">
						<div class="mytrend-font2">전화번호</div>
						<div class="mytrend-input">
							<input type="text" id="phoneNumber"
								placeholder="'-' 없이 숫자만 입력하세요.">
						</div>
					</div>
					<div class="mt-2">
						<div class="mytrend-font2">추가 연락처(선택)</div>
						<div class="mytrend-input">
							<input type="text" id="extraPhoneNumber"
								placeholder="'-' 없이 숫자만 입력하세요.">
						</div>
					</div>
					<div class="mt-2">
						<div class="mytrend-font2">배송지 주소</div>
						<div class="address-input d-flex align-items-center">
							<input type="text" id="sample6_postcode" readonly="readonly">
							<button type="button" id="findAddressBtn" class="ml-2"
								onclick="sample6_execDaumPostcode()">찾 기</button>
						</div>
						<div class="address-input2">
							<input type="text" id="sample6_address" readonly="readonly">
						</div>
						<div class="address-input2">
							<input type="text" id="sample6_detailAddress">
						</div>
					</div>
					<div class="mt-1">
						<input type="checkbox" id="defaultAddress"> <label
							for="defaultAddress" class="mytrend-font3">기본 배송지 설정</label>
					</div>
					<div class="d-flex mt-3">
						<input type="button" id="registerAddressBtn" value="확인"
							class="mytrend-btn">
					</div>
				</div>
			</div>
			<div class="mt-5">
				<div class="font1">배송 시 요청사항</div>
				<select name="colorOption" class="custom-select my-2"
					id="orderRequestOption">
					<option value="0" selected class="mytrend-font3">Choose...</option>
					<option class="mytrend-font3">배송 전 연락 바랍니다.</option>
					<option class="mytrend-font3">부재 시, 휴대폰으로 연락주세요.</option>
					<option class="mytrend-font3">부재 시, 경비실에 맡겨주세요.</option>
				</select> <input type="text" id="orderRequest" placeholder="기타 내용을 입력해주세요."
					class="form-control">
				<div class="d-flex justify-content-end font6 text-dark">최대 30자</div>
				<div class="font6 text-dark mt-5">주문 시 입력한 배송지는 자동으로 배송지 목록에
					추가됩니다.</div>
			</div>

			<!-- 3. 포인트 -->
			<div class="font1 mt-5">3. 포인트 사용</div>
			<hr class="bg-dark">
			<div>
				<div class="font5">포인트</div>
				<div class="d-flex align-items-center">
					<input type="number" id="pointNum" class="col-9 form-control" value="0">
					<input type="button" id="pointBtn" class="text-btn font6"
						value="모두사용">
					<div id="userPoint" class="point-text ml-1">${orderView.totalPoint}</div>
					<div class="point-text">원</div>
				</div>
			</div>

			<!-- 4. 결제-->
			<div class="font1 mt-5">4. 결제</div>
			<hr class="bg-dark">
			<div class="d-flex align-items-center mt-4">
				<input type="checkbox" name="orderCheck" id="orderCheck"> <label
					for="orderCheck" class="font6 m-0 ml-1">주문하실 상품의 상품명, 가격,
					배송정보를 확인하였으며, 이에 동의합니다.</label>
			</div>

			<div class="d-flex mt-3">
				<input type="button" id="orderBtn" value="결제하기" class="mytrend-btn"
					data-user-id="${orderView.user.id}"
					data-basket-id="${orderView.basket.id}">
			</div>
		</div>
		<!-- 주문 상품 -->
		<div class="order-div">
			<div class="font1">주문상품</div>
			<hr class="bg-dark">

			<!-- 상품 -->
			<c:forEach items="${orderView.basketViewList}" var="basketView">
				<div class="d-flex align-items-center m-4">
					<div>
						<img alt="제품 이미지" src="${basketView.product.mainImagePath}"
							width="180px">
					</div>
					<div class="ml-4 w-100">
						<div class="font1">${basketView.product.name}</div>
						<div class="mt-1 font1">${basketView.product.price}</div>
						<div class="mt-4 font1">색상 :
							${basketView.productOption.color}</div>
						<div class="mt-1 font1">사이즈 :
							${basketView.productOption.size}</div>
						<div class="mt-1 font1">수량 :
							${basketView.basketProduct.count}</div>
						<div class="mt-5 font2 d-flex justify-content-end">
							${basketView.product.price*basketView.basketProduct.count}
							<div class="font2">원</div>
						</div>
					</div>
				</div>
				<hr>
			</c:forEach>

			<div class="d-flex justify-content-between m-3">
				<div class="font1">총 상품 금액</div>
				<div class="d-flex">
					<div id="totalPrice" class="font1">${orderView.basket.totalPrice}</div>
					<div class="font1">원</div>
				</div>
			</div>
			<c:if test="${orderView.basket.totalPrice > 300000}">
				<div class="d-flex justify-content-between m-3">
					<div class="font1">배송비</div>
					<div class="d-flex">
						<div class="delivery-charge font1">0</div>
						<div class="font1">원</div>
					</div>
				</div>
			</c:if>
			<c:if test="${orderView.basket.totalPrice <= 300000}">
				<div class="d-flex justify-content-between m-3">
					<div class="font1">배송비</div>
					<div class="d-flex">
						<div class="delivery-charge font1">3000</div>
						<div class="font1">원</div>
					</div>
				</div>
			</c:if>
			<div class="d-flex justify-content-between m-3">
				<div class="font1 text-danger">총 할인금액</div>
				<div class="d-flex">
					<div class="font1 text-danger">-</div>
					<div id="totalPoint" class="font1 text-danger">0</div>
					<div class="font1 text-danger">원</div>
				</div>
			</div>
			<hr class="bg-dark">
			<div class="d-flex justify-content-between m-3 mt-4">
				<div class="font1">총 결제 금액</div>
				<div class="d-flex">
					<div id="totalPay" class="font1"></div>
					<div class="font1">원</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal" tabindex="-1" id="orderModal">
	<div class="modal-dialog modal-dialog-centered modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">Notice</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body" id="modalBody"></div>
		</div>
	</div>
</div>

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
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
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
						} else {
							document.getElementById("sample6_address").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById("sample6_address").value = addr
								+ extraAddr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("sample6_detailAddress")
								.focus();
					}
				}).open();
	}
	
	function requestPay(data) {
    	var IMP = window.IMP; // 생략 가능
    	IMP.init("imp55413628"); // 예: imp00000000
        //IMP.request_pay(param, callback) //결제창 호출
      
      IMP.request_pay({ // param
          pg: "kcp.INIBillTst", //결제대행사 설정에 따라 다르며 공식문서 참고
          pay_method: "card", //결제방법 설정에 따라 다르며 공식문서 참고
          merchant_uid: data.orderId, //주문(db에서 불러옴) 고유번호
          name: data.orderProductName,
          amount: data.order.totalPay,
          buyer_email: data.user.email,
          buyer_name: data.user.name,
          buyer_tel: data.user.phoneNumber,
          buyer_addr: data.address.address + data.address.detailedAddress,
          buyer_postcode: data.address.postcode
      }, function (rsp) { // callback
          if (rsp.success) {
        	  // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
              // jQuery로 HTTP 요청
              jQuery.ajax({
                url: "/order/verify/"+ rsp.imp_uid, 
                method: "POST",
              }).done(function (data) {
            	// 위의 rsp.paid_amount 와 data.response.amount를 비교한후 로직 실행 (iamport 서버검증)
            	  if(rsp.paid_amount == data.response.amount){
  		        	succeedPay(rsp.imp_uid, rsp.merchant_uid);
  	        	} else {
  	        		alert("결제 검증 실패");
  	        	}
              })
          } else {
              $("#orderModal").modal();
    		  $("#orderModal #modalBody").text('결제를 취소하셨습니다.\n 주문 상세 페이지에서 결제를 완료해주세요.');

			  $('#orderModal').on('hidden.bs.modal', function(e) {
	          	location.href="/order/order_deliver_view"
			  });
          }
      });
    }
	
	function succeedPay(imp_uid, merchant_uid){
		$.ajax({  
			 url : '/order/succeed',
			 type : 'POST',
			 async : true,
			 dataType : "Json", 
			 data :{
				imp_uid: imp_uid,            // 결제 고유번호
	            merchant_uid: merchant_uid   // 주문번호 
			 },
			 success : function(data){
				 if(data.code == 1){
					$("#orderModal").modal();
					$("#modalBody").text(data.result);

					$('#orderModal').on('hidden.bs.modal', function(e) {
		            	location.href="/order/order_deliver_view"
					}) 
	            }else{
	            	$("#orderModal").modal();
					$("#modalBody").text('결제가 완료되었으나 에러가 발생했습니다.');

					$('#orderModal').on('hidden.bs.modal', function(e) {
		               	location.href="/order/order_deliver_view"
					})
			 	}
			 }, 
			 error : function (e){
				 alert("에러")
			 }
		});
	}
	
	$(document).ready(function() {
		let totalPrice = $("#totalPrice").text();
		let userPoint = $("#totalPoint").text();
		let deliveryCharge = $(".delivery-charge").text();
		
		// 결제 정보
		const IMP = window.IMP; // 생략 가능
		IMP.init("imp55413628"); // 예: imp00000000a
		
		$("#totalPay").text(parseInt(totalPrice) + parseInt(deliveryCharge) - parseInt(userPoint));
		
		$('input[type=radio][name=addressType]').change(function() {
			var value = $("input[type=radio][name=addressType]:checked").val();
			if (value == "list") {
				$("#adlist").removeClass("d-none");
				$("#newad").addClass("d-none");
			} else if (value == "create") {
				$("#newad").removeClass("d-none");
				$("#adlist").addClass("d-none");
			}
		});

		$("#registerAddressBtn").on("click", function() {
			let name = $("#name").val().trim();
			let phoneNumber = $("#phoneNumber").val().trim();
			let extraPhoneNumber = $("#extraPhoneNumber").val().trim();
			let postcode = $("#sample6_postcode").val();
			let address = $("#sample6_address").val();
			let detailedAddress = $("#sample6_detailAddress").val().trim();
			let defaultAddress = $('#defaultAddress').is(':checked'); // true or false

			if (!name) {
				$("#orderModal").modal();
				$("#modalBody").text("이름을 입력해주세요.");
				return;
			}
			if (!phoneNumber) {
				$("#orderModal").modal();
				$("#modalBody").text("전화번호를 입력해주세요.");
				return;
			}
			if (phoneNumber.includes("-")) {
				$("#orderModal").modal();
				$("#modalBody").text("-없이 숫자만 입력해주세요.");
				return;
			}
			if (extraPhoneNumber.includes("-")) {
				$("#orderModal").modal();
				$("#modalBody").text("-없이 숫자만 입력해주세요.");
				return;
			}
			if (!postcode) {
				$("#orderModal").modal();
				$("#modalBody").text("우편번호를 입력해주세요.");
				return;
			}
			if (!detailedAddress) {
				$("#orderModal").modal();
				$("#modalBody").text("상세 주소를 입력해주세요.");
				return;
			}

			$.ajax({
				type : "POST",
				url : "/address/address_create",
				data : {
					"name" : name,
					"phoneNumber" : phoneNumber,
					"extraPhoneNumber" : extraPhoneNumber,
					"postcode" : postcode,
					"address" : address,
					"detailedAddress" : detailedAddress,
					"defaultAddress" : defaultAddress
				}
				
				, success : function(data) {
					if (data.code == 1) {
						$("#orderModal").modal();
						$("#modalBody").text(data.result);

						$('#orderModal').on('hidden.bs.modal', function(e) {
							location.reload();
						})
					} else {
						$("#orderModal").modal();
						$("#modalBody").text(data.errorMessage);

						$('#orderModal').on('hidden.bs.modal', function(e) {
							location.reload();
						})
					}
				},
				error : function(request, status, error) {
					$("#orderModal").modal();
					$("#modalBody").text("배송지 생성에 실패했습니다.");
					return;
				}
			});

		});
		
		$(".address-btn").on("click", function(){
			// 다른 button 테두리 색 검은색으로
			$(".address-btn").removeClass("address-click");
			// div 테두리 색 변경
			$(this).addClass("address-click");
		});
		
		var addressId = null;
		$("#addressBtn").on("click", function(){
			// 배송지 등록
			addressId = $(".address-click").data("address-id");
			if(!addressId) {
				$("#orderModal").modal();
				$("#modalBody").text("배송지를 선택해주세요.");
				return;
			}
			$("#orderModal").modal();
			$("#modalBody").text("배송지를 선택하였습니다.");
			return;
		});
		
		$("#pointBtn").on("click", function(){
			let userPoint = $("#userPoint").text();
			let totalPrice = $("#totalPrice").text();

			if(userPoint > totalPrice){
				$("#orderModal").modal();
				$("#modalBody").text("사용할 수 있는 최대 포인트는" + (parseInt(totalPrice)-100) + "포인트입니다.");
				
				$("#pointNum").val(parseInt(totalPrice)-100);
				$("#totalPoint").text(parseInt(totalPrice)-100);
				$("#totalPay").text(parseInt(totalPrice) + parseInt(deliveryCharge) - (parseInt(totalPrice)-100));
				return;
			} else {
				$("#pointNum").val(userPoint);
				$("#totalPoint").text(userPoint);
				
				let totalPrice = $("#totalPrice").text();
				userPoint = $("#totalPoint").text();
				
				$("#totalPay").text(totalPrice - userPoint);
			}
		});
		$("#pointNum").change(function(){
			$("#totalPoint").text($(this).val());
			
			let totalPrice = $("#totalPrice").text();
			let totalPoint = $("#totalPoint").text();
			let deliveryCharge = $(".delivery-charge").text();
			
			$("#totalPay").text(parseInt(totalPrice) + parseInt(deliveryCharge) - parseInt(totalPoint));
			
			let userPoint = $("#userPoint").text();
			let usePoint = $(this).val();
			if(parseInt(usePoint) < 0){
				$("#orderModal").modal();
				$("#modalBody").text("사용할 수 있는 포인트는 0포인트부터 사용 가능합니다.");
				
				$("#pointNum").val("");
				$("#totalPoint").text("0");
				$("#totalPay").text(parseInt(totalPrice) + parseInt(deliveryCharge));
				return;
			}
			if(parseInt(usePoint) > userPoint){
				$("#orderModal").modal();
				$("#modalBody").text("사용할 수 있는 최대 포인트는 " + userPoint + "포인트 입니다.");
				
				$("#pointNum").val("");
				$("#totalPoint").text("0");
				$("#totalPay").text(parseInt(totalPrice) + parseInt(deliveryCharge));
				return;
			}
			if(parseInt(usePoint) > parseInt(totalPrice)-100){
				$("#orderModal").modal();
				$("#modalBody").text("사용할 수 있는 최대 포인트는 " + (parseInt(totalPrice)-100) + "포인트 입니다.");
				
				$("#pointNum").val("");
				$("#totalPoint").text("0");
				$("#totalPay").text(parseInt(totalPrice) + parseInt(deliveryCharge));
				return;
			}
		});
		
		$("#orderBtn").on("click", function(){
			// 유저 정보
			let userId = $(this).data("user-id");
			// 배송 정보 - addressId
			// 장바구니 정보
			let basketId = $(this).data("basket-id");
			// 배송 시 요청
			let orderRequetOption = $("#orderRequestOption option:selected").val();
			if(orderRequetOption == 0){
				orderRequetOption = "";
			}
			let orderRequest = orderRequetOption + $("#orderRequest").val();
			// 포인트 사용
			let point = $("#pointNum").val();
			// 결제 정보
			let payType = "카드결제";
			// 동의
			let agreement = $('input[name="orderCheck"]:checked').val();
			// 총 결제 금액
			let totalPay = $("#totalPay").text();
			
			if(!addressId){
				$("#orderModal").modal();
				$("#modalBody").text("배송지를 선택해주세요.");
				return;
			}
			if(!payType){
				$("#orderModal").modal();
				$("#modalBody").text("결제방법을 선택해주세요.");
				return;
			}
			if(!agreement){
				$("#orderModal").modal();
				$("#modalBody").text("주문내용 확인 후 동의부탁드립니다.");
				return;
			}
			
			$.ajax({
				type:"POST"
				, url:"/order/create"
				, data:{"userId":userId, "addressId":addressId, "basketId":basketId,
					"orderRequest":orderRequest, "point":point, "payType":payType, "totalPay":totalPay}
				, async: false
				, success:function(data) {
					if(data.code == 1){
						requestPay(data);
					} else {
						$("#orderModal").modal();
						$("#modalBody").text(data.errorMessage);
						
						$('#orderModal').on('hidden.bs.modal', function (e) {
						     location.reload();
						})
					}
				}
				, error : function(request, status, error) {
					$("#addressModal").modal();
					$("#modalBody").text("배송지 생성에 실패했습니다.");
					return;
				}
			});
		});
	});
</script>