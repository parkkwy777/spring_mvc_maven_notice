package com.mvc.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mvc.repository.BoardDao;
import com.mvc.vo.Notice;
import com.mvc.vo.NoticeSch;
import com.mvc.vo.Reple;

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
	    //1
		
		//선택한 페이지에 보여질 첫번째 요소 1
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
	/*
	 * //선택글 조회수 증가 public void counting(int no) {
	 * 
	 * dao.counting(no); }
	 */
	
	
	//선택한 게시글 detail
	public Notice getDetailNotice(int no) {
		//조회수 증가
		dao.counting(no);
		Notice n=dao.getDetailNotice(no);
		n.setFnames(dao.getfileName(no));
		
		
		return n;
	}
	
	//게시글 추가
	public boolean noticeInput(Notice n) {
		dao.noticeInput(n);
		System.out.println("작성글 등록 완료");
		
			for (MultipartFile report : n.getReport()) { // 물리적 파일 정리]
				
					upload(report);
				}
			
			return true;

	}
	
	@Value("${upload}")
	private String upload; // 업로드할 위치..
	@Value("${tmpUpload}")
	private String tmpUpload;// 임시업로드 위치.
	private void upload(MultipartFile mtf) {
		
		String fileName=mtf.getOriginalFilename();
		
		if(fileName!=null&&!fileName.equals("")) {
			System.out.println("??");
			File tmpFile = new File(tmpUpload+fileName);
			// 해당 폴드에 동일한 파일이 있으면 삭제 처리
			if(tmpFile.exists()) tmpFile.delete();
			try {
			// Stream으로 온 MultipartFile을 실제 파일로 변경처리.	
				mtf.transferTo(tmpFile);
				File orgFile = new File(upload+fileName);
		
			// tmp위치에 있는 파일을 현재 웹서버에 특정할 폴드로 이동.
			// StandardCopyOption.REPLACE_EXISTING : 기존 동일 파일명이 있을 때,
			// 마지막에 올린 파일로 변경 처리..
				Files.copy(tmpFile.toPath(), orgFile.toPath(), 
							StandardCopyOption.REPLACE_EXISTING);
				System.out.println(fileName);
				dao.insertFile(fileName);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			
			}
		
		
		}
		
	}
	
	
	//게시판 댓글 조회
	public ArrayList<Reple> getReple(NoticeSch n,int no){
		
		
		n.setCount(dao.totCntReple(no));
		
		//페이지에 나타낼 갯수
		if(n.getPageSize()==0) {
			n.setPageSize(10);
		}
		if(n.getCurPage()==0) {
			n.setCurPage(1);
		}
		//총 페이지 숫자
		
		n.setPageCount((int)(Math.ceil(n.getCount()/(double)n.getPageSize())));
		/*
		 * n.setPageCount(n.getCount()!= n.getPageSize() ?
		 * (int)(Math.ceil(n.getCount()/(double)n.getPageSize())):
		 * (int)(Math.ceil(n.getCount()/(double)n.getPageSize()))-1 );
		 */
		System.out.println((int)(Math.ceil(n.getCount()/(double)n.getPageSize()))-1 +"페이지와 카운트가 같으면..");
		//선택한 페이지에 보여질 첫번째 요소 
		n.setStart((n.getPageSize()*n.getCurPage())-(n.getPageSize()-1));
		//선택한 페이지에 보여질 끝
		//System.out.println("?"+n.getPageSize()+"  "+ n.getCurPage());
		n.setEnd(n.getPageSize()*n.getCurPage());
		//System.out.println("끝나는페이지:"+n.getEnd());
		//한번에 보여질 블럭사이즈
		n.setBlockSize(10);
		
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
		
		HashMap<String, Object> hash=  new HashMap<String, Object>();
		hash.put("hash",n);
		hash.put("no",no);
		
		
		return dao.getReple(hash);
	}
	
	//댓글등록 
	public void insertReple(Reple r) {
		//form안에 같은이름 name이 2개 있을경우 ,로 붙는다. 
		//하나만 입력처리.
	
		//0부터 ,전까지
		/*
		 * r.setR_etc(r.getR_etc().substring (0,r.getR_etc().indexOf(",")));
		 * 
		 * r.setR_writer(r.getR_writer().substring (0,r.getR_writer().indexOf(",")));
		 */
		
		
		 r.setR_etc(r.getR_etc().replace(",",""));
		 r.setR_writer(r.getR_writer().replace(",",""));
		 
		
		dao.inserReple(r);
	}


	public int delete(Notice n) {
		// TODO Auto-generated method stub
		return dao.delete(n);
	}

	
}
