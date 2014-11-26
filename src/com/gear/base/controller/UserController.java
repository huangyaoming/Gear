package com.gear.base.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.gear.base.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService service;
	
	@RequestMapping
	public ModelAndView addUser(String name, String sex) {
		ModelAndView mv = new ModelAndView("result");
		Map<String, Object> user = new HashMap<String, Object>();
		user.put("name", name);
		user.put("sex", sex);
		try {
			service.addUser(user);
			user.put("returnCode", 0);
		} catch (DataAccessException e) {
			user.put("returnCode", -1);
			user.put("errorMessage", e.getMessage());
		}
		mv.addObject("map", user);
		return mv;
	}
}
