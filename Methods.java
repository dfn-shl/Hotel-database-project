import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;


public class Methods {
	private static Connection connect=null;
	private static Statement statement=null;
	private static ResultSet resultSet=null;
	private static int updater=0;
	
	
	public static void MenuPrinter() {
		System.out.println("Please select function from menu.");
		System.out.println("1-) List Tables");
		System.out.println("2-) Update Employee");
		System.out.println("3-) Delete From Payments");
		System.out.println("4-) Insert Hotel");
		System.out.println("5-) Quit Menu");
	}
	public static void writeResults(ResultSet resultset,int index) throws SQLException{
		if(index==1) {
			System.out.println("\n\t\tEmployee Table\n");
			System.out.println("EmployeeId | Name | Surname | WorkingHour | HotelID | DutyID | TotalHoliday | UsedHoliday |");
		}else if(index==2) {
			System.out.println("\n\t\t Payment Table\n");
			System.out.println("PaymentID | PaymentMethod | GuestID | ReservationID |");
			
		}else if(index==3) {
			System.out.println("\n\t\t Hotel Table\n");
			System.out.println("HotelId | HotelName | Country | City | Phone | Rating | District |");
		}else if(index==4) {
			System.out.println("\n\t\tEmployee Table\n");
			System.out.println("EmployeeId | Name | Surname | UsedHoliday |");
		}
			
			
		ResultSetMetaData rsmd=resultset.getMetaData();
		int totalCollumnNum=rsmd.getColumnCount();
		System.out.println("-------------------------------------------------------------------------------");
		while(resultset.next()) {
			for(int i=1;i<=totalCollumnNum;i++) {

				System.out.print("| "+resultset.getString(i)+ "\t  ");
		
			}
			System.out.println();
		}
		System.out.println("-------------------------------------------------------------------------------");
	}
	
	public static void printer(int i) {
		if(i==1) {
			System.out.println("\nDo you want to list which table? ");
			System.out.println("1- Employee \n2- Payment \n3- Hotel");
			System.out.println("Please enter an integer:\n");
		}else if(i==2) {
			System.out.println("Now you can update Used Holiday Ent");
			System.out.println("Please first select the employee id of the person");
			System.out.println("Who do you want to update please give the \"Employee id\" of him/her.");
		}
	}

	public static void MenuSelection(int index) {
		
	}
	/*
	 //Even though we tried to create method in this class it didn't work perfectly.
	public static void insert(int a,String b,String c,String d,String e,int f,int g )  {
		try {
			updater=statement.executeUpdate("INSERT INTO hotel (hotelid, hotelname, country, city, district, phone, rating) "+
					 "VALUES('"+a+"', '"+b+"', '"+c+"', '"+d+"', '"+e+"', '"+f+"', '"+g+"')");
			resultSet=statement.executeQuery("select * from hotel order by hotelid asc");
			writeResults(resultSet);
			
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
	}
	*/
	public static void close() {
		try {
			if(resultSet!=null) {
				resultSet.close();
			}
			if(statement!=null) {
				statement.close();
			}
			if(connect!=null) {
				connect.close();
			}
		}catch(Exception e) {
			System.out.println("\nAn Error Occurred");
		}
		
	}
	
	
}