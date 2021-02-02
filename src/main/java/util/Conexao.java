/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import java.sql.*;
import com.mysql.jdbc.Driver;


/**
 *
 * @author tiagomariano
 */
public class Conexao {
    public Connection conectar() throws SQLException{
        try{
           Class.forName("com.mysql.cj.jdbc.Driver");
           
           //localhost
           return DriverManager.getConnection("jdbc:mysql://localhost/aveJeferson?useTimezone=true&serverTimezone=UTC&user=root&password="); 
           
            //hospedada
           //return DriverManager.getConnection("jdbc:mysql://node50289-javaav.jelastic.saveincloud.net/webavancado?useTimezone=true&serverTimezone=UTC&user=root&password="); 
           
        }catch(ClassNotFoundException e){
            throw new RuntimeException(e);
        }
    }
}
