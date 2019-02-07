   // Brett Barinaga
  // CPSC 321
 // 12/2/2018
// hw11.java

import java.awt.*;
import java.util.*;
import java.io.*;

public class hw11 {

	public static int n = 10000; // NUMBER OF ROWS DESIRED

	public static void main(String[] args) throws IOException {
		BufferedWriter file = new BufferedWriter(new FileWriter("hw11-data-" + n +".sql"));	
		generateData(n, file);
		file.close();
	}

	public static void generateData(int numRows, BufferedWriter file) throws IOException {
		int employee_id;
		int salary;
		String[] title = new String[4];

		title[0] = "engineer";
		title[1] = "manager";
		title[2] = "salesperson";
		title[3] = "administrator";

		String command; 

		command = "INSERT INTO Employee VALUES\n";

		int j = 0;
		for (int i = 0; i < (numRows - 1); i++) {
			employee_id = i + 1;
			salary = (int)(Math.random() * 150000 + 12000);
			
			if (j == 4)
				j = 0;
			command += "(" + employee_id + ", " + salary + ", " + "\"" + title[j] + "\"),\n";
			j++;
		}
		employee_id = numRows;
		salary = (int)(Math.random() * 150000 + 12000);
		if (j == 4)
			j = 0;
		command += "(" + employee_id + ", " + salary + ", " + "\"" + title[j] + "\");";
		j++;
		file.write(command);
	}
}