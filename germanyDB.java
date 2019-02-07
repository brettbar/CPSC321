// Brett Barinaga
// Sebastian Berven
// GermanyDB
// 12/12/2018
// This program will run a console interface to let users interact with the GermanyDB interface.
// They be able to pick from 5 options, to search, add, remove, modify the database, or to leave
// the program.
// NOTE: This document operates on the assumption that germanyDB.sql has already been ran to populate 
// the bbarinagaDB database.


import java.sql.*;
import java.awt.*;
import java.util.*;

public class germanyDB {
	public static void main(String[] args) throws SQLException {
		Scanner jin = new Scanner(System.in);

		String username;
		String password;

		System.out.print("Enter username -> ");
		username = jin.nextLine();

		System.out.print("Enter password -> ");
		password = jin.nextLine();

		Connection con = establishConnection("jdbc:mysql://cps-database.gonzaga.edu/bbarinagaDB", username, password);
		

		boolean done = false;

		printWelcomeMenu();
		while(!done) {
			int choice = printAndGetOptions(jin);
			switch (choice) {
				case 1: 
					search((jin), con);
				break;

				case 2:
					String executer;
					executer =  enter(jin);
					if (executer.equals("Nothing"))
						done = true;
					else
						executeTheQuery(executer, con); 			
				break;

				case 3:
					String executer1;
					executer1 =  remove(jin);
					if (executer1.equals("Nothing"))
						done = true;
					else
					executeTheQuery(executer1, con);
				break;

				case 4:
					String executer2;
					executer2 =  change(jin);
					if (executer2.equals("Nothing"))
						done = true;
					else
					executeTheQuery(executer2,con);
				break;

				case 5: 
					done = true;
					System.out.println();
					System.out.println("~Auf Wiedersehen!~");
					System.out.println();
				break;
			}
				

		}
		con.close();
	}

	// This function takes in login info and returns a connection to be used in main
	public static Connection establishConnection(String url, String username, String password) throws SQLException {
		Connection con = DriverManager.getConnection(url, username, password);
		return con;
	}

	// This function takes in a full query string and executes it on the current connection
	public static void executeTheQuery(String query, Connection con) throws SQLException {
		PreparedStatement st = con.prepareStatement(query);
		st.execute();
		st.close();
	}

	// Displays the standard greeting at the beginning
	public static void printWelcomeMenu() {
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println("===================================================================================");
		System.out.println("				Guten Tag!");
		System.out.println("			Und Wilkommen to GermanyDB");
		System.out.println("===================================================================================");
	}

	// Displays all menu options, gets user choice, and returns which option they select
	public static int printAndGetOptions(Scanner jin) {
		System.out.println();
		System.out.println("Please select one of the following options:");
		System.out.println("1. Search for statistics on German states, cities, politics, landmarks and more");
		System.out.println("2. Enter new information about Germany");
		System.out.println("3. Remove existing information");
		System.out.println("4. Change existing information");
		System.out.println("5. Exit GermanyDB");
		System.out.println();
		System.out.print("Enter your option (1-5) -> ");

		int choice; boolean finished = false;
		choice = jin.nextInt();

		do {
			if (choice == 1 || choice == 2 || choice == 3 || choice == 4 || choice == 5) {
				return choice;
			}
			else {
				System.out.println("Not a valid option");
				System.out.print("Enter your option (1-5) -> ");
				choice = jin.nextInt();
			}
		} while (!finished);
		return 5;
	}

