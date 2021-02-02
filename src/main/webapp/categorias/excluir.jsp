<%-- 
    Document   : newjsp
    Created on : 2 de fev de 2021, 17:06:42
    Author     : tiagomariano
--%>

<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>  

<% String id = request.getParameter("id"); %>

<%
    Statement st = null;
    ResultSet rs = null;

    try {
        
        st = new Conexao().conectar().createStatement();
        st.executeUpdate("DELETE from categorias where id = '" + id + "'");
        
        out.print("Excluído com Sucesso!!");
        
    } catch (Exception e) {
        out.print(e);
    }

%>