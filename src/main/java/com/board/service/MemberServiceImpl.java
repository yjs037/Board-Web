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
	public boolean updateAccount(MemberVO vo) {
		
		log.info("updateAccount..." + vo);
		
		return mapper.updateAccount(vo) == 1;
		
	}


	@Override
	public boolean deleteAccount(String id) {
			
		log.info("deleteAccount..." + id);
		
		return mapper.deleteAccount(id) == 1;
		
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


	@Override
	public MemberVO get(String id) {
		
		return mapper.read(id);
	}

	
}
