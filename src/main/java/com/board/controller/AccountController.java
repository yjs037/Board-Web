package com.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.domain.MemberVO;
import com.board.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class AccountController {
	
	@Setter(onMethod_ = @Autowired)
	private MemberService service;
	
	@GetMapping("/register")
	public void resgister() {
		
	}
	
	@PostMapping("/register")
	private String register(MemberVO member) {
		
		service.register(member);
		log.info("register : " + member);
		
		return "redirect:/";
	}
	
	@PostMapping("/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("id") String id) {
		log.info("IdCheck 진입");
		log.info("전달받은id : " + id);
		int cnt = service.idCheck(id);
		log.info("결과 : " + cnt);
		return cnt;
	}
	

	

}













