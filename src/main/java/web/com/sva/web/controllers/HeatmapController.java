package com.sva.web.controllers;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sva.common.ConvertUtil;
import com.sva.common.conf.Params;
import com.sva.dao.AreaDao;
import com.sva.dao.LocationDao;
import com.sva.dao.MapsDao;
import com.sva.model.LocationModel;
import com.sva.model.MapsModel;
import com.sva.web.models.HeatmapModel;

@Controller
@RequestMapping(value = "/heatmap")
public class HeatmapController
{

    @Autowired
    private LocationDao locationDao;
    
    private static final String NUMBER_LITERAL = "number";

    @RequestMapping(value = "/api/getMapInfoByPosition", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> getHeatmapInfoData(@RequestParam("floorNo") String floorNo)
    {

        String bgImg = "";
        int bgImgWidth = 0;
        int bgImgHeight = 0;
        String xo = "";
        String yo = "";
        String scale = "";
        String coordinate = "";
        Collection<MapsModel> resultList = daoMaps.getMapDetail(floorNo);

        for (MapsModel l : resultList)
        {
            bgImg = l.getPath();
            bgImgWidth = l.getImgWidth();
            bgImgHeight = l.getImgHeight();
            xo = l.getXo();
            yo = l.getYo();
            scale = l.getScale();
            coordinate = l.getCoordinate();
        }
        Map<String, Object> modelMap = new HashMap<String, Object>(8);

        modelMap.put(Params.RETURN_KEY_ERROR, null);
        modelMap.put("bg", bgImg);
        modelMap.put("bgWidth", bgImgWidth);
        modelMap.put("bgHeight", bgImgHeight);
        modelMap.put("xo", xo);
        modelMap.put("yo", yo);
        modelMap.put("scale", scale);
        modelMap.put("coordinate", coordinate);

        return modelMap;
    }

    @RequestMapping(value = "/api/getData", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> getHeatmapData(
            @RequestParam("floorNo") String floorNo,
            @RequestParam("times") int times)
    {
        // 查询截至时间
        long time = System.currentTimeMillis() - times * 1000;
        // 表名
        String tableName = Params.LOCATION + ConvertUtil.dateFormat(new Date(), Params.YYYYMMDD);
        List<HeatmapModel> list = new ArrayList<HeatmapModel>(10);
        Collection<LocationModel> resultList = locationDao.queryHeatmap(floorNo, time, tableName);
        HeatmapModel hm;
        for (LocationModel l : resultList)
        {
            hm = new HeatmapModel();
            hm.setX(l.getX());
            hm.setY(l.getY());
            list.add(hm);
        }
        Map<String, Object> modelMap = new HashMap<String, Object>(2);

        modelMap.put(Params.RETURN_KEY_ERROR, null);
        modelMap.put(Params.RETURN_KEY_DATA, list);

        return modelMap;
    }

    @RequestMapping(value = "/api/getData5", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> getHeatmapData5(
            @RequestParam("floorNo") String floorNo,
            @RequestParam("period") int period)
    {
        // 查询截至时间
        long time = System.currentTimeMillis() - period * 60 * 1000;
        // 表名
        String tableName = Params.LOCATION + ConvertUtil.dateFormat(new Date(), Params.YYYYMMDD);
        List<HeatmapModel> list = new ArrayList<HeatmapModel>(10);
        Collection<LocationModel> resultList = locationDao.queryHeatmap5(floorNo, time, tableName);
        HeatmapModel hm;
        for (LocationModel l : resultList)
        {
            hm = new HeatmapModel();
            hm.setX(l.getX());
            hm.setY(l.getY());
            list.add(hm);
        }
        Map<String, Object> modelMap = new HashMap<String, Object>(2);

        modelMap.put(Params.RETURN_KEY_ERROR, null);
        modelMap.put(Params.RETURN_KEY_DATA, list);

        return modelMap;
    }

    @RequestMapping(value = "/api/getFloorsByMarket", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> getFloors(@RequestParam("placeId") String placeId)
    {

        Collection<MapsModel> resultList = daoMaps.getFloors(placeId);
        Map<String, Object> modelMap = new HashMap<String, Object>(2);

        modelMap.put(Params.RETURN_KEY_ERROR, null);
        modelMap.put(Params.RETURN_KEY_DATA, resultList);

        return modelMap;
    }

    @RequestMapping(value = "/api/getFlooNo", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> getFlooNo(
            @RequestParam("floorNo") String floorNo,
            @RequestParam("time") String time)
    {
        // 时间
        String time1 = getChooseTime(time);
        // 表名
        String tableName = Params.LOCATION + ConvertUtil.dateFormat(new Date(), Params.YYYYMMDD);

        List<LocationModel> list = locationDao.getUserId(floorNo,time1,tableName);
        Map<String, Object> modelMap = new HashMap<String, Object>(2);
        modelMap.put(Params.RETURN_KEY_ERROR, null);
        modelMap.put(Params.RETURN_KEY_DATA, list);

        return modelMap;
    }

    @RequestMapping(value = "/api/getMark", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> getMark(
            @RequestParam("userId") String userId,
            @RequestParam("time") String time)
    {
        // 时间
        String time1 = getChooseTime(time);
        // 表名
        String tableName = Params.LOCATION + ConvertUtil.dateFormat(new Date(), Params.YYYYMMDD);
        List<LocationModel> list = locationDao.getMark(userId, time1, tableName);
        Map<String, Object> modelMap = new HashMap<String, Object>(2);
        modelMap.put(Params.RETURN_KEY_ERROR, null);
        modelMap.put(Params.RETURN_KEY_DATA, list);

        return modelMap;
    }

    @RequestMapping(value = "/api/getOverData", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> getOverData(@RequestParam("store") String placeId)
    {
        Calendar currentDate1 = new GregorianCalendar();
        currentDate1.set(Calendar.HOUR_OF_DAY, 0);
        currentDate1.set(Calendar.MINUTE, 0);
        currentDate1.set(Calendar.SECOND, 0);
        String visitDay = ConvertUtil.dateFormat(currentDate1.getTime(),
                "yyyy-MM-dd");
        List<Map<String, Object>> list = areaDao.getNowNumber(placeId);
        Map<String, Object> neirong = new HashMap<String, Object>(2);
        List<String> areaNames = new ArrayList<String>(10);
        List<String> areaIds = new ArrayList<String>(10);
        List<Integer> numbers = new ArrayList<Integer>(10);
        List<String> visitTime = new ArrayList<String>(10);
        List<Map<String, Object>> mapTime;
        long allTime;
        int size;
        String averageTime;
        int lisSize = list.size();
        for (int i = 0; i < lisSize; i++)
        {
            numbers.add(Integer.parseInt(list.get(i).get(NUMBER_LITERAL).toString()));
            areaIds.add(list.get(i).get("areaId").toString());
            areaNames.add(areaDao.getAreaNameByAreaId(
                    list.get(i).get("areaId").toString()).get(0));
        }
        int areaIdSize = areaIds.size();
        for (int i = 0; i < areaIdSize; i++)
        {
            mapTime = areaDao.getOverAverageTime(areaIds.get(i), visitDay);
            if (!mapTime.isEmpty())
            {
                allTime = Long.parseLong(mapTime.get(0).get("allTime")
                        .toString());
                size = Integer
                        .parseInt(mapTime.get(0).get(NUMBER_LITERAL).toString());
                averageTime = getMinute(allTime, size);
                visitTime.add(averageTime);
            }
            else
            {
                visitTime.add("0");
            }
        }
        List<Map<String, Object>> peopleList = daoMaps.getAllPeopleByPlaceId(
                placeId, visitDay);
        int count = 0;
        int allcount = 0;
        int yesterdayAll = 0;
        if (!peopleList.isEmpty())
        {
            allcount = Integer.parseInt(peopleList.get(0).get("nowNumber")
                    .toString());
            yesterdayAll = Integer.parseInt(peopleList.get(0)
                    .get("yesterNumber").toString());
            count = Integer
                    .parseInt(peopleList.get(0).get(NUMBER_LITERAL).toString());
        }

        neirong.put("names", areaNames);
        neirong.put("cout", count);
        neirong.put(NUMBER_LITERAL, numbers);
        neirong.put("allcount", allcount);
        neirong.put(Params.RETURN_KEY_ERROR, null);
        neirong.put("yesterdayAllcount", yesterdayAll);
        neirong.put("visitList", visitTime);

        return neirong;
    }

    public static String getMinute(long time, int size)
    {
        if (size == 0)
        {
            return "0";
        }
        else
        {

            float b = (time / 1000) / 60;
            float averageTime = b / size;
            DecimalFormat df = new DecimalFormat("0.00");
            return df.format(averageTime);
        }

    }
    
    private String getChooseTime(String time)
    {
        String t = "";
        String sTime = null;
        int iTime = 0;
        if (time.equals(t))
        {
            iTime = 60;
        }
        else
        {
            iTime = Integer.parseInt(time);
        }

        long time2 = System.currentTimeMillis() - iTime * 60 * 1000;
        sTime = String.valueOf(time2);

        return sTime;

    }
}
