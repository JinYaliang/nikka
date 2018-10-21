<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<!-- 
	web资源的路径问题，不是以/开始的都是相对路径，/代表站点根目录
 -->
<%
	pageContext.setAttribute("path", request.getContextPath());
%>
<link rel="stylesheet"
	href="${path}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script type="text/javascript"
	src="${path }/static/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="${path }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>
<!-- --------------------------------添加员工的模态框------------------------------>
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增员工信息</h4>
				</div>
				<!--新增表单-->
				<div class="modal-body">
					<form class="form-horizontal" id="emp_form">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="empName_input" placeholder="xxx" /> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender_m" value="M" checked> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender_f" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_input" placeholder="xxx@qq.com" />
								<!-- 示例 -->
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">部门</label>
							<div class="col-sm-5">
								<select class="form-control" name="dId" id="deptName_input">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="save_emp_btn">提交</button>
				</div>
			</div>
		</div>
	</div>
<!------------------------------修改员工的模态框---------------------------------------->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="emp_update_form">
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">姓名</label>
						 <!--  <div class="col-sm-10">
								<input type="text"  id="empName_update_input" name="empName" class="form-control"
									id="empName_input" placeholder="xxx" /> <span
									class="help-block"></span>
							</div>   -->
							  
							 <div class="col-sm-10">
							      
								 <p class="form-control-static" id="empName_update_input"></p>
							</div>  
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="genderm_update_input" value="M"  checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="genderf_update_input" value="F" > 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control"
									id="email_update_input" placeholder="xxx@qq.com" />
								<!-- 示例 -->
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">所属部门</label>
							<div class="col-sm-5">
								<select class="form-control" name="dId" id="deptName_update_input">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="update_emp_btn">修改</button>
				</div>
			</div>
		</div>
	</div>
<!-- ------------------------------------------------------------------------------------------ -->	
	<div class="container">
		<!-- 第一行显示标题-->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM演示</h1>
			</div>
		</div>
		<!--第二行显示按钮  -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8.5">
				<button class="btn btn-primary" id="emp_add_btn">添加</button>
				<button class="btn btn-danger" id="emp_del_btn">删除</button> 
			</div>
		</div>
		<!-- 第三行显示表格数据 -->
		<div class="row">
			<div class="col-md-10">
				<table class="table table-hover " border="2" id="emps_table">
					<!-- <thead>必须有-->
					<thead>
						<tr>
						    <th><input type="checkbox" id="check_all"/></th> 
							<th>编号</th>
							<th>姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>所属部门</th>
							<th>操作</th>
						</tr>
					</thead>
					<!--<tbody>必须有 -->
					<tbody>

					</tbody>
				</table>
			</div>
		</div>
		<!--第四行显示分页条  -->
		<div class="row">
			<!-- 只需定义一个div元素 -->
			<div class="col-md-6" id="page_info_area"></div>
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
//----------------------------------1.实现分页功能----------------------------------//	
        var totalRecord,currentPageNum;	
        //1.页面加载完成以后，直接发送ajax请求，获取分页数据
		$(function() {
			toPage(1);
		});
		//跳转页码
		function toPage(pn) {
			$.ajax({
				url : "${path}/emps",
				data : "pn="+pn,
				type : "GET",
				success : function(result) {//回调函数
					//console.log(result);
					//1.解析并显示员工数据
					build_emps_table(result);
					//2.解析并显示分页数据
					build_page_info(result);
					//3.解析显示分页条数据
					build_page_nav(result)
				}
			});
		}
		//2.解析Json并显示员工数据
		function build_emps_table(result) {
			//清空table表格
			$("#emps_table tbody").empty();
			//解析Json获取员工列表
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				//alert(item.empName) 
				//把员工数据添加到单元格中
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(
						item.gender == 'M' ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>")
						.append(item.department.deptName);

				//editbtn和delbtn表示按钮元素及其类容
				var editbtn = $("<button></button>")
				                .addClass("btn btn-primary btn-sm editbtn")
				                .append($("<span></span>")
								.addClass("glyphicon glyphicon-pencil"))
								.append("编辑")
						        .attr("editid", item.empId);

				var delbtn = $("<button></button>")
				                .addClass("btn btn-danger btn-sm delbtn")
				                .append($("<span></span>")
								.addClass("glyphicon glyphicon-trash"))
								.append("删除")
								.attr("delid", item.empId);//自定义属性和获取id值

				var operate = $("<td></td>").append(editbtn).append("  ")
						.append(delbtn);
				//把解析的Json数据放到表格中
				//append方法执行完以后继续返回原来的元素
				//把每个单元格中的数据添加为一行数据，并把它添加到table中
				$("<tr></tr>").append(checkBoxTd)
				              .append(empIdTd)
				              .append(empNameTd)
				              .append(genderTd)
				              .append(emailTd)
				              .append(deptNameTd)
				              .append(operate)
				              .appendTo("#emps_table tbody");
			});
		}
		//3.解析显示分页信息
		function build_page_info(result) {
			$("#page_info_area").empty();
			//定位到page_info_area元素并把数据添加到此处
			$("#page_info_area").append(
					"当前第" + result.extend.pageInfo.pageNum + "页，总"
							+ result.extend.pageInfo.pages + "页，总"
							+ result.extend.pageInfo.total + "条记录");
                 totalRecord=result.extend.pageInfo.total;
                 currentPageNum=result.extend.pageInfo.pageNum;
		}
		//4.解析显示分页导航数据
		function build_page_nav(result) {
			$("#page_nav_area").empty();
			//创建ul class="pagination"元素
			var ul = $("<ul></ul>").addClass("pagination");
			//创建首页，前页，下一页，末页元素
			var firstPage = $("<li></li>").append($("<a></a>").append("首页"));
			var prePage = $("<li></li>").append($("<a></a>").append("&laquo;"));
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPage.addClass("disabled");
				prePage.addClass("disabled");
			} else {
				firstPage.click(function() {
					toPage(1);
				});
				prePage.click(function() {
					toPage(result.extend.pageInfo.pageNum - 1);
				});
			}

			var nextPage = $("<li></li>")
					.append($("<a></a>").append("&raquo;"));
			var lastPage = $("<li></li>").append($("<a></a>").append("末页"));
			if (result.extend.pageInfo.hasNextPage == false) {
				//不能点击
				lastPage.addClass("disabled");
				nextPage.addClass("disabled");
			} else {
				lastPage.click(function() {
					toPage(result.extend.pageInfo.pages);
				});
				nextPage.click(function() {
					toPage(result.extend.pageInfo.pageNum + 1);
				});
			}
			//将首页，前页li元素添加到ul元素中
			ul.append(firstPage).append(prePage);
			//获取要显示的所有页码参数
			var nums = result.extend.pageInfo.navigatepageNums;
			$.each(nums, function(index, item) {
				var num = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageInfo.pageNum == item)
					//添加活动标识
					num.addClass("active");
				num.click(function() {
					toPage(item);
				});
				ul.append(num);
			});
			//添加下一页和末页提示
			ul.append(nextPage).append(lastPage);
			$("<nav></nav>").append(ul).appendTo("#page_nav_area");
		}
