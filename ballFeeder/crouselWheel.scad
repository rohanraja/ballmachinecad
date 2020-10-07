include <params.scad>

CROUSEL_WHEEL_DIM = 210;
CROUSEL_WHEEL_RAD = CROUSEL_WHEEL_DIM / 2;
CROUSEL_WHEEL_THICKNESS = 10;
CROUSEL_HOLES_COUNT = 4;

CROUSEL_HOLES_SPREAD = 135;
CROUSEL_CENTER_RADIUS = 10.2;

BASE_PLATE_FACELETS = 40;

BALL_HOLE_MARGIN = 2;

deflectorHeight = 15;
deflectorThickness = 4;
deflectorLength = 50;

baseSupportWidth = 65;
baseSupportLength =150;

CROUSEL_HOLE_RADIUS = TENNIS_BALL_CURAVTURE_RAD + BALL_HOLE_MARGIN;


difference(){

   basePlate();

   allBallHoles();
    
    centerHole();

    screwHoleCylinders();
}

ballDeflectors();

baseSupportRect();

module basePlate(){

    cylinder(r=CROUSEL_WHEEL_RAD, h=CROUSEL_WHEEL_THICKNESS, center=true, $fn=BASE_PLATE_FACELETS);
}

module allBallHoles(){

    for (i = [0:(360 / CROUSEL_HOLES_COUNT):360]) {

        theta = i;
        x = (CROUSEL_HOLES_SPREAD / 2) * cos(theta);        
        y = (CROUSEL_HOLES_SPREAD / 2) * sin(theta);        
        translate([ x, y, 0 ]) ballHoleCylinder();
    }
}

module ballHoleCylinder(){

    cylinder(r=CROUSEL_HOLE_RADIUS, h=CROUSEL_WHEEL_THICKNESS + 10, center=true);
}

module centerHole(){

    cylinder(r=CROUSEL_CENTER_RADIUS, h=CROUSEL_WHEEL_THICKNESS + 10, center=true);
}

module
screwHoleCylinders()
{
    echo(Y_DIM); 

    for (i = [0:(360 / BOLT_COUNT):360]) {

        theta = i;
        x = (BOLT_SPREAD / 2) * cos(theta);        y = (BOLT_SPREAD / 2) * sin(theta);        translate([ x, y, 0]) cylinder(r = BOLT_DIM / 2, h = CROUSEL_WHEEL_THICKNESS + 10, center=true);    
        
    }
        
}

module ballDeflectors(){

    for (i = [0:(360 / CROUSEL_HOLES_COUNT):360]) {

        theta = i + (360 / CROUSEL_HOLES_COUNT )/2;

        x = (CROUSEL_HOLES_SPREAD / 2) * cos(theta);        
        y = (CROUSEL_HOLES_SPREAD / 2) * sin(theta);        
        rotate([0,0,0])translate([ x, y, 0 ]) ballDeflectorsCube(theta);
    }
}


module ballDeflectorsCube(z){

    rotate([0,0,z])translate([0,0,deflectorHeight/2]) cube([deflectorLength, deflectorThickness, deflectorHeight], center=true);
}

module baseSupportRect(){
   translate([0,0,-5]) cube([baseSupportLength,baseSupportWidth,10], center=true);
}