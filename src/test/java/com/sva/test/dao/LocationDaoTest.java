/**    
 * @Title:  LocationDaoTest.java   
 * @Package com.sva.test.dao   
 * @Description:    LocationDao测试类   
 * @author: LabelCS    
 * @date:   2016年9月3日 下午9:20:39   
 * @version V1.0     
 */  
package com.sva.test.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
    public void doquery1Test(){
        String userId = "11111";
        String floorNo = "1";
        List<LocationModel> result = locationDao.doquery1(userId, floorNo);
        Assert.assertEquals("结果为0",0, result.size());
    }
    
    @Test
    public void queryHeatmapTest(){
        String floorNo = "10001";
        long time = 1111L;
        String tableName = "location20160625";
        List<LocationModel> result = locationDao.queryHeatmap(floorNo, time, tableName);
        Assert.assertNotEquals("结果不为0",0, result.size());
    }
    
    @Test
    public void queryHeatmap5Test(){
        String floorNo = "10001";
        long time = 1111L;
        String tableName = "location20160625";
        List<LocationModel> result = locationDao.queryHeatmap5(floorNo, time, tableName);
        Assert.assertNotEquals("结果不为0",0, result.size());
    }
    
    @Test
    public void queryHeatmap6Test(){
        String floorNo = "10001";
        String tableName = "location20160625";
        List<LocationModel> result = locationDao.queryHeatmap6(floorNo, tableName);
        Assert.assertNotEquals("结果不为0",0, result.size());
    }
    
    @Test
    public void queryLocationByUseIdTest(){
        String userId = "1";
        List<LocationModel> result = locationDao.queryLocationByUseId(userId);
        Assert.assertEquals("结果为0",0, result.size());
    }
    
    @Test
    public void getUserIdTest(){
        String floorNo = "1";
        String time = "1111";
        String tableName = "location20160625";
        List<LocationModel> result = locationDao.getUserId(floorNo, time, tableName);
        Assert.assertEquals("结果为0",0, result.size());
    }
    
    @Test
    public void getMarkTest(){
        String userId = "1";
        String time = "1111";
        String tableName = "location20160615";
        List<LocationModel> result = locationDao.getMark(userId, time, tableName);
        Assert.assertEquals("结果为0",0, result.size());
    }
    
    @Test
    public void queryOverDataTest(){
        int floorNo = 40003;
        String time = "1111";
        String tableName = "location20160615";
        List<LocationModel> result = locationDao.queryOverData(floorNo, time, tableName);
        Assert.assertNotEquals("结果不为0",0, result.size());
    }
    
    @Test
    public void queryLocationForPositionTest(){
        String floorNo = "10001";
        List<String> timeList = new ArrayList<String>();
        timeList.add("20160625");
        timeList.add("20160626");
        timeList.add("20160627");
        List<Map<String, Object>> result = locationDao.queryLocationForPosition(floorNo, timeList);
        Assert.assertNotEquals("结果不为0",0, result.size());
    }
    
    @Test
    public void queryScatterMapDataTest(){
        String floorNo = "10001";
        long time = 1111L;
        String tableName = "location20160625";
        List<Map<String, Object>> result = locationDao.queryScatterMapData(floorNo,time, tableName);
        Assert.assertNotEquals("结果不为0",0, result.size());
    }
}
