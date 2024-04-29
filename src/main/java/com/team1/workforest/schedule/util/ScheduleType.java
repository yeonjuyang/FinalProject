package com.team1.workforest.schedule.util;

import java.util.HashMap;
import java.util.Map;

public enum ScheduleType {
	MY_SCHEDULE("mySch"),
    TEAM_SCHEDULE("teamSch"),
    DEPARTMENT_SCHEDULE("deptSch"),
    COMPANY_SCHEDULE("compSch");

    private static final Map<String, ScheduleType> BY_VALUE = new HashMap<>();

    static {
        for (ScheduleType type : values()) {
            BY_VALUE.put(type.value, type);
        }
    }

    private final String value;

    ScheduleType(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static ScheduleType fromValue(String value) {
        return BY_VALUE.get(value);
    }
}
