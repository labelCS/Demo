/**   
 * @Title: LocationDao.java 
 * @Package com.sva.dao 
 * @Description: LocationDao接口类 
 * @author labelCS   
 * @date 2016年9月21日 下午3:28:34 
 * @version V1.0   
 */
package com.sva.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.sva.model.LocationModel;

/** 
 * @ClassName: LocationDao 
 * @Description: LocationDao接口类 
 * @author labelCS 
 * @date 2016年9月21日 下午3:28:34 
 *  
 */
public interface LocationDao {
    
    /** 
     * @Title: findCurrentUser 
     * @Description: 获取当前楼层的顾客数
     * @return 
     */
    public int findCurrentUser(@Param("floorNo")String floorNo, @Param("time")long time);
    
    /** 
     * @Title: deleteLocation 
     * @Description: 清空location表
     * @return 
     */
    public int deleteLocation();

    /** 
     * @Title: queryHeatmap 
     * @Description: 获取当前楼层的顾客位置数据
     * @param floorNo
     * @param time
     * @param tableName
     * @return 
     */
    public List<LocationModel> queryHeatmap(@Param("floorNo")String floorNo, @Param("time")long time);
}
