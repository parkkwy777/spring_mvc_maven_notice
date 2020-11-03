package com.mvc.vo;

import java.util.Date;

public class Reple {
	
	
	/* NO|REPNO|R_LEVEL|R_TODAY|R_WRITER |R_TOLIST |R_ETC */ 

	private int no;
	private int repno;
	private int r_level;
	private String r_today;
	private String r_writer;
	private Date r_tolist;
	private String r_etc;
	
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getRepno() {
		return repno;
	}
	public void setRepno(int repno) {
		this.repno = repno;
	}
	public int getR_level() {
		return r_level;
	}
	public void setR_level(int r_level) {
		this.r_level = r_level;
	}
	public String getR_today() {
		return r_today;
	}
	public void setR_today(String r_today) {
		this.r_today = r_today;
	}
	public String getR_writer() {
		return r_writer;
	}
	public void setR_writer(String r_writer) {
		this.r_writer = r_writer;
	}
	public Date getR_tolist() {
		return r_tolist;
	}
	public void setR_tolist(Date r_tolist) {
		this.r_tolist = r_tolist;
	}
	public String getR_etc() {
		return r_etc;
	}
	public void setR_etc(String r_etc) {
		this.r_etc = r_etc;
	}
	
	
	
	
	
}
