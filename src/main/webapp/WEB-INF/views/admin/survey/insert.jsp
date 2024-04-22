<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
.wf-insert-form{
    padding:10px;
}
    
</style>

    <script>
        let choiceCounter = 1;

        //증가시킬 카운터
        let counter = 1;

        let __checkBoxDivNum = 2;

        $(() => {

            // 사원 자동 검색
            $('#empSearch').autocomplete({
                source: function (request, response) { //source: 입력시 보일 목록
                    console.log("체크 --->", this.element[0].value);
                    autoNm = this.element[0].value;
                    //console.log("auto2" ,autoNm);
                    data = {
                        "empNm": autoNm,
                    }
                    //아작스 시작   
                    $.ajax({
                        url: "/admin/survey/empSearch",
                        data: JSON.stringify(data),
                        contentType: "application/json;charset=utf-8",
                        type: "post",
                        dataType: 'json',
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                        },
                        success: function (res) { 	// 성공
                            console.log("res--->", res);
                            response(
                                $.map(res, function (item) {
                                    console.log("item ---->", item);

                                    return {
                                        label: item.empNm,
                                        value: item.empNm,
                                        empNo: item.empNo
                                    }
                                })
                            );    //response 
                        }
                    });
                    //아작스 끝  
                },
                focus: function (event, ui) { // 방향키로 자동완성단어 선택 가능하게 만들어줌	
                    return false;
                }
                , minLength: 1// 최소 글자수
                , autoFocus: true // true == 첫 번째 항목에 자동으로 초점이 맞춰짐
                , delay: 100	//autocomplete 딜레이 시간(ms)
                , select: function (evt, ui) {
                    // 아이템 선택시 실행 ui.item 이 선택된 항목을 나타내는 객체, lavel/value/idx를 가짐
                    console.log(ui.item.label);
                    console.log("선택됌---->", ui.item.empNo);
                    document.getElementById("hdnEmpNo").value = ui.item.empNo;
                }
            });



            // 직원 개개인 추가
            $(document).on("click", "#empPlus", function () {
                console.log("버튼 누름");
                let th = this;
                console.log("th ---> ", th);


                let empNo = $("#hdnEmpNo").val(); // jQuery로 요소 선택
                console.log("empNo ---> ", empNo);


                let ev = $(th).closest(".wf-insert-form");
                console.log("insertArea --> ", ev);

                let evv = ev.find("#inputSelectEmp");
                console.log("insertArea4---->", evv);

                let inputArea = evv.find("#inputSelectEmpCh");
                console.log("inputArea ---> ", inputArea);

                let data = {
                    empNo: empNo,
                }

                $.ajax({
                    url: "/admin/survey/emp/imp",
                    data: JSON.stringify(data),
                    contentType: "application/json;charset=utf-8",
                    type: "post",
                    dataType: "json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                    success: function (res) {
                        console.log("res---->", res);
                        let str = "";
                        str += "<span class='wf-badge2'>" + res.deptNm + "&nbsp;" + res.empNm + "&nbsp;" + res.rspnsblCtgryNm + "&nbsp;&nbsp;<button type='button' class='del-btn empDelete'>";
                        str += "<input type='hidden' value='" + res.empNo + "'name='surveyParticEmpNo'  />";
                        str += "<i class='xi-close'>";
                        str += "</i>";
                        str += "</button>";
                        str += "</span>";

                        $(inputArea).append(str);
                        $("#empSearch").val("");

                    },
                });


            });



            //삭제
            $(document).on("click", ".empDelete", function () {
                console.log("버튼 누름")

                let th = this;
                console.log("th---> ", th);

                let deleteArea = th.closest(".wf-badge2");
                console.log("deleteArea", deleteArea);

                deleteArea.remove();

            });



            ///____________________________________________________________부서 시작
            //부서별로 선택
            $('#deptSearch').autocomplete({
                source: function (request, response) { //source: 입력시 보일 목록
                    console.log("체크 --->", this.element[0].value);
                    autoNm = this.element[0].value;
                    //console.log("auto2" ,autoNm);
                    data = {
                        "deptNm": autoNm,
                    }
                    //아작스 시작   
                    $.ajax({
                        url: "/admin/survey/deptSearch",
                        data: JSON.stringify(data),
                        contentType: "application/json;charset=utf-8",
                        type: "post",
                        dataType: 'json',
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                        },
                        success: function (res) { 	// 성공
                            console.log("res--->", res);
                            response(
                                $.map(res, function (item) {
                                    console.log("item ---->", item.deptNm);
                                    console.log("체크2 ---->", item.deptNo);

                                    return {
                                        label: item.deptNm,
                                        value: item.deptNm,
                                        deptNo: item.deptNo
                                    }
                                })
                            );    //response 
                        }
                    });
                    //아작스 끝  
                },
                focus: function (event, ui) { // 방향키로 자동완성단어 선택 가능하게 만들어줌	
                    return false;
                }
                , minLength: 1// 최소 글자수
                , autoFocus: true // true == 첫 번째 항목에 자동으로 초점이 맞춰짐
                , delay: 100	//autocomplete 딜레이 시간(ms)
                , select: function (evt, ui) {
                    // 아이템 선택시 실행 ui.item 이 선택된 항목을 나타내는 객체, lavel/value/idx를 가짐
                    console.log(ui.item.label);
                    console.log("선택됌---->", ui.item);
                    document.getElementById("hdnDeptNo").value = ui.item.deptNo;
                }
            });






            //부서별로 선택
            $(document).on("click", "#deptPlus", function () {
                console.log("클릭함");
                let th = this;
                console.log("th ---> ", th);


                let deptNo = $("#hdnDeptNo").val(); // jQuery로 요소 선택
                console.log("deptNo ---> ", deptNo);


                let ev = $(th).closest(".wf-insert-form");
                console.log("insertArea --> ", ev);

                let evv = ev.find("#inputSelectdept");
                console.log("insertArea4---->", evv);

                let inputArea = evv.find("#inputSelectDeptCh");
                console.log("inputArea ---> ", inputArea);

                let data = {
                    deptNo: deptNo,
                }

                $.ajax({
                    url: "/admin/survey/dept/imp",
                    data: JSON.stringify(data),
                    contentType: "application/json;charset=utf-8",
                    type: "post",
                    dataType: "json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                    success: function (res) {
                        console.log("res---->", res);


                        let str = "";
                        str += "<span class='wf-badge2'>" + res.deptNm + "&nbsp;&nbsp;<button type='button' class='del-btn empDelete'>";
                        str += "<input type='hidden' value='" + res.deptNo + "'  name='deptNo' />";
                        str += "<i class='xi-close'>";
                        str += "</i>";
                        str += "</button>";
                        str += "</span>";


                        $(inputArea).append(str);
                        $("#deptSearch").val("");

                    },
                });

            });


            //------------------------------------------------------------------------------------------------설문지 질문 목록

            //설문 질문 목록 만들기
            $(document).on("click", "#Surveyplus", function () {
                console.log("플러스 체크")
                let parentClass = $(this).closest(".selectOptionSurvey");
                console.log("parentClass --> ", parentClass);

                let checkedRadio = parentClass.find('input[name="surveytype"]:checked');
                if (checkedRadio.length > 0) {
                    console.log("checkedRadio value --> ", checkedRadio.val());
                    const newElement = document.createElement('div');
                    newElement.id = 'surveyOptionList' + counter;
                    // input 할 부모
                    const parentDiv = document.getElementsByClassName('inputAreaSurvey')[0];
                    console.log(parentDiv);
                    let str = "";
                    switch (checkedRadio.val()) {
                        case "1":
                            console.log("1번");
                            str = getForm(1, counter, __checkBoxDivNum)
                            console.log("str ---> ", str);
                            newElement.innerHTML = str;
                            parentDiv.appendChild(newElement);
                            counter++;
                            break;
                        case "2":
                            console.log("2번");
                            str = getForm(2, counter, __checkBoxDivNum)
                            console.log("str ---> ", str);
                            newElement.innerHTML = str;
                            parentDiv.appendChild(newElement);
                            counter++;
                            break;
                        case "3":
                            console.log("3번")
                            str = getForm(3, counter)
                            console.log("str ---> ", str);
                            newElement.innerHTML = str;
                            parentDiv.appendChild(newElement);
                            counter++;
                            break;
                        default:
                            break;
                    }
                } else {
                    alert("설문 문항 타입을 선택하세요.")
                    console.log("선택된 라디오 버튼이 없습니다.");
                }





            });


            // 질문 삭제
            $(document).on("click", "#Surveyminus", function () {
                console.log("마이너스 체크")
                console.log("counter값", counter);
                let minusCounter = counter;     // 무조건 최대값 +할시 하나 증가할 때 counter = 2
                minusCounter -= 1
                console.log("counter값", minusCounter);
                const element = document.getElementById('surveyOptionList' + minusCounter);
                console.log("element", element);

                element.remove();
                counter--;
            });



            $(document).on("click", "#detailplus", function () {
                let str = "";
                console.log("체크++++++");
                let th = this;
                console.log("이 this ---> ", th);
                const wfContentBox = this.closest('.wf-content-area');
                console.log("wfContentBox---->", wfContentBox);
                const surveyTypeCd = wfContentBox.dataset.surveyTypeCd;
                console.log("surveyTypeCd ----> ", surveyTypeCd);
                const targetElement = document.getElementById('surveyRespon1');
                console.log("targetElement--->", targetElement);
                let firstInput = targetElement.dataset.setNum;
                console.log("eee--->", firstInput);

                const num = wfContentBox.dataset.noNum;
                console.log("num----->",num);


                // 마지막 요소
                var checkboxes = document.querySelectorAll('.wf-content-area .checkbox-radio-custom');
                var lastCheckbox = checkboxes[checkboxes.length - 1];
                console.log("lastCheckbox ----> ", lastCheckbox);



                var dataNum = lastCheckbox.dataset.setNum;
                console.log("dataNum----->", dataNum);





                str = checkBoxDiv(surveyTypeCd, dataNum, __checkBoxDivNum ,num);

                wfContentBox.insertAdjacentHTML('beforeend', str);



            });


            // 선택지 삭제
            $(document).on("click", "#detailminus", function () {
                console.log("체크----");
                let th = this;
                console.log("이 this ---> ", th);
                let parentClass = th.closest(".wf-content-area");
                console.log("parentClass --->", parentClass);
                var checkboxes = document.querySelectorAll('.wf-content-area .checkbox-radio-custom');
                var lastCheckbox = checkboxes[checkboxes.length - 1];
                console.log("lastCheckbox---->", lastCheckbox);

                lastCheckbox.remove();
            });





        });

        //체크 박스 radio 분류 함수
        function checkBoxDiv(check22, dataNum, notData ,num) {
            console.log("check222--->", check22);
            console.log("dataNum----> ", dataNum);
            console.log("notData---->", notData);
            console.log("num------->", num);
            ++dataNum;
            __checkBoxDivNum++;
            console.log("notData--->", notData);
            let str = "";
            if (check22 == 1) {
                str += "<ul class='checkbox-radio-custom' id='surveyRespon" + dataNum + "'  data-set-num='" + dataNum + "'>";
                str += "<li>";
                str += "<input type='radio' name='radio' id='rad" + notData + "'>";
                str += "<label for='rad" + notData + "'>";
                str += "<ul class='wf-insert-form'>";
                str += "<input  type='text' id='choiceNum"+choiceCounter+"' placeholder='선택지 문항을 작성해주세요' name='surveyChoiceList["+num+"].surveyChoiceSj' />";
                str += "</ul>";
                str += "</label>";
                str += "</li>";
                str += "</ul>";
                choiceCounter++;
                return str;
            } else if (check22 == 2) {
                console.log(check22)
                console.log("dataNum----->", dataNum)
                str += "<ul class='checkbox-radio-custom' id='surveyRespon" + dataNum + "' data-set-num='" + dataNum + "'>";
                str += "<li>";
                str += "<input type='checkbox' id='check" + notData + "'>";
                str += "<label for='check" + notData + "'>";
                str += "<ul class='wf-insert-form'>";
                str += "<input type='text' id='choiceNum"+choiceCounter+"'  placeholder='선택지 문항을 작성해주세요' name='surveyChoiceList["+num+"].surveyChoiceSj' />";
                str += "</ul>";
                str += "</label>";
                str += "</li>";
                str += "</ul>";
                choiceCounter++;
                return str;
            }
        }





        // 설문 목록 함수
        function getForm(SurveytypeNum, counter, dataNum) {
            console.log("SurveytypeNum ---> ", SurveytypeNum);
            console.log("counter ---> ", counter);
            console.log("dataNum--->", dataNum);
            __checkBoxDivNum++;
            let counter2 = counter-1;
            let str = "";
            // 1번 객관일 경우
            if (SurveytypeNum == 1) {
                console.log("1번 선택");
                str += ""
                str += "<br>";
                str += "<div class='wf-content-area' data-survey-type-cd='" + SurveytypeNum + "' data-No-Num='"+counter2+"' >";
                str += "<input type='hidden' name='surveyQuestionList["+counter2+"].surveyQuestionTypeCd' value='"+ SurveytypeNum +"' />";
                str += "<input type='hidden' name='surveyChoiceList["+counter2+"].surveyQuestionId'  value='"+counter+"'/>";
                str += "<p class='box-heading1'>" + counter + "</p>";
                str += "<input type='hidden' name='surveyQuestionList["+counter2+"].surveyQuestionId' value='"+counter+"'/>";
                str += "<button type='button' style='float: right;' class='btn2  Surveyminus' id='detailminus'>";
                str += "<i class='xi-minus'>";
                str += "</i>";
                str += "</button>";
                str += "<button type='button' style='float: right;' class='btn2  Surveyplus' id='detailplus'>";
                str += "<i class='xi-plus'>";
                str += "</i>";
                str += "</button>";
                str += "<p>문항 질문 :</p>";
                str += "<ul class='wf-insert-form'>";
                str += "<input type='text' id='autoQuestion"+counter+"' placeholder='질문 문항을 작성해주세요' name='surveyQuestionList["+counter2+"].surveyQuestionSj' />";
                str += "</ul>";

                //질문 답변 항목
                str += "<ul class='checkbox-radio-custom' id='surveyRespon1' data-set-num='1'>";
                str += "<li>";
                str += "<input type='radio' name='radio' id='rad" + dataNum + "'>";
                str += "<label for='rad" + dataNum + "'>";
                str += "<ul class='wf-insert-form'>";
                str += "<input  type='text' id='choiceNum"+choiceCounter+"' placeholder='선택지 문항을 작성해주세요' name='surveyChoiceList["+counter2+"].surveyChoiceSj' />";
                str += "</ul>";
                str += "</label>";
                str += "</li>";
                str += "</ul>";
                //질문 답변 항목 끝
                
                str += "</div>";
                str += "<br>";
                choiceCounter++;
                return str;
            }
            else if (SurveytypeNum == 2) {
                //2번 선택  counter2 ---> index값
                console.log("2번 선택")
                str += "<br>";
                str += "<div class='wf-content-area'  data-survey-type-cd='" + SurveytypeNum + "'  data-No-Num='"+counter2+"' >";
                str += "<input type='hidden' name='surveyQuestionList["+counter2+"].surveyQuestionTypeCd' value='"+ SurveytypeNum +"' />";
                str += "<p class='box-heading1'>" + counter + "</p>";
                str += "<input type='hidden' name='surveyQuestionList["+counter2+"].surveyQuestionId' value='"+counter+"'/>";
                str += "<input type='hidden' name='surveyChoiceList["+counter2+"].surveyQuestionId'  value='"+counter+"'/>";
                str += "<button type='button' style='float: right;' class='btn2  Surveyminus' id='detailminus'>";
                str += "<i class='xi-minus'>";
                str += "</i>";
                str += "</button>";
                str += "<button type='button' style='float: right;' class='btn2  Surveyplus' id='detailplus'>";
                str += "<i class='xi-plus'>";
                str += "</i>";
                str += "</button>";
                str += "<p>문항 질문 :</p>";
                str += "<ul class='wf-insert-form'>";
                str += "<input  type='text' id='autoQuestion"+counter+"' placeholder='질문 문항을 작성해주세요' name='surveyQuestionList["+counter2+"].surveyQuestionSj' />";
                str += "</ul>";
                //질문 답변 항목 
                str += "<ul class='checkbox-radio-custom' id='surveyRespon1' data-set-num='1'>";
                str += "<li>";
                str += "<input type='checkbox' id='check" + dataNum + "'  >";
                str += "<label for='check" + dataNum + "'>";
                str += "<ul class='wf-insert-form'>";
                str += "<input  type='text' id='choiceNum"+choiceCounter+"'  placeholder='선택지 문항을 작성해주세요' name='surveyChoiceList["+counter2+"].surveyChoiceSj' />";
                str += "</ul>";
                str += "</label>";
                str += "</li>";
                str += "</ul>";
                // 질문 답변 항목 끝
                str += "</div>";
                str += "<br>";
                choiceCounter++;
                return str;
            }
            else if (SurveytypeNum == 3) {
                console.log("3번 선택")
                str += "<br>";
                str += "<div class='wf-content-area'  data-survey-type-cd='" + SurveytypeNum + "'>";
                str += "<input type='hidden' name='surveyQuestionList["+counter2+"].surveyQuestionTypeCd' value='"+ SurveytypeNum +"' />";
                str += "<p class='box-heading1'>" + counter + "</p>";
                str += "<input type='hidden' name='surveyQuestionList["+counter2+"].surveyQuestionId' value='"+counter+"'/>";
                str += "<p>문항 질문 :</p>";
                str += "<ul class='wf-insert-form'>";
                str += "<input type='text' id='autoQuestion"+counter+"' placeholder='질문 문항을 작성해주세요' name='surveyQuestionList["+counter2+"].surveyQuestionSj' />";
                str += "</ul>";
                str += "</div>";
                str += "<br>";
                return str;
            }
            //2번 체크박스 일 경우

        }



        
      

