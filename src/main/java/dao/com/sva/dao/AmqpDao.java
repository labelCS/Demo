/**    
 * @Title:  AmqpDao.java   
 * @Package com.sva.dao   
 * @Description:  对接amqp   
 * @author: LabelCS    
 * @date:   2016年8月27日 上午10:41:23   
 * @version V1.0     
 */  
package com.sva.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.sva.model.LocationModel;
import com.sva.model.SvaModel;

/**   
 * @ClassName:  AmqpDao   
 * @Description: 对接amqp   
 * @author: LabelCS  
 * @date:   2016年8月27日 上午10:41:23   
 *      
 */
@SuppressWarnings("all")
@Repository
public interface AmqpDao {
    
    /** 
     * @Title: saveAmqpData 
     * @Description: 位置信息存储逻辑
     * @param loc：位置数据
     * @param tableName：表名
     * @return 
     */
    public int saveAmqpData(@Param("loc")LocationModel loc, @Param("tableName")String tableName);
    
    /** 
     * @Title: checkPhoneIsExisted 
     * @Description: 检查该用户是否已经存在
     * @param userId：用户id
     * @return 
     */
    public int checkPhoneIsExisted(String userId);
    
    /** 
     * @Title: updatePhoneLocation 
     * @Description: 更新制定用户的位置信息
     * @param loc
     * @return 
     */
    public int updatePhoneLocation(LocationModel loc);
    
    /**   
     * @Title: svaPrru   
     * @Description: prru数据入库逻辑  
     * @param enbid
     * @param userId
     * @param gpp
     * @param rsrp
     * @param ip       
     * @throws   
     */ 
    public int svaPrru(@Param("enbid")String enbid,@Param("userId")String userId,@Param("gpp")String gpp,
            @Param("rsrp")String rsrp,@Param("ip")String ip);
    
    /**   
     * @Title: svaGeofencing   
     * @Description: 电子围栏数据入库逻辑   
     * @param idType
     * @param userId
     * @param mapId
     * @param zoneId
     * @param zoneEvent
     * @param timestamp
     * @return：int       
     * @throws   
     */ 
    public int svaGeofencing(@Param("idType")String idType,@Param("userId")String userId,@Param("mapId")String mapId,
            @Param("zoneId")String zoneId,@Param("zoneEvent")String zoneEvent, @Param("timestamp")String timestamp, 
            @Param("timeLocal")long timeLocal);
    
    /** 
     * @Title: getActiveSva 
     * @Description: 获取启动状态的sva信息 
     * @return 
     */
    public List<SvaModel> getActiveSva();
}
