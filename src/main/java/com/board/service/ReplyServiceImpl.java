package com.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.board.domain.Criteria;
import com.board.domain.ReplyPageDTO;
import com.board.domain.ReplyVO;
import com.board.mapper.BoardMapper;
import com.board.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		
		log.info("register...." + vo);
		
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		
		return mapper.replyInsert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		
		log.info("get... " + rno );
		
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		
		log.info("modify... " + vo);
		
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		
		log.info("remove... " + rno);
		
		ReplyVO vo = mapper.read(rno);
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		
		return mapper.delete(rno);
	}

	/*
	 * @Override public List<ReplyVO> getList(Criteria cri, Long rno) {
	 * 
	 * log.info("get Reply List " + rno);
	 * 
	 * return mapper.getListWithPaging(cri, rno); }
	 */

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long rno) {
		
		return new ReplyPageDTO(
				mapper.getCountByRno(rno),
				mapper.getListWithPaging(cri, rno));
	}

}












