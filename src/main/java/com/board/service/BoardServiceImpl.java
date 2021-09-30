package com.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.domain.BoardVO;
import com.board.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	@Override
	public void register(BoardVO board) {
		
		log.info("register...." + board);
		
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		
		log.info("get..........." + bno);
		
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		
		log.info("modify....." + board);
		
		// void로 설계할 수도 있지만 엄격하게 처리하기위해 boolean으로 처리
		return mapper.update(board) == 1;  
	}

	@Override
	public boolean remove(Long bno) {
		
		log.info("remove....." + bno);
		
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList() {
		
		log.info("get List..........");
		
		return mapper.getList();
	}

}
