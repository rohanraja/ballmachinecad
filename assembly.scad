use <mainFrameAssembly.scad>;
include <params.scad>;

TILT_ANGLE = 25; 

wheel_y_translate = Y_DIM/2 + SPINE_THICKNESS/2 + WHEEL_SPINE_GAP;

rotate([0,-TILT_ANGLE,0])
    translate([SPINE_WIDTH/2,0,SPINE_HEIGHT/2]) 
        MainFrame();

color("green") translate([-190,wheel_y_translate,300]) cylinder(r=TENNIS_BALL_CURAVTURE_RAD, h=200);