package com.gear.datetime.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DatetimeController {

	@RequestMapping
	public ModelAndView show() {
		ModelAndView mv = new ModelAndView("datetime/datetimeshow");
		return mv;
	}
	
	@RequestMapping
	public void getDate(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		System.out.println(year + "-" + month + "-" + day);
	}
	
	@RequestMapping
	public void getDatetime(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String chooseDate = request.getParameter("chooseDate");
		System.out.println(startDate);
		System.out.println(endDate);
		System.out.println(chooseDate);
	}
}
