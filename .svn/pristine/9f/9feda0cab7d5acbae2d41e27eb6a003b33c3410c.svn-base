<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%--  <p>${newsList}</p> --%>
<div class="wf-content-wrap">
	<div class="wf-content-area">
		<table class="wf-table">
			<tr>
				<th>IT/컴퓨터 기사</th>
			</tr>
			<%--  <td><a href="${newsList[0].url}">${newsList[0].subject}</a></td> --%>
			<c:forEach var="news" items="${newsList}" varStatus="stat">
				<tr>
					<td><a href="${news.url}">${news.subject}</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>


