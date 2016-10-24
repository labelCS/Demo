/**   
 * @Title: HttpParams.java 
 * @Package com.sva.model.core 
 * @Description: 用于发送http请求的参数 
 * @Company:ICS
 * @author label  
 * @date 2016年6月30日 上午9:27:28 
 * @version V1.0 
 */
package com.sva.model.core;

/**
 * <p>Title:HttpParams</p>
 * <p>Description:用于发送http请求的参数</p>
 * <p>Company: ICS</p>
 * @author label
 * @date 2016年6月30日 上午9:27:28
 */
public class HttpParams {
	/**
	 * @Fields url 请求地址
	 */
	private String url = "";
	
	/**
	 * @Fields accept 请求报头
	 */
	private String accept = "*/*";
	
	/**
	 * @Fields connection 如何处理长连接
	 */
	private String connection = "Keep-Alive";
	
	/**
	 * @Fields userAgent 包含请求者的一些信息
	 */
	private String userAgent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)";
	
	/**
	 * @Fields method 请求方法
	 */
	private String method = "GET";
	
	/**
	 * @Fields param POST请求参数，形如name1=value1&name2=value2
	 */
	private String param = "";
	
	/**
	 * @return the param 
	 */
	public String getParam() {
		return param;
	}

	/**
	 * @param param the param to set
	 */
	public void setParam(String param) {
		this.param = param;
	}

	/**
	 * @return the method
	 */
	public String getMethod() {
		return method;
	}

	/**
	 * @param method the method to set
	 */
	public void setMethod(String method) {
		this.method = method;
	}

	/**
	 * @return the url
	 */
	public String getUrl() {
		return url;
	}
	
	/**
	 * @param url the url to set
	 */
	public void setUrl(String url) {
		this.url = url;
	}
	
	/**
	 * @return the accept
	 */
	public String getAccept() {
		return accept;
	}
	
	/**
	 * @param accept the accept to set
	 */
	public void setAccept(String accept) {
		this.accept = accept;
	}
	
	/**
	 * @return the connection
	 */
	public String getConnection() {
		return connection;
	}
	
	/**
	 * @param connection the connection to set
	 */
	public void setConnection(String connection) {
		this.connection = connection;
	}
	
	/**
	 * @return the userAgent
	 */
	public String getUserAgent() {
		return userAgent;
	}
	
	/**
	 * @param userAgent the userAgent to set
	 */
	public void setUserAgent(String userAgent) {
		this.userAgent = userAgent;
	}
	

}
