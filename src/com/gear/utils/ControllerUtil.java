package com.gear.utils;

import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Controller工具类,json转bean,bean转json
 *
 */
public class ControllerUtil {
	
	private static final Logger log = LogManager.getLogger(ControllerUtil.class);
	
	private static final String DEFAULT_DATE_PATTERN = "yyyy-MM-dd";
	
	private static final String DEFAULT_DOUBLE_PATTERN = "0.00";
	
	/**
	 * 可映射Controller中多个对象
	 * {"page":{"first":1,"max":10,"orderBy":"TEST_ID asc"},"test":{"testName":"titleName"}}
	 * @param request
	 * @param obj
	 * @throws Exception
	 */
	public static void jsonToBean(HttpServletRequest request, Object obj) throws Exception {		
		Enumeration<?> e = request.getParameterNames();
		String json = "";
		if (e.hasMoreElements()) {			
			json = e.nextElement().toString();
		}		
		if (log.isDebugEnabled()) {
			log.debug(json);
		}
		Gson g = new GsonBuilder().setDateFormat(DEFAULT_DATE_PATTERN).create();
		Object controller = g.fromJson(json, obj.getClass());
		Field f[] = obj.getClass().getDeclaredFields();
		for (int i = 0; i < f.length; i++) {			
			if (f[i].getDeclaredAnnotations().length == 0) {
				f[i].setAccessible(true);
				f[i].set(obj, f[i].get(controller));
			}
		}
	}
	
	public static ModelAndView pageListToJson(HttpServletResponse response, List<?> list,
			long totalRows) throws Exception {
		Gson g = new GsonBuilder().create();		
		String json = g.toJson(list);
		PrintWriter pw = null;
		try {
			response.setContentType("text/json;charset=utf-8");
			pw = response.getWriter();			
			String s = "{\"result\":\"1\",\"totalRows\":" + totalRows + ",\"list\":" + json + "}";
			if (log.isDebugEnabled()) {
				log.debug(s);
			}
			pw.write(s);
		} catch (Exception e) {
			throw e;
		} finally {
			if (pw != null) {
				pw.close();
			}
		}	
		return null;
	}
	
	public static void pageListToJson(HttpServletResponse response, List<?> list,
			long totalRows, String datePattern, String doublePattern) throws Exception {
		if (datePattern == null) {
			datePattern = DEFAULT_DATE_PATTERN;
		}
		if (doublePattern == null) {
			doublePattern = DEFAULT_DOUBLE_PATTERN;
		}
		Gson g = new GsonBuilder().setDateFormat(datePattern)
			.registerTypeAdapter(Double.class, new JsonDoubleSerializer(doublePattern))
			.create();
		String json = g.toJson(list);
		PrintWriter pw = null;
		try {
			response.setContentType("text/json;charset=utf-8");
			pw = response.getWriter();			
			String s = "{\"result\":\"1\",\"totalRows\":" + totalRows + ",\"list\":" + json + "}";
			if (log.isDebugEnabled()) {
				log.debug(s);
			}
			pw.write(s);
		} catch (Exception e) {
			throw e;
		} finally {
			if (pw != null) {
				pw.close();
			}
		}
	}
	
	public static void toJson(HttpServletResponse response, String sign) throws Exception {		
		PrintWriter pw = null;
		try {
			response.setContentType("text/json;charset=utf-8");
			pw = response.getWriter();			
			String s = "{\"result\":\"" + sign + "\"}";
			if (log.isDebugEnabled()) {
				log.debug(s);
			}
			pw.write(s);
		} catch (Exception e) {
			throw e;
		} finally {
			if (pw != null) {
				pw.close();
			}
		}
	}
	
	public static void beantoJson(HttpServletResponse response, Object entry) throws Exception {
		Gson g = new GsonBuilder().create();
		String json = g.toJson(entry);
		PrintWriter pw = null;
		try {
			response.setContentType("text/json;charset=utf-8");
			pw = response.getWriter();
			String s = "{\"result\":\"1\",\"entry\":" + json + "}";
			if (log.isDebugEnabled()) {
				log.debug(s);
			}
			pw.write(s);
		} catch (Exception e) {
			throw e;
		} finally {
			if (pw != null) {
				pw.close();
			}
		}
	}
	
	public static void writeJson(HttpServletResponse response, String json) throws Exception {		
		PrintWriter pw = null;
		try {
			response.setContentType("text/json;charset=utf-8");
			pw = response.getWriter();
			if (log.isDebugEnabled()) {
				log.debug(json);
			}
			pw.write(json);
		} catch (Exception e) {
			throw e;
		} finally {
			if (pw != null) {
				pw.close();
			}
		}
	}
	   
}
