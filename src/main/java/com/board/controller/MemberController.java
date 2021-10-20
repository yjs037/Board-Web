package com.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
public class MemberController {
		
	@Setter(onMethod_ = @Autowired)
	private MemberService service;
	
	@Setter(onMethod_ = @Autowired)
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@GetMapping("/register")
	public void resgister() {
		
	}
	
	@PostMapping("/register")
	private String register(MemberVO member) {
		
		log.info("암호화 전 : " + member.getMem_pw());
		member.setMem_pw(bcryptPasswordEncoder.encode(member.getMem_pw()));
		log.info("암호화 후 : " + member.getMem_pw());
		
		service.register(member);
		log.info("register : " + member);
		
		return "redirect:/";
	}
	
	@GetMapping("/update")
	public void update(@RequestParam("mem_id") String id, MemberVO member, Model model) {
		
		
		model.addAttribute("member", service.get(id));
		
				
	}
	
	@PostMapping("/update")
	public String update(MemberVO member) {
		
		bcryptPasswordEncoder = new BCryptPasswordEncoder();
		//수정전
		System.out.println("수정전 : " + member.getMem_pw());
		
		//수정후
		String updatePW = bcryptPasswordEncoder.encode(member.getMem_pw());
		member.setMem_pw(updatePW);
		
		service.updateAccount(member);		
		
		return "redirect:/";
	}
	
	@PostMapping("/delete")
	public String delete(@RequestParam("mem_id") String id, MemberVO member) {
		
		service.deleteAccount(id);
		
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













