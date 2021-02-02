<%-- 
    Document   : newjsp
    Created on : 2 de fev de 2021, 17:06:42
    Author     : tiagomariano
--%>

<%@page import="util.Upload" %>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="util.Conexao"%>



<%
    Statement st = null;
    ResultSet rs = null;

    String nome = "";
    String descricao = "";
    String imagem = null;
    
    String id = "";
    String antigo = "";

    Upload up = new Upload();

//definir qual a pasta a ser salva
    up.setFolderUpload("img");

    if (up.formProcess(getServletContext(), request)) {

        try {
            
            nome = up.getForm().get("nome").toString();
            descricao = up.getForm().get("descricao").toString();
            id = up.getForm().get("txtid").toString();
            antigo = up.getForm().get("antigo").toString();
            imagem = up.getFiles().get(0).toString();
            
            
            
        } catch (Exception e) {
            imagem = "sem-foto.jpg";

        }

        //INSERIR OS DADOS NO BANCO DE DADOS
        try {
            
            //verificar se o campo � vazio
            if(nome.equals("")){
                out.print("Preencha o Campo Nome!!");
                return;
            }
            
            if(descricao.equals("")){
                out.print("Preencha o Campo Descri��o!!");
                return;
            }
            
            st = new Conexao().conectar().createStatement();
            
            //VERIFICAR SE JA EXISTE UM REGISTRO COM ESTE NOME NO BANCO
            if(!nome.equals(antigo)){
                rs = st.executeQuery("SELECT * FROM categorias where nome = '" + nome + "'");
            while (rs.next()) {
                rs.getRow();
                if (rs.getRow() > 0) {
                    out.print("Registro J� Cadastrado!");
                    return;
                }
            }
            }
            
            if(id.equals("")){
                st.executeUpdate("INSERT into categorias (nome, descricao, imagem) values ('" + nome + "', '" + descricao + "', '" + imagem + "')");
            }else{
                if(imagem.equals("sem-foto.jpg")){
                    st.executeUpdate("UPDATE categorias SET nome = '" + nome + "', descricao = '" + descricao + "' WHERE id = '" + id + "'");
                }else{
                    st.executeUpdate("UPDATE categorias SET nome = '" + nome + "', descricao = '" + descricao + "', imagem = '" + imagem + "' WHERE id = '" + id + "'");
                }
                
            }
            
            out.print("Salvo com Sucesso!!");
        } catch (Exception e) {
            out.print(e);
        }

    }

%>