package com.company;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Query {
    private Connection conn = null;
    private PreparedStatement statement;
    private ResultSet resultSet;

    public String addNewCustomer(String name, String last_name, String nhs_number){
        connectToDatabase();
        try {
            this.statement = this.conn.prepareStatement("INSERT INTO customers (name, last_name, nhs_number) VALUES (?, ?, ?);");
            this.statement.setString(1, name);
            this.statement.setString(2, last_name);
            this.statement.setString(3, nhs_number);
            this.statement.executeUpdate();
            System.out.printf("Customer: %s %s with nhs number %s was added to the database.\n", name, last_name, nhs_number);
        } catch (Exception e) {
            e.printStackTrace();
        }
        disconnectFromDatabase();
        return getCustomerIDFromNHSNumber(nhs_number);
    }

    private String getCustomerIDFromNHSNumber(String nhsNumber){
        String customerID = null;
        connectToDatabase();
        try {
            this.statement = this.conn.prepareStatement("SELECT * FROM customers WHERE nhs_number = ?;");
            this.statement.setString(1, nhsNumber);
            this.resultSet = statement.executeQuery();
            this.resultSet.next();
            customerID = resultSet.getString("id");
        } catch (Exception e){
            e.printStackTrace();
        }
        disconnectFromDatabase();
        return customerID;
    }

    public String addNewBookingToDatabase(String beginDate, String endDate, String customerID, String roomID, String placeID, String totalGuests){
        connectToDatabase();
        try {
            this.statement = this.conn.prepareStatement("INSERT INTO bookings (begin_date, end_date, customer_id, room_id, place_id, total_guests) " +
                    "VALUES (?, ?, ?, ?, ?, ?);");
            this.statement.setString(1, beginDate);
            this.statement.setString(2, endDate);
            this.statement.setString(3, customerID);
            this.statement.setString(4, roomID);
            this.statement.setString(5, placeID);
            this.statement.setString(6, totalGuests);
            this.statement.executeUpdate();
            System.out.println("Booking was added to the database.");
            return getIDOfBookingFrom(beginDate, endDate, customerID, roomID);
        } catch (Exception e) {
            e.printStackTrace();
        }
        disconnectFromDatabase();
        return null;
    }

    public String getIDOfBookingFrom(String beginDate, String endDate, String customerID, String roomID){
        try{
            connectToDatabase();
            this.statement = this.conn.prepareStatement("SELECT * FROM bookings WHERE begin_date=? AND end_date=? AND customer_id=? AND room_id=?");
            this.statement.setString(1, beginDate);
            this.statement.setString(2, endDate);
            this.statement.setString(3, customerID);
            this.statement.setString(4, roomID);
            this.resultSet = statement.executeQuery();
            this.resultSet.next();
            String bookingID = resultSet.getString("id");
            disconnectFromDatabase();
            return bookingID;
        } catch (Exception e){
            e.printStackTrace();
        }
        disconnectFromDatabase();
        return null;
    }

    public void linkBookingWithAddon(String bookingID, String addonID){
        connectToDatabase();
        try {
            this.statement = this.conn.prepareStatement("INSERT INTO bookings_and_addons (booking_id, addon_id) VALUES (?, ?);");
            this.statement.setString(1, bookingID);
            this.statement.setString(2, addonID);
            this.statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        disconnectFromDatabase();
    }

    public void deleteCustomerWithID(String customerID){
        connectToDatabase();
        try {
            this.statement = this.conn.prepareStatement("DELETE FROM customers WHERE id=?;");
            this.statement.setString(1, customerID);
            this.statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        disconnectFromDatabase();
    }

    public String deleteBookingWithID(String bookingID){
        connectToDatabase();
        try {
            this.statement = this.conn.prepareStatement("SELECT customer_id FROM bookings WHERE id=?;");
            this.statement.setString(1, bookingID);
            this.resultSet = statement.executeQuery();
            this.resultSet.next();
            String customerID = resultSet.getString("customer_id");

            this.statement = this.conn.prepareStatement("DELETE FROM bookings WHERE id=?;");
            this.statement.setString(1, bookingID);
            this.statement.executeUpdate();
            disconnectFromDatabase();
            return customerID;
        } catch (Exception e) {
            e.printStackTrace();
        }
        disconnectFromDatabase();
        return null;
    }

    public void displayAllBookings(){
        connectToDatabase();
        try {
            this.statement = this.conn.prepareStatement("SELECT bookings.id, begin_date, end_date, customers.* FROM bookings INNER JOIN customers ON customer_id=customers.id;");
            this.resultSet = statement.executeQuery();
            while (resultSet.next()){
                System.out.printf(
                        "%d. %s-%s - FullName: %s %s - NHS number: %s\n",
                        resultSet.getInt("id"),
                        resultSet.getString("begin_date"),
                        resultSet.getString("end_date"),
                        resultSet.getString("name"),
                        resultSet.getString("last_name"),
                        resultSet.getString("nhs_number")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        disconnectFromDatabase();
    }

    public void displayAddons(){
        connectToDatabase();
        try {
            this.statement = this.conn.prepareStatement("SELECT * FROM Addons");
            this.resultSet = statement.executeQuery();
            while (resultSet.next()) {
                System.out.printf(
                        "%d. %s - %s kr\n",
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("price")
                );
            }
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

    public void checkIfARoomIsAvailableDuringTheDates(String arrivalDate, String departureDate, String placeID, String totalGuests){
        connectToDatabase();
        try {
            int intPlaceID = Integer.parseInt(placeID);
            int intTotalGuests = Integer.parseInt(totalGuests);
            this.statement = this.conn.prepareStatement("SELECT rooms.id, rooms.room_number, places.name, sizes.size_name, sizes.max_guests " +
                    "FROM bookings INNER JOIN rooms ON room_id = rooms.id INNER JOIN places ON bookings.place_id = places.id " +
                    "INNER JOIN sizes ON rooms.size_id = sizes.id " +
                    "WHERE (? < bookings.begin_date OR ? > bookings.end_date AND ? < bookings.begin_date OR ? > bookings.end_date) " +
                    "AND (bookings.place_id = ?) AND (? <= (sizes.max_guests + 1)) GROUP BY bookings.room_id;");
            this.statement.setString(1, arrivalDate);
            this.statement.setString(2, arrivalDate);
            this.statement.setString(3, departureDate);
            this.statement.setString(4, departureDate);
            this.statement.setInt(5, intPlaceID);
            this.statement.setInt(6, intTotalGuests);
            this.resultSet = statement.executeQuery();
            while (resultSet.next()){
                int totalMaxGuests = resultSet.getInt("max_guests") + 1;
                System.out.printf(
                        "%d. Room #: %s - Size: %s - Max guests: %d (%6$d with an extra bed) - Place: %s\n",
                        resultSet.getInt("rooms.id"),
                        resultSet.getString("room_number"),
                        resultSet.getString("size_name"),
                        resultSet.getInt("max_guests"),
                        resultSet.getString("name"),
                        totalMaxGuests
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