	// This function will let the user search GermanyDB with a number of both basic
	// and advanced searches. It will then execute and display the query results in a list on screen.
	public static void search(Scanner jin, Connection con) throws SQLException {
		String searchQuery;
		searchQuery = "";
		boolean done = false;
		String one, two, three;
		one = " ";
		two = " ";
		three = " ";
		do {
			System.out.println();
			System.out.println("Welcome to the search function.");		
			System.out.println("Enter the corresponding number for the type of search you wish to do.");

			System.out.println("Option 1. Use common sample searches of GermanyDB");
			System.out.println("Option 2. Use special advanced searches of GermanyDB");
			System.out.println("Option 3. Go back to GermanyDB main menu ");
			System.out.print("-> ");
			int choice = jin.nextInt(); jin.nextLine();

			switch (choice) {
				case 1:
					System.out.println();
					System.out.println("Here are a list of commonly used searches of GermanyDB");
					System.out.println("1. Search for all states with population less than a specified value");
					System.out.println("2. Search for all states with population greater than a specified value");
					System.out.println("3. Search for all cities with population less than a specified value");
					System.out.println("4. Search for all cities with population greater than a specified value");
					System.out.println("5. Search for all political parties with membership greater than a specified value");
					System.out.println("6. Search for all landmarks of a particular type");
					System.out.println("7. Search for all landmarks in a particular states");
					System.out.println("8. Display the top X states by their population");
					System.out.println("9. Display the top X states by their number of cities");
					System.out.println("10. Display the top X states by their number of landmarks");
					System.out.println("11. Display the top X cities by their population");
					System.out.println("12. Display the top X political parties by their number of members");
					System.out.println("13. Display the top x political parties by their number of states led");
					System.out.println();
					System.out.println("Enter the corresponding number for the type of search you wish to do. Type 0 to exit");
					System.out.print("-> ");

					int sampleChoice = jin.nextInt(); jin.nextLine();
					boolean sampleDone = false;
					int num;
					String strong;					

					do {
						switch (sampleChoice) {
							case 0: 
								sampleDone = true;
							break;

							case 1:
								System.out.print("Enter population cutoff -> ");
								num = jin.nextInt(); jin.nextLine(); 
								searchQuery = "SELECT state_name, population FROM state WHERE population > " + num + ";";
								one = "state_name";
								two = "population";
								sampleDone = true;
							break;

							case 2:
								System.out.print("Enter population cutoff -> ");
								num = jin.nextInt(); jin.nextLine(); 
								searchQuery = "SELECT state_name, population FROM state WHERE population < " + num + ";";
								one = "state_name";
								two = "population";
								sampleDone = true;
							break;

							case 3:
								System.out.print("Enter population cutoff -> ");
								num = jin.nextInt(); jin.nextLine(); 
								searchQuery = "SELECT name, population FROM city WHERE population < " + num + ";";
								one = "state_name";
								two = "population";
								sampleDone = true;
							break;

							case 4:
								System.out.print("Enter population cutoff -> ");
								num = jin.nextInt(); jin.nextLine(); 
								searchQuery = "SELECT name, population FROM city WHERE population > " + num + ";";
								one = "state_name";
								two = "population";
								sampleDone = true;
							break;

							case 5:
								System.out.print("Enter membership cutoff -> ");
								num = jin.nextInt(); jin.nextLine(); 
								searchQuery = "SELECT party_name, membership FROM politics WHERE membership > " + num + ";";
								one = "party_name";
								two = "membership";
								sampleDone = true;
							break;

							case 6:
								System.out.print("Enter type of landmark -> ");
								strong = jin.nextLine();
								searchQuery = "SELECT lm_name, state FROM landmark WHERE type = \"" + strong + "\";";
								one = "lm_name";
								two = "state";
								sampleDone = true;
							break;

							case 7:
								System.out.print("Enter name of state -> ");
								strong = jin.nextLine();
								searchQuery = "SELECT lm_name, type FROM landmark WHERE state = \"" + strong + "\";";
								one = "lm_name";
								two = "type";
								sampleDone = true;
							break;

							case 8:
								System.out.print("Enter desired number of results -> ");
								num = jin.nextInt(); jin.nextLine(); 
								searchQuery = "SELECT state_name, population FROM state ORDER BY population desc LIMIT " + num + ";";
								one = "state_name";
								two = "population";
								sampleDone = true;
							break;

							case 9:
								System.out.print("Enter desired number of results -> ");
								num = jin.nextInt(); jin.nextLine(); 
								searchQuery = "SELECT state, COUNT(*) FROM city GROUP BY state ORDER BY COUNT(*) desc LIMIT " + num + ";";
								one = "state";
								two = "COUNT(*)";
								sampleDone = true;
							break;

							case 10:
								System.out.print("Enter desired number of results -> ");
								num = jin.nextInt(); jin.nextLine(); 
								searchQuery = "SELECT state, COUNT(*) FROM landmark GROUP BY state ORDER BY COUNT(*) desc LIMIT " + num + ";";
								one = "state";
								two = "COUNT(*)";
								sampleDone = true;
							break;

							case 11:
								System.out.print("Enter desired number of results -> ");
								num = jin.nextInt(); jin.nextLine(); 
								searchQuery = "SELECT name, population FROM city ORDER BY population desc LIMIT " + num + ";";
								one = "name";
								two = "population";
								sampleDone = true;
							break;

							case 12:
								System.out.print("Enter desired number of results -> ");
								num = jin.nextInt(); jin.nextLine(); 
								searchQuery = "SELECT party_name, membership FROM politics ORDER BY membership desc LIMIT " + num + ";";
								one = "party_name";
								two = "membership";
								sampleDone = true;
							break;

							case 13:
								System.out.print("Enter desired number of results -> ");
								num = jin.nextInt(); jin.nextLine(); 
								searchQuery = "SELECT party1, COUNT(*) FROM state_politics GROUP BY party1 ORDER BY COUNT(*) desc LIMIT " + num + ";";
								one = "party1";
								two = "COUNT(*)";
								sampleDone = true;
							break;

							default:
								System.out.println("Invalid option inputted: try again");
								System.out.println();
								System.out.println("Enter the corresponding number for the type of search you wish to do. Type 0 to exit");
								System.out.print("-> ");
								sampleChoice = jin.nextInt(); jin.nextLine();
							break;
						}
					} while (!sampleDone);

					PreparedStatement st = con.prepareStatement(searchQuery);
					ResultSet rs = st.executeQuery();
					while (rs.next()) {
						String first = rs.getString(one);
						String second = rs.getString(two);
						System.out.println(first + ", "+ second);
					}
					System.out.println();
					rs.close();
					st.close();
					done = true;
				break;

				case 2:
					System.out.println();
					System.out.println("Here are a list of advanced searches of GermanyDB");
					System.out.println("1. Diplay all political parties with their headquarters in a state they aren't leading.");
					System.out.println("2. Displays population densities of German States.");
					System.out.println("3. Display the political leaning of the different states.");
					System.out.println("4. Displays the landmarks per state.");
					System.out.println("5. Proportion of each party's control of government and population.");
					System.out.println();
					System.out.println("Enter the corresponding number for the search you wish to do. 0 to back out");
					System.out.print("-> ");

					int advancedChoice = jin.nextInt(); jin.nextLine();
					boolean advancedDone = false;

					boolean isOneString = false;
					boolean isTwoString = false;
					boolean isThreeString = false;

					do {
						switch (advancedChoice) {
							case 0:
								advancedDone = true;
							break;

							case 1:
								searchQuery = "SELECT DISTINCT p.party_name FROM state_politics sp JOIN politics p ON sp.party1 = p.abbr JOIN city c ON sp.state_name = c.state WHERE p.headquarters != c.name;";

								isOneString = true;
								isTwoString = false;
								isThreeString = false;

								one = "party_name";
								advancedDone = true;
							break;

							case 2:
								searchQuery = "SELECT state_name, population/area AS \"Citizens/km^2\" FROM state ORDER BY \"Citizens/km^2\" desc;";

								isOneString = false;
								isTwoString = true;
								isThreeString = false;

								one = "state_name";
								two = "Citizens/km^2";
								advancedDone = true;
							break;

							case 3:
								searchQuery = "SELECT sp.state_name, p.position FROM state_politics sp JOIN politics p ON sp.party1 = p.abbr;";

								isOneString = false;
								isTwoString = true;
								isThreeString = false;

								one = "sp.state_name";
								two = "p.position";
								advancedDone = true;
							break;

							case 4:
								searchQuery = "SELECT s.state_name, COUNT(*) FROM state s JOIN landmark l ON s.state_name = l.state GROUP BY s.state_name ORDER BY COUNT(*) desc;";
								
								isOneString = false;
								isTwoString = true;
								isThreeString = false;

								one = "s.state_name";
								two = "COUNT(*)";

								advancedDone = true;
							break;

							case 5:
								searchQuery = "SELECT p.party_name,";

								searchQuery += "(SELECT 100*SUM(bundesrat_votes)/(SELECT SUM(bundesrat_votes) FROM state_politics)";
								searchQuery += " FROM state_politics sp";
								searchQuery += " WHERE sp.party1 = p.abbr";
								searchQuery += " GROUP BY sp.party1";
								searchQuery += " ) AS Vote_Percent,";
								searchQuery += " (SELECT 100*membership/(SELECT SUM(population) FROM state)";
								searchQuery += " FROM politics p2";
								searchQuery += " WHERE p.party_name = p2.party_name";
								searchQuery += " ) AS Pop_Percent";
								searchQuery += " FROM politics p;";

								isOneString = false;
								isTwoString = false;
								isThreeString = true;

								one = "p.party_name";
								two = "Vote_Percent";
								three = "Pop_Percent";
								advancedDone = true;
							break;

							default:
								System.out.println("Invalid option inputted: try again");
								System.out.println();
								System.out.println("Enter the corresponding number for the search you wish to do. 0 to back out");
								System.out.print("-> ");

								advancedChoice = jin.nextInt(); jin.nextLine();
							break;
						}
					} while (!advancedDone);

					if (isOneString) {
						PreparedStatement oneStatement = con.prepareStatement(searchQuery);
						ResultSet oneRS = oneStatement.executeQuery();
						while (oneRS.next()) {
							String first = oneRS.getString(one);
							System.out.println(first);
						}
						System.out.println();
						oneRS.close();
						oneStatement.close();
					}
					else if (isTwoString) {
						PreparedStatement twoStatement = con.prepareStatement(searchQuery);
						ResultSet twoRS = twoStatement.executeQuery();
						while (twoRS.next()) {
							String first = twoRS.getString(one);
							String second = twoRS.getString(two);
							System.out.println(first + ", " + second);
						}
						System.out.println();
						twoRS.close();
						twoStatement.close();
					}
					else if (isThreeString) {
						PreparedStatement threeStatement = con.prepareStatement(searchQuery);
						ResultSet threeRS = threeStatement.executeQuery();
						while (threeRS.next()) {
							String first = threeRS.getString(one);
							String second = threeRS.getString(two);
							String third = threeRS.getString(three);
							System.out.println(first + ", " + second + ", " + third);
						}
						System.out.println();
						threeRS.close();
						threeStatement.close();
					}
					
					done = true;
				break;

				case 3: 
					done = true;
				break;
			} 
		} while (!done);
	}

