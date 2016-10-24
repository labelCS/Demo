package com.sva.service.core;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import org.apache.log4j.Logger;

import com.sva.common.conf.Params;
import com.sva.model.core.HttpParams;

/**
 * <p>Title:HttpServiceInterface</p>
 * <p>Description:</p>
 * <p>Company: ICS</p>
 * @author label
 * @date 2016年6月29日 下午5:29:27
 */
public abstract class HttpService {
	
	/**
	 * @Fields log 输出日志
	 */
	private static final Logger LOG = Logger.getLogger(HttpService.class);
	
	/** 
	 * @Title: httpRequest 
	 * @Description: 发送http请求的核心函数
	 * @param httpParam
	 * @return String    
	 * @throws 
	 */
	protected String httpRequest(HttpParams httpParam){
		String line;
        BufferedReader in = null;
        PrintWriter out = null;
        StringBuilder sb = new StringBuilder();
        try{
        	URL realUrl = new URL(httpParam.getUrl());
        	// 打开和URL之间的连接
            URLConnection connection = realUrl.openConnection();
            // 设置通用的请求属性
            connection.setRequestProperty("accept", httpParam.getAccept());
            connection.setRequestProperty("connection", httpParam.getConnection());
            connection.setRequestProperty("user-agent", httpParam.getUserAgent());

        	// 发送POST请求必须设置如下两行
            if(Params.POST.equals(httpParam.getMethod())){
            	connection.setDoOutput(true);
            	connection.setDoInput(true);
            }
            
            // 建立实际的连接
            connection.connect();
            
            // POST请求设置参数
            if(Params.POST.equals(httpParam.getMethod())){
            	// 获取URLConnection对象对应的输出流
                out = new PrintWriter(connection.getOutputStream());
                // 发送请求参数
                out.print(httpParam.getParam());
                // flush输出流的缓冲
                out.flush();
            }
            
            // 定义 BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(
                    connection.getInputStream(),"gb2312"));
            // 循环读取字符流
            while ((line = in.readLine()) != null) {
            	sb.append(line);
            }
        	
        }catch(Exception e){
            LOG.error(e);
        }
        // 关闭输入流
        finally {
            try {
            	if(out != null){
                    out.close();
                }
            	
                if (in != null) {
                    in.close();
                }
            } catch (Exception e2) {
                LOG.error(e2);
            }
        }
        return sb.toString();
	}
	
	public abstract Object sendRequest(Object param);

}
