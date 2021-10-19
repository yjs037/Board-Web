package com.board.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {

	private String mem_id;
	private String mem_pw;
	private String mem_name;
	private String mem_birth;
	private String mem_phone;
	private String mem_gender;
	private boolean enabled;
	
	private List<AuthVO> authList;
}
