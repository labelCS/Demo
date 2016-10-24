/**   
 * @Title: SubscriptionService.java 
 * @Package com.sva.service 
 * @Description: 订阅服务 
 * @author labelCS   
 * @date 2016年8月18日 下午4:43:51 
 * @version V1.0   
 */
package com.sva.service;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.sva.common.ConvertUtil;
import com.sva.common.conf.GlobalConf;
import com.sva.dao.AmqpDao;
import com.sva.dao.LocationDao;
import com.sva.service.core.HttpsService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/** 
 * @ClassName: SubscriptionService 
 * @Description: 订阅服务
 * @author labelCS 
 * @date 2016年8月18日 下午4:43:51 
 *  
 */
@Service
public class SubscriptionService extends HttpsService {
    /**
     * @Fields log ： 输出日志
     */
    private static final Logger LOG = Logger.getLogger(SubscriptionService.class);
        
    /**   
     * @Fields amqpDao : amqp对接入库dao   
     */ 
    @Autowired
    private AmqpDao amqpDao;
    
    /** 
     * @Fields locDao : 位置dao
     */ 
    @Autowired
    private LocationDao locDao;
    
    @Value("${sva_ip}")
    private String svaIp;
    
    @Value("${sva_token_port}")
    private String tokenPort;
    
    @Value("${sva_broker_port}")
    private String brokerPort;
    
    @Value("${sva_type}")
    private int type;
    
    @Value("${app_name}")
    private String appName;
    
    @Value("${app_password}")
    private String appPassword;
    
    @Value("${sva_id_specific}")
    private int isSpecific;
    
    @Value("${sva_id_type}")
    private String idType;
    
    /** 
     * @Title: subscribeSva 
     * @Description: 实现sva数据订阅
     * @param sva sva信息
     */
    public void subscribeSva(){
        LOG.debug("subscripiton started!");
        
        // 获取token地址
        String url = "https://" + svaIp + ":"
                + tokenPort + "/v3/auth/tokens";
        // 获取token参数
        String content = "{\"auth\":{\"identity\":{\"methods\":[\"password\"],\"password\": {\"user\": {\"domain\": \"Api\",\"name\": \""
                + appName
                + "\",\"password\": \""
                + appPassword + "\"}}}}}";
        String charset = "UTF-8";
        
        try{
            // 获取token值
            Map<String,String> tokenResult = this.httpsPost(url, content, charset,"POST", null);
            String token = tokenResult.get("token");
            
            if(StringUtils.isEmpty(token)){
                LOG.warn("token got failed!");
                return;
            }
            LOG.debug("token got:"+token);
            
            // 是否需要在订阅参数中加idType
            String idTypeString = "";
            if(isSpecific == 1){
                idTypeString = ",\"idType\":\""+idType+"\"";
            }
            
            // 非匿名化全量订阅
            if (type == 0)
            {
                url = "https://" + svaIp + ":" + tokenPort
                        + "/enabler/catalog/locationstreamreg/json/v1.0";
                content = "{\"APPID\":\"" + appName + "\"" +idTypeString + "}";
            }
            // 匿名化全量订阅
            else if (type == 1)
            {
                url = "https://"
                        + svaIp
                        + ":"
                        + tokenPort
                        + "/enabler/catalog/locationstreamanonymousreg/json/v1.0";
                content = "{\"APPID\":\"" + appName + "\"}";
            }
            // 指定用户订阅
            else if (type == 2)
            {
                url = "https://" + svaIp + ":" + tokenPort
                        + "/enabler/catalog/locationstreamreg/json/v1.0";
                content = "{\"APPID\":\"" + appName
                        + "\"" + idTypeString
                        + ",\"useridlist\":[\""
                        + ConvertUtil.convertMacOrIp("10.10.10.10")
                        + "\"]}";
            }
            LOG.debug("url:"+url+"--content:"+content);
    
            // 获取订阅ID
            Map<String,String> subResult = this.httpsPost(url, content, charset,"POST", tokenResult.get("token"));
            LOG.debug("subscription result:" + subResult.get("result"));
            JSONObject jsonObj = JSONObject.fromObject(subResult.get("result"));    
            JSONArray list = jsonObj.getJSONArray("Subscribe Information");
            JSONObject obj = (JSONObject) list.get(0);
            String queueId = obj.getString("QUEUE_ID");
            LOG.debug("queueId:" + queueId);
            
            // 如果获取queueId，则进入数据对接逻辑
            if(StringUtils.isNotEmpty(queueId)){
                AmqpThread at = new AmqpThread(amqpDao,queueId);
                GlobalConf.setAmqpThread(at);
                at.start();
            }else{
                LOG.warn("queueId got failed!");
            }
        }
        catch (IOException e)
        {
            LOG.error("IOException.", e);
        }
        catch (KeyManagementException e)
        {
            LOG.error("KeyManagementException.", e);
        }
        catch (NoSuchAlgorithmException e)
        {
            LOG.error("NoSuchAlgorithmException.", e);
        }
    }
    
