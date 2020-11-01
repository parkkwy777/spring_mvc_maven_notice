package com.mvc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mvc.service.BoardService;
import com.mvc.vo.NoticeSch;


@Controller
@RequestMapping("/park")
public class BoardCtrl2{

	@Autowired(required = false)
	private BoardService service;
	
	@RequestMapping(params="method=list")
	String noticeView(NoticeSch n, Model d) {
		d.addAttribute("nlist",service.getNoticeList(n));
		System.out.println("d12313");
		return "\\WEB-INF\\index.jsp";
	}

}
