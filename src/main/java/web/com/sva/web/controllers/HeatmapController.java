package com.sva.web.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.sva.common.conf.Params;
import com.sva.dao.LocationDao;
import com.sva.model.LocationModel;
import com.sva.service.SubscriptionService;

@Controller
@RequestMapping(value = "/heatmap")
public class HeatmapController
{
    /** 
     * @Fields locationDao : 位置dao
     */ 
    @Autowired
    private LocationDao locationDao;
    
    /** 
     * @Fields service : 订阅服务
     */ 
    @Autowired
    private SubscriptionService service;
    
    /** 
     * @Title: getHeatmapData 
     * @Description: 获取最近一段时间某个楼层的人流数据
     * @param floorNo：楼层号
     * @param times：多长时间段内（单位秒）
     * @return 
     */
    @RequestMapping(value = "/api/getData", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> getHeatmapData(
            @RequestParam("floorNo") String floorNo,
            @RequestParam("times") int times)
    {
        // 返回值
        Map<String, Object> modelMap = new HashMap<String, Object>();
        // 查询截至时间
        long time = System.currentTimeMillis() - times * 1000;
        // 位置数据
        List<LocationModel> resultList = locationDao.queryHeatmap(floorNo, time);
        
        // 如果没有数据，要返回提示给客户端
        if(resultList.isEmpty()){
            modelMap.put(Params.RETURN_KEY_ERROR, "No Data!");
        }
        
        modelMap.put(Params.RETURN_KEY_DATA, resultList);

        return modelMap;
    }

    /** 
     * @Title: diagnoseSva 
     * @Description: 没有数据的情况下，对SVA连接进行测试，确认问题原因
     * @return 
     */
    @RequestMapping(value = "/api/diagnoseSva", method = {RequestMethod.GET})
    @ResponseBody
    public Map<String, Object> diagnoseSva()
    {
        return service.diagnoseSva();
    }
        
}
