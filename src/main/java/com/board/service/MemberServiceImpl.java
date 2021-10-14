package com.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.domain.MemberVO;
import com.board.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService {
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;

	@Override
	public void register(MemberVO vo) {
		
		log.info("register..." + vo);
		
		mapper.registerAccount(vo);
	}

	@Override
	public void modify(MemberVO vo) {

	}

	@Override
	public void delete(MemberVO vo) {

	}
	
	@Override
	public int idCheck(String id) {
		int cnt = mapper.idCheck(id);
		return cnt;
	}

	@Override
	public int passChk(MemberVO vo) {
		
		return mapper.passChk(vo);
	}

	

	
}
