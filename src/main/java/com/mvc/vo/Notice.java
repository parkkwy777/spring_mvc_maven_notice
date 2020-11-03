package com.mvc.vo;

import java.sql.Date;

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
	
	
}