//--------------------------------2.实现添加员工数据功能----------------------------------//	
		//重置表单数据
		function resetForm(ele) {
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		//向服务器发送请求获取部门数据
		function getDepts(ele) {
			$(ele).empty();
			$.ajax({
				url : "${path}/depts",
				data : "",
				type : "POST",
				success : function(result) {//result代表Json数据
					//构建下拉列表
					$.each(result.extend.depts, function() {//this表示当前遍历对象
						$("<option></option>").append(this.deptName).attr("value", this.deptId)
						.appendTo(ele);

					});
				}
			});
		}
		//校验表单输入的用户名是否重复，当输入数据时立刻发送ajax请求
		$("#empName_input").change(
				function() {
					//获取当前输入框的值
					var empName = this.value;
					$.ajax({
						url : "${path}/checkUser",
						data : "empName=" + empName,
						type : "POST",
						success : function(result) {
							//响应码100为可用
							if (result.code == 100) {
								showValidateMsg("#empName_input", "success","用户名可以使用");
								$("#save_emp_btn").attr("save", "success");
							} else if (result.code == 200) {
								showValidateMsg("#empName_input", "error",
										result.extend.error);
								$("#save_emp_btn").attr("save", "error");
							}
						}
					})
				});
		//添加用户
		$("#emp_add_btn").click(function() {
			//弹出模态框前查出部门信息显示在下拉列表
			 getDepts("#deptName_input");
			//清空表单数据
			resetForm("#emp_form");
		    //返回添加模态框
			$('#empAddModal').modal({
				backdrop : "static"
			});
		});
		//显示校验信息
		function showValidateMsg(ele, status, msg) {
			$(ele).parent().removeClass("has-error has-success");
			$(ele).next("span").text("");
			if (status == "error") {
				$(ele).parent().addClass("has-error has-feedback"); 
				$(ele).next("span").text(msg);
			} else {
				$(ele).parent().addClass("has-success has-feedback"); 
				$(ele).next("span").text(msg);
			}
		}
		//校验表单提交数据
		function validateEmpForm() {
			var flag = true;
			//1.获取员工名字并进行校验
			var empName = $("#empName_input").val();
			var regName = /^[a-zA-Z0-9_-]{6,16}$|(^[\u2E80-\u9FFF]{2,5}$)/;
			if (!regName.test(empName)) {
				showValidateMsg("#empName_input", "error", "用户名格式不正确");
				flag = false;
			} else {
				//showValidateMsg("#empName_input", "success", "用户名格格式正确");
			}
			//2.获取email并进行校验
			var email = $("#email_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				showValidateMsg("#email_input", "error", "Email格式不正确");
				flag = false;
			} else {
				//showValidateMsg("#email_input", "success", "格式正确");
			}
			return flag;
		}
		//点击保存按钮
		$("#save_emp_btn").click(function(){
			//1.模态框中填写的表单数据提交给服务器保存
			//2.校验提交表单数据
			//3.发送ajax请求保存表单数据
			if (!validateEmpForm())
				return false;
			//判断之前ajax判断是否成功！，如果失败无法向数据库插入数据
			if ($(this).attr("save") == "error")
				return false;
			$.ajax({
				url:"${path}/emp",
				type:"POST",
				data: $("#emp_form").serialize(),
				success:function(result){
					//alert(result.msg);
					//1.员工保存成功：首先关闭模态框，其次来到最后一页显示刚保存的数据
					$('#empAddModal').modal("hide");
					//保存数据后来到最后一页
					toPage(totalRecord);
				}
			}); 
		});
//-----------------------3.实现修改员工数据功能----------------------------------//	
        //绑定编辑按钮（editbtn表示按钮的标识，而不是按钮元素）
        $(document).on("click",".editbtn",function(){
        	//1.获取部门数据，填写到id="deptName_update_input"的下拉框
        	getDepts("#deptName_update_input");
        	//2.重置表单
			resetForm("#emp_update_form");
        	//获取员工id属性
			getEmp($(this).attr("editid"));
        	//将editid添加到下面元素中
			$("#update_emp_btn").attr("editid",$(this).attr("editid"));
        	//3.弹出模态框
        	$('#empUpdateModal').modal({
				backdrop : "static"
			});
        });
		//ajax向服务器发送请求 
        function getEmp(id){
			$.ajax({
				url:"${path}/emp/"+id,
				type:"GET",
				success:function(result){
					var emp=result.extend.emp;
					//alert(emp.gender) 
					$("#empName_update_input").text(emp.empName);
					$("#email_update_input").attr("value",emp.email);
					//将查询出来的数据填充在id选择器中，实现redio被选中
					$("#emp_update_form input[name=gender]").val([emp.gender]);
					$("#emp_update_form select").val([emp.dId]);
				}
			})
		}
		
      //绑定更新按钮，也需要校验
		$("#update_emp_btn").click(function(){
			
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				showValidateMsg("#email_update_input", "error", "Email格式不正确");
				return false;
			} else {
				showValidateMsg("#email_update_input", "success", "格式正确");
			}
			
			$.ajax({
				url:"${path}/emp/"+$(this).attr("editid"),
				data:$("#emp_update_form").serialize(),//+"&_method=PUT",
				type:"PUT",
				success:function(result){
					 
					$("#empUpdateModal").modal("hide");
					toPage(currentPageNum);
				}
			})
		});
