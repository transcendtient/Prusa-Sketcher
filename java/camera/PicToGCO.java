import java.io.*;
import java.util.*;

public class PicToGCO {
	public static void main (String args[]) throws InterruptedException,IOException{
		//create object to start off
		PicToGCO obj = new PicToGCO();	
		String picName;	
		int postProcess;//removes small spots, highly dependant on pic size
		if(args==null) picName="face (copy).jpg";
		else picName=args[0];
		if(args[1]!=null)postProcess=Integer.parseInt(args[1]);
		else postProcess=5;
		String picLoc="../../pic/";
		String stlLoc="../../stl/camera/";
		String scadLoc="../../scad/camera/";
		String gcoLoc="../../gcode/camera/";
		String bmpName=picName.substring(0,picName.length()-4)+".bmp";	
		String dxfName=picName.substring(0,picName.length()-4)+".dxf";
		String epsName=picName.substring(0,picName.length()-4)+".eps";
		String stlName=picName.substring(0,picName.length()-4)+".stl";
		String scadName="dxf.scad";
		String gcoName=picName.substring(0,picName.length()-4)+".gco";
		//convert to grayscale BMP and simplify
        String[] grayscale = {"bash", "-c", "convert \""+picLoc+picName+"\" +dither -colorspace gray -auto-level -contrast-stretch 10%x30%  \""+picLoc+bmpName+"\""};
        obj.executeCommand(grayscale);
		//GIMP launcher
		String settings="60 20";//60-6=good for many light contrasting elements are lost. script settings affect image
		String[] gimp = {"bash", "-c", "gimp -i -b \"(do-pencil-drawing \\\""+picLoc+bmpName+"\\\" "+settings+")\" -b \"(gimp-quit 0)\""};
        obj.executeCommand(gimp);

		//post-process lumping and smoothing into 2 colors
        String[] despeckle  = {"bash", "-c", "convert \""+picLoc+bmpName+"\" +dither -colors 2 -median "+postProcess+" \""+picLoc+bmpName+"\""};
        obj.executeCommand(despeckle);
        
        
        //potrace launcher
        String[] potrace = {"bash", "-c", "potrace \""+picLoc+bmpName+"\""};
        obj.executeCommand(potrace);
        
        //convert to BMP launcher
        String[] bmp = {"bash", "-c", "convert \""+picLoc+bmpName+"\" \""+picLoc+picName+"\""};
        obj.executeCommand(bmp);
        //pstoedit launcher
		String[] pstoedit = {"bash", "-c", "pstoedit -dt -f dxf:-polyaslines \"" +picLoc+epsName+"\" \""+picLoc+dxfName+"\""};
		obj.executeCommand(pstoedit);
		//openscad launcher
		String[] openscad = {"bash", "-c", "openscad -D 'dxf=\""+picLoc+dxfName+"\"' -o \""+stlLoc+stlName+"\" \""+scadLoc+scadName+"\""};
		obj.executeCommand(openscad);
		//kisslicer launcher
        String[] kisslicer = {"bash", "-c", "../../kiss/KISSlicer -o \""+gcoLoc+gcoName+"\" \""+stlLoc+stlName+"\""};
        //obj.executeCommand(kisslicer);
	}

	private void executeCommand(String[] command) throws InterruptedException,IOException{    
        ProcessBuilder probuilder = new ProcessBuilder( command );
       // probuilder.redirectErrorStream(true);
       
        Process process = probuilder.start();
        
        //Read out dir output
StreamGobbler errorGobbler = new StreamGobbler(process.getErrorStream(), "");

// any output?
StreamGobbler outputGobbler = new StreamGobbler(process.getInputStream(), "");

// start gobblers
outputGobbler.start();
errorGobbler.start();
        System.out.printf("Running %s :\n",
                Arrays.toString(command));
        process.waitFor();
        //this.sleep(15);
    }
    
    private class StreamGobbler extends Thread {
    InputStream is;
    String type;

		private StreamGobbler(InputStream is, String type) {
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
    
    private void sleep(int seconds){
		try {
            Thread.sleep(seconds*1000);
        }
        catch (InterruptedException ie) {
            // Handle the exception
        }
	}
}

