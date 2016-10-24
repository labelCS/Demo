/**   
 * @Title: HttpsService.java 
 * @Package com.sva.service.core 
 * @Description: https服务
 * @author labelCS   
 * @date 2016年8月18日 下午3:57:48 
 * @version V1.0   
 */
package com.sva.service.core;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

/** 
 * @ClassName: HttpsService 
 * @Description: https服务
 * @author labelCS 
 * @date 2016年8月18日 下午3:57:48 
 *  
 */
public abstract class HttpsService {
	/**
	 * @Fields log 输出日志
	 */
	private static Logger log = Logger.getLogger(HttpsService.class);

    /** 
     * @Fields xtm : 证书管理器 
     */ 
    private X509TrustManager xtm = new X509TrustManager()
    {
        @Override
        public X509Certificate[] getAcceptedIssuers()
        {
            // TODO Auto-generated method stub
            X509Certificate[] a = null;
            return a;
        }

        @Override
        public void checkServerTrusted(X509Certificate[] arg0, String arg1)
                throws CertificateException
        {
            // TODO Auto-generated method stub

        }

        @Override
        public void checkClientTrusted(X509Certificate[] arg0, String arg1)
                throws CertificateException
        {
            // TODO Auto-generated method stub

        }
    };

    /** 
     * @Fields hv : 主机名验证 
     */ 
    private HostnameVerifier hv = new HostnameVerifier()
    {
        @Override
        public boolean verify(String arg0, SSLSession arg1)
        {
            return true;
        }
    };
    
    /** 
     * @Title: httpsPost 
     * @Description: 发送https请求 
     * @param url 请求地址
     * @param content 请求参数
     * @param charset 编码
     * @param method 请求方式
     * @param token 
     * @return
     * @throws NoSuchAlgorithmException
     * @throws KeyManagementException
     * @throws IOException 
     */
    public Map<String,String> httpsPost(String url, String content, String charset,String method, String token)
            throws NoSuchAlgorithmException, KeyManagementException,
            IOException
    {
    	log.debug("httpsPost url:" + url);
        Map<String,String> result = new HashMap<String,String>();
        String returnVal = "";
        URL console = new URL(url);
        HttpsURLConnection con = (HttpsURLConnection) console.openConnection();

        // SSL验证
        TrustManager[] tm = {xtm};
        System.setProperty("https.protocols", "TLSv1");
        SSLContext ctx = SSLContext.getInstance("TLSv1");
        ctx.init(null, tm, null);
        con.setSSLSocketFactory(ctx.getSocketFactory());
        con.setHostnameVerifier(hv);

        // 属性设置
        con.setDoOutput(true);
        con.setDoInput(true);
        con.setRequestMethod(method);
        con.setRequestProperty("Accept", "application/json");
        con.setRequestProperty("Content-Type", "application/json");
        if(StringUtils.isNotEmpty(token)){
            con.setRequestProperty("X-Auth-Token", token);        	
        }

        // 写入参数
        DataOutputStream out = new DataOutputStream(con.getOutputStream());
        out.write(content.getBytes("UTF-8"));
        out.flush();
        out.close();
        // 接受响应并返回
        InputStream is = con.getInputStream();
        if (is != null)
        {
            ByteArrayOutputStream outStream = new ByteArrayOutputStream();
            byte[] buffer = new byte[1024];
            int len = 0;
            while ((len = is.read(buffer)) != -1)
            {
                outStream.write(buffer, 0, len);
            }
            is.close();
            returnVal = outStream.toString();
            log.debug(result);
        }
        con.disconnect();
        
        result.put("result", returnVal);
        result.put("token", con.getHeaderField("X-Subject-Token"));
        return result;
    }
}
