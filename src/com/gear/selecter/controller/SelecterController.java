package com.gear.selecter.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.gear.searchbox.controller.RegionEntry;
import com.gear.utils.ControllerUtil;

@Controller
public class SelecterController {

	@RequestMapping
	public ModelAndView show() {
		ModelAndView mv = new ModelAndView("selecter/selectershow");
		return mv;
	}
	
	@RequestMapping
	public void getInitData(HttpServletResponse response) throws Exception {
		Map<String, List<String>> map = new HashMap<String, List<String>>();
		List<String> guangdong = Arrays.asList("广州", "深圳", "东莞", "佛山", "珠海", "江门", "韶关");
		List<String> guangxi = Arrays.asList("南宁", "柳州", "桂林", "梧州", "玉林", "贵港");
		map.put("广东", guangdong);
		map.put("广西", guangxi);
		List<Map<String, List<String>>> list = new ArrayList<Map<String, List<String>>>();
		list.add(map);
		
//		List<String> provinces = new ArrayList<String>();
//		provinces.add("广东");
//		provinces.add("广西");
//		List<String> guangdongcity = Arrays.asList("广州", "深圳", "东莞", "佛山", "珠海", "江门", "韶关");
//		List<String> guangxicity = Arrays.asList("南宁", "柳州", "桂林", "梧州", "玉林", "贵港");
//		List<List<String>> city = new ArrayList<List<String>>();
//		city.add(guangdongcity);
//		city.add(guangxicity);
//		List<Object> list = new ArrayList<Object>();
//		list.add(e)
		
		ControllerUtil.pageListToJson(response, list, list.size());
	}
	
	@RequestMapping
	public void getRegion(HttpServletResponse response) throws Exception {
		RegionEntry root = new RegionEntry("0", "全球");
		
		RegionEntry china = new RegionEntry("00000A", "中国");
		RegionEntry american = new RegionEntry("00000B", "美国");
		
		List<RegionEntry> rootsub = new ArrayList<RegionEntry>();
		rootsub.add(china);
		rootsub.add(american);
		root.setSubRegion(rootsub);
		
		List<RegionEntry> subRegion = new ArrayList<RegionEntry>();
		RegionEntry guangdong = new RegionEntry("440000", "广东");
		RegionEntry guangxi = new RegionEntry("450000", "广西");
		subRegion.add(guangdong);
		subRegion.add(guangxi);
		china.setSubRegion(subRegion);
		
		List<RegionEntry> guangxiSub = new ArrayList<RegionEntry>();
		List<String> gx = Arrays.asList("南宁", "柳州", "桂林", "梧州", "玉林", "贵港");
		List<String> gxcode = Arrays.asList("450100", "450200", "450300", "450400", "450500", "450800");
		for (int i = 0; i < gx.size(); i++) {
			RegionEntry temp = new RegionEntry(gxcode.get(i), gx.get(i));
			guangxiSub.add(temp);
		}
		guangxi.setSubRegion(guangxiSub);
		
		List<RegionEntry> guangdongSub = new ArrayList<RegionEntry>();
		List<String> gd = Arrays.asList("广州", "深圳", "东莞", "佛山", "珠海", "江门", "韶关");
		List<String> gdcode = Arrays.asList("440100", "440200", "440300", "440400", "440500", "440600", "440700");
		for (int i = 0; i < gd.size(); i++) {
			RegionEntry temp = new RegionEntry(gdcode.get(i), gd.get(i));
			guangdongSub.add(temp);
		}
		guangdong.setSubRegion(guangdongSub);
		
		ControllerUtil.beantoJson(response, root);
	}
}
