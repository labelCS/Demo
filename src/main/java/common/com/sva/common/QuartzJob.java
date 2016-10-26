package com.sva.common;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import com.sva.common.conf.GlobalConf;
import com.sva.service.AmqpThread;
import com.sva.service.SubscriptionService;

public class QuartzJob {
    
    @Autowired
    private SubscriptionService service;

    private static final Logger LOG = Logger.getLogger(QuartzJob.class);
    
    /** 
     * @Title: startSva 
     * @Description: 启动与SVA的对接
     */
    public void startSva(){
        LOG.debug("执行SVA初始对接");
        service.initParams();
        service.subscribeSva();
    }
    
    /** 
     * @Title: checkSvaStatus 
     * @Description: 检查SVA对接是否正常，如不正常则重新发起订阅
     */
    public void checkSvaStatus(){
        LOG.debug("检查SVA对接是否正常");
        // 判断接受数据线程是否在运行,数据库是否有数据
        AmqpThread thread = GlobalConf.getAmqpThread();
        if(thread==null || !thread.isAlive() || !service.checkDataIsFreash()){
            // 重新订阅
            service.unsubscribe();
            service.subscribeSva();
        }
    }
    
    /** 
     * @Title: cleanLocation 
     * @Description: 每日定时清除location表 
     */
    public void cleanLocation(){
        LOG.debug("执行location表清空任务");
        service.cleanLocation();
    }
}
