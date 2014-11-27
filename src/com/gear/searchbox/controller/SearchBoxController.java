package com.gear.searchbox.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.gear.utils.ControllerUtil;

@Controller
public class SearchBoxController {

	@RequestMapping
	public ModelAndView show() {
		ModelAndView mv = new ModelAndView("searchbox/searchboxshow");
		return mv;
	}
	
	@RequestMapping
	public void getRegion(HttpServletResponse response) throws Exception {
		
		List<RegionEntry> root = new ArrayList<RegionEntry>();
		
		List<String> gx = Arrays.asList("南宁南宁南宁南宁", "柳州", "桂林", "梧州", "玉林", "贵港");
		List<String> gxcode = Arrays.asList("450100", "450200", "450300", "450400", "450500", "450800");
		List<String> gxspell = Arrays.asList("nnnnnnnn", "lzhlz", "gl", "wzhwz", "yl", "gg");
		List<String> gxpinyin = Arrays.asList("nanningnanning", "liuzhou", "guilin", "wuzhou", "yulin", "guigang");
		for (int i = 0; i < gx.size(); i++) {
			RegionEntry temp = new RegionEntry(gxcode.get(i), gx.get(i));
			temp.setPinyin(gxpinyin.get(i));
			temp.setSpell(gxspell.get(i));
			root.add(temp);
		}
		
		List<String> gd = Arrays.asList("广州", "深圳", "东莞", "佛山", "珠海", "江门", "韶关");
		List<String> gdcode = Arrays.asList("440100", "440200", "440300", "440400", "440500", "440600", "440700");
		List<String> gdspell = Arrays.asList("gzhgz", "szhsz", "dg", "fshfs", "zhhzh", "jm", "shgsg");
		List<String> gdpinyin = Arrays.asList("guangzhou", "shenzhen", "dongguan", "foshan", "zhuhai","jiangmen", "shaoguan");
		for (int i = 0; i < gd.size(); i++) {
			RegionEntry temp = new RegionEntry(gdcode.get(i), gd.get(i));
			temp.setPinyin(gdpinyin.get(i));
			temp.setSpell(gdspell.get(i));
			root.add(temp);
		}
		
		ControllerUtil.pageListToJson(response, root, root.size());
	}
}
