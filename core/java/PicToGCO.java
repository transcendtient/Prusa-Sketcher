//import java.lang.InterruptedException;
import java.io.IOException;
import java.lang.Integer;
import java.io.File;
import java.nio.file.Files;

public class PicToGCO {
  private static final String picLoc="../../Pictures/";
	private static final String stlLoc="../stl/";
	private static final String scadLoc="../scad/";
	private static final String gcoLoc="../gcode/";

  //removes small spots, highly dependant on pic size
	private	int postProcess = 2;
  //do-pencil-drawing (BlurRadius Strength)
  private String gimpSettings = " 60 20";

  private String fullPath;
  private String picName;
  private String picBase;
  private String picDir;
	private String bmpName;	
	private String dxfName;
	private String epsName;
	private String stlName;
	private String gcoName;
  private String scadName;

  private PicToGCO(String args[])
   throws InterruptedException,IOException{
    //Argument correction
    if(args.length>0){//filename
      if(args.length>1){//postprocess
        try {
          this.postProcess=Integer.parseInt(args[1]);
        }
        catch (NumberFormatException e) {
          System.err.println(
           "No valid post-processing specified.\n"+
           "No GIMP pencil filter settings specified.\n"+
           "Using default settings.");
        }
      }
      if(args.length>2){//GIMP drawing settings
        try {
          args[2] = String.valueOf((Integer.parseInt(args[2])));
          args[3] = String.valueOf((Integer.parseInt(args[3])));
          this.gimpSettings=args[2]+" "+args[3];
        }
        catch (NumberFormatException e) {
          System.err.println(
           "No GIMP pencil filter settings specified.\n"+
           "Using default settings.");
        }
      }
    }
    else{
      System.err.println(
       "Illegal argument(s). Arguments with '*' are optional.\n"+
       "java PicToGCO <filename> <median>* <drawing1 drawing2>*\n"+
       "Example: java PicToGCO pic.jpg\n"+
       "Example: java PicToGCO pic.jpg 5 60 20");
      System.exit(1);
    }

    //directory and file names
    this.fullPath=args[0];//original path and file name
    File f = new File(fullPath);
    this.picName=f.getName();//original name
    System.out.println("picName="+picName);
    this.picBase=picName.replaceFirst("[.][^.]+$", "");//cleave ".ext"
    System.out.println("picBase="+picBase);
    //make directories ./picBase/SHA32(picBase)/
    picDir = mkdir(picBase)+"/"+picName;
    System.out.println("picDir="+picDir);
    File picFile = new File(picDir);
    if(!picFile.exists()){
      Files.copy(f.toPath(), picFile.toPath());
    }
    else{
      System.out.println("Your picture is already archived.\n"+
      "Using archived picture for script.");
    }
    System.out.println("Picture copied to:"+picDir);
    this.picBase=picDir.replaceFirst("[.][^.]+$", "");//cleave ".ext"
    this.bmpName=picBase+".bmp";	
    this.dxfName=picBase+".dxf";
    this.epsName=picBase+".eps";
    this.stlName=picBase+".stl";
    this.gcoName=picBase+".gco";
    this.scadName="dxf.scad";

    this.processPic();
  }

  //For archival purposes. Create directory with name of picture.
  //Subdirectory is CRC32 of the file to ensure uniqueness.
  private String mkdir(String dir) throws IOException{
    boolean result = false;
    dir=picLoc+dir;
    File theDir = new File(dir);
    // if the directory does not exist, create it
    if (!theDir.exists()) {
      System.out.println("creating directory: " + dir);
      try{
          theDir.mkdir();
          result = true;
       } catch(SecurityException se){
          System.out.println(se);
       }        
       if(result) {    
         System.out.println(dir+" DIR created");  
       }
    }
    else{
      System.out.println(dir+" already exists. Checking CRC.");
    }
    //theCRCDir = CRC of the bytestream of the picture
    String crcDir = dir+"/"+new FileCRC32(this.fullPath).getCRC();
    File theCRCDir = new File(crcDir);
    if (!theCRCDir.exists()) {
      System.out.println("creating directory: " + crcDir);
      try{
          theCRCDir.mkdir();
          result = true;
       } catch(SecurityException se){
          System.out.println(se);
       }        
       if(result) {    
         System.out.println(crcDir);  
       }
    }
    else{
      System.out.println(dir+" already exists.\n"+
      "FILE WON'T BE OVERWRITTEN. IF YOU GET A FILE NOT FOUND EXCEPTION "+
      "THIS IS A TWIN PICTURE. CONGRATULATIONS.");
    }
    return crcDir;
  }
  
  private void processPic()
   throws InterruptedException,IOException{
    //convert to grayscale BMP and simplify
    new ExecuteCommand(new String[]{
     "bash", "-c", "convert \""+picDir+
     "\" +dither -colorspace gray -auto-level -contrast-stretch 10%x20%"+
     "  \""+bmpName+"\""});
     
		//GIMP pencil-drawing filter
    new ExecuteCommand(new String[]{
     "bash", "-c", "gimp -i -b \"(do-pencil-drawing \\\""+
     bmpName+"\\\" "+gimpSettings+")\" -b \"(gimp-quit 0)\""});

		//post-process lumping and "despeckling"
    new ExecuteCommand(new String[]{
     "bash", "-c", "convert \""+bmpName+
     "\" +dither -colors 2 -median "+postProcess+" \""+
     bmpName+"\""});       
        
    //vectorize with potrace 
    new ExecuteCommand(new String[]{
     "bash", "-c", "potrace \""+bmpName+"\""});

    //convert to DXF with pstoedit
		new ExecuteCommand(new String[]{
     "bash", "-c", "pstoedit -dt -f dxf:-polyaslines \"" +
     epsName+"\" \""+dxfName+"\""});
    
		//convert to STL OpenSCAD
		new ExecuteCommand(new String[]{
     "bash", "-c", "openscad -D 'dxf=\""+dxfName+"\"' -o \""+
     stlName+"\" \""+scadLoc+scadName+"\""});
     
		//kisslicer launcher
    new ExecuteCommand(new String[]{
     "bash", "-c", "../../kiss/KISSlicer -o \""+
     gcoName+"\" \""+stlName+"\""});
  }

  public static void main (String args[])
   throws InterruptedException,IOException{
 		PicToGCO pic = new PicToGCO(args);	
	}
}

