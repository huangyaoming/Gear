package com.gear.base.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gear.base.dao.UserDao;

@Service
public class UserService {

	@Autowired
	private UserDao dao;
	
	@Transactional
	public int addUser(Map<String, Object> map) {
		int result = dao.insertUser(map);
		if (result == 1) {
			int count = dao.getUserCount(map);
			if (count > 1) {
				throw new DataIntegrityViolationException("用户名已存在！");
			}
		}
		return result;
	}
}
/**
CleanupFailureDataAccessException:	
一项操作成功地执行，但在释放数据库资源时发生异常（例如，关闭一个Connection） 

DataAccessResourceFailureException:	
数据访问资源彻底失败，例如不能连接数据库 

DataIntegrityViolationException:	
Insert或Update数据时违反了完整性，例如违反了惟一性限制 

DataRetrievalFailureException:	
某些数据不能被检测到，例如不能通过关键字找到一条记录 

DeadlockLoserDataAccessException:	
当前的操作因为死锁而失败 

IncorrectUpdateSemanticsDataAccessException:	
Update时发生某些没有预料到的情况，例如更改超过预期的记录数。当这个异常被抛出时，执行着的事务不会被回滚 

InvalidDataAccessApiusageException:	
一个数据访问的JAVA API没有正确使用，例如必须在执行前编译好的查询编译失败了 

invalidDataAccessResourceUsageException:	
错误使用数据访问资源，例如用错误的SQL语法访问关系型数据库 

OptimisticLockingFailureException:	
乐观锁的失败。这将由ORM工具或用户的DAO实现抛出 

TypemismatchDataAccessException:	
Java类型和数据类型不匹配，例如试图把String类型插入到数据库的数值型字段中 

UncategorizedDataAccessException:	
有错误发生，但无法归类到某一更为具体的异常中 
*/
