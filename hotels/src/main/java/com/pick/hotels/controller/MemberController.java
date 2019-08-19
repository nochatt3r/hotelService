package com.pick.hotels.controller;

import java.io.IOException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pick.hotels.entity.MemberDto;
import com.pick.hotels.repository.MemberDao;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberDao memberDao;
	
	@GetMapping("/regist")
	public String regist() {
		return "member/regist";
	}
	
	@PostMapping("/regist")
	public String regist(@ModelAttribute MemberDto memberDto) {
		System.out.println(memberDto);
		String origin = memberDto.getMember_pw();
		String encrypt = BCrypt.hashpw(origin, BCrypt.gensalt());
		memberDto.setMember_pw(encrypt);
		System.out.println(encrypt);
		boolean result = memberDao.regist(memberDto);
		if(result)
			return "member/regist_result";
		else
			return "member/regist_fail";
	}
	
	@GetMapping("/id_check")
	public void id_check(@RequestParam String member_id, HttpServletResponse resp) throws IOException {
		resp.setContentType("text/plain");
		MemberDto mdto = memberDao.get(member_id);
		if(mdto==null) {
			resp.getWriter().print("Y");
		}
		else {
			resp.getWriter().print("N");
		}
			
		
	}
	
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("/login")
	public String login(
			@ModelAttribute MemberDto memberDto,
			@RequestParam(required=false) String remember,
			HttpSession session,
			HttpServletResponse response) {
//		암호화 적용 전
//		MemberDto result = memberDao.login(memberDto);
//		if(result != null) {
		
//		암호화 적용 후
//		1. DB에서 회원정보를 불러온다
		MemberDto result = memberDao.get(memberDto.getMember_id());
//		2. BCrypt의 비교 명령을 이용하여 비교 후 처리
		if(BCrypt.checkpw(memberDto.getMember_pw(), result.getMember_pw())) {
			session.setAttribute("ok", result.getMember_id());
			session.setAttribute("auth", result.getMember_class());
			
			System.out.println("로그인 성공");
			
			//쿠키객체를 만들고 체크여부에 따라 시간 설정 후 response에 추가
			Cookie c = new Cookie("saveId", memberDto.getMember_id());
			if(remember == null)//체크 안했을때 
				c.setMaxAge(0);
			else //체크 했을때
				c.setMaxAge(4 * 7 * 24 * 60 * 60);//4주
			response.addCookie(c);
			
			return "redirect:/";
		}
		else {
			return "member/login_fail";
		}
	}
	
}
