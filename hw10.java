// Brett Barinaga
// CPSC 321
// HW10 
// 11/19/2018

// =======================================================================================
// SELF NOTES: 
// left off: just started option 3, (look at last method)
// just declared needed types, and need to figure out 
// how to get data from preparedStatement query and put them into
// those variables
// =======================================================================================

import java.sql.*;
import java.awt.*;
import java.util.*;


public class hw10 {
	// Main method, handels all connection steps with the MySQL database
	public static void main(String[] args) throws Exception {
		Scanner cin = new Scanner(System.in);

		int choice;

		// create connection
		String url = "jdbc:mysql://cps-database.gonzaga.edu/bbarinagaDB";
		String user = "bbarinaga";
		String pass = "Mithrandir77";
		Connection con = DriverManager.getConnection(url, user, pass);

		do {
			printMenu();
			choice = getChoice(cin);
			if (choice == 1)
				listCountries(con);
			else if (choice == 2)
				addCountry(con, cin);
			else if (choice == 3)
				findCountries(con, cin);
			else if (choice == 4) 
				updateCountries(con, cin);
			else 
				choice = 5;
		} while (choice != 5);

		con.close();
	}

	// This method prints the menu described in Part 2.1
	public static void printMenu() {
		System.out.println();
		System.out.println("1. List countries");
		System.out.println("2. Add country");
		System.out.println("3. Find countries based on gdp and inflation");
		System.out.println("4. Update country's gdp and inflation");
		System.out.println("5. Exit");
		System.out.print("Enter your choice (1-5): ");
	}

	// This method takes in a scanner and returns the choice from the user
	public static int getChoice(Scanner cin) {
		return cin.nextInt();
	}

	// This method prints out all the countries currently stored in the database
	// In the form: United States (US)
	public static void listCountries(Connection con) throws SQLException {
		Statement st = con.createStatement();
		String query = "SELECT country_name, code FROM country";
		ResultSet rs = st.executeQuery(query);

		System.out.println();
		while (rs.next()) {
			String country_name = rs.getString("country_name");
			String code = rs.getString("code");
			System.out.println(country_name + " ("  + code + ")");
		}
		System.out.println();
		rs.close();
		st.close();
	}

	// This method allows the user to add countries to the database. It checks the entered 
	// country code to ensure no duplicate countries are allowed in
	public static void addCountry(Connection con, Scanner jin) throws SQLException {
		Statement st = con.createStatement();
		String query = "SELECT code FROM country";
		ResultSet rs = st.executeQuery(query);

		boolean done = false;
		String code;
		String country_name;
		int gdp;
		double inflation;

		String inCode;
		String inCountry;
		int inGDP;
		double inInflation; 

		do {
			System.out.print("Country code................: ");
			inCode = jin.next();
			jin.nextLine();
			while (rs.next()) {
				code = rs.getString("code");
				if (inCode.equals(code)) {
					System.out.println("ERROR: Country code already exists...");
					done = true;
					break;
				}
			}
			rs.close();
			st.close();
			code = inCode;
			if (!done) {
				System.out.print("Country name................: ");
				inCountry = jin.nextLine();
				country_name = inCountry;

				System.out.print("Country per capita gdp (USD): ");
				inGDP = jin.nextInt();
				gdp = inGDP;

				System.out.print("Country inflation (pct).....: ");
				inInflation = jin.nextDouble();
				inflation = inInflation;

				PreparedStatement stmt = con.prepareStatement("INSERT INTO country(code, country_name, gdp, inflation) VALUES (?,?,?,?)");
				stmt.setString(1, code);
				stmt.setString(2, country_name);
				stmt.setInt(3, gdp);
				stmt.setDouble(4, inflation);

				stmt.execute();

				stmt.close();
			}	
			done = true;
		} while (!done);
	}

	// This method searches for countries based off of their gdp and inflation
	// and ranks the resulting set accordingly, limiting the result to the specified
	// number of countries
	public static void findCountries(Connection con, Scanner jin) throws SQLException {
		int countriesToDisplay;
		int minGDP;
		double maxInflation;

		System.out.println();

		System.out.print("Number of countries to display: ");
		countriesToDisplay = jin.nextInt();

		System.out.print("Minimum per capita gdp (USD)..: ");
		minGDP = jin.nextInt();	

		System.out.print("Maximum inflation (pct).......: ");
		maxInflation = jin.nextDouble();

		PreparedStatement stmt = con.prepareStatement("SELECT *" + 
													  "FROM country " + 
													  "WHERE gdp >= ? AND inflation <= ? " +
													  "ORDER BY gdp DESC, inflation " +
													  "LIMIT ?");
		stmt.setInt(1, minGDP);
		stmt.setDouble(2, maxInflation);
		stmt.setInt(3, countriesToDisplay);

		ResultSet rs = stmt.executeQuery();

		String country_name;
		String code;
		String gdp;
		String inflation;

		System.out.println();
		while (rs.next())
		{
			country_name = rs.getString("country_name");
			code = rs.getString("code");
			gdp = rs.getString("gdp");
			inflation = rs.getString("inflation");

			System.out.println(country_name + " (" + code + "), " + gdp + ", " + inflation);
		}
		System.out.println();

		rs.close();
		stmt.close();		
	}

	// This method checks to see if an inputted country code is there, and if so, updates 
	// the country's gdp and inflation with values inputted by the user
	public static void updateCountries(Connection con, Scanner jin) throws SQLException {
		String cCode;
		int cGDP;
		double cInflation;

		String code;
		boolean done = false;
		boolean found = false;
		String updater;

		Statement st = con.createStatement();
		String query = "SELECT code FROM country";
		ResultSet rs = st.executeQuery(query);

		System.out.println();

		do {
			System.out.print("Country code................: ");
			cCode = jin.next();

			while (rs.next()) {
				code = rs.getString("code");
				if (cCode.equals(code)) {
					found = true;
				} 
			}
			if (!found) {
				System.out.println("ERROR: Country code doesn't exists...");
				done = true;
				break;
			}
			rs.close();
			st.close();
			if (!done && found) {
				System.out.print("Country per capita gdp (USD): ");
				cGDP = jin.nextInt();	

				System.out.print("Country inflation (pct).....: ");
				cInflation = jin.nextDouble();

				updater = "UPDATE country SET gdp=?, inflation=? WHERE code=?";
				PreparedStatement ps = con.prepareStatement(updater);

				ps.setInt(1, cGDP);
				ps.setDouble(2, cInflation);
				ps.setString(3, cCode);

				ps.execute();
				System.out.println("Update complete...");
				done = true;
			}
		} while (!done);
	}
}

