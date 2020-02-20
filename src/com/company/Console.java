package com.company;

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

    private void addCustomerToDatabase(){
        System.out.print("Enter first name: ");
        String name = scan.nextLine();
        System.out.print("Enter last name: ");
        String lastName = scan.nextLine();
        System.out.print("Enter NHS number: ");
        String nhsNumber = scan.nextLine();
        this.query.addNewCustomer(name, lastName, nhsNumber);
    }

    private void selectPlaceToStayAt(){
        query.selectPlace();
        System.out.print("Enter a number: ");
        String choice = scan.nextLine();
        switch (choice){
            case "1": case "2": case "3": case "4": case "5":
                System.out.println("-- Location includes --");
                query.includedAtLocation(choice);
                break;
            default: System.out.println("DEFAULT");
        }
    }

    public boolean choiceFromMenu(){
        System.out.print("Enter a number: ");
        switch (scan.nextLine()){
            case "1": addCustomerToDatabase(); break;
            case "2": System.out.println("TWO"); break;
            case "3": System.out.println("THREE"); break;
            case "4": selectPlaceToStayAt(); break;
            case "5": System.out.println("QUIT"); return false;
            default: System.out.println("DEFAULT");
        }
        return true;
    }

}
