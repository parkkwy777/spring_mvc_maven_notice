package com.mvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mvc.service.BoardService;
import com.mvc.vo.Notice;
import com.mvc.vo.NoticeSch;
import com.mvc.vo.Reple;

@Controller
@RequestMapping("/notice")
public class BoardCtrl {

	@Autowired(required = false)
	private BoardService service;

	public void str() {

	}

	@RequestMapping("/list")
	String noticeView(@ModelAttribute("nsch") NoticeSch nsh, Model d) {
		// 게시판 조회
		/*
		 * ModelAttribute가 아래 역할을 대신해준다. 해당내용은 순서에 상관없이 리턴이 마지막이기때문에 상관없다.
		 * d.addAttribute("NoticeSch",n);
		 */
		d.addAttribute("nlist", service.getNoticeList(nsh));

		System.out.println("git에서 변경");
	
		return "/WEB-INF/view/list.jsp";

	}

	  @RequestMapping("/ajaxList") 
	  String noticeView1(@ModelAttribute("nsch") NoticeSch nsh, Model d) {
	  
	  d.addAttribute("nlist",service.getNoticeList(nsh));
	  
	  	return "jsonView"; 
	  }
	  
	  @RequestMapping("/detail")
	  String noticeDetail(@ModelAttribute("nsch") NoticeSch nsh,Notice n, Model d) {
		  //선택한 게시글 모델로 전달
		 System.out.println(n.getNo());
		  d.addAttribute("detail",service.getDetailNotice(n.getNo()));
		  d.addAttribute("reples",service.getReple(nsh,n.getNo()));
		 
		  return "/WEB-INF/view/detail.jsp";
	  }
	  @RequestMapping(params ="method=insertReple")
	  String insertReple(Reple r, Model d) {
		
		  service.insertReple(r);
		  return "redirect:/notice/detail?no="+r.getNo();
	  }

}
