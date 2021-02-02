<%-- 
    Document   : newjsp
    Created on : 2 de fev de 2021, 17:06:42
    Author     : tiagomariano
--%>

<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>  

<% String pag = "produtos"; %>
<% String buscar = request.getParameter("txtbuscar"); %>
<% String nomeCat = ""; %>
<%

            Statement st,st2 = null;
            ResultSet rs,rs2 = null;
            
        %>

<% out.print(" <table class='table table-sm table-striped'>"
                                    +"<thead>"
                                        +"<tr>"
                                            +"<th scope='col'>Nome</th>"
                                            +"<th scope='col'>Descrição</th>"
                                            +"<th scope='col'>Valor</th>"
                                            +"<th scope='col'>Categoria</th>"
                                            +"<th scope='col'>Imagem</th>"
                                           
                                            +"<th scope='col'>Ações</th>"
                                        +"</tr>"
                                    +"</thead>"
                                    +"<tbody>" ); 

                                                                                  
                                                try {

                                                st = new Conexao().conectar().createStatement();
                                                st2 = new Conexao().conectar().createStatement();
                                                if (buscar != null) {
                                                   buscar = '%' + buscar + '%';
                                                    rs = st.executeQuery("SELECT * FROM produtos where nome LIKE '" + buscar + "' order by nome asc");
                                                } else {
                                                    rs = st.executeQuery("SELECT * FROM produtos order by nome asc");
                                                }
                                                
                                                

                                                while (rs.next()) {
                                                    
                                                //buscar o nome da categoria
                                                rs2 = st2.executeQuery("SELECT * FROM categorias where id = '" + rs.getString(5) + "'");
                                                while (rs2.next()) {
                                                    nomeCat = rs2.getString(2);
                                                }
                                                
                                            out.print("<tr>");
                                            
                                            out.print("<td>"+rs.getString(2)+"</td>");
                                            out.print("<td>"+rs.getString(3)+"</td>");
                                            out.print("<td>R$ "+rs.getString(4).replace(".", ",")+"</td>");
                                            out.print("<td>"+nomeCat+"</td>");
                                            out.print("<td><img src='img/"+rs.getString(6)+"' width='40'></td>");
                                                                                      
                                            
                                            out.print("<td>");
                                            out.print("<a href='"+pag+".jsp?funcao=editar&id="+rs.getString(1)+"' class='text-info mr-1' title='Editar Dados'><i class='far fa-edit'></i></a>");
                                            out.print("<a href='"+pag+".jsp?funcao=excluir&id="+rs.getString(1)+"' class='text-danger' title='Excluir Dados'><i class='far fa-trash-alt'></i></a>");
                                            out.print("</td>");
                                                    
                                             out.print("</tr>");
                                          

                                        }
                                            } catch (Exception e) {
                                                out.print(e);
                                            }

                                       



                                    out.print("</tbody>"
                                +"</table>");     
%>

