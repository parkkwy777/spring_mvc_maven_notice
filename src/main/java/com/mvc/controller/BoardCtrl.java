package com.mvc.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	  public String noticeDetail(@ModelAttribute("nsch") NoticeSch nsh, Notice n, Model d) {
		  //선택한 게시글 모델로 전달
		  d.addAttribute("detail",service.getDetailNotice(n.getNo()));
		  d.addAttribute("repleCount",service.repleCount(n.getNo()));
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
	
		//글 수정
		@RequestMapping("/noticeUpdate")
		public String update(Notice n ,Model d) {
			 d.addAttribute("detail",service.getDetailNotice(n.getNo()));
			return "/WEB-INF/view/update.jsp";
		}
		@RequestMapping(params="method=update")
		public String updateContent(Notice n, Model d) {
			System.out.println("업데이트");
			service.updateNotice(n);
			d.addAttribute("success","success");
			d.addAttribute("no",n.getNo());
			return "/WEB-INF/view/update.jsp";
		}
	
		//글삭제
		@RequestMapping("/noticeDelete")
		public String delete() {
			return "/WEB-INF/view/delete.jsp";
		}
		@RequestMapping(params="method=delete")
		public String deleteContent(Notice n,Model d) {
			
			try {
				int result= service.delete(n);
				if(result==0) {
					d.addAttribute("result","cancle");
				}
				else {
					d.addAttribute("result","success");
				}
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.getMessage());
				d.addAttribute("result","cancle");
			}
			
			return "/WEB-INF/view/delete.jsp";
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
		  
		  
		  //첨부파일 다운로드
		  
		  @RequestMapping(params="method=download")
		  public String download(@RequestParam("fname") String fname, Model d) {
			  d.addAttribute("downloadFile", fname);
			  return "download";
		  }
		 
}
