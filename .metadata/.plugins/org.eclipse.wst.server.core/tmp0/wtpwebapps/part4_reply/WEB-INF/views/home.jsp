<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!
</h1>
	<ul>
		<c:forEach var="board" items="${listBoard}">
			<li>
				<a href="/post/listPost?boardId=${board.id}">${board.name}</a>
			</li>
		</c:forEach>
	</ul>
</body>
</html>
