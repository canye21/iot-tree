<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ page import="
	org.iottree.core.util.*,
	org.iottree.core.*,
	java.io.*,
	java.util.*,
	java.net.*,
	java.util.*,
	org.iottree.core.util.xmldata.*
"%><%@ taglib uri="wb_tag" prefix="wbt"%><%//UserProfile up = UserProfile.getUserProfile(request);
//String un = up.getUserInfo().getFullName();
List<UAPrj> reps = UAManager.getInstance().listPrjs();
%><!DOCTYPE html>
<html class="">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,minimum-scale=1,initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
    <title>IOT-Tree</title>
    <link href="/favicon.ico" rel="shortcut icon" type="image/x-icon">
<jsp:include page="head.jsp"/>
            <link href="./inc/common.css" rel="stylesheet" type="text/css">
        <link href="./inc/index.css" rel="stylesheet" type="text/css">
 <style>
 .btn_sh
 {
  //display:none;
  visibility: hidden;
 }
 
 .btn_sh_c:hover .btn_sh
 {
visibility: visible;
 }

 </style>
</head>
<body aria-hidden="false">
	<div class="iot-top-menu-wrap">
		<div class="container">
			<!-- start logo -->
			<div class="iot-logo">
				<a><img src="inc/logo1.png" width="40px" height="40px"/> IOT-Tree Server</a>
			</div>
			<!-- end logo -->
			<!-- start nav -->
			<div class="iot-top-nav navbar">
				<div class="navbar-header">
				  <button class="navbar-toggle pull-left">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				  </button>
				</div>
				<nav role="navigation" class="collapse navbar-collapse bs-navbar-collapse">
				  <ul class="nav navbar-nav">
					  <li><a href="https://github.com/bambooww/iot-tree.git"  target="_blank" class=""><i class="icon icon-home"></i> Home</a></li>
					  <li><a href=""><i class="icon icon-topic"></i> Helper</a></li>
				  </ul>
				</nav>
			</div>
			<!-- end nav-->
			
			<!-- search 
			<div class="iot-search-box  hidden-xs hidden-sm">
				<form class="navbar-search" id="global_search_form" method="post">
					<input class="form-control search-query" type="text" placeholder="" autocomplete="off" name="q" id="iot-search-query">
					
				</form>
			</div>
			end search -->
			<!-- user -->
			<div class="iot-user-nav">
					<div class="iot-top-user"><a class="login" href="javascript:logout()">logout</a></div>
			</div>
			<!-- end user -->
			
		</div>
	</div>
	

<div class="iot-container-wrap" style="height: auto !important;">
		<div class="container" style="height: auto !important;">
		<div class="row" style="height: auto !important;">
			<div class="iot-content-wrap clearfix" style="height: auto !important;">
				<div class="iot-main-content" style="height: auto !important; min-height: 0px !important;">
					<div class="iot-mod iot-question-detail iot-item">
						<div class="mod-head">
							<h1>Local Projects</h1>
							
							<div style="float:left;top:5px;position: absolute;left:160px" >
							<a class0="btn btn-success" style0="width:80px;height:40px;align-content: center;" href="javascript:add_prj()">
							
							<span class="fa-stack">
							  <i class="fa fa-square-o fa-stack-2x"></i>
							  <i class="fa fa fa-plus fa-stack-1x"></i>
							</span>&nbsp;Add
							</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<a class0="btn btn-success"  style0="width:100px;height:40px;" href="javascript:imp_prj()">
							<span class="fa-stack">
							  <i class="fa fa-square-o fa-stack-2x"></i>
							  <i class="fa fa-arrow-down fa-stack-1x"></i>
							</span>&nbsp;Import
							 <input type="file" id='add_file' onchange="add_file_onchg()" name="file" style="left:-9999px;position:absolute;" accept=".zip"/>
							</a>
