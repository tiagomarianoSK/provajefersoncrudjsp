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
    String valor = "";
    String categoria = "";
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
            valor = up.getForm().get("valor").toString();
            valor = valor.replace(",", ".");
            categoria = up.getForm().get("categoria").toString();
            id = up.getForm().get("txtid").toString();
            antigo = up.getForm().get("antigo").toString();
            imagem = up.getFiles().get(0).toString();
            
            
            
        } catch (Exception e) {
            imagem = "sem-foto.jpg";

        }

        //INSERIR OS DADOS NO BANCO DE DADOS
        try {
            
            //verificar se o campo é vazio
            if(nome.equals("")){
                out.print("Preencha o Campo Nome!!");
                return;
            }
            
            if(descricao.equals("")){
                out.print("Preencha o Campo Descrição!!");
                return;
            }
            
            st = new Conexao().conectar().createStatement();
            
            //VERIFICAR SE JA EXISTE UM REGISTRO COM ESTE NOME NO BANCO
            if(!nome.equals(antigo)){
                rs = st.executeQuery("SELECT * FROM produtos where nome = '" + nome + "'");
            while (rs.next()) {
                rs.getRow();
                if (rs.getRow() > 0) {
                    out.print("Registro Já Cadastrado!");
                    return;
                }
            }
            }
            
            if(id.equals("")){
                st.executeUpdate("INSERT into produtos (nome, descricao, valor, categoria, imagem) values ('" + nome + "', '" + descricao + "' , '" + valor + "' , '" + categoria + "', '" + imagem + "')");
            }else{
                if(imagem.equals("sem-foto.jpg")){
                    st.executeUpdate("UPDATE produtos SET nome = '" + nome + "', descricao = '" + descricao + "', valor = '" + valor + "', categoria = '" + categoria + "' WHERE id = '" + id + "'");
                }else{
                    st.executeUpdate("UPDATE produtos SET nome = '" + nome + "', descricao = '" + descricao + "', valor = '" + valor + "', categoria = '" + categoria + "', imagem = '" + imagem + "' WHERE id = '" + id + "'");
                }
                
            }
            
            out.print("Salvo com Sucesso!!");
        } catch (Exception e) {
            out.print(e);
        }

    }

%>