	// This function will generate a query string that allows the user to 
	// enter additional data into the DB.
	public static String enter(Scanner jin) {
		int choice;
		String query;
		boolean done = false;

		query = "INSERT INTO ";

		String statePoliticQuery;
		statePoliticQuery = "INSERT INTO state_politics VALUES\n";

		System.out.println();
		System.out.println("Enter the corresponding number below. Would you like to add a: ");
		System.out.print("1. State, 2. City, 3. Political party, or 4. Landmark or 5. Exit -> ");
		choice = jin.nextInt();
		jin.nextLine();
		
		do {
			switch (choice) {
				case 1:
					String state_name;
					String capital;
					int area;
					int population;

					String party1;
					String party2;
					String bundesrat_votes;

					System.out.print("What is the name of the state? -> ");
					state_name = jin.nextLine();
					
					System.out.print("What is the capital of the state? -> ");
					capital = jin.nextLine();
					
					System.out.print("What is the area of the state? -> ");
					area = jin.nextInt();

					System.out.print("What is the population of the state -> ");
					population = jin.nextInt();
					jin.nextLine();

					System.out.println();
					System.out.println("NOTE: State Political Info, if you don't want to enter these type NULL");

					System.out.print("What is the majority political party of the state? -> ");
					party1 = jin.nextLine();

					System.out.print("What is the runner-up political party of the state? -> ");
					party2 = jin.nextLine();

					System.out.print("How many bundesrat votes does the state have? -> ");
					bundesrat_votes = jin.nextLine();

					query += "state VALUES\n";
					query += "(\"" + state_name + "\", \"" + capital + "\", " + area + ", " + population + ");";

					statePoliticQuery += "(\"" + state_name + "\", \"" + party1 + "\", \"" + party2 + "\", " + bundesrat_votes + ");";

					System.out.println();
					System.out.println("Adding your State now...");
					done = true;
				break;

				case 2:
					String name;
					String state;
					int cpopulation;

					System.out.print("What is the name of the city? -> ");
					name = jin.nextLine();

					System.out.print("What state is the city in? -> ");
					state = jin.nextLine(); 

					System.out.print("What is the population of the city -> ");
					cpopulation = jin.nextInt();
					jin.nextLine();

					query += "city VALUES\n";
					query += "(\"" + name + "\", \"" + state + "\", " + cpopulation + ");";

					System.out.println();
					System.out.println("Adding your city now...");
					done = true;
				break;

				case 3: 
					String party_name;
					String abbr;
					String leader;
					int membership;
					String headquarters;
					String position;

					System.out.print("What is the name of the political party? -> ");
					party_name = jin.nextLine();

					System.out.print("What is the party name abbreviated? -> ");
					abbr = jin.nextLine();

					System.out.print("Who is the party leader? -> ");
					leader = jin.nextLine();

					System.out.print("How many members does the party have -> ");
					membership = jin.nextInt();
					jin.nextLine();

					System.out.print("What city is the party headquarters in? -> ");
					headquarters = jin.nextLine();

					System.out.println("What is the party position?");
					System.out.println("(options: Center, Center-left, Center-right, Syncretic,"); 
					System.out.println("Left-wing, Right-wing, Far-left, Far-right, Apolitical)");
					System.out.print("-> ");
					position = jin.nextLine();

					query += "politics VALUES\n";
					query += "(\"" + party_name + "\", \"" + abbr + "\", \"" + leader + "\", " + membership + ", \"" + headquarters + "\", \"" + position + "\", );";

					System.out.println();
					System.out.println("Adding your party now...");
					done = true;
				break;

				case 4:	
					String type;
					String lmName;
					String lmState;

					System.out.println("What kind of landmark is it?");
					System.out.println("(options: castle, cathedral, mountain, monument, park)");
					System.out.print("-> ");
					type = jin.nextLine();

					System.out.print("What is the name of the landmark? -> ");
					lmName = jin.nextLine();

					System.out.print("What state is the landmark in? -> ");
					lmState = jin.nextLine();

					query += "landmark VALUES\n";
					query += "(\'" + type + "\', \'" + lmName + "\', \'" + lmState + "\');";

					System.out.println();
					System.out.println("Adding your landmark now...");
					done = true;
				break;

				case 5:
					query = "Nothing";
					done = true;
				break;
				default: 
					System.out.println("Not a valid option, try again");
					System.out.println();
					System.out.println("Enter the corresponding number below. Would you like to add a: ");
					System.out.print("1. State, 2. City, 3. Political party, or 4. Landmark or 5. Exit -> ");
					choice = jin.nextInt();
				break;
			}
		} while (!done);

		//System.out.print(query);
		return query;
	}

