package com.mvc.repository;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.mvc.vo.Notice;
import com.mvc.vo.NoticeSch;
import com.mvc.vo.Reple;

@Repository
public interface BoardDao {

	
	//게시판 전체 글수
	public int totCnt(NoticeSch n);
	
	// 게시판 리스트 출력
	public ArrayList<Notice> getNoticeList(NoticeSch n);
	
	// 선택 게시글 조회수 증가
	public void counting(int no);
	//선택한 게시글 글수
	public int totCntReple(int no);
	//선택한 게시글 detail
	public Notice getDetailNotice(int no);
	
	//게시판 댓글 기능 
	public ArrayList<Reple> getReple(HashMap<String, Object> hash);
	
	//댓글 등록
	public void inserReple(Reple r);
	
	
}