&nbsp;&nbsp;&nbsp;&nbsp;
							<a class0="btn btn-success"  style0="width:100px;height:40px;" href="javascript:imp_prj_demo()">
							<span class="fa-stack">
							  <i class="fa fa-square-o fa-stack-2x"></i>
							  <i class="fa fa-arrow-down fa-stack-1x"></i>
							</span>&nbsp;Import Demo
							</a>
							
							<%--
							&nbsp;&nbsp;&nbsp;&nbsp;
							<a class0="btn btn-success"  style0="width:100px;height:40px;" href="javascript:exp_prj()">
							<span class="fa-stack">
							  <i class="fa fa-square-o fa-stack-2x"></i>
							  <i class="fa fa-arrow-up fa-stack-1x"></i>
							</span>&nbsp;Export
							</a>
							 --%>
							</div>
				           
						</div>
						<div class="mod-body">
							<div class="content markitup-box" style="height:100%">
<%
	for(UAPrj rep:reps)
{
%>
	<div class="aw-item btn_sh_c">
	   
       <a class="img aw-border-radius-5" >
         <i class="fa fa-sitemap fa-1x"></i>
       </a>
       <a class="text title" href="javascript:open_rep('<%=rep.getId()%>')" data-id="8"><%=rep.getTitle() %></a>
       <div class="inline-block pull-right text-left ">

          
          <span class="btn_sh">
<%
if(!rep.isMainPrj())
{
%>
          <span>
           <a class=" " href="javascript:set_prj_main('<%=rep.getId()%>')" title="set as main">
              <span class="fa-stack">
							  <i class="fa fa-square-o fa-stack-2x"></i>
							  &nbsp;&nbsp;M
							</span>
           </a>
           </span>
<%
}
if(rep.isAutoStart())
{
%><a class=" " href="javascript:set_prj_auto_start('<%=rep.getId()%>',false)" title="unset auto start">
<span class="fa-stack">
							  <i class="fa fa-square-o fa-stack-2x"></i>
							  &nbsp;&nbsp;A
							</span>
</a><%
}
else
{
%><a class=" " href="javascript:set_prj_auto_start('<%=rep.getId()%>',true)" title="set auto start">
<span class="fa-stack">
							  <i class="fa fa-square-o fa-stack-2x"></i>
							  &nbsp;&nbsp;A
							</span>
</a><%
}
%>
           <a class0="btn btn-success download-btn white" href="javascript:open_rep('<%=rep.getId()%>')" title="show detail">
              <span class="fa-stack">
							  <i class="fa fa-square-o fa-stack-2x"></i>
							  <i class="fa fa fa-pencil fa-stack-1x"></i>
							</span>
           </a>
           
           <a class0="btn btn-success"  href="javascript:exp_prj('<%=rep.getId()%>')" title="export">
              <span class="fa-stack">
							  <i class="fa fa-square-o fa-stack-2x"></i>
							  <i class="fa fa-arrow-up fa-stack-1x"></i>
							</span>
           </a>
           <a class0="btn btn-success " style="color: #e33a3e" href="javascript:del_rep('<%=rep.getId()%>')" title="delete">
              <span class="fa-stack">
							  <i class="fa fa-square-o fa-stack-2x"></i>
							  <i class="fa fa fa-times fa-stack-1x"></i>
							</span>
           </a>
           </span>
           
           <div style="width:150px;border:0px solid;float: right">&nbsp;
<%
if(rep.isMainPrj())
{
%>&nbsp;&nbsp;<span class="layui-badge layui-bg-blue">Main</span><%
}

if(rep.isAutoStart())
{
%>&nbsp;&nbsp;<span class="layui-badge layui-bg-blue">Auto Start</span><%
}
%>
         </div>
       </div>

       <div class="text-color-999">
           <span class="text-color-666">&nbsp;&nbsp;&nbsp;</span>
           • modified date:<span class="text-color-666"><%=Convert.toFullYMDHMS(new Date(rep.getSavedDT())) %></span>
       </div>
   </div>
<%
}
%>

							</div>
						</div>
						<%--
						<div class="mod-footer">
							<div class="meta">
																
								
								<div class="pull-right more-operate">
									<a class="text-color-999 dropdown-toggle" data-toggle="dropdown">
										<i class="icon icon-share"></i>bottom									</a>
									<div aria-labelledby="dropdownMenu" role="menu" class="iot-dropdown shareout pull-right">
										<ul class="iot-dropdown-list">
											<li><a ><i class="icon icon-weibo"></i>act1</a></li>
											<li><a ><i class="icon icon-qzone"></i> act2</a></li>
											<li><a ><i class="icon icon-wechat"></i> act3</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						 --%>
					</div>
					
					<div class="iot-mod iot-question-detail iot-item">
					    <div class="mod-head">
					        <h1>Device Library </h1>
					        
					        <div style="float:left;top:5px;position: absolute;left:210px" >
					        	<a href="javascript:devdef_cat_import()">
					        	<span class="fa-stack">
							  <i class="fa fa-square-o fa-stack-2x"></i>
							  <i class="fa fa-arrow-down fa-stack-1x"></i>
							</span>&nbsp;&nbsp; Import
							<input type="file" id='devlib_add_file' onchange="devlib_add_file_onchg()" name="devlib_file" style="left:-9999px;position:absolute;" accept=".zip"/>
							</a>
					        	&nbsp;&nbsp;&nbsp;&nbsp;
					        	<a class0="btn btn-success"  style="width:100px;height:40px;" href="javascript:devdef_cat_export()">
							<span class="fa-stack">
							  <i class="fa fa-square-o fa-stack-2x"></i>
							  <i class="fa fa-arrow-up fa-stack-1x"></i>
							</span>&nbsp;&nbsp;Export
							</a>
							
							&nbsp;&nbsp;&nbsp;&nbsp;
					        	<a class0="btn btn-success"  title="git help" style="width:100px;height:40px;" href="javascript:devdef_help()">
							<span class="fa-stack">
							  <i class="fa fa-square-o fa-stack-2x"></i>
							  <i class="fa fa-question fa-stack-1x"></i>
							</span>
							</a>
							
					        </div>
					        
					        <div style="float:right;top:0px;position: absolute;right:10px" onclick="show_hide('cont_devlib')"><i class="fa fa-bars fa-lg"></i></div>
					    </div>
					    <div class="mod-body" style="display:none" id="cont_devlib">
