import java.util.zip.CRC32;
import java.util.zip.Checksum;
import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.lang.String;

public class FileCRC32{
  private String value;
	public FileCRC32(String picName) throws IOException{
    File pic = new File(picName);
		// get bytes from pic
		byte bytes[] = readFile(pic);
		 
		Checksum checksum = new CRC32();
		
		// update the current checksum with the specified array of bytes
		checksum.update(bytes, 0, bytes.length);
		 
		// get the current checksum value
		long checksumValue = checksum.getValue();
		 
		System.out.println("CRC32 checksum for input string is: " +
     checksumValue);
    value=String.valueOf(checksumValue);
	}

  public String getCRC(){
    return value;
  }

  public static byte[] readFile(File file) throws IOException {
    // Open file
    RandomAccessFile f = new RandomAccessFile(file, "r");
    try {
        // Get and check length
        long longlength = f.length();
        int length = (int) longlength;
        if (length != longlength)
          throw new IOException("File size >= 2 GB");
        // Read file and return data
        byte[] data = new byte[length];
        f.readFully(data);
        return data;
    }
    finally {
      f.close();
    }
  }
}
