<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="s" uri="/struts-tags"%>



<%
    pageContext.setAttribute("pageName","Stage");
%>


<html>

<%@ include file="include/header.jsp"%>

<script>
    $(function() {

        $("#internalSearchKeyword").keyup(function(){
            var keyword = $(this).val();

            var data = "internalSearchKeyword="+keyword;

            $.ajax({
                type: "POST",
                url: "managesearchResultKnowledge",
                data: data,
                success:
                    function (data, textStatus) {
                        $("#result").html(data);
                    }
            });

        });


    });
</script>



<body>
<h1>全文查询</h1>

<div align="center">
    <!--		 		<form action="managesearchResultKnowledge" method="post">-->
    <input id="internalSearchKeyword" type="text" name="internalSearchKeyword"/>
    <!--		 		</form>-->


</div>

<br/>
<br/>
<br/>

<div align="center" id="result">

</div>
</body>
</html>
