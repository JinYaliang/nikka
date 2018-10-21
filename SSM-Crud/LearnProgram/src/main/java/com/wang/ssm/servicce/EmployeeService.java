package com.wang.ssm.servicce;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wang.ssm.bean.Employee;
import com.wang.ssm.bean.EmployeeExample;
import com.wang.ssm.bean.EmployeeExample.Criteria;
import com.wang.ssm.dao.EmployeeMapper;
@Service
public class EmployeeService {
	@Autowired
    EmployeeMapper  employeeMapper;
	//1.查询所有员工信息
	public List<Employee> getAll() {
		EmployeeExample ee=new EmployeeExample();
		ee.setOrderByClause("emp_id");
		return employeeMapper.selectByExampleWithDept(ee);
	}
	//2.向数据库中插入数据
	public void saveEmp(Employee employee){
		employeeMapper.insertSelective(employee);
	}
	
	//3.通过id获取员工数据
	public Employee getEmp(Integer id) {
		return employeeMapper.selectByPrimaryKey(id);
	}
	//4.校验
	public boolean checkUser(String empName) {
		EmployeeExample example=new EmployeeExample();
		Criteria cri=example.createCriteria();
		cri.andEmpNameEqualTo(empName);
		//查询是否有此对象
		int count=(int) employeeMapper.countByExample(example);
		//哈哈，绝了
		return count==0;
	}
	//5.修改数据
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	
	//6.删除某一个员工
	public void deleteEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}
	//7.批量删除操作
	 public void bathDeleteEmps(List<Integer> list) {
		EmployeeExample example=new EmployeeExample();
		Criteria criteria=example.createCriteria();
		criteria.andEmpIdIn(list);
		employeeMapper.deleteByExample(example);
	}
	

}
