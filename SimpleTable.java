import java.awt.*;
import java.io.*;

public class SimpleTable {
   public static void main(String args[]) {
   	PrintHeader();
   }
   
   public static void PrintHeader() {
   	System.out.println("Name	  ID		  GPA");
   	System.out.println("---------------------");

   	String[] names = new String[5];
   	int[] ids = new int[5];
   	double[] gpas = new double[5];

   	names[0] = "John";
   	names[1] = "Mark";
   	names[2] = "Luke";
   	names[3] = "Matt";
   	names[4] = "Pete";

   	ids[0] = 42515;
   	ids[1] = 12415;
   	ids[2] = 45645;
   	ids[3] = 64567;
   	ids[4] = 97858;

   	gpas[0] = 4.0;
   	gpas[1] = 3.7;
   	gpas[2] = 3.8;
   	gpas[3] = 3.4;
   	gpas[4] = 3.9;

   	for (int i = 0; i < 5; i++) {
   		System.out.println(names[i] + "     " + ids[i] + "     " + gpas[i]);
   	}
   }
}