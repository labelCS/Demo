package com.sva.common.conf;

import com.sva.service.AmqpThread;

public abstract class GlobalConf
{
    public static String svaIp;
    
    public static String tokenPort;
    
    public static String brokerPort;
    
    public static int type;
    
    public static String appName;
    
    public static String appPassword;
    
    public static int isSpecific;
    
    public static String idType;
    
    public static String floorNo;
    
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
