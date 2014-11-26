package com.gear.base.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao extends JdbcDaoSupport {

	@Autowired
    public void setB2bJdbcTemplate(JdbcTemplate b2bJdbcTemplate) {
        setJdbcTemplate(b2bJdbcTemplate);
    }
	
	public int insertUser(Map<String, Object> map) {
		List<Object> args = new ArrayList<Object>();
		String sql = "";
		if (map.get("userid") != null) {
			sql = "insert into user(userid, name, sex) values(?, ?, ?)";
			args.add(map.get("userid"));
		} else {
			sql = "insert into user(name, sex) values(?, ?)";
		}
		args.add(map.get("name"));
		args.add(map.get("sex"));
		System.out.println("sql:" + sql + "\nParam:" + args.toString());
		return getJdbcTemplate().update(sql, args.toArray());
	}
	
	public int getUserCount(Map<String, Object> map) {
		List<Object> args = new ArrayList<Object>();
		String sql = "select count(1) cou from user where name = ?";
		args.add(map.get("name"));
		System.out.println("sql:" + sql + "\nParam:" + args.toString());
		return getJdbcTemplate().queryForInt(sql, args.toArray());
	}
}
