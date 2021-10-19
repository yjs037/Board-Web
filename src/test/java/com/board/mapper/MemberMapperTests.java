package com.board.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.board.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberMapperTests {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Test
	public void testRegister() {
		MemberVO member = new MemberVO();
		member.setMem_id("newID");
		member.setMem_pw("newPW");
		member.setMem_name("newName");
		member.setMem_birth("new_birth");
		member.setMem_phone("newPhone");
		member.setMem_gender("남");
		
		mapper.registerAccount(member);
		
		log.info(member);
		
	}
	
	@Test
	public void testRead() {
		MemberVO vo = mapper.read("user79");
		
		log.info(vo);
		
		vo.getAuthList().forEach(authVO -> log.info(authVO));
	}

}












