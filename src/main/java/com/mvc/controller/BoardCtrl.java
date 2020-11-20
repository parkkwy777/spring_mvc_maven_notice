package com.mvc.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mvc.service.BoardService;
import com.mvc.vo.Notice;
import com.mvc.vo.NoticeSch;
import com.mvc.vo.Reple;

@Controller
@RequestMapping("/notice")
public class BoardCtrl {

	@Autowired(required = false)
	private BoardService service;

	@RequestMapping("/list")
	public String noticeView(@ModelAttribute("nsch") NoticeSch nsh, Model d) {
		// 게시판 조회
		/*
		 * ModelAttribute가 아래 역할을 대신해준다. 해당내용은 순서에 상관없이 리턴이 마지막이기때문에 상관없다.
		 * d.addAttribute("nsch",nsh);
		 */
	
		d.addAttribute("nlist", service.getNoticeList(nsh));

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
		  d.addAttribute("detail",service.getDetailNotice(n.getNo()));
		  d.addAttribute("reples",service.getReple(nsh,n.getNo()));
		 
		  return "/WEB-INF/view/detail_ajax.jsp";
		}
	  
	  @RequestMapping(params="method=repleAjax")
	  public String repleAjax(@ModelAttribute("nsch") NoticeSch nsh,Notice n, Model d) {
		  //선택한 게시글 모델로 전달
		  d.addAttribute("reples",service.getReple(nsh,n.getNo()));
		  return "jsonView";
	  }
	  
	  //글쓰기 페이지
		@RequestMapping("/noticeInput")
	  public String noticeInput() {
		  
		  return "/WEB-INF/view/input.jsp";
	  }

		// method=input 형태일때 호출되고 get방식으로 다른 값 넘어오면 맵핑 안됨. only post
		@RequestMapping(params="method=input")
	  public String noticeInput1(Notice n,Model d) {
			System.out.println("작성자:" +n.getWriter()+" 내용:"+n.getEtc());
			System.out.println(n.getReport());
		try {
		  d.addAttribute("inputSuccess", service.noticeInput(n));
		}catch (Exception e) {
		 System.out.println(e.getMessage());
		}
		  return "/WEB-INF/view/input.jsp";
		
	  }
		  
		  // 리플 생성
		@RequestMapping(params ="method=insertReple") 
		  public String insertReple(NoticeSch n, Reple r, Model d){
			
			  service.insertReple(r); 
			  System.out.println("curpage:"+n.getCurPage());
			return "redirect:/notice/detail?no="+r.getNo()+"&curPage="+n.getCurPage();
			 
		  }
		
		  @ResponseBody
		  @RequestMapping(params ="method=insertRepleAjax") 
		  public HashMap<String, String> insertRepleAjax(NoticeSch n,Reple r, Model d){
			 
			  HashMap<String, String> result= new HashMap<String, String>();
			  
			  result.put("result","sucess");
			  
			  service.insertReple(r); 
				return result;
		  }
		 
}
