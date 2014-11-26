package com.gear.utils;

import java.lang.reflect.Type;
import java.text.DecimalFormat;

import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;

/**
 * Gson转换时,Double转式化
 *
 */
public class JsonDoubleSerializer implements JsonSerializer<Double> {
	
	private String doublePattern;
	
	public JsonDoubleSerializer(String doublePattern) {
		this.doublePattern = doublePattern;
	}
		
	public JsonElement serialize(Double arg0, Type arg1,
			JsonSerializationContext arg2) {
		return new JsonPrimitive(new DecimalFormat(doublePattern).format(arg0));
	}
}
