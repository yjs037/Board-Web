package com.board.service;

import com.board.domain.Criteria;
import com.board.domain.ReplyPageDTO;
import com.board.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long rno);
	
	//public List<ReplyVO> getList(Criteria cri, Long rno);

	public ReplyPageDTO getListPage(Criteria cri, Long rno);
}
