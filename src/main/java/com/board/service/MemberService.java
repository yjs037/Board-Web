package com.board.service;

import com.board.domain.MemberVO;

public interface MemberService {
	
	public void register(MemberVO vo);
	
	public void modify(MemberVO vVo);
	
	public void delete(MemberVO vo);
	
	public int idCheck(String id);
	
	public int passChk(MemberVO vo);


}
