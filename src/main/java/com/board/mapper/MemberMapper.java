package com.board.mapper;

import com.board.domain.MemberVO;

public interface MemberMapper {
	
	//회원가입
	public void registerAccount(MemberVO memberVo);
	
	//회원정보 수정
	public int updateAccount(MemberVO meberVo);
		
	//회원 탈퇴
	public int deleteAccount(String id); 
	
	//아이디 중복체크
	public int idCheck(String id);
	
	//비밀번호 체크
	public int passChk(MemberVO memberVo);
	
	public MemberVO read(String id);


}
