<%@page import="java.time.LocalDate" %>
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

		<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
			<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
			<script>

				$(() => {
						
					

					 $('.ck-blurred').keydown(function(){
					        $("#noticeBrdCn").val(window.editor.getData());
					    });
					    
					    $('.ck-blurred').on("focusout", function(){
					        $("#noticeBrdCn").val(window.editor.getData());
					    });
					 
					



				});


				//자동 등록
				function autoFill() {

					let textAreaInput = "2024년 하반기 워크샵 공지 ";
					let noticeBrdSeCd = "1";
					let fixingDate = "2024-05-12";
					let textAreaInputCn="직원여러분!<br>정신없이 달려온 2024년 하반기를 돌아보고, 잠시동안의 휴식과 재충전을 위한 워크샵이 개최될 예정입니다.<br>아래 세부일정대로 진행될 예정이오니, 모두 참여하여 즐겁고 의미있는 시간 보내시기 바랍니다.<br>열정을 제대로 보여주시는 3인에게는 어마어마한 상품을 안겨드릴 예정입니다.<br><br><br>1등 : 에어팟 맥스<br>2등 : 다이슨 청소기<br>3등 : 마샬 스피커<br>모범사원상 : 현금지급<br>레크레이션 우수팀 : 현금지금<br><br>이외에도 다양한 경품을 받을 수 있는 스페셜 이벤트 보물찾기를 진행합니다~! <br>체크인 시간 이후부터 숙소, 대연회장 곳곳에 숨겨진 다양한 보물을 찾아주세요~!<br>(ex, 삼다정 런치 뷔페권, 스타벅스 상품권, 탐나는전 상품권 등등) <br><br>저녁식사 이후 시상식 때 경품 교환해 드리겠습니다.<br><br><br>-준비물<br>보구정제주 단체 후드티, 물놀이 후 입을 여벌옷, 슬리퍼, 세면도구<br>";


					$('#noticeBrdSeCd').val(noticeBrdSeCd);
					$('#fixingEndDate').val(fixingDate);
					$('#noticeBrdSj').val(textAreaInput);

					editor.setData(textAreaInputCn);
					document.getElementById("noticeBrdCn").value = textAreaInputCn;
				};
			</script>
			<!DOCTYPE html>
			<html>

			<body>
				<div class="wf-main-container">
					<!-- =============== body 시작 =============== -->
					<!-- =============== 상단타이틀영역 시작 =============== -->
					<form action="/notice/creatNotice?${_csrf.parameterName}=${_csrf.token}" method="post"
						enctype="multipart/form-data">
						<div class="wf-tit-wrap" data-aos="fade-right" data-aos-duration="700" data-aos-delay="0">
							<h1 class="page-tit">공지 게시판 등록</h1>
							<div class="wf-util">
								<button type="button" class="btn1" onclick="autoFill()">자동 완성</button>
								<button type="button" class="btn1" onclick="location.href='/notice/list'">취소</button>
								<button type="submit" id="submitBtn" class="btn2">등록</button>
							</div>
						</div>
						<!-- =============== 상단타이틀영역 끝 =============== -->
						<!-- =============== 컨텐츠 영역 시작 =============== -->
						<div class="wf-content-wrap" data-aos="fade-right" data-aos-duration="700" data-aos-delay="200">

							<div class="wf-content-area">

								<!-- 등록폼 시작 -->
								<ul class="wf-insert-form3">
									<li>
										<input type="hidden" id="empNo" name="empNo" value="<%=session.getAttribute("empNo")%>">
										<div class="wf-insert-tit">
											<div class="wf-select-group">
												<select name="noticeBrdSeCd" id="noticeBrdSeCd" required>
													<option value="1">일반</option>
													<option value="2">인사</option>
												</select>
											</div>
											<input type="text" id="noticeBrdSj" name="noticeBrdSj"
												placeholder="제목을 입력해주세요">
											<input type="date" name="fixingEndDate" id="fixingEndDate"
												min="<%= LocalDate.now() %>">
										</div>
									</li>
									<li>
										<div id="ckExam"></div> <textarea name="noticeBrdCn"
										id="noticeBrdCn" placeholder="내용을 입력해주세요." style="display:none;"
										 ></textarea>
									</li>
									<li><input type="file" name="uploadfile" id="uploadfile" multiple></li>
								</ul>
							</div>
						</div>
					</form>
					<!-- 등록폼 끝 -->
				</div>
				<!-- =============== 컨텐츠 영역 끝 =============== -->
				<!-- =============== body 끝 =============== -->

			</body>

			</html>
			
			<script type="text/javascript">
				ClassicEditor
				.create( document.querySelector('#ckExam'),{ckfinder:{uploadUrl:'/upload/uploads?${_csrf.parameterName}=${_csrf.token}'}})
				 .then(editor=>{window.editor=editor;})
				 .catch(err=>{console.error(err.stack);});
		</script>
		<script type="text/javascript">
						window.editor.setData("내용을 입력해주세요");
				</script>