    /**   
     * @Title: unsubscribe   
     * @Description: 取消订阅    
     * @return: void      
     * @throws   
     */ 
    public void unsubscribe()
    {
        LOG.debug("unsubcribe started!");
        String url = "";
        String content = "";

        try
        {
            // 获取token
            url = "https://" + svaIp + ":"
                    + tokenPort + "/v3/auth/tokens";
            content = "{\"auth\":{\"identity\":{\"methods\":[\"password\"],\"password\": {\"user\": {\"domain\": \"Api\",\"name\": \""
                    + appName
                    + "\",\"password\": \""
                    + appPassword + "\"}}}}}";
            String charset = "UTF-8";
            Map<String,String> tokenResult = this.httpsPost(url, content, charset,"POST", null);            
            String token = tokenResult.get("token");            
            if(StringUtils.isEmpty(token)){
                LOG.warn("[unsubscribe]token got failed!");
                return;
            }
            LOG.debug("[unsubscribe]token got:"+token);
            
            // 是否需要在订阅参数中加idType
            String idTypeString = "";
            if(isSpecific == 1){
                idTypeString = ",\"idType\":\""+idType+"\"";
            }
            
            // 非匿名化取消订阅
            if (type == 0){
                url = "https://" + svaIp + ":" + tokenPort
                        + "/enabler/catalog/locationstreamunreg/json/v1.0";
                content = "{\"APPID\":\"" + appName+ "\""+idTypeString+"}";
                Map<String,String> subResult = this.httpsPost(url, content,charset, "DELETE", token);
                LOG.debug("[unsubscribe]result:" + subResult.get("result"));
            }else if(type == 1){
                // 匿名化取消订阅
                url = "https://" + svaIp + ":" + tokenPort
                        + "/enabler/catalog/locationstreamanonymousunreg/json/v1.0";
                content = "{\"APPID\":\"" + appName + "\"}";
                Map<String,String> subResultAnonymous = this.httpsPost(url, content,charset, "DELETE", token);
                LOG.debug("[unsubscribe]anonymous result:" + subResultAnonymous.get("result"));
            }
            
            // 关闭amqp连接
            GlobalConf.removeAmqpThread();
            LOG.debug("[unsubscribe]connection closed!");

        }
        catch (KeyManagementException e)
        {
            LOG.error("KeyManagementException.", e);
        }
        catch (NoSuchAlgorithmException e)
        {
            LOG.error("NoSuchAlgorithmException.", e);
        }
        catch (IOException e)
        {
            LOG.error("IOException.", e);
        }
        catch (Exception e)
        {
            LOG.error("Exception.", e);
        }
    }
    
    /** 
     * @Title: checkDataIsFreash 
     * @Description: 检查数据是否在持续接收
     * @return 
     */
    public boolean checkDataIsFreash(){
        int result = locDao.findCurrentUser();
        if(result > 0){
            return true;
        }else{
            return false;
        }
    }
    
    /** 
     * @Title: cleanLocation 
     * @Description: 定时清除location数据
     */
    public void cleanLocation(){
        //清空location表
        locDao.deleteLocation();
    }
}
