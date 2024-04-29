package com.team1.workforest.schedule.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team1.workforest.common.mapper.CommonMapper;
import com.team1.workforest.employee.vo.EmployeeVO;
import com.team1.workforest.schedule.mapper.ScheduleMapper;
import com.team1.workforest.schedule.service.ScheduleService;
import com.team1.workforest.schedule.util.ScheduleType;
import com.team1.workforest.schedule.vo.ScheduleVO;

@Service
public class ScheduleServiceImpl implements ScheduleService{

	@Autowired
	ScheduleMapper scheduleMapper;
	
	@Autowired
	CommonMapper commonMapper;

	@Override
	public JSONArray getScheduleList(String empNo, List<String> chkSchs) {
		Map<String, String> params = new HashMap<>();
	    params.put("empNo", empNo);

	    JSONArray jsonArr = new JSONArray();

	    // 체크박스에 선택한 일정 찾은 후 데이터 가져와서 반환
	    if (chkSchs != null) {
	        for (String schTypeStr : chkSchs) {
	            ScheduleType schType = ScheduleType.fromValue(schTypeStr);
	            switch (schType) {
	                case MY_SCHEDULE:
	                    convertScheduleList(scheduleMapper.getMyScheduleList(params), schType.getValue(), jsonArr);
	                    break;
	                case TEAM_SCHEDULE:
	                    convertScheduleList(scheduleMapper.getTeamScheduleList(params), schType.getValue(), jsonArr);
	                    break;
	                case DEPARTMENT_SCHEDULE:
	                    convertScheduleList(scheduleMapper.getDeptScheduleList(params), schType.getValue(), jsonArr);
	                    break;
	                case COMPANY_SCHEDULE:
	                    convertScheduleList(scheduleMapper.getCompScheduleList(params), schType.getValue(), jsonArr);
	                    break;
	            }
	        }
	    }

	    return jsonArr;
	}
	
	@Override
	public ScheduleVO getSchedule(String schdulNo) {
		return scheduleMapper.getSchedule(schdulNo);
	}
	
	@Override
	public int createSchedule(ScheduleVO scheduleVO) {
		return scheduleMapper.createSchedule(scheduleVO);
	}

	@Override
	public int updateSchedule(ScheduleVO scheduleVO) {
		return scheduleMapper.updateSchedule(scheduleVO);
	}

	@Override
	public int deleteSchedule(String schdulNo) {
		return scheduleMapper.deleteSchedule(schdulNo);
	}
	
	@Override
	public JSONArray getTodayScheduleList(String empNo) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("empNo", empNo);
		// date칸 채워서 오늘의 일정 검색 가능하도록(SQL)
		params.put("date", "today");		
		
		JSONArray jsonArr = new JSONArray();
		
		convertScheduleList(scheduleMapper.getMyScheduleList(params), "mySch", jsonArr);		
		convertScheduleList(scheduleMapper.getTeamScheduleList(params), "teamSch", jsonArr);
	    convertScheduleList(scheduleMapper.getDeptScheduleList(params), "deptSch", jsonArr);
	    convertScheduleList(scheduleMapper.getCompScheduleList(params), "compSch", jsonArr);   

		return jsonArr;
	}
	
	// 캘린더에 랜더링하기 위한 데이터로 포맷
	public void convertScheduleList(List<ScheduleVO> inputScheduleList, String schType, JSONArray jsonArr) {
        for (ScheduleVO schedule : inputScheduleList) {
        	
        	// 사원번호 이용해 사원정보 가져오기
        	String empNo = schedule.getEmpNo();        	
        	EmployeeVO empVO = commonMapper.getEmpInfo(empNo);
			String empNm = empVO.getEmpNm();
			String position = empVO.getPosition();
			String rspnsblCtgryNm = empVO.getRspnsblCtgryNm();
			
			// 사원이 직책이 있는 경우, 직급 말고 직책을 표시하도록 함
			if(!rspnsblCtgryNm.equals("팀원")) {
				position = rspnsblCtgryNm;
			}
			        	
			// 스케쥴마다 jsonArr에 add
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("schNo", schedule.getSchdulNo());
            jsonObj.put("empNo", schedule.getEmpNo());
            jsonObj.put("empInfo", "(" + empNm + " " + position + ")");
            jsonObj.put("deptNo", schedule.getDeptNo());
            jsonObj.put("schSeCd", schedule.getSchdulSeCd());
            jsonObj.put("title", schedule.getSchdulSj());
            jsonObj.put("start", schedule.getSchdulBeginDate());
            jsonObj.put("end", schedule.getSchdulEndDate());
            jsonObj.put("location", schedule.getSchdulLoc());
            jsonObj.put("content", schedule.getSchdulCn());
            jsonObj.put("schType", schType);
            jsonObj.put("allDayCd", schedule.getAllDayCd());
            jsonArr.add(jsonObj);
        }
    }

	
}
