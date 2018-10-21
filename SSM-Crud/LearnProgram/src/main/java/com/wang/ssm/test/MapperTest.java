package com.wang.ssm.test;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.wang.ssm.bean.Department;
import com.wang.ssm.bean.DepartmentExample;
import com.wang.ssm.dao.DepartmentMapper;
import com.wang.ssm.dao.EmployeeMapper;
/*
 * Spring框架自带测试功能的使用
 * 1.将搭建好的SSM项目进行单元测试：比如增删查改
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring-bean.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void test() {
//		System.out.println(departmentMapper);
//		1、插入部门
//		departmentMapper.insertSelective(new Department(null,"开发部"));
//		departmentMapper.insertSelective(new Department(null,"测试部"));
//		2、插入员工数据
//		employeeMapper.insertSelective(new Employee(null, "gl", "M", "stream_gao@qq.com", 1));
//		employeeMapper.insertSelective(new Employee(null,"zhangsan","F","123@126.com",2));
//		3、批量插入员工数据
//		EmployeeMapper em=sqlSession.getMapper(EmployeeMapper.class);
//		for(int i=0;i<1000;i++){
//			String uid=UUID.randomUUID().toString().substring(0,5)+i;
//			em.insertSelective(new Employee(null, uid, "M", uid+"@126.com", 1));
//		}
//		4、查询dept
		System.out.println(departmentMapper.selectByPrimaryKey(1));
		DepartmentExample de=new DepartmentExample();
		List<Department> list=departmentMapper.selectByExample(de);
		for(Department d:list) {
			System.out.println(d.toString());
		}
	}

}

