/**    
 * @Title:  LocationDaoTest.java   
 * @Package com.sva.test.dao   
 * @Description:    LocationDao测试类   
 * @author: LabelCS    
 * @date:   2016年9月3日 下午9:20:39   
 * @version V1.0     
 */  
package com.sva.test.dao;

import java.util.List;
import javax.annotation.Resource;
import org.junit.Test;
import com.sva.dao.LocationDao;
import com.sva.model.LocationModel;
import org.junit.Assert;

/**   
 * @ClassName:  LocationDaoTest   
 * @Description: LocationDao测试类  
 * @author: LabelCS  
 * @date:   2016年9月3日 下午9:20:39   
 *      
 */
public class LocationDaoTest extends BasicDaoTest {
    
    @Resource
    LocationDao locationDao;

    @Test
    public void findCurrentUserTest(){
        String floorNo = "1";
        long time = 1212122121L;
        int result = locationDao.findCurrentUser(floorNo,time);
        Assert.assertEquals("结果为0",0, result);
    }
    
    @Test
    public void checkSvaDataExistedTest(){
        long time = 1212122121L;
        int result = locationDao.checkSvaDataExisted(time);
        Assert.assertEquals("结果为0",0, result);
    }
    
    @Test
    public void deleteLocationTest(){
        int result = locationDao.deleteLocation();
        Assert.assertEquals("结果为1",1, result);
    }
    
    @Test
    public void queryHeatmapTest(){
        String floorNo = "10001";
        long time = 1111L;
        List<LocationModel> result = locationDao.queryHeatmap(floorNo, time);
        Assert.assertNotEquals("结果不为0",0, result.size());
    }
}
