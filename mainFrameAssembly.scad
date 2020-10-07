use <full_wheel.scad>;
use <wheel_skirt.scad>;
include <params.scad>;


/* Private vars */

wheel_y_translate = Y_DIM/2 + SPINE_THICKNESS/2 + WHEEL_SPINE_GAP;

bottom_wheel_z = -1 * ( (SPINE_HEIGHT/2) - WHEEL_MAX_RAD - BOTTOM_WHEEL_GAP_TO_FLOOR);
top_wheel_z = bottom_wheel_z + GAP_BETWEEN_SERVER_WHEELS + 2*WHEEL_MAX_RAD;

MainFrame();


module MainFrame(){

    cube([SPINE_WIDTH,SPINE_THICKNESS,SPINE_HEIGHT], center=true);

    translate([0,0,bottom_wheel_z]) WheelInFront();
    translate([0,0,top_wheel_z]) WheelInFront();

    translate([0,0,top_wheel_z])
        translate([0,wheel_y_translate,0]) 
            rotate([90,180,0]) 
                wheelSkirt();
}

module WheelInFront(){

    color("grey") 
        translate([0,wheel_y_translate,0]) 
            rotate([90,0,0]) 
                serverWheel();
}