//-----------------------4.实现删除某一条员工记录----------------------------------//	
        //绑定删除按钮
		$(document).on("click",".delbtn",function(){
			//获取员工姓名
			//var empName=$(this).parents().find("tr td:eq(1)").text();
			var empId=$(this).attr("delid");
			if(confirm("确认要删除吗？")){
				$.ajax({
					url:"${path}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						alert("删除成功！");
						toPage(currentPageNum);
					}
				})
			}
		});
		
		//全选按钮
		$("#check_all").click(function(){
			//attr()获取checked市undefined,全部选中显示true
			//alert($(this).prop("checked"));
			
			//1.prop修改和读取dom原生属性值
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		//绑定事件
		$(document).on("click",".check_item",function(){
			//判断选中的和所有要选的个数相等，显示全部被选中
			var flag=$(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		
		//批量删除操作
		$("#emp_del_btn").click(function(){
			alert("确定要删除吗？");
			var ids="";
			$.each($(".check_item:checked"),function(){
				ids+=$(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			//http://localhost:8083/ssm-crud/emp/201236-201237-201238-201239-201240
			ids=ids.substring(0,ids.length-1);
			$.ajax({
				url:"${path}/emp/"+ids,
				type:"DELETE",
				success:function(result){
					if(result.code==100){
						alert("删除成功！");
						toPage(currentPageNum);
					} 
				}
			});
		});
	</script>
</body>
</html>















