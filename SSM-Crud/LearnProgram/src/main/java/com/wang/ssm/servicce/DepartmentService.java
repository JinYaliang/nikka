package com.wang.ssm.servicce;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.wang.ssm.bean.Department;
import com.wang.ssm.dao.DepartmentMapper;

@Service
public class DepartmentService {
	@Autowired
	private DepartmentMapper departmentMapper;
	public List<Department> getAll(){
		return departmentMapper.selectByExample(null);
	}
}