	// This function generates a query string which allows the user to remove a row from the database
	public static String remove(Scanner jin) {
		int choice; 
		boolean done = false;
		String removeQuery;
		removeQuery = "DELETE FROM ";

		System.out.println("What would you like to delete from GermanyDB?");
		System.out.println("Enter the number corresponding to the option: ");
		System.out.println("1. A state, 2. A city, 3. A political party, 4. A landmark, 5. Exit menu");
		System.out.print("-> ");
		choice = jin.nextInt();
		jin.nextLine();

		do {
			switch (choice) {
				case 1:
					String stateTBDel;
					System.out.print("What is the name of the state you would like to delete? -> ");
					stateTBDel = jin.nextLine();

					removeQuery += "state WHERE state_name = \"" + stateTBDel + "\";";
					done = true;
				break;

				case 2:
					String cityTBDel;
					System.out.print("What is the name of the city you would like to delete? -> ");
					cityTBDel = jin.nextLine();

					removeQuery += "city WHERE name = \"" + cityTBDel + "\";";
					done = true;
				break;

				case 3:
					String partyTBDel;
					System.out.print("What is the name of the party you would like to delete? -> ");
					partyTBDel = jin.nextLine();

					removeQuery += "politics WHERE party_name = \"" + partyTBDel + "\";";
					done = true;
				break;

				case 4:
					String lmTBDel;
					System.out.print("What is the name of the landmark you would like to delete? -> ");
					lmTBDel = jin.nextLine();

					removeQuery += "landmark WHERE lm_name = \"" + lmTBDel + "\";";
					done = true;
				break;

				case 5:
					removeQuery = "Nothing";
					done = true;
				break;   

				default:
					System.out.println("Not a valid option");
					System.out.println("Enter the number corresponding to the option: ");
					System.out.println("1. A state, 2. A city, 3. A political party, 4. A landmark, 5. Exit menu");
					System.out.print("->");
					choice = jin.nextInt();
					jin.nextLine();
				break;
			}
		} while (!done);
		//System.out.print(removeQuery);
		return removeQuery;
	}

