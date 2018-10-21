package com.wang.ssm.test;
import java.util.List;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import com.github.pagehelper.PageInfo;
import com.wang.ssm.bean.Employee;

/*
 * spring4的测试需要servlet-api 3.0以上版本
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
//引入spring-bean.xml，springmvc.xml文件
@ContextConfiguration(locations={"classpath:spring-bean.xml","classpath:springmvc.xml"})
public class SpringMVCTest {
	@Autowired
	WebApplicationContext context;
	MockMvc mvc; //虚拟springmvc
	
	@Before
	public void initMockMvc(){
		//首先初始化
		mvc=MockMvcBuilders.webAppContextSetup(context).build();
	}
	@Test
	public void page() throws Exception{
		//1.MockMvcRequestBuilders模拟浏览器向服务器发送请求
		MvcResult result=mvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
		
		//2.服务器端返回给浏览器的数据
		MockHttpServletRequest request=result.getRequest();
		@SuppressWarnings("unchecked")
		//3.获取pageInfo封装的数据
		PageInfo<Employee> info=(PageInfo<Employee>) request.getAttribute("pageInfo");
		
		//4.info调用以下数据可以获取分页信息
		System.out.println("当前页码="+info.getPageNum());
		System.out.println("总页码="+info.getPages());
		System.out.println("每页的个数="+info.getSize());
		System.out.println("总记录数="+info.getTotal());
		System.out.println("连续显示的页码数字");
		int[]pages=info.getNavigatepageNums();
		for(int i:pages) {
			System.out.print(i+",");
		}
		System.out.println("显示当前页码所显示的员工数据：");
		List<Employee> list=info.getList();
		for(Employee e:list){
			System.out.println(e);
		}
	}
}
