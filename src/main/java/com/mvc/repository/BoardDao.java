package com.mvc.repository;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

import com.mvc.vo.Notice;
import com.mvc.vo.NoticeSch;

@Repository
public interface BoardDao {

	
	//게시판 전체 글수
	public int totCnt(NoticeSch n);
	
	// 게시판 리스트 출력
	public ArrayList<Notice> getNoticeList(NoticeSch n);
	
}
