package com.board.mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {
	
	@Select("SELECT now() from dual")
	public String getTime();
	
	public String getTime2();

}
