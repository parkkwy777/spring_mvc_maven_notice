package com.mvc.vo;

import java.sql.Date;
import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

public class Notice {

	/*
	 * NO no, header varchar2(50), title varchar(150), 
	 * writer varchar(150),
	 * today DATE, counting no, 
	 * upPoint no, etc varchar2(500)
	 */
	
	private int no;
	private String header;
	private int refno;
	private String title;
	private String writer;
	private String today;
	private int counting;
	private int upPoint;
	private String etc;
	private Date tolist;
	private String pass;

	private MultipartFile[] report;
	private ArrayList<String> filenames;
	
	// 파일 로딩 정보 가지고 오기
	private String[] fnames;
	

	public MultipartFile[] getReport() {
		return report;
	}
	public void setReport(MultipartFile[] report) {
		this.report = report;
	}
	public ArrayList<String> getFilenames() {
		return filenames;
	}
	public void setFilenames(ArrayList<String> filenames) {
		this.filenames = filenames;
	}
	public String[] getFnames() {
		return fnames;
	}
	public void setFnames(String[] fnames) {
		this.fnames = fnames;
	}
	public int getRefno() {
		return refno;
	}
	public void setRefno(int refno) {
		this.refno = refno;
	}
	public Date getTolist() {
		return tolist;
	}
	public void setTolist(Date tolist) {
		this.tolist = tolist;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getHeader() {
		return header;
	}
	public void setHeader(String header) {
		this.header = header;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getToday() {
		return today;
	}
	public void setToday(String today) {
		this.today = today;
	}
	public int getCounting() {
		return counting;
	}
	public void setCounting(int counting) {
		this.counting = counting;
	}
	public int getUpPoint() {
		return upPoint;
	}
	public void setUpPoint(int upPoint) {
		this.upPoint = upPoint;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	
}
