package com.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.board.domain.BoardVO;
import com.board.domain.Criteria;
import com.board.domain.MemberVO;
import com.board.domain.PageDTO;
import com.board.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
public class BoardController {
	
		@Setter(onMethod_ = @Autowired)
		private BoardService service;
			
		@GetMapping("/list")
		public void list(Model model, Criteria cri, MemberVO member) {
			
			log.info("list.....");
			model.addAttribute("list", service.getList(cri));
			
			int total = service.getTotal(cri);
			
			log.info("total : " + total);			
			
			model.addAttribute("pageMaker", new PageDTO(cri, total));
			
		}
		
		@GetMapping("/register")
		@PreAuthorize("isAuthenticated()")
		public void register() {
			
		}		
		
		@PostMapping("/register")
		@PreAuthorize("isAuthenticated()")
		public String register(BoardVO board, RedirectAttributes rttr) {
			
			log.info("register : " + board);
			
			service.register(board);
			
			rttr.addFlashAttribute("result", board.getBno());
			
			return "redirect:/board/list";
		}
		
		@GetMapping({"/get", "/modify"})
		public void get(@RequestParam("bno") Long bno, Model model, @ModelAttribute("cri") Criteria cri) {
			
			log.info("/get or modify");
			model.addAttribute("board", service.get(bno));
			
		}
		
		@PreAuthorize("principal.username == #board.writer")
		@PostMapping("/modify")
		public String modify(BoardVO board, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
			
			log.info("modify : " + board);
			
			if(service.modify(board)) {
				rttr.addFlashAttribute("result", "success");
			}
			
			return "redirect:/board/list" + cri.getListLink();
		}
		
		@PreAuthorize("principal.username == #writer")
		@PostMapping("/remove")
		public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
			
			log.info("remove......" + bno);
			
			if (service.remove(bno)) {
				rttr.addFlashAttribute("result", "success");
			}			
			
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("keyword", cri.getKeyword());
			rttr.addAttribute("type", cri.getType());
			
			return "redirect:/board/list" + cri.getListLink();
		}
		
}
