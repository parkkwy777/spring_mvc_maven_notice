package com.mvc.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mvc.repository.BoardDao;
import com.mvc.vo.Notice;
import com.mvc.vo.NoticeSch;

@Service
public class BoardService {

	@Autowired(required = false)
		private BoardDao dao;
	
	
	public ArrayList<Notice> getNoticeList(NoticeSch n){
		
		//keypoint 데이터건수의 start와 end가있고 
		// block들 마다 startBlock과 endBlock이 있다.
		
		//총 건수
		
		n.setCount(dao.totCnt(n));
		
		//페이지에 나타낼 갯수
		if(n.getPageSize()==0) {
			n.setPageSize(3);
		}
		if(n.getCurPage()==0) {
			n.setCurPage(1);
		}
		
		//총 페이지 숫자
		n.setPageCount((int)(Math.ceil(n.getCount()/(double)n.getPageSize())));
	    
		//선택한 페이지에 보여질 첫번째 요소 
		n.setStart((n.getPageSize()*n.getCurPage())-(n.getPageSize()-1));
		//선택한 페이지에 보여질 끝
		//System.out.println("?"+n.getPageSize()+"  "+ n.getCurPage());
		n.setEnd(n.getPageSize()*n.getCurPage());
		//System.out.println("끝나는페이지:"+n.getEnd());
		//한번에 보여질 블럭사이즈
		n.setBlockSize(3);
		
		//
		int blocknum=((int)Math.ceil(n.getCurPage()/(double)n.getBlockSize()));
		
		int endBlock =n.getBlockSize()*blocknum ;
		
		
		//
		
		// 블럭(예를들어 한번에보여질 Blocksize가 3이면 페이지번호 1,2,3이 하나로 1블럭이다.) 
		n.setStartBlock((n.getBlockSize()*blocknum)-(n.getBlockSize()-1));
		n.setEndBlock(endBlock>n.getPageCount()? n.getPageCount():endBlock);
		System.out.println("블럭번호:"+blocknum);
		System.out.println("시작블럭번호:"+n.getStartBlock());
		System.out.println("끝블럭번호:"+n.getEndBlock());
		
		
		
		return dao.getNoticeList(n);
	}
	
}
