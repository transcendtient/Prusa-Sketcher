import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.io.*;

public class ExecuteShellCommand { 
	String gcodePath = "../../gcode/time/";
	String pronterface = "python ../../Printrun/printcore.py ";
	String serial = "/dev/ttyACM0 ";
	String command = pronterface+serial+gcodePath+"time.gcode";
	public static void main(String[] args) throws java.io.IOException{ 
    DateFormat dateFormat = new SimpleDateFormat("HH:mm");
    Calendar cal = Calendar.getInstance();
    String oldTime = "-1";
    int minutesToDwell=5;//minutes "catch-up" before pause to see the time
    while(true){//loop forever
      cal = Calendar.getInstance();
      System.out.println(dateFormat.format(cal.getTime()));
      String timeStr=dateFormat.format(cal.getTime());
      String hourL=timeStr.substring(0,1);
      String hourR=timeStr.substring(1,2);
      String minL=timeStr.substring(3,4);
      String minR=timeStr.substring(4,5);  
      if(oldTime.compareTo(timeStr)!=0){//time changed
        oldTime=timeStr;
        System.out.println(hourL+hourR+minL+minR+minutesToDwell);
        ExecuteShellCommand obj = new ExecuteShellCommand();
        if(minutesToDwell<=0)obj.catFile(hourL,hourR,minL,minR,obj.gcodePath,true);
        else {
			minutesToDwell--;
			obj.catFile(hourL,hourR,minL,minR,obj.gcodePath,false);
		}
        //to write time... we get get the digits, and in order we
      
        //print
        obj.executeCommand(obj.command);
        //delete time file
        try{ 
          File file = new File(obj.gcodePath+"time.gcode");
        	if(file.delete()){
            System.out.println(file.getName() + " is deleted!");
          }
          else{
            System.out.println("Delete operation is failed.");
          } 
        }
        catch(Exception e){ 
          e.printStackTrace();
        }
      }
    }
  }
 
	private String executeCommand(String command) { 
		StringBuffer output = new StringBuffer(); 
		Process p;
		try {
			p = Runtime.getRuntime().exec(command);
			p.waitFor();
			BufferedReader reader = 
          new BufferedReader(new InputStreamReader(p.getInputStream()));
      String line = "";			
			while ((line = reader.readLine())!= null) {
				output.append(line + "\n");
			}
 		}catch (Exception e){
			e.printStackTrace();
		} 
		return output.toString(); 
	}

  private void catFile(String a, String b, String c, String d, String path, boolean dwell) throws java.io.IOException{
    PrintWriter pw = new PrintWriter(new FileOutputStream(path+"time.gcode"));
    //pre G-Code
    BufferedReader br = new BufferedReader(new FileReader(path+"prefix.gcode"));
    String line = br.readLine();
    while (line != null) {
            pw.println(line);
            line = br.readLine();
    }
    br.close();
    //time follows
    br = new BufferedReader(new FileReader(path+a+".gcode"));
    line = br.readLine();
    while (line != null) {
            pw.println(line);
            line = br.readLine();
    }
    br.close();
    br = new BufferedReader(new FileReader(path+b+".gcode"));
    line = br.readLine();
    while (line != null) {
            pw.println(line);
            line = br.readLine();
    }
    br.close();
    br = new BufferedReader(new FileReader(path+"colon.gcode"));
    line = br.readLine();
    while (line != null) {
            pw.println(line);
            line = br.readLine();
    }
    br.close();
    br = new BufferedReader(new FileReader(path+c+".gcode"));
    line = br.readLine();
    while (line != null) {
            pw.println(line);
            line = br.readLine();
    }
    br.close();
    br = new BufferedReader(new FileReader(path+d+".gcode"));
    line = br.readLine();
    while (line != null) {
            pw.println(line);
            line = br.readLine();
    }
    br.close();
    if(dwell){
		br = new BufferedReader(new FileReader(path+"wipeDwell.gcode"));
		line = br.readLine();
		while (line != null) {
				pw.println(line);
				line = br.readLine();
		}
		br.close();
	}
	else{
		br = new BufferedReader(new FileReader(path+"wipe.gcode"));
		line = br.readLine();
		while (line != null) {
				pw.println(line);
				line = br.readLine();
		}
		br.close();
	}
	
    pw.close();
    System.out.println("All files have been concatenated into time");
  } 
}