	// This function generates a string that allows the user to modify an existing row in the database
	public static String change(Scanner jin) {
		boolean done = false;
		int choice;
		String modifyQuery;

		modifyQuery = "UPDATE ";

		System.out.println("What would you like to modify in GermanyDB?");
		System.out.println("Enter the number corresponding to the option: ");
		System.out.println("1. A state, 2. A city, 3. A political party, 4. Exit menu");
		System.out.print("-> ");		
		choice = jin.nextInt();
		jin.nextLine();

		do {
			switch (choice) {
				case 1:
					String whichState;
					String newStateCapital;
					int newStateArea;
					int newStatePopulation;

					System.out.print("Which state would you like to modify -> ");
					whichState = jin.nextLine();
					System.out.print("Enter the updated capital -> ");
					newStateCapital = jin.nextLine();
					System.out.print("Enter the updated area -> ");
					newStateArea = jin.nextInt();
					jin.nextLine();
					System.out.print("Enter the updated state population -> ");
					newStatePopulation = jin.nextInt();
					jin.nextLine();

					modifyQuery += "state SET capital = \"" + newStateCapital +"\", area = " + newStateArea + ", population = " + newStatePopulation;
					modifyQuery += " WHERE state_name = \"" + whichState + "\";"; 

					done = true;
				break;

				case 2:
					String whichCity;
					String newCityState;
					int newCityPopulation;

					System.out.print("Which city would you like to modify -> ");
					whichCity = jin.nextLine();
					System.out.print("Enter the updated state which the city is in -> ");
					newCityState = jin.nextLine();
					System.out.print("Enter the updated city population -> ");
					newCityPopulation = jin.nextInt();
					jin.nextLine();

					modifyQuery += "city SET state = \"" + newCityState +"\", population = " + newCityPopulation;
					modifyQuery += " WHERE name = \"" + whichCity + "\";"; 

					done = true;
				break;

				case 3:
					String whichParty;
					String newLeader;
					int newMembership;
					String newHQ;
					String newPosition;

					System.out.print("Which political party would you like to modify -> ");
					whichParty = jin.nextLine();
					System.out.print("Enter the updated leader of the party -> ");
					newLeader = jin.nextLine();
					System.out.print("Enter the updated number of party members -> ");
					newMembership = jin.nextInt();
					jin.nextLine();
					System.out.print("Enter the updated HQ of the party -> ");
					newHQ = jin.nextLine();
					System.out.print("Enter the updated political platform of the party -> ");
					newPosition = jin.nextLine();

					modifyQuery += "politics SET leader = \"" + newLeader +"\", membership = " + newMembership;
					modifyQuery += ", headquarters = \"" + newHQ + "\", position = \"" + newPosition + "\"";
					modifyQuery += " WHERE party_name = \"" + whichParty + "\";"; 

					done = true;
				break;

				case 4:
					modifyQuery = "Nothing";
					done = true;
				break;

				default:
					System.out.println("Not a valid option");
					System.out.println("What would you like to modify in GermanyDB?");
					System.out.println("Enter the number corresponding to the option: ");
					System.out.println("1. A state, 2. A city, 3. A political party, 4. A landmark, 5. Exit menu");
					System.out.print("-> ");		
					choice = jin.nextInt();
					jin.nextLine();
				break;
			}
		} while (!done);
		//System.out.print(modifyQuery);
		return modifyQuery;
	}

}
