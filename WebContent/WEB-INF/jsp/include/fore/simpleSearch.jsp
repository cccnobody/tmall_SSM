<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" isELIgnored="false"%>

<div style="background:#1B1B1B;">
	<div style="width:1150px;margin:0 auto;background:#1B1B1B; ">

			<a href="${contextPath}">
				<img id="simpleLogo" class="simpleLogo" src="img/site/logo.png">
			</a>


			<form action="foresearch" method="post" >
				<div class="simpleSearchDiv pull-right">
					<input type="text" placeholder="平衡车 原汁机"  value="${param.keyword}" name="keyword">
					<button class="searchButton" type="submit">搜地狗</button>
					<div class="searchBelow">
						<c:forEach items="${cs}" var="c" varStatus="st">
							<c:if test="${st.count>=8 and st.count<=11}">
							<span>
								<a href="forecategory?cid=${c.id}">
										${c.name}
								</a>
								<c:if test="${st.count!=11}">
									<span>|</span>
								</c:if>
							</span>
							</c:if>
						</c:forEach>

				</div>
			</form>
		</div>
	</div>
		<div style="clear:both"></div>
</div>