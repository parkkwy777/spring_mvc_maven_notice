package com.mvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.service.BoardService;
import com.mvc.vo.NoticeSch;

@Controller
@RequestMapping("/notice")
public class BoardCtrl {

	@Autowired(required = false)
	private BoardService service;

	public void str() {

	}

	@RequestMapping("/list")
	String noticeView(@ModelAttribute("nsch") NoticeSch n, Model d) {
		// 게시판 조회
		/*
		 * ModelAttribute가 아래 역할을 대신해준다. 해당내용은 순서에 상관없이 리턴이 마지막이기때문에 상관없다.
		 * d.addAttribute("NoticeSch",n);
		 */
		d.addAttribute("nlist", service.getNoticeList(n));

		System.out.println("git에서 변경");
	
		return "/WEB-INF/view/index.jsp";

	}

	  @RequestMapping("/ajaxList") 
	  String noticeView1(@ModelAttribute("nsch") NoticeSch n, Model d) {
	  
	  d.addAttribute("nlist",service.getNoticeList(n));
	  
	  	return "jsonView"; 
	  }

}
