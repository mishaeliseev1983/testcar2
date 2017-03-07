<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.*"%>
<html>
<title>Web auto</title>
<link href="js/style.css" rel="stylesheet">
<script src="js/jquery-3.1.1.js"></script>
<script type="text/javascript">
<%
HttpSession currentSession = request.getSession();
String currentlogin= "Пользователь";
Object cl= currentSession.getAttribute("login");
if(cl!=null)
	currentlogin= cl.toString();
%>

$(document).ready(function() {
	
	$('#btnSearch').click(function() {
			$.ajax({
			type:'post',
			url : 'SearchServlet',
			data : {
				dataquery : $('#name').val()+':'+$('#surname').val()+
				':'+$('#patronymic').val()+':'+$('#city').val()+':'+$('#model').val()
			},
			 beforeSend:function() { 
				 if ($('#name').val()=="" && $('#surname').val()=="" 
						 && $('#patronymic').val()=="" 
						 && $('#city').val()=="" && $('#model').val()==""){
					 alert('Введите данные для запроса !');
					 return false;
				 }
				 
			 },
			success: function( data) {
				
				 if(data==""){
					 alert("Данных по вашему запросу нет.");
					 return;
				 }
					 
				 $("#records_table").find("tr:gt(0)").remove();  
                 var rows = data.split('_next_Object_');
                 var trHTML = '';
                 for(var i=0; i<rows.length; i++){
                	 var arr= rows[i].split(':');
                 
                 		var name=arr[0];
                 		var surname=arr[1];
                 		var patronymic=arr[2];
                 		var city=arr[3];
                 		var number=arr[4];
                 		var model=arr[5];
                		trHTML += 
                     	'<tr><td>' + name + 
                     	'</td><td>' + surname + 
                     	'</td><td>' + patronymic + 
                     	'</td><td>' + city + 
                     	'</td><td>' + number + 
                     	'</td><td>' + model  +
                     	'</td></tr>';            
                 }
               	  $('#records_table').append(trHTML);
                  } 
		
		});
});
});
</script>
</head>
    
<body>
<div class="tg">
	<h2> Данные автовладельцев: </h2>
		<table>
		<tr>	
		<th valign="top">
		<table id="button_table">
    	<tr><th align="center" width="120">Имя<input type="text" 		id="name"></th></tr>
        <tr><th align="center" width="120">Фамилия<input type="text" 	id="surname"></th></tr>
        <tr><th align="center" width="120">Отчество<input type="text" 	id="patronymic"></th></tr>
        <tr><th align="center" width="120">Город <input type="text" 	id="city"></th></tr>
        <tr><th align="center" width="120">Марка <input type="text" 	id="model"></th></tr>
		</table>
		<br>
		<input type="button" value="Поиск" id="btnSearch">
		<br>
		</th>
		
		<th valign="top">
		<table id="records_table">
    	<tr>
        <th align="center" width="100" >Имя</th>
        <th align="center" width="100" >Фамилия</th>
        <th align="center" width="100" >Отчество</th>
        <th align="center" width="100" >Город</th>
        <th align="center" width="100" >Номер</th>
        <th align="center" width="100" >Марка</th>
    	</tr>
		</table>

    	</th>
    	</tr>
    	</table>
</div>
<br>

 <p><span id="currentlogin">Вы залогинились - <%= currentlogin %></span> </p>
<form  method="post"  action="ExitServlet">
 <p><input type="submit" value="Выход" name="btnExit"> <p>
</form>
</body>
</html>