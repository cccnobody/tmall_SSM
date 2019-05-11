<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>
<div style="background:#1B1B1B;">
	<div style="background: #1B1B1B;width: 1150px;margin:0 auto;height: 135px;">
		<div style="float: left;">
			<a href="${contextPath}">
				<img id="logo" src="img/site/logo.png" class="logo">
			</a>
		</div>
		<div style="float: left;margin-left: 425px;margin-top: 40px;">
			<form action="foresearch" method="post" >
				<div class="searchDiv">
					<input name="keyword" type="text" value="${param.keyword}" placeholder="时尚男鞋  太阳镜 ">
					<button  type="submit" class="searchButton">搜索</button>
					<div class="searchBelow">
						<c:forEach items="${cs}" var="c" varStatus="st">
							<c:if test="${st.count>=5 and st.count<=8}">
									<span>
										<a href="forecategory?cid=${c.id}">
												${c.name}
										</a>
										<c:if test="${st.count!=8}">
											<span>|</span>
										</c:if>
									</span>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>