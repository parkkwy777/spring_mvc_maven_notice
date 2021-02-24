package com.mvc.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownloadViewer extends AbstractView {

	@Value("${upload}")
	private String upload;
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
			
		String fname= (String)model.get("downloadFile");
		File file =new File(upload+fname);
		
		response.setContentType("application/download; charset=UTF-8");
		response.setContentLength((int)file.length());
		fname=URLEncoder.encode(fname,"utf-8").replaceAll("\\+", " ");
		
		response.setHeader("Content-Disposition", "attachment;filename=\""+fname+"\"");
		response.setHeader("Content-Transfer-Encoding", "binary");
	
		FileInputStream fis = new FileInputStream(file);
		
		OutputStream out = response.getOutputStream();
		
		FileCopyUtils.copy(fis, out);
		out.flush();
		
	}

}
