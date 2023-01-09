/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package shopping_cart;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

/**
 *
 * @author Antonio
 */
public class Shopping_cart {

    /**
     * @param args the command line arguments
     */
    static final String URL = "jdbc:mysql://localhost:";
    static final String PORT = "3306";
    static final String DATABASE = "addbooks";
    static final String USER = "root";
    static final String PASSWORD = "";

    public static void main(String[] args) {
        // TODO code application logic here
        Scanner input1 = new Scanner(System.in);
        Scanner input2 = new Scanner(System.in);

        Connection connection = null;
        PreparedStatement pstatement = null;
        Statement statement = null;
        ResultSet result = null;
        ResultSetMetaData metadata = null;

        Map<String, Integer> cart = new HashMap<>();

        try {
            connection = DriverManager.getConnection(URL + PORT + "/" + DATABASE, USER, PASSWORD);
            statement = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

            result = statement.executeQuery("select ISBN, Title, Quantity from titles");

            metadata = result.getMetaData();

            int column = metadata.getColumnCount();

            int option = 0;

            do {
                System.out.println("\nSHOPPING CART\n"
                        + "1. List of books\n"
                        + "2. Add to cart\n"
                        + "3. Show cart\n"
                        + "4. Check out \n"
                        + "5. End\n"
                        + "Choose an option: ");
                option = input1.nextInt();

                switch (option) {

                    case 1:

                        for (int i = 1; i <= column; i++) {
                            System.out.printf("%-40s\t", metadata.getColumnName(i));
                        }

                        System.out.println();

                        while (result.next()) {
                            for (int i = 1; i <= column; i++) {
                                System.out.printf("%-40s\t", result.getObject(i));
                            }

                            System.out.println();
                        }

                        result.beforeFirst();

                        break;

                    case 2:

                        int amount = 0;
                        boolean exist = false;

                        System.out.println("Enter the ISBN: ");
                        String isbn = input2.nextLine();

                        while (result.next()) {
                            if (result.getString("ISBN").equalsIgnoreCase(isbn)) {
                                exist = true;
                                do {
                                    System.out.println("Enter the amount of books: ");
                                    amount = input1.nextInt();

                                    if (amount <= 0) {
                                        System.out.println("The amount must be at least one.");
                                    }

                                } while (amount <= 0);

                                int db_amount = result.getInt("Quantity");

                                int total = amount;

                                if (cart.containsKey(isbn)) {
                                    total += cart.get(isbn);
                                }

                                if (total > db_amount) {
                                    System.out.println("Not so many copies in stock");
                                } else {
                                    cart.put(isbn, total);
                                    System.out.println("The cart has been updated");
                                }
                            }

                        }

                        if (!exist) {
                            System.out.println("The book doesnt exist.");
                        }

                        result.beforeFirst();

                        break;

                    case 3:

                        if (!cart.isEmpty()) {

                            for (Map.Entry<String, Integer> entry : cart.entrySet()) {
                                String key = entry.getKey();
                                Integer value = entry.getValue();
                                System.out.println(key + " " + value + " units.");
                            }

                        } else {
                            System.out.println("The cart is empty");
                        }

                        break;

                    case 4:

                        if (!cart.isEmpty()) {

                            for (Map.Entry<String, Integer> entry : cart.entrySet()) {
                                String key = entry.getKey();
                                int value = (int) entry.getValue();

                                while (result.next()) {

                                    if (result.getString("ISBN").equalsIgnoreCase(key)) {
                                        result.updateInt("Quantity", result.getInt("Quantity") - value);
                                        result.updateRow();
                                        result.refreshRow();
                                    }
                                }

                            }

                            System.out.println("The purchase was successful");
                            cart.clear();

                        } else {
                            System.out.println("The cart is empty");
                        }

                        break;

                    case 5:

                        String answer;

                        if (!cart.isEmpty()) {

                            System.out.println("The cart is not empty");

                            System.out.println("Do you want to shop before leaving? y/n");
                            answer = input2.nextLine();

                            if (answer.equalsIgnoreCase("y")) {

                                pstatement = connection.prepareStatement("update titles set Quantity = Quantity - ? where ISBN = ?");

                                for (Map.Entry<String, Integer> entry : cart.entrySet()) {
                                    String key = entry.getKey();
                                    int value = (int) entry.getValue();

                                    pstatement.setInt(1, value);
                                    pstatement.setString(2, key);
                                    pstatement.executeUpdate();

                                }

                                System.out.println("The purchase was successful");

                            } else {

                                System.out.println("All books in the shopping cart have been removed.");
                            }

                        } else {
                            System.out.println("The cart is empty");
                        }

                        cart.clear();

                        break;
                }

            } while (option != 5);

        } catch (SQLException e) {
            e.getMessage();
        }
    }
}
