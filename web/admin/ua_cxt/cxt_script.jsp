<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="
	java.io.*,
	java.util.*,
	java.net.*,
	java.util.*,
	org.iottree.*,
	org.iottree.core.*,
	org.iottree.core.util.*,
	org.iottree.core.util.xmldata.*
	"%>
<%@ taglib uri="wb_tag" prefix="wbt"%>	
<%
//String prjid = 
String path = request.getParameter("path") ;

if(path==null)
	path = "" ;
UANode n = null;//
String path_title = "" ;
if(Convert.isNotNullEmpty(path))
{
	n = UAUtil.findNodeByPath(path) ;
	if(n==null)
	{
		out.print("no node found") ;
		return ;
	}

	if(!(n instanceof UANodeOCTags))
	{
		out.print("not node oc tags") ;
		return ;
	}
	//path_title = n.getNodePathTitle()+" "+n.getNodePath() ;
	path_title = n.getNodePath() ;
}

String taskid = request.getParameter("taskid") ;
if(taskid==null)
	taskid="" ;
String opener_txt_id = request.getParameter("opener_txt_id") ;
if(opener_txt_id==null)
	opener_txt_id = "" ;

String sample_txt_id = request.getParameter("sample_txt_id") ;
if(sample_txt_id==null)
	sample_txt_id = "" ;
String func_params  = request.getParameter("func_params") ;
//UANode n = rep.findNodeById(id) ;


//UANode topn = n.getTopNode() ;
//UAPrj prj = null ;
//if(topn instanceof UAPrj)
//{
//	prj = (UAPrj)topn ;
//}

//UANodeOCTags ntags = (UANodeOCTags)n ;
//List<UATag> tags = ntags.listTagsAll() ;

boolean bdlg = "true".equalsIgnoreCase(request.getParameter("dlg"));
%>
<html>
<head>
<title>context script</title>
<style>
		table{border-collapse:collapse;}
		body,td{font-size:12px;cursor:default;}
</style>
<jsp:include page="../head.jsp">
	<jsp:param value="true" name="simple"/>
	<jsp:param value="true" name="tree"/>
</jsp:include>
<script>
	dlg.resize_to(900,600) ;
</script>
</head>
<body marginwidth="0" marginheight="0" margin="0">
<b>Context @ <%=path_title %></b>
<%
if(Convert.isNotNullEmpty(path))
{
%>
<input type='button' value='Test Run' onclick="run_script_test('')" class="layui-btn layui-btn-sm layui-border-blue" />
<%
}
%>
<table border='1' style="height:90%;width:100%">
 <tr>
  <td style="width:30%;vertical-align: top;" >
   <div style="top:0px;height:60%;width:100%;overflow: auto;">
  	<div id="tree" class="tree" style="height:100%;overflow: auto;"></div>
   </div>
   <div id="node_detail" style="top:60%;height:40%;width:100%;overflow: auto;border:1px solid;">
   Node Detail
   </div>
  </td>
  <td>
	  <table style="width:100%;height:100%">
	 <tr height="75%">
	  <td colspan="2">&nbsp;&nbsp;
	<%
	String cheight = "100%" ;
	if(Convert.isNotNullEmpty(func_params))
	{
		cheight="200px" ;
	%>
	(<%=func_params %>)=&gt;{
	<%
	}
	
	if(Convert.isNotNullEmpty(sample_txt_id))
	{
	%>
	<button onclick="insert_sample()">insert sample</button>
	<%
	}
	%>
	   <textarea id='script_test' rows="6" style="overflow: scroll;width:100%;height:<%=cheight%>" placeholder="Input JS Script Here"></textarea>
	&nbsp;&nbsp;<%=(Convert.isNotNullEmpty(func_params)?"}":"")%>
	  </td>
	 </tr>
	  <tr height="20%">
	
	  <td  colspan="2">
	  script test result
	   <textarea id='script_res' rows="6" style="overflow: scroll;width:100%;height:100%"></textarea>
	  </td>
	 </tr>
	</table>
  </td>
 </tr>
</table>

<div id='opc_info'>
</div>
</body>
<script>
var path="<%=path%>" ;
var opener_txt_id = "<%=opener_txt_id%>" ;
var sample_txt_id = "<%=sample_txt_id%>" ;
var taskid="<%=taskid%>";

function log(s)
{
	document.getElementById('log_inf').innerHTML = s ;
}

function tree_init()
{
	$.jstree.destroy();
	this.jsTree = $('#tree').jstree(
				{
					'core' : {
						'data' : {
							'url' :"cxt_script_help_ajax.jsp?op=sub_json&path="+path,
							"dataType" : "json",
							"data":function(node){
		                        return {"id" : node.id};
		                    }
						},
						
						'themes' : {
							//'responsive' : false,
							'variant' : 'small',
							'stripes' : true
						}
					},
					'contextmenu' : { //
						
						'items' :(node)=>{
							//this.get_type(node)==='ch''
							//console.log(node)
							var tp = node.original.type
							//console.log(tp) ;
							return this.get_cxt_menu(tp,node.original) ;
		                }
					},
					'types' : {
						'default' : { 'icon' : 'folder' },
						'file' : { 'valid_children' : [], 'icon' : 'file' }
					},
					'unique' : {
						'duplicate' : function (name, counter) {
							return name + ' ' + counter;
						}
					},
					'plugins' : ['state','dnd','types','contextmenu','unique']
				}
		);
	
	
		this.jsTree.on('activate_node.jstree',(e,data)=>{
			on_tree_node_sel(data.node.original)
		})
		
}

function on_tree_node_sel(n)
{
	//console.log("select",n) ;
	var id = n.id;
	send_ajax("cxt_script_help_ajax.jsp",{op:"sub_detail",path:path,id:id},(bsucc,ret)=>{
		$("#node_detail").html(ret) ;
	}) ;
}



function init()
{
	if(opener_txt_id!='')
	{
		var ow = dlg.get_opener_w();
		var txtob = ow.document.getElementById(opener_txt_id) ;
		if(txtob!=null)
		{
			$("#script_test").val(txtob.value) ;
		}
	}
	
	tree_init();
}

function insert_sample()
{
	if(sample_txt_id=='')
		return ;
	
	var ow = dlg.get_opener_w();
	var txtob = ow.document.getElementById(sample_txt_id) ;
	if(txtob!=null)
	{
		var oldv = $("#script_test").val() ;
		$("#script_test").val(oldv+"\r\n"+txtob.value) ;
	}
	
}

init() ;

function run_script_test(fn)
{
	var scode = document.getElementById('script_test').value ;
	if(scode==null||scode==''||trim(scode)=='')
		return ;
	var pm = {path:path,txt:scode} ;
	if(taskid!='')
	{
		pm.taskid = taskid;
		pm.op='task';
	}
	send_ajax('cxt_script_test.jsp',pm,function(bsucc,ret)
		{
			document.getElementById('script_res').value = ret ;
		},false) ;
}

function get_edited_js()
{
	return $("#script_test").val() ;
}
</script>
</html>