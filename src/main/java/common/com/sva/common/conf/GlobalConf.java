package com.sva.common.conf;

import org.springframework.beans.factory.annotation.Value;
import com.sva.service.AmqpThread;

public abstract class GlobalConf
{
    @Value("${sva_ip}")
    public static String svaIp;
    
    @Value("${sva_token_port}")
    public static String tokenPort;
    
    @Value("${sva_broker_port}")
    public static String brokerPort;
    
    @Value("${sva_type}")
    public static int type;
    
    @Value("${app_name}")
    public static String appName;
    
    @Value("${app_password}")
    public static String appPassword;
    
    @Value("${sva_id_specific}")
    public static int isSpecific;
    
    @Value("${sva_id_type}")
    public static String idType;
    
    /**
     * 对接SVA数据线程
     */
    private static AmqpThread thread = null;
    
    /**   
     * @Title: addService   
     * @Description: 加入SVA数据对接管理表   
     * @return: void      
     * @throws   
     */ 
    public static synchronized void setAmqpThread(AmqpThread threadParam)
    {
        thread = threadParam;
    }

    /**   
     * @Title: removeService   
     * @Description: 移除SVA数据对接管理表  
     * @return: void      
     * @throws   
     */ 
    public static synchronized void removeAmqpThread()
    {
    	if(thread != null){
    	    thread.stopThread();
    	}
    }

    /**   
     * @Title: getService   
     * @Description: 根据键，获取对应的sva数据对接服务  
     * @return：SubscriptionService       
     * @throws   
     */ 
    public static synchronized AmqpThread getAmqpThread()
    {
        return thread;
    }
}
