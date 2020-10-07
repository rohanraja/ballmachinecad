include <params.scad>

arnWidth = 8;
armLength = 50.0;
armThickness = 4;

numHolesPerRow = 8;
numRows = 1; 
holeXMargin = 3;
holeYMargin = 3;



xStep = ( armLength - (2*holeXMargin) - holeDiameter )/ (numHolesPerRow - 1);

yStep = ( arnWidth - (2*holeYMargin) - holeDiameter )/ (numRows - 1);

xLeft = armLength/2 - holeXMargin - holeDiameter/2;
yTop = arnWidth/2 - holeYMargin - holeDiameter/2;



difference(){
    cube([armLength, arnWidth , armThickness],center=true);

    for (i = [0:numRows-1]) {

        for (j = [0:numHolesPerRow-1]) {

            x = xLeft - j*xStep;
            y = yTop - i*yStep;
            if(numRows == 1){
                translate([x,0,0]) hole();
            }
            else{
               translate([x,y,0]) hole();

            }

        }
    }
}

module hole(){
    cylinder(r=holeDiameter/2, h=armThickness+10, center=true, $fn=100);
}