/* 
    $(document).on("click", ".surveyCreate", function () {
        let selectedEmpNo = $("#hdnEmpNo").val();
        let selectedDeptNo = $("#hdnDeptNo").val();
        
        // 직원과 부서 모두 선택하지 않은 경우
        if (!selectedEmpNo && !selectedDeptNo) {
            alert("직원과 부서중 하나를 선택하세요.");
            return false; // 폼 제출을 막음
        } 
    });
         */
    
	//자동 채우기
    function autoFill(){
        // 제목
        var title = "직무 만족도 조사";
        // 설문 조사 마감일 
        var date = "2024-05-12";
        
        // 익명 비익명 설정 버튼
        clickRadioButton();
        
        $("#autoTitle").val(title);
        $("#autoDate").val(date);
		
        // 사원번호 입력 하면 자동으로 추가되는 방식
        let autoEmpNo =['2019001','2019002','2019003','2019004','2019005','2019006','2019007','2019202'];
        console.log("autoEmpNo--->",autoEmpNo);
        let inputArea =document.getElementById("inputSelectEmpCh");
        console.log("inputArea---->",inputArea);
        let data ={
            autoEmpNo:autoEmpNo,
        };
        // 사원 자동완성
        $.ajax({
            url: "/admin/survey/autoEmp",
            data: JSON.stringify(data),
            contentType: "application/json;charset=utf-8",
            type: "post",
            dataType: "json",
            beforeSend: function (xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
        success: function (res) {
            let str ="";
                for(let i = 0 ; i<res.length;i++){
                    str += "<span class='wf-badge2'>" + res[i].deptNm + "&nbsp;" + res[i].empNm + "&nbsp;" + res[i].cmmnCdNm + "&nbsp;&nbsp;<button type='button' class='del-btn empDelete'>";
                    str += "<input type='hidden' value='" + res[i].empNo + "'name='surveyParticEmpNo'  />";
                    str += "<i class='xi-close'>";
                    str += "</i>";
                    str += "</button>";
                    str += "</span>";
                }
                $(inputArea).append(str);
            },
        });

    }
        
	//라디오 버튼 선택(radio1:익명 , radio2:비익명)
    function clickRadioButton() {
        document.getElementById("radio1").checked = true; // 라디오 버튼을 선택 상태로 변경
    }


//////////////////////////////////////@@@@@@@@@@@@자동완성
    //질문 자동으로 채우기
    function autoQuestionFill(){
		let inputArea = $('.inputAreaSurvey');
        console.log("inputArea--->",inputArea[0]);
        let str ="";

        str+=`<div id="surveyOptionList1">
        	<br>
        	<div class="wf-content-area" data-survey-type-cd="1" data-no-num="0">
        	<input type="hidden" name="surveyQuestionList[0].surveyQuestionTypeCd" value="1">
        	<input type="hidden" name="surveyChoiceList[0].surveyQuestionId" value="1">
        	<p class="box-heading1">1</p>
        	<input type="hidden" name="surveyQuestionList[0].surveyQuestionId" value="1">
        	<button type="button" style="float: right;" class="btn2  Surveyminus" id="detailminus">
        	<i class="xi-minus">
        	</i>
        	</button>
        	<button type="button" style="float: right;" class="btn2  Surveyplus" id="detailplus">
        	<i class="xi-plus">
        	</i>
        	</button><p>문항 질문 :</p>
        	<ul class="wf-insert-form">
        	<input type="text" id="autoQuestion1" placeholder="질문 문항을 작성해주세요" value="나는 내가 하는 업무에 대해 전반적으로 만족한다." name="surveyQuestionList[0].surveyQuestionSj">
        	</ul>
        	<ul class="checkbox-radio-custom" id="surveyRespon1" data-set-num="1">
        	<li>
        	<input type="radio" name="radio" id="rad2"><label for="rad2">
        	<ul class="wf-insert-form">
        	<input type="text" id="choiceNum1" placeholder="선택지 문항을 작성해주세요" value="매우불만족" name="surveyChoiceList[0].surveyChoiceSj">
        	</ul>
        	</label>
        	</li>
        	</ul>
        	<ul class="checkbox-radio-custom" id="surveyRespon2" data-set-num="2">
        	<li>
        	<input type="radio" name="radio" id="rad3">
        	<label for="rad3"><ul class="wf-insert-form">
        	<input type="text" id="choiceNum2" placeholder="선택지 문항을 작성해주세요" value="불만족" name="surveyChoiceList[0].surveyChoiceSj">
        	</ul>
        	</label>
        	</li>
        	</ul>
        	<ul class="checkbox-radio-custom" id="surveyRespon3" data-set-num="3">
        	<li>
        	<input type="radio" name="radio" id="rad4"><label for="rad4">
        	<ul class="wf-insert-form">
        	<input type="text" id="choiceNum3" placeholder="선택지 문항을 작성해주세요" value="보통" name="surveyChoiceList[0].surveyChoiceSj">
        	</ul>
        	</label>
        	</li>
        	</ul>
        	<ul class="checkbox-radio-custom" id="surveyRespon4" data-set-num="4">
        	<li>
        	<input type="radio" name="radio" id="rad5">
        	<label for="rad5"><ul class="wf-insert-form">
        	<input type="text" id="choiceNum4" placeholder="선택지 문항을 작성해주세요" value="만족" name="surveyChoiceList[0].surveyChoiceSj">
        	</ul>
        	</label>
        	</li>
        	</ul>
        	<ul class="checkbox-radio-custom" id="surveyRespon5" data-set-num="5">
        	<li>
        	<input type="radio" name="radio" id="rad6"><label for="rad6">
        	<ul class="wf-insert-form">
        	<input type="text" id="choiceNum5" placeholder="선택지 문항을 작성해주세요" value="매우만족" name="surveyChoiceList[0].surveyChoiceSj">
        	</ul>
        	</label>
        	</li>
        	</ul>
        	</div>
        	<br>
        	</div>
        	

        	<div id="surveyOptionList2">
            <br>
            <div class="wf-content-area" data-survey-type-cd="1" data-no-num="1">
            <input type="hidden" name="surveyQuestionList[1].surveyQuestionTypeCd" value="1">
            <input type="hidden" name="surveyChoiceList[1].surveyQuestionId" value="2">
            <p class="box-heading1">2</p>
            <input type="hidden" name="surveyQuestionList[1].surveyQuestionId" value="2">
            <button type="button" style="float: right;" class="btn2  Surveyminus" id="detailminus">
            <i class="xi-minus">
            </i>
            </button>
            <button type="button" style="float: right;" class="btn2  Surveyplus" id="detailplus">
            <i class="xi-plus">
            </i>
            </button><p>문항 질문 :</p>
            <ul class="wf-insert-form">
            <input type="text" id="autoQuestion2" placeholder="질문 문항을 작성해주세요" value="내게 주어진 업무의 양은 적당하다." name="surveyQuestionList[1].surveyQuestionSj">
            </ul>
            <ul class="checkbox-radio-custom" id="surveyRespon1" data-set-num="1">
            <li>
            <input type="radio" name="radio" id="rad7">
            <label for="rad7"><ul class="wf-insert-form">
            <input type="text" id="choiceNum6" placeholder="선택지 문항을 작성해주세요" value="매우불만족" name="surveyChoiceList[1].surveyChoiceSj">
            </ul>
            </label>
            </li>
            </ul>
            <ul class="checkbox-radio-custom" id="surveyRespon2" data-set-num="2">
            <li>
            <input type="radio" name="radio" id="rad8"><label for="rad8">
            <ul class="wf-insert-form">
            <input type="text" id="choiceNum7" placeholder="선택지 문항을 작성해주세요" value="불만족" name="surveyChoiceList[1].surveyChoiceSj">
            </ul>
            </label>
            </li>
            </ul>
            <ul class="checkbox-radio-custom" id="surveyRespon3" data-set-num="3">
            <li>
            <input type="radio" name="radio" id="rad9"><label for="rad9">
            <ul class="wf-insert-form">
            <input type="text" id="choiceNum8" placeholder="선택지 문항을 작성해주세요" value="보통" name="surveyChoiceList[1].surveyChoiceSj">
            </ul>
            </label>
            </li>
            </ul>
            <ul class="checkbox-radio-custom" id="surveyRespon4" data-set-num="4">
            <li>
            <input type="radio" name="radio" id="rad10">
            <label for="rad10"><ul class="wf-insert-form">
            <input type="text" id="choiceNum9" placeholder="선택지 문항을 작성해주세요" value="만족" name="surveyChoiceList[1].surveyChoiceSj">
            </ul>
            </label>
            </li>
            </ul>
            <ul class="checkbox-radio-custom" id="surveyRespon5" data-set-num="5">
            <li>
            <input type="radio" name="radio" id="rad11">
            <label for="rad11">
            <ul class="wf-insert-form">
            <input type="text" id="choiceNum10" placeholder="선택지 문항을 작성해주세요" value="매우만족" name="surveyChoiceList[1].surveyChoiceSj">
            </ul>
            </label>
            </li>
            </ul>
            </div>
            <br>
            </div>
        	

            <div id="surveyOptionList3">
            <br>
            <div class="wf-content-area" data-survey-type-cd="1" data-no-num="2">
            <input type="hidden" name="surveyQuestionList[2].surveyQuestionTypeCd" value="1">
            <input type="hidden" name="surveyChoiceList[2].surveyQuestionId" value="3">
            <p class="box-heading1">3</p>
            <input type="hidden" name="surveyQuestionList[2].surveyQuestionId" value="3">
            <button type="button" style="float: right;" class="btn2  Surveyminus" id="detailminus">
            <i class="xi-minus">
            </i>
            </button>
            <button type="button" style="float: right;" class="btn2  Surveyplus" id="detailplus">
            <i class="xi-plus"></i></button>
            <p>문항 질문 :</p>
            <ul class="wf-insert-form">
            <input type="text" id="autoQuestion3" placeholder="질문 문항을 작성해주세요" value="업무수행 중 나의 의견은 충분히 반영되고 있다." name="surveyQuestionList[2].surveyQuestionSj">
            </ul>
            <ul class="checkbox-radio-custom" id="surveyRespon1" data-set-num="1">
            <li>
            <input type="radio" name="radio" id="rad14">
            <label for="rad14">
            <ul class="wf-insert-form">
            <input type="text" id="choiceNum13" placeholder="선택지 문항을 작성해주세요" value="매우불만족" name="surveyChoiceList[2].surveyChoiceSj">
            </ul>
            </label>
            </li>
            </ul>
            <ul class="checkbox-radio-custom" id="surveyRespon2" data-set-num="2">
            <li>
            <input type="radio" name="radio" id="rad15">
            <label for="rad15">
            <ul class="wf-insert-form">
            <input type="text" id="choiceNum14" placeholder="선택지 문항을 작성해주세요" value="불만족" name="surveyChoiceList[2].surveyChoiceSj">
            </ul>
            </label>
            </li>
            </ul>
            <ul class="checkbox-radio-custom" id="surveyRespon3" data-set-num="3">
            <li>
            <input type="radio" name="radio" id="rad16">
            <label for="rad16">
            <ul class="wf-insert-form">
            <input type="text" id="choiceNum15" placeholder="선택지 문항을 작성해주세요" value="보통" name="surveyChoiceList[2].surveyChoiceSj">
            </ul>
            </label>
            </li>
            </ul>
            <ul class="checkbox-radio-custom" id="surveyRespon4" data-set-num="4">
            <li>
            <input type="radio" name="radio" id="rad17">
            <label for="rad17">
            <ul class="wf-insert-form">
            <input type="text" id="choiceNum16" placeholder="선택지 문항을 작성해주세요" value="만족" name="surveyChoiceList[2].surveyChoiceSj">
            </ul>
            </label>
            </li>
            </ul>
            <ul class="checkbox-radio-custom" id="surveyRespon5" data-set-num="5">
            <li>
            <input type="radio" name="radio" id="rad18">
            <label for="rad18"><ul class="wf-insert-form">
            <input type="text" id="choiceNum17" placeholder="선택지 문항을 작성해주세요" value="매우만족" name="surveyChoiceList[2].surveyChoiceSj">
            </ul>
            </label>
            </li>
            </ul>
            </div>
            <br>
            </div>
        	

            <div id="surveyOptionList4">
            <br>
            <div class="wf-content-area" data-survey-type-cd="1" data-no-num="3">
            <input type="hidden" name="surveyQuestionList[3].surveyQuestionTypeCd" value="1">
            <input type="hidden" name="surveyChoiceList[3].surveyQuestionId" value="4">
            <p class="box-heading1">4</p>
            <input type="hidden" name="surveyQuestionList[3].surveyQuestionId" value="4">
            <button type="button" style="float: right;" class="btn2  Surveyminus" id="detailminus">
            <i class="xi-minus">
            </i>
            </button>
            <button type="button" style="float: right;" class="btn2  Surveyplus" id="detailplus">
            <i class="xi-plus">
            </i>
            </button>
            <p>문항 질문 :</p>
            <ul class="wf-insert-form">
            <input type="text" id="autoQuestion4" placeholder="질문 문항을 작성해주세요" value="나는 현재 맡은 업무에 대해 강한 애착을 가지고 있다." name="surveyQuestionList[3].surveyQuestionSj">
            </ul>
            <ul class="checkbox-radio-custom" id="surveyRespon1" data-set-num="1">
            <li>
            <input type="radio" name="radio" id="rad20">
            <label for="rad20">
            <ul class="wf-insert-form">
            <input type="text" id="choiceNum19" placeholder="선택지 문항을 작성해주세요" value="매우불만족" name="surveyChoiceList[3].surveyChoiceSj">
            </ul>
            </label>
            </li>
            </ul>
            <ul class="checkbox-radio-custom" id="surveyRespon2" data-set-num="2">
            <li>
            <input type="radio" name="radio" id="rad21">
            <label for="rad21"><ul class="wf-insert-form">
            <input type="text" id="choiceNum20" placeholder="선택지 문항을 작성해주세요" value="불만족" name="surveyChoiceList[3].surveyChoiceSj">
            </ul>
            </label>
            </li>
            </ul>
            <ul class="checkbox-radio-custom" id="surveyRespon3" data-set-num="3">
            <li>
            <input type="radio" name="radio" id="rad22">
            <label for="rad22">
            <ul class="wf-insert-form">
            <input type="text" id="choiceNum21" placeholder="선택지 문항을 작성해주세요" value="보통" name="surveyChoiceList[3].surveyChoiceSj">
            </ul>
            </label>
            </li>
            </ul>
            <ul class="checkbox-radio-custom" id="surveyRespon4" data-set-num="4">
            <li>
            <input type="radio" name="radio" id="rad23">
            <label for="rad23"><ul class="wf-insert-form">
            <input type="text" id="choiceNum22" placeholder="선택지 문항을 작성해주세요" value="만족" name="surveyChoiceList[3].surveyChoiceSj">
            </ul>
            </label>
            </li>
            </ul>
            <ul class="checkbox-radio-custom" id="surveyRespon5" data-set-num="5">
            <li>
            <input type="radio" name="radio" id="rad24">
            <label for="rad24">
            <ul class="wf-insert-form">
            <input type="text" id="choiceNum23" placeholder="선택지 문항을 작성해주세요" value="매우만족" name="surveyChoiceList[3].surveyChoiceSj">
            </ul>
            </label>
            </li>
            </ul>
            </div>
            <br>
            </div>
        	`;
        	

            inputArea.append(str);
        	
        	
    }


    



    </script>







    <!DOCTYPE html>
    <html>

    <body>
        <div class="wf-main-container">
            <!-- =============== 상단타이틀영역 시작 =============== -->
            <!--form 태그 시작-->
            <form action="/admin/survey/creatSurvey?${_csrf.parameterName}=${_csrf.token}" method="post"
                  onsubmit="return validateForm()" >
                  <!-- enctype="multipart/form-data"-->
                <div class="wf-tit-wrap" data-aos="fade-right" data-aos-duration="700" data-aos-delay="0">
                    <h1 class="page-tit">설문조사</h1>
                    <div>
                        <button type="button" class="btn1" onclick="autoQuestionFill()">질문</button>
                        <button type="button" class="btn1" onclick="autoFill()">자동완성</button>
                        <button type="button" class="btn2" onclick="location.href='/admin/survey/list'">취소</button>
                        <button type="submit" class="btn2 surveyCreate">등록</button>
                    </div>
                </div>
                <!-- =============== 상단타이틀영역 끝 =============== -->
                <!-- =============== 컨텐츠 영역 시작 =============== -->
                <div class="wf-content-wrap" data-aos="fade-right" data-aos-duration="700" data-aos-delay="200">
                    <!-- inputText영역 -->
                    <div class="wf-content-area">
                        <!--  -->
                        <ul class="wf-insert-form">
                            <input type="hidden" name="surveyEmpNo" value="<%=session.getAttribute("empNo")%>">
                            <li><label>제목</label> <input type="text" name="surveyTitle" id="autoTitle" placeholder="설문조사 제목을 작성해주세요" required></li>
                            <li><label>종료날짜</label> <input name="surveyEndDate" id="autoDate" type="date"></li>
                            <li>
                                <ul class="checkbox-radio-custom" required>
                                    <p class="heading2">익명여부</p>
                                    <li><input type="radio" name="surveyAnonyCd" id="radio1" value="Y"> <label
                                            for="radio1">익명</label></li>
                                    <li><input type="radio" name="surveyAnonyCd" id="radio2" value="N"> <label
                                            for="radio2">비익명</label></li>
                                </ul>
                            </li>
                            <li></li>
                            <li><label>참여자</label>
                                <div class="wf-flex-box">
                                    <input type="text" id="empSearch" placeholder="설문조사 참여자를 입력해주세요">
                                    <input type="hidden" id="hdnEmpNo" />
                                    <button type="button" id="empPlus" class="btn2">+</button>
                                </div>
                            </li>
                            <!--참가자 입력칸-->
                            <li id="inputSelectEmp">
                                <div id="inputSelectEmpCh"></div>
                            </li>

                            <li><label>부서별</label>
                                <div class="wf-flex-box">
                                    <input type="text" id="deptSearch" placeholder="설문조사 참여할 부서를 입력해주세요"> <input
                                        type="hidden" id="hdnDeptNo" />
                                    <button type="button" id="deptPlus" class="btn2">+</button>
                                </div>
                            </li>
                            <li id="inputSelectdept">
                                <div id="inputSelectDeptCh"></div>
                            </li>
                        </ul>
                    </div>



                    <!-- 하단 설문문항 항목 표 시작-->
                    <div class="wf-content-area">
                        <p class="heading1">설문조사 문항</p>
                        <div class="selectOptionSurvey">
                            <ul class="checkbox-radio-custom surveySelectType">
                                <li>
                                    <p class="heading2">설문 문항 종류</p>
                                </li>
                                <li>
                                    <input type="radio" name="surveytype" id="surveytype1" value="1">
                                    <label for="surveytype1">객관</label>
                                </li>
                                <li>
                                    <input type="radio" name="surveytype" id="surveytype2" value="2">
                                    <label for="surveytype2">체크박스</label>
                                </li>
                                <li>
                                    <input type="radio" name="surveytype" id="surveytype3" value="3">
                                    <label for="surveytype3">서술</label>
                                </li>
                                
                                <button type="button" style="float: right;" class="btn1  Surveyminus" id="Surveyminus">
                                    <i class='xi-minus'></i>
                                </button>
                                <button type="button" style="float: right;" class="btn1  Surveyplus" id="Surveyplus">
                                    <i class='xi-plus'></i>
                                </button>
                            </ul>
                        </div>

                        <!--버튼 클릭시 form영역 시작-->
                        <br>
                        <br>
                        <div class="inputAreaSurvey">

                        </div>
                        <!--버튼 클릭시 form영역 끝-->
                    </div>
                    <!--하단 설문문항 항목 표 끝-->


                </div>
            </form>
            <!--폼 태그 끝-->
            <!-- =============== 컨텐츠 영역 끝 =============== -->
        </div>




    </body>

    </html>