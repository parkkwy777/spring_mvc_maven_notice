package com.mvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.service.BoardService;
import com.mvc.vo.Notice;
import com.mvc.vo.NoticeSch;

@Controller
@RequestMapping("/notice")
public class BoardCtrl {

	@Autowired(required = false)
	private BoardService service;

	public void str() {

	}

	@RequestMapping("/list")
	public String noticeView(@ModelAttribute("nsch") NoticeSch nsh, Model d) {
		// 게시판 조회
		/*
		 * ModelAttribute가 아래 역할을 대신해준다. 해당내용은 순서에 상관없이 리턴이 마지막이기때문에 상관없다.
		 * d.addAttribute("nsch",nsh);
		 */
	
		d.addAttribute("nlist", service.getNoticeList(nsh));

		System.out.println("git에서 변경");
		
	
		return "/WEB-INF/view/list.jsp";

	}

	  @RequestMapping("/ajaxList") 
	  public String noticeView1(@ModelAttribute("nsch") NoticeSch nsh, Model d) {
	  
	   System.out.println("cur:"+nsh.getCurPage());
	  d.addAttribute("nlist",service.getNoticeList(nsh));
	  
	  	return "jsonView"; 
	  }
	  
	  @RequestMapping("/detail")
	  public String noticeDetail(@ModelAttribute("nsch") NoticeSch nsh,Notice n, Model d) {
		  //선택한 게시글 모델로 전달
		 System.out.println(n.getNo());
		  d.addAttribute("detail",service.getDetailNotice(n.getNo()));
		  d.addAttribute("reples",service.getReple(nsh,n.getNo()));
		 
		  return "/WEB-INF/view/detail.jsp";
	  }
	  //글쓰기 페이지
		@RequestMapping("/noticeInput")
	  public String noticeInput() {
		  
		  return "/WEB-INF/view/input.jsp";
		
	  }

		// method=input 형태일때 호출되고 get방식으로 다른 값 넘어오면 맵핑 안됨. only post
	  @RequestMapping(params="method=input")
	  public String noticeInput1(Notice n) {
		System.out.println(n.getHeader());
		  service.noticeInput(n);
		  
		  return "redirect:/notice/list";
		
	  }
		  
	  
	  
		/*
		 * // 리블 생성
		 * 
		 * @RequestMapping(params ="method=insertReple") public String insertReple(Reple
		 * r, Model d) {
		 * 
		 * service.insertReple(r); return "redirect:/notice/detail?no="+r.getNo(); }
		 */
}
