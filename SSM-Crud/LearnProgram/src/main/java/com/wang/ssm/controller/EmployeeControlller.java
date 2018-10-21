package com.wang.ssm.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wang.ssm.bean.Employee;
import com.wang.ssm.bean.Msg;
import com.wang.ssm.servicce.EmployeeService;
@Controller
public class EmployeeControlller {

	@Autowired
	EmployeeService employeeService;
    /*
     * 使用@ResponseBody需要jacksonjar包
     */
	@RequestMapping("/emps")
	@ResponseBody 
	//1.查询所有员工数据
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) {
		//1.使用PageHelper分页插件,在查询之前只需传入页码及每页显示的数据记录参数即可！
		PageHelper.startPage(pn, 5);
		//2.startPage后紧跟的就是一个分页查询
		List<Employee> emps=employeeService.getAll();
		//3.使用PageInfo封装查询结果，只需将PageInfo交给页面即可
		//4.PageInfo封装分页的详细信息
		//5. PageInfo构造器的5表示连续显示的页码数字
		PageInfo<Employee> page=new PageInfo<Employee>(emps,5);
		//6.处理结果以Json数据格式返回给浏览器
		return Msg.success().add("pageInfo",page);
		
	}
	//2.保存新增的员工数据
//	@RequestMapping(value="/emp",method=RequestMethod.POST)
//	@ResponseBody
//	public Msg saveEmp(Employee employee) {
//		employeeService.saveEmp(employee);
//		return Msg.success();
//	}
	    //2.1.JSR303校验表单数据,后保存数据
		@RequestMapping(value="/emp",method=RequestMethod.POST)
		@ResponseBody
		public Msg saveEmps(@Validated Employee employee,BindingResult result){
			//从前端传来的参数springmvc会自动封装
			//System.out.println(employee);
			if(result.hasErrors()){
				Map<String, String>map=new HashMap<>();
				List<FieldError> list=result.getFieldErrors();
				for (FieldError fieldError : list) {
					map.put(fieldError.getField(), fieldError.getDefaultMessage());
				}
				return Msg.fail().add("errorFields", map);
			}else{
				employeeService.saveEmp(employee);
				return Msg.success();
			}
		}
	
	//3.后台校验
	@RequestMapping(value="/checkUser")
	@ResponseBody
	public Msg checkUser(@RequestParam("empName")String empName){
		//重复校验一遍姓名
		String regx="^[a-zA-Z0-9_-]{6,16}$|(^[\u2E80-\u9FFF]{2,5}$)";
		if(!empName.matches(regx)){
			return Msg.fail().add("error", "用户名格式不正确！");
		}
		//true：表示可以  false：表示不可以
		boolean flag=employeeService.checkUser(empName);
		if(flag){
			return Msg.success();
		}else{
			return Msg.fail().add("error", "用户名重复，请输入新的用户名！");
		}
	}
	
	//4.查询员工数据
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		Employee employee=employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	//5.修改员工数据
	@ResponseBody
	//empId是Employee的属性，否则无法绑定数据
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg updateEmp(Employee employee){
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
    //6.删除某一个员工
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmp(@PathVariable("ids")String ids){
		//URL:http://localhost:8083/ssm-crud/emp/201236-201237-201238-201239-201240
		//如果URL中包含"-"就执行批量删除
		if(ids.contains("-")){
			List<Integer> list=new ArrayList<>();
			String[]strs=ids.split("-");
			for (String id : strs) {
				list.add(Integer.parseInt(id));
			}
			employeeService.bathDeleteEmps(list);
		}else{
			employeeService.deleteEmp(Integer.parseInt(ids));
		}
		return Msg.success();
	}
	
}










































