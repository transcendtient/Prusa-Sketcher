dxf="";
translate([0,0,0])
resize([140,0,0.3], auto=true)
resize([0,140,0.3], auto=true)
linear_extrude(height = 0.3, center = true)
   import (file = dxf);