<%--
					        <a href="javascript:open_devlib()">Open</a>
 --%>
							<iframe id="devdef_lister" src="/admin/dev/dev_lib_lister.jsp?mgr=true" style="width:100%;height:500px;"></iframe>
					        
					    </div>
					</div>
					
					<div class="iot-mod iot-question-detail iot-item">
					    <div class="mod-head">
					        <h1 style="width:200px">HMI Library</h1>
					        
					        <div style="float:left;top:5px;position: absolute;left:210px" >
					        	<a href="javascript:comp_cat_import()"><span class="fa-stack">
							  <i class="fa fa-square-o fa-stack-2x"></i>
							  <i class="fa fa-arrow-down fa-stack-1x"></i>
							</span>&nbsp;&nbsp; Import</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
					        	<a href="javascript:comp_cat_export()"><span class="fa-stack">
							  <i class="fa fa-square-o fa-stack-2x"></i>
							  <i class="fa fa-arrow-up fa-stack-1x"></i>
							</span> Export</a>
							
							&nbsp;&nbsp;&nbsp;&nbsp;
					        	<a class0="btn btn-success"  title="git help" style="width:100px;height:40px;" href="javascript:comp_help()">
							<span class="fa-stack">
							  <i class="fa fa-square-o fa-stack-2x"></i>
							  <i class="fa fa-question fa-stack-1x"></i>
							</span>
							</a>
							
					        </div>
					        
					        <div style="float:right;top:5px;position: absolute;right:10px" onclick="show_hide('cont_hmilib')"><i class="fa fa-bars fa-lg"></i></div>
					    </div>
					    <div class="mod-body"  id="cont_hmilib" style="display:none">
					        <iframe id="comp_lister" src="/admin/ua_hmi/hmi_left_comp.jsp" style="width:100%;height:500px;"></iframe>
					        
					    </div>
					</div>
					
				</div>
				<!--right side -->
				<div class="iot-side-bar">
					
					<div class="iot-mod iot-text-align-justify">
					    <div class="mod-head">
					        <h3>Tag Indicator</h3>
					    </div>
					    <div class="mod-body">
					       
					       TODO 1.2v
					        
					    </div>
					</div>

					<div class="iot-mod iot-text-align-justify">
					    <div class="mod-head">
					        <h3>Store Adapters</h3>
					    </div>
					    <div class="mod-body">
					       
					       TODO 1.2v
					        
					    </div>
					</div>

					<div class="iot-mod iot-text-align-justify">
					    <div class="mod-head">
					        <h3>Remote Connections</h3>
					    </div>
					    <div class="mod-body">
					                
					                
					            </div>
					</div>

				</div>
				<!-- end 侧边栏 -->
			</div>
		</div>
	</div>
