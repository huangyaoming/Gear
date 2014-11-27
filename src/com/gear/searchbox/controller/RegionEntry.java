package com.gear.searchbox.controller;

import java.util.List;

public class RegionEntry {
	
	private String regionCode;
	private String regionName;
	private List<RegionEntry> subRegion;
	
	private String spell;
	public String getSpell() {
		return spell;
	}

	public void setSpell(String spell) {
		this.spell = spell;
	}

	public String getPinyin() {
		return pinyin;
	}

	public void setPinyin(String pinyin) {
		this.pinyin = pinyin;
	}
	private String pinyin;
	
	public RegionEntry(String code, String name) {
		this.regionCode = code;
		this.regionName = name;
	}
	
	public String getRegionCode() {
		return regionCode;
	}
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}
	public String getRegionName() {
		return regionName;
	}
	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}
	public List<RegionEntry> getSubRegion() {
		return subRegion;
	}
	public void setSubRegion(List<RegionEntry> subRegion) {
		this.subRegion = subRegion;
	}
}
