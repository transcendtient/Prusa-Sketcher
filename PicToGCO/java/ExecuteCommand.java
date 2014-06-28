import java.util.Arrays;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.InputStream;

public class ExecuteCommand{
  public ExecuteCommand(String[] command)
   throws InterruptedException,IOException{     
    ProcessBuilder probuilder = new ProcessBuilder( command );
    // probuilder.redirectErrorStream(true);
    Process process = probuilder.start();

    //Read out dir output
    StreamGobbler errorGobbler =
     new StreamGobbler(process.getErrorStream(), "");

    // any output?
    StreamGobbler outputGobbler =
     new StreamGobbler(process.getInputStream(), "");

    // start gobblers
    outputGobbler.start();
    errorGobbler.start();
    System.out.printf("Running %s :\n", Arrays.toString(command));
    process.waitFor();
  }
  public class StreamGobbler extends Thread {
    private InputStream is;
    private String type;

    public StreamGobbler(InputStream is, String type) {
      this.is = is;
      this.type = type;
    }

    @Override
    public void run() {
      try {
        InputStreamReader isr = new InputStreamReader(is);
        BufferedReader br = new BufferedReader(isr);
        String line = null;
        while ((line = br.readLine()) != null)
          System.out.println(type + "> " + line);
      }
      catch (IOException ioe) {
        ioe.printStackTrace();
      }
    }
  }
}