</div>

<div class="iot-footer-wrap">
	<div class="iot-footer">
		Copyright:  Version:<%=Config.getVersion() %>

	</div>
</div>
</body>
<script type="text/javascript">

var all_panels=[];
function open_rep(id)
{
	window.open("prj_editor.jsp?id="+id);
	//window.open("ua_rep.jsp?repid="+id);
}

function set_prj_main(id)
{
	send_ajax('ua/prj_ajax.jsp',{op:"main",id:id},function(bsucc,ret){
		if(!bsucc||ret!='ok')
		{
			dlg.msg(ret) ;
			return ;
		}
		document.location.href=document.location.href;
	});
}

function set_prj_auto_start(id,b)
{
	send_ajax('ua/prj_ajax.jsp',{op:"auto_start",id:id,auto_start:b},function(bsucc,ret){
		if(!bsucc||ret!='ok')
		{
			dlg.msg(ret) ;
			return ;
		}
		document.location.href=document.location.href;
	});
}

function show_hide(id)
{
	var ob = $("#"+id) ;
	if(ob.css("display")=='none')
		ob.css("display","") ;
	else
		ob.css("display",'none') ;
}

function del_rep(id)
{
	dlg.confirm("make sure to delete it？",{btn:["Yes","Cancel"],title:"Delete Confirm"},function ()
    {
		send_ajax('ua/prj_ajax.jsp',{op:"del",id:id},function(bsucc,ret){
			if(!bsucc||ret!='ok')
			{
				dlg.msg(ret) ;
				return ;
			}
			document.location.href=document.location.href;
		});
     });
}

function open_devlib()
{
	dlg.open_win("dev/dev_lib_lister.jsp?mgr=true",
			{title:"Device Library",w:'1000',h:'560'},
			[{title:'Close',style:"primary"},{title:'Help',style:"primary"}],
			[
				function(dlgw)
				{
					dlg.close();
				},
				function(dlgw)
				{
					dlg.msg("help is under dev");
				}
			]);
}
function add_prj()
{
	dlg.open("ua/prj_edit.jsp",
			{title:"Add Project",w:'500px',h:'400px'},
			['Ok','Cancel'],
			[
				function(dlgw)
				{
					dlgw.do_submit(function(bsucc,ret){
						 if(!bsucc)
						 {
							 dlg.msg(ret) ;
							 //enable_btn(true);
							 return;
						 }
						 //console.log(ret);
						 dlg.close();
						 document.location.href=document.location.href;
				 	});
				},
				function(dlgw)
				{
					dlg.close();
				}
			]);
}

function comp_cat_export()
{
	var w = document.getElementById("comp_lister").contentWindow ;
	if(!w||!w.get_sel_cat_ids)
	{
		dlg.msg("no comp cat selected") ;
		return ;
	}
	var catids = w.get_sel_cat_ids() ;
	if(catids==null||catids.length==0)
	{
		dlg.msg("please select component catetory");
		return ;
	}
		
	window.open("./ua_hmi/comp_lib_export.jsp?catid="+catids[0]) ;
}

function comp_cat_import()
{
	
}

function exp_prj(id)
{
	window.open("./ua/prj_export.jsp?id="+id) ;
}


function add_file_onchg()
{
	//$("#"+id).
	var fs = $("#add_file")[0].files ;
	if(fs==undefined||fs==null||fs.length<=0)
	{
		return ;
	}
	var f = fs[0];

	//upload
	var fd = new FormData();
    //fd.append("cxtid",cur_cxtid) ;
    fd.append("file",f);
     $.ajax({"url": "ua/prj_imp_upload.jsp",type: "post","processData": false,"contentType": false,
		"data": fd,
		success: function(data)
       	{
 	  		//dlg.msg(data);
 	  		//document.location.href=document.location.href;
 	  		if(data.indexOf("succ=")==0)
 	  			before_imp(data.substring(5)) ;
 	  		else
 	  			dlg.msg(data) ;
   　  },
      　error: function(data)
         {
  				dlg.msg("upload failed");
　　　}
  　　});
}


