package com.board.mapper;

import java.util.List;

import com.board.domain.BoardVO;

public interface BoardMapper {
	
	public List<BoardVO> getList();
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardVO board);

}
