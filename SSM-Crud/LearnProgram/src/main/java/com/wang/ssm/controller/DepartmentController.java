package com.wang.ssm.controller;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.wang.ssm.bean.Department;
import com.wang.ssm.bean.Msg;
import com.wang.ssm.servicce.DepartmentService;
@Controller
public class DepartmentController {
	@Autowired
	private DepartmentService departmentService; 
	@RequestMapping("/depts")
	@ResponseBody
	//获取部门数据
	public Msg getDeptsWithJson(){
		List<Department> list=departmentService.getAll();
		//System.out.println(list.size());
		return Msg.success().add("depts", list);
	}
	 
}