function before_imp(tmpfn,bdemo)
{
	dlg.open("ua/prj_import.jsp?tmpfn="+tmpfn+"&demo="+bdemo,
			{title:"Import project",w:'500px',h:'400px'},
			['Do Import','Cancel'],
			[
				function(dlgw)
				{
					dlgw.do_submit(function(bsucc,ret){
						 if(!bsucc)
						 {
							 dlg.msg(ret) ;
							 //enable_btn(true);
							 return;
						 }
						 //console.log(ret);
						 dlg.close();
						 document.location.href=document.location.href;
				 	});
				},
				function(dlgw)
				{
					dlg.close();
				}
			]);
}



function imp_prj()
{
	add_file.click() ;
}

function imp_prj_demo()
{
	dlg.open("ua/prj_demo_list.jsp",
			{title:"Import Demo project",w:'500px',h:'400px'},
			['Select','Cancel'],
			[
				function(dlgw)
				{
					dlgw.do_submit(function(bsucc,ret){
						 if(!bsucc)
						 {
							 dlg.msg(ret) ;
							 return;
						 }
						 //console.log(ret);
						 dlg.close();
						 //document.location.href=document.location.href;
						 before_imp(ret,true);
				 	});
				},
				function(dlgw)
				{
					dlg.close();
				}
			]);
}

function devdef_cat_export()
{
	var w = document.getElementById("devdef_lister").contentWindow ;
	
	var drvnt = w.get_cur_drv_name_title();
	if(drvnt==null)
	{
		dlg.msg("no Driver selected") ;
		return;
	}
	var catname = w.get_cur_cat_name() ;
	if(catname==null||catname=="")
	{
		dlg.msg("please select Device Definition Category catetory");
		return ;
	}
		
	window.open("./dev/cat_export.jsp?drvn="+drvnt[0]+"&catn="+catname) ;
}



function devdef_cat_import()
{
	devlib_add_file.click();
}


function devlib_before_imp(tmpfn)
{

	dlg.open("dev/cat_import.jsp?tmpfn="+tmpfn,
			{title:"Import Device Definition",w:'500px',h:'400px'},
			['Do Import','Cancel'],
			[
				function(dlgw)
				{
					dlgw.do_submit(function(bsucc,ret){
						 if(!bsucc)
						 {
							 dlg.msg(ret) ;
							 //enable_btn(true);
							 return;
						 }
						 //console.log(ret);
						 dlg.msg(ret) ;
						 
						 var w = document.getElementById("devdef_lister").contentWindow ;
						 w.drv_sel_chg();
						 dlg.close();
						 
				 	});
				},
				function(dlgw)
				{
					dlg.close();
				}
			]);
}

function devlib_add_file_onchg()
{
	//$("#"+id).
	var fs = $("#devlib_add_file")[0].files ;
	if(fs==undefined||fs==null||fs.length<=0)
	{
		return ;
	}
	var f = fs[0];

	//upload
	var fd = new FormData();
    //fd.append("cxtid",cur_cxtid) ;
    fd.append("file",f);
     $.ajax({"url": "dev/cat_imp_upload.jsp",type: "post","processData": false,"contentType": false,
		"data": fd,
		success: function(data)
       	{
 	  		//dlg.msg(data);
 	  		//document.location.href=document.location.href;
 	  		if(data.indexOf("succ=")==0)
 	  			devlib_before_imp(data.substring(5)) ;
 	  		else
 	  			dlg.msg(data) ;
   　  },
      　error: function(data)
         {
  				dlg.msg("upload failed");
　　　}
  　　});
}


function logout()
{
	$.ajax({
        type: 'post',
        url:'./login/login_ajax.jsp',
        data: {op:"logout"},
        async: true,  
        success: function (result) {  
        	if("ok"==result)
        	{
        		document.location.href="/admin/login/login.jsp" ;
        	}
        	else
        	{
        		dlg.msg("Login failed") ;
        	}
        },
        error:function(req,err,e)
        {
        	dlg.msg(e);
        }
    });
}
</script>
</html>
