package com.company;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Scanner;

public class Console {
    private Scanner scan = new Scanner(System.in);
    private Query query = new Query();
    public Console(){
    }

    public void displayMenu(){
        System.out.println("---- MENU ----");
        System.out.print(
                        "1. Add a new booking.\n" +
                        "2. Update a booking.\n" +
                        "3. Delete a booking.\n" +
                        "4. Search...\n" +
                        "5. Quit.\n"
        );
    }

    private void addNewBooking(){
        // return the info and keep it and only add it all at the end if all is fine
        String customerID = addCustomerToDatabase();
        // again return the choice "id"
        String placeID = selectPlaceToStayAt();
        String[] dates = chooseDates();
        String beginDate = dates[0];
        String endDate = dates[1];
        String totalGuests = addHowManyGuestsAreStaying();
        this.query.checkIfARoomIsAvailableDuringTheDates(beginDate, endDate, placeID, totalGuests);
        String roomID = selectRoomToStayAt();
        this.query.addNewBookingToDatabase(beginDate, endDate, customerID, roomID, placeID, totalGuests);
        System.out.printf("%s %s cID: %s - rID: %s - pID: %s - totalGuest: %s\n", beginDate, endDate,customerID,roomID,placeID,totalGuests);
    }

    private String addCustomerToDatabase(){
        System.out.print("Enter first name: ");
        String name = scan.nextLine();
        System.out.print("Enter last name: ");
        String lastName = scan.nextLine();
        System.out.print("Enter NHS number: ");
        String nhsNumber = scan.nextLine();
        return this.query.addNewCustomer(name, lastName, nhsNumber);
    }

    private String addHowManyGuestsAreStaying(){
        System.out.println("How many guests are staying?");
        System.out.print("Enter a number between 1 to 5: ");
        String choice = scan.nextLine();
        return choice;
    }

    private String selectRoomToStayAt(){
        System.out.print("Enter a number: ");
        String choice = scan.nextLine();
        return choice;
    }

    private String selectPlaceToStayAt(){
        query.selectPlace();
        System.out.print("Enter a number: ");
        String choice = scan.nextLine();
        switch (choice){
            case "1": case "2": case "3": case "4": case "5":
                System.out.println("-- Location includes --");
                query.includedAtLocation(choice);
                System.out.println("-----------------------");
                return choice;
            default: System.out.println("DEFAULT");
        }
        return null;
    }

    private boolean dateIsValid(String date){
        int year = Integer.parseInt(date.substring(0, 4));
        System.out.println(year);
        String month = date.substring(5, 7);
        System.out.println(month);
        int day = Integer.parseInt(date.substring(8,10));
        System.out.println(day);
        return yearIsCurrentOrLater(year) && monthIsJuneOrJuly(month) && dayIsValid(day);
    }

    private boolean yearIsCurrentOrLater(int year){
        return year >= Calendar.getInstance().get(Calendar.YEAR);
    }

    private boolean monthIsJuneOrJuly(String month){
        return month.equals("06") || month.equals("07");
    }

    private boolean dayIsValid(int day){
        return (day > 0 && day <= 31);
    }

    private boolean departureDateIsLaterThanArrivalDate(String arrivalDate, String departureDate){
        //int arrivalDay = Integer.parseInt(arrivalDate.substring(8, 10));
        //int departureDay = Integer.parseInt(departureDate.substring(8, 10));
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date arrival = dateFormat.parse(arrivalDate);
            Date departure = dateFormat.parse(departureDate);
            return departure.after(arrival);
        } catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    private String[] chooseDates(){
        String arrivalDate;
        while (true){
            System.out.print("Give arrival date in a YYYY-MM-DD format: ");
            arrivalDate = scan.nextLine();
            if (arrivalDate.matches("\\d{4}-\\d{2}-\\d{2}")){
                if (dateIsValid(arrivalDate)){
                    break;
                } else{
                    System.out.println("INVALID ARRIVAL DATE!");
                }
            }
        }
        String departureDate;
        while (true){
            System.out.print("Give departure date in a YYYY-MM-DD format: ");
            departureDate = scan.nextLine();
            if (departureDate.matches("\\d{4}-\\d{2}-\\d{2}")){
                if (dateIsValid(departureDate) && departureDateIsLaterThanArrivalDate(arrivalDate, departureDate))
                {
                    break;
                } else{
                    System.out.println("INVALID DEPARTURE DATE!");
                }
            }
        }
        return new String[]{arrivalDate, departureDate};
    }

    public boolean choiceFromMenu(){
        System.out.print("Enter a number: ");
        switch (scan.nextLine()){
            case "1": addNewBooking(); break;
            case "2": System.out.println("TWO"); break;
            case "3": System.out.println("THREE"); break;
            case "4": System.out.println("FOUR"); break;
            case "5": System.out.println("QUIT"); return false;
            default: System.out.println("DEFAULT");
        }
        return true;
    }

}
