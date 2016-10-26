package com.sva.web.controllers;

import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContext;

/**
 * <p>Title:HomeController</p>
 * <p>Description:页面菜单跳转controller</p>
 * <p>Company: ICS</p>
 * @author label
 * @date 2016年6月30日 下午2:59:26
 */
@Controller
@RequestMapping(value = "/home")
public class HomeController
{

    private static final Logger LOG = Logger.getLogger(HomeController.class);

    @Autowired
    private LocaleResolver localeResolver;

    @RequestMapping(value = "/showStoreMng", method = {RequestMethod.GET})
    public String showSvaMng(Model model)
    {
        model.addAttribute("infoMng", true);
        model.addAttribute("storeMng", true);
        return "home/storeMng";
    }

    
    @RequestMapping(value = "/showSvaMng", method = {RequestMethod.GET})
    public String showSvaMng(Model model,
            @RequestParam(value = "info", required = false) String info)
    {
        model.addAttribute("infoMng", true);
        model.addAttribute("svaMng", true);
        model.addAttribute("info", info);
        return "home/svaMng";
    }

    @RequestMapping(value = "/showHeatmap", method = {RequestMethod.GET})
    public String showHeatmap(Model model)
    {
        model.addAttribute("customerStat", true);
        model.addAttribute("heatmap", true);
        return "home/heatmap";
    }

    @RequestMapping(value = "/sample/heatmap", method = {RequestMethod.GET})
    public String showHeatmapSample(Model model, @RequestParam("floorNo") String floorNo)
    {
        model.addAttribute("floorNos", floorNo);
        return "tool/heatmapSample";
    }
    
    @RequestMapping(value = "/changeLocal", method = {RequestMethod.GET})
    public String changeLocal(HttpServletRequest request, String local,
            HttpServletResponse response)
    {
        if ("zh".equals(local))
        {
            localeResolver.setLocale(request, response, Locale.CHINA);
        }
        else if ("en".equals(local))
        {
            localeResolver.setLocale(request, response, Locale.ENGLISH);
        }
        String lastUrl = request.getHeader("Referer");
        String str;
        if (lastUrl.indexOf("?") != -1)
        {
            str = lastUrl.substring(0, lastUrl.lastIndexOf("?"));
        }
        else
        {
            str = lastUrl;
        }
        RequestContext requestContext = new RequestContext(request);

        Locale myLocale = requestContext.getLocale();

        LOG.info(myLocale);

        return "redirect:" + str;
    }

    @RequestMapping(value = "/notfound")
    public ModelAndView notfound()
    {

        ModelAndView mv = new ModelAndView();
        mv.setViewName("404");

        return mv;
    }
}
