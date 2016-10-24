/**    
 * @Title:  AmqpDaoDaoTest.java   
 * @Package com.sva.test.dao   
 * @Description:    AmqpDaoDao测试类   
 * @author: LabelCS    
 * @date:   2016年9月3日 下午9:20:39   
 * @version V1.0     
 */  
package com.sva.test.dao;

import java.math.BigDecimal;
import java.util.List;
import javax.annotation.Resource;
import org.junit.Test;
import com.sva.dao.AmqpDao;
import com.sva.model.LocationModel;
import com.sva.model.SvaModel;
import org.junit.Assert;

/**   
 * @ClassName:  AmqpDaoTest   
 * @Description:AmqpDaoDao测试类  
 * @author: LabelCS  
 * @date:   2016年9月3日 下午9:20:39   
 *      
 */
public class AmqpDaoTest extends BasicDaoTest {
    
    @Resource
    AmqpDao amqpDao;
    
    @Test
    public void saveAmqpAllPeopleTest(){
        String tableName = "location20161010";
        LocationModel loc = new LocationModel();
        loc.setDataType("ok");
        loc.setIdType("IP");
        loc.setTimeLocal(new BigDecimal(System.currentTimeMillis()));
        loc.setTimestamp(new BigDecimal(1212121));
        loc.setUserID("12121212");
        loc.setX(new BigDecimal(1));
        loc.setY(new BigDecimal(2));
        loc.setZ(new BigDecimal(2));        
        int result = amqpDao.saveAmqpData(loc, tableName);
        Assert.assertEquals("结果为1",1, result);
    }
    
    @Test
    public void checkPhoneIsExistedTest(){
        String userId = "12121212";
        int result = amqpDao.checkPhoneIsExisted(userId);
        Assert.assertEquals("结果为0",0, result);
    }
    
    @Test
    public void updatePhoneLocationTest(){
        LocationModel loc = new LocationModel();
        loc.setDataType("ok");
        loc.setIdType("IP");
        loc.setTimeLocal(new BigDecimal(System.currentTimeMillis()));
        loc.setTimestamp(new BigDecimal(1212121));
        loc.setUserID("12121212");
        loc.setX(new BigDecimal(1));
        loc.setY(new BigDecimal(2));
        loc.setZ(new BigDecimal(2));        
        int result = amqpDao.updatePhoneLocation(loc);
        Assert.assertEquals("结果为0",0, result);
    }
    
    @Test
    public void svaPrruTest(){
        String enbid = "111";
        String userId = "12121212";
        String gpp = "2_01";
        String rsrp = "-1300";
        String ip = "17.0.0.1";
        int result = amqpDao.svaPrru(enbid, userId, gpp, rsrp, ip);
        Assert.assertEquals("结果为1",1, result);
    }
    
    @Test
    public void svaGeofencingTest(){
        String idType = "IP";
        String userId = "12121212";
        String mapId = "1111";
        String zoneId = "1";
        String zoneEvent = "enter";
        String timestamp = "111111";
        long timeLocal = System.currentTimeMillis();
        int result = amqpDao.svaGeofencing(idType, userId, mapId, zoneId, zoneEvent, timestamp, timeLocal);
        Assert.assertEquals("结果为1",1, result);
    }

    @Test
    public void getActiveSvaTest(){
        List<SvaModel> result = amqpDao.getActiveSva();
        Assert.assertEquals("结果为1",1, result.size());
    }
}
