package com.board.service;

import com.board.domain.MemberVO;

public interface MemberService {
	
	public void register(MemberVO vo);
	
	public boolean updateAccount(MemberVO Vo);
	
	public boolean deleteAccount(String id);
	
	public int idCheck(String id);
	
	public int passChk(MemberVO vo);

	public MemberVO get(String id);
	

}
