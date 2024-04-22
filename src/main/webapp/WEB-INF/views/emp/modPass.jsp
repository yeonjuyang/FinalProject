<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.swal2-container {
	z-index: 100000;
}
</style>
	<div class="login-container">
		<div class="login-wrap">
			<h1 class="logo-wrap">
				<span class="logo">WORKFOREST</span>
			</h1>
			<h2 class="logo-wrap">비밀번호 변경</h2>
			<div class="input pw">
				<input type="hidden" name="empNo" id="empNo" value="${empNo}" /> <input
					type="password" name="empPw1" value="" placeholder="새 비밀번호 입력하세요"
					class="form-control" id="empPw1" />
			</div>
			<br>
			<div class="input pw">
				<input type="password" name="empPw2" value=""
					placeholder="새 비밀번호를 한번 더 입력하세요" class="form-control" id="empPw2" />
			</div>
			<br>
			<br>
			<div class="wf-util">
				<button type="button" class="btn1" id="cancel">취소</button>
				<button type="button" class="btn2" id="confirm">등록</button>
			</div>
		</div>
	</div>
<!-- </body> -->
<script type="text/javascript">
//확인(수정)
$("#confirm").on("click",function() {
	
	let empNo = $("#empNo").val();
	let empPw1 = $("#empPw1").val(); //수정 대상
	let empPw2 = $("#empPw2").val();
	
	// 새 비밀번호 입력 확인
    if(empPw1 !== empPw2) {
     alert("비밀번호가 일치하지 않습니다.");  
//     	   Swal.fire({
//             title: "비밀번호가 일치하지 않습니다.",
//             icon: "error"
//         });
         return;
    }
	
	//json오브젝트
	let data = {
		"empNo": empNo,
		"empPw": empPw1
	};
	console.log("data : ",data);
	

	
	$.ajax({
		url: "/emp/modPass",
		contentType: "application/json;charset=utf-8",
		data: JSON.stringify(data),
		type: "post",
		dataType: "text",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result :",result);	
			alert("비밀번호가 변경되었습니다.");
			
			$("#cancel").click();
		}
	});
});

//취소 버튼 클릭시
$("#cancel").on("click",function(){
 	let empNo=$("#empNo").val();
	location.href="/emp/detail?empNo="+empNo;
});

</script>
