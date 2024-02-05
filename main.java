

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;



public class main {
	private static Connection connect=null;
	private static Statement statement=null;
	private static ResultSet resultSet=null;
	private static int updater=0;

	final private static String host ="jdbc:postgresql://10.98.98.61:5432/group21";
	final private static String user ="group21";
	final private static String password ="8C%Rjj#D8Lff&V8r";


	public static void main(String[] args) {
		try (
				Connection connection = DriverManager.getConnection(host, user, password)) {

			System.out.println("Java JDBC PostgreSQL Example");
			System.out.println("Connected to PostgreSQL database!");
			System.out.println("Welcome to Group21's JAVA PROJECT");
			Scanner scanner = new Scanner(System.in); 
			System.out.println();
			Statement statement = connection.createStatement();

			Methods utils=new Methods();
			int userInput=0;
			String status;
			// In this part now we can create our menu.
			while(userInput!=5) {
				System.out.println("\n");
				//This method prints the menu for user
				utils.MenuPrinter();
				System.out.println("Please enter an integer");

				try {
					userInput=scanner.nextInt();
				}catch(Exception e) {
					System.out.println("Input is not an integer");
				}
				if (userInput==1) {
					//This is the listing part
					utils.printer(1);
					int listUserInput = 0;
					try {
						listUserInput=scanner.nextInt();
					}catch(Exception e) {
						System.out.println("Input is not an integer");
					}

					if(listUserInput==1) {
						resultSet=statement.executeQuery("select * from employee order by employeeid asc");

						utils.writeResults(resultSet,1);
					}else if(listUserInput==2) {
						resultSet=statement.executeQuery("select * from payment order by paymentid asc");	
						utils.writeResults(resultSet,2);
					}else if(listUserInput==3){
						resultSet=statement.executeQuery("select * from hotel order by hotelid asc");
						utils.writeResults(resultSet,3);
					}else {
						System.out.println("Please give a valid value");
					}
					System.out.println();
				}else if(userInput==2) {
					//This is the update employee part

					System.out.println("List will give you the employees who has not used their all holiday rights?");
					resultSet=statement.executeQuery("select employeeid,name,surname,usedholidayent from employee where usedholidayent<30 order by "
							+ "employeeid asc");
					utils.writeResults(resultSet,4);
					utils.printer(2);

					try {
						int employeeid=scanner.nextInt();
						System.out.println("Now please to set used holiday collumn give an integer value");
						int usedHol=scanner.nextInt();	
						updater=statement.executeUpdate("update employee set usedholidayent="+usedHol+" where employeeid="+employeeid);
						System.out.println("Rows impacted : " + updater );
						resultSet=statement.executeQuery("select employeeid,name,surname,usedholidayent from employee where usedholidayent<30 "
								+ "order by employeeid asc");
						utils.writeResults(resultSet,4);

					}catch(Exception e) {
						System.out.println("Please give an integer value!");
					}

					
				}else if(userInput==3) {
					//This is the delete payment part
					resultSet=statement.executeQuery("select * from payment order by paymentid asc");
					utils.writeResults(resultSet,2);
					System.out.println("Select a payment id to delete it.");
					int paymentid=scanner.nextInt();
					updater=statement.executeUpdate("delete from payment where paymentid="+paymentid);
					resultSet=statement.executeQuery("select * from payment order by paymentid asc");
					utils.writeResults(resultSet,2);



				}else if(userInput==4) {
					//This is the insert hotel part
					System.out.println("To insert something to hotel you need to give some inputs.");
					resultSet=statement.executeQuery("select * from hotel order by hotelid asc");
					utils.writeResults(resultSet,3);
					System.out.println("\nBy looking this table please give a valid values");
					System.out.println("Please give a hotel id as an integer");
					int hotelid=scanner.nextInt();

					System.out.println("Please give a hotel name to your hotel as string without space.");
					String hotelname=scanner.next();

					System.out.println("Please give the name of the country as string");
					String country=scanner.next();		

					System.out.println("Please give the name of the city as string");
					String city=scanner.next();

					System.out.println("Please give the name of the district as string");
					String district=scanner.next();

					System.out.println("Please give a telephone number as an integer and max length is 9");
					int phone=scanner.nextInt();

					System.out.println("Please give the rating of the hotel as an integer between 0 and 5(0 and 5 is not included)");
					int rating=scanner.nextInt();

					try {
						updater=statement.executeUpdate("INSERT INTO hotel (hotelid, hotelname, country, city, district, phone, rating) "+
								"VALUES('"+hotelid+"', '"+hotelname+"', '"+country+"', '"+city+"', '"+district+"', '"+phone+"', '"+rating+"')");
						resultSet=statement.executeQuery("select * from hotel order by hotelid asc");
						utils.writeResults(resultSet,3);
						
					}catch (SQLException e1) {
						e1.printStackTrace();
					}

				}else {
					if(userInput==5) {
						
					}else {
						System.out.println("It is a wrong input please select a valid one!");
						userInput=6;
					}
					
				}


				if(userInput==5) {
					userInput=5;
				}else {
					System.out.println("Do you want to select another function?(Yes/No)");
					status=scanner.next();
					if(status.equalsIgnoreCase("YES")) {
						userInput=-1;
					}else if(status.equalsIgnoreCase("NO")) {
						userInput=5;
					}else {
						System.out.println("Please select Yes or No next time.");
						userInput=5;
					}
				}

			}
			System.out.println("\nSuccessful Quit from Group21's Database");
			Methods a=new Methods();
			a.close();

		} catch (SQLException e) {
        	System.out.println("Connection failure.");
        	e.printStackTrace();
        }
		
	}
}