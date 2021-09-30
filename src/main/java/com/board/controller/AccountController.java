package com.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member/*")
public class AccountController {
	
	@PostMapping("/register")
	public void resgister() {
		
	}

}
