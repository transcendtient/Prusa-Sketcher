import java.io.BufferedReader;
import java.io.IOException;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.io.File;
import java.io.PrintWriter;
import java.io.FileOutputStream;
import java.io.FileReader;
import gnu.io.CommPortIdentifier;
import java.util.Enumeration;

public class Clock {
  //List of port names
  private static final String PORT_NAMES[] = {
    "/dev/ttyACM0",
    "/dev/ttyACM1",
    "/dev/ttyACM2",
    "/dev/ttyACM3",
    "/dev/ttyACM4",
    "/dev/ttyACM5",
    "/dev/ttyUSB0",
    "/dev/ttyUSB1",
    "/dev/ttyUSB2",
    "/dev/ttyUSB3",
    "/dev/ttyUSB4",
    "/dev/ttyUSB5"
  };
  
	private static final String GCODE_PATH = "../gcode/";
	private static final String PRONTERFACE =
      "../../Printrun/printcore.py ";

  //Setup our clock
  private Calendar calendar;
  private String oldTime = "-1";
  private DateFormat dateFormat = new SimpleDateFormat("HH:mm");
  private String time;
  
  //Buffer time to let machine catch up and allow pausing before erasing
  private int minutesToDwell=5;
  private boolean dwell=false;
  
  //Serial port used by ATMEGA type motherboard
  private String serial;

  //Terminal command that fetches Pronterface
  private String[] command =
      new String[] {"bash", "-c", ""};
  
	public static void main(String[] args)
      throws IOException, InterruptedException{    
    Clock clock = new Clock();
    
    //loop forever
    while(true){
      //Update clock: fetch time & ATMEGA port->format terminal command
      clock.updateCommand();
      
      //Check if it's a new minute
      if(clock.oldTime.compareTo(clock.time)!=0){
        clock.oldTime=clock.time;
        
        //Check if it's time to dwell
        if(clock.minutesToDwell<=0){
          clock.dwell=true;
        }
        else {
          clock.dwell=false;
          clock.minutesToDwell--;
        }
        //Sketch the time!
        clock.sketchTime();
      }
    }
  }
  
  private void sketchTime() throws IOException, InterruptedException{
    //build our GCODE file
    this.catFile();
    //print
    new ExecuteCommand(this.command);
    //delete time file
    try{ 
      File file = new File(this.GCODE_PATH+"time.gcode");
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

  private void updateCommand() {
    //Find the ATMEGA port
    this.findPort();
    //Format the terminal command
    this.command[2] = PRONTERFACE+this.serial+GCODE_PATH+"time.gcode";
    this.updateTime();
  }

  private void updateTime() {
    this.calendar = Calendar.getInstance();
    this.time=this.dateFormat.format(this.calendar.getTime());
  }

  //Assembles 4 digits, colon, and wipe or wipeDwell
  private void catFile() throws java.io.IOException{
    //Get the digits for the time
    String hourL=this.GCODE_PATH+this.time.substring(0,1);
    String hourR=this.GCODE_PATH+this.time.substring(1,2);
    String minL=this.GCODE_PATH+this.time.substring(3,4);
    String minR=this.GCODE_PATH+this.time.substring(4,5);
    
    PrintWriter pw =
        new PrintWriter(
            new FileOutputStream(this.GCODE_PATH+"time.gcode"));
    
    //pre G-Code
    BufferedReader br =
        new BufferedReader(
            new FileReader(this.GCODE_PATH+"prefix.gcode"));
    String line = br.readLine();
    while (line != null) {
            pw.println(line);
            line = br.readLine();
    }
    br.close();
    //time follows
    br = new BufferedReader(new FileReader(hourL+".gcode"));
    line = br.readLine();
    while (line != null) {
            pw.println(line);
            line = br.readLine();
    }
    br.close();
    br = new BufferedReader(new FileReader(hourR+".gcode"));
    line = br.readLine();
    while (line != null) {
            pw.println(line);
            line = br.readLine();
    }
    br.close();
    br = new BufferedReader(
        new FileReader(this.GCODE_PATH+"colon.gcode"));
    line = br.readLine();
    while (line != null) {
            pw.println(line);
            line = br.readLine();
    }
    br.close();
    br = new BufferedReader(new FileReader(minL+".gcode"));
    line = br.readLine();
    while (line != null) {
            pw.println(line);
            line = br.readLine();
    }
    br.close();
    br = new BufferedReader(new FileReader(minR+".gcode"));
    line = br.readLine();
    while (line != null) {
            pw.println(line);
            line = br.readLine();
    }
    br.close();
    if(this.dwell){
      br = new BufferedReader(
          new FileReader(this.GCODE_PATH+"wipeDwell.gcode"));
      line = br.readLine();
      while (line != null) {
          pw.println(line);
          line = br.readLine();
      }
      br.close();
    }
    else{
      br = new BufferedReader(new FileReader(
          this.GCODE_PATH+"wipe.gcode"));
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

  private void findPort() {  
    CommPortIdentifier portId = null;
    Enumeration portEnum = CommPortIdentifier.getPortIdentifiers();

    // iterate through, looking for the port
    while (portEnum.hasMoreElements()) {
        CommPortIdentifier currPortId =
            (CommPortIdentifier) portEnum.nextElement();
        for (String portName : PORT_NAMES) {
            if (currPortId.getName().equals(portName)) {
                portId = currPortId;
                this.serial = portName;
                return;
            }
        }
    }
    System.out.println("Could not find COM port.");
  }
}
