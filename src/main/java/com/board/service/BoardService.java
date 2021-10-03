package com.board.service;

import java.util.List;

import com.board.domain.BoardVO;
import com.board.domain.Criteria;

public interface BoardService {

	public void register(BoardVO board);
	
	public BoardVO get(Long bno);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	
	//페이징추가
	public List<BoardVO> getList(Criteria cri);
	
	//페이징을 위한 전체 게시물 구하기
	public int getTotal(Criteria cri);
	
}
