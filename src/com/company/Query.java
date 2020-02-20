package com.company;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Query {
    private Connection conn = null;
    private PreparedStatement statement;
    private ResultSet resultSet;


    public void addNewCustomer(String name, String last_name, String nhs_number){
        connectToDatabase();
        try {
            this.statement = this.conn.prepareStatement("INSERT INTO customers (name, last_name, nhs_number) VALUES (?, ?, ?);");
            this.statement.setString(1, name);
            this.statement.setString(2, last_name);
            this.statement.setString(3, nhs_number);
            this.statement.executeUpdate();
            System.out.printf("Customer: %s %s with nhs number %s was added to the database.", name, last_name, nhs_number);
        } catch (Exception e) {
            e.printStackTrace();
        }
        disconnectFromDatabase();
    }

    public void selectPlace(){
        connectToDatabase();
        try {
            this.statement = this.conn.prepareStatement("SELECT places.id, places.name, addresses.* FROM places INNER JOIN addresses ON places.address_id=addresses.id;");
            this.resultSet = statement.executeQuery();
            while (resultSet.next()) {
                System.out.printf(
                        "%d. %s (%s %s, %s, %s).\n",
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("street"),
                        resultSet.getString("number"),
                        resultSet.getString("city"),
                        resultSet.getString("country")
                );
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        disconnectFromDatabase();
    }
    //"select * from rooms inner join places on rooms.place_id = places.id WHERE rooms.place_id = 1"

    public void includedAtLocation(String placeID){
        connectToDatabase();
        try {
            this.statement = this.conn.prepareStatement("SELECT access_to.name FROM places_and_access INNER JOIN access_to ON access_id = access_to.id WHERE place_id = ?;");
            this.statement.setString(1, placeID);
            this.resultSet = statement.executeQuery();
            while (resultSet.next()) {
                System.out.printf(
                        "%s.\n",
                        resultSet.getString("name")
                );
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        disconnectFromDatabase();
    }

    private void connectToDatabase() {
        try {
            this.conn = DriverManager.getConnection("jdbc:mysql://localhost/holidaymaker_database?user=root&password=mysql&serverTimezone=UTC");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void disconnectFromDatabase(){
        try{
            this.conn.close();
        } catch (Exception e){
            e.printStackTrace();
        }
    }
}
