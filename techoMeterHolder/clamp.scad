
include <params.scad>


cubeHeight = scewHolderLeakHeight;
cubeWidth = 2*motorRadius + 2*margin + 2*scewHolderLeak;

hole_x = (motorRadius + margin)  + scewHolderLeak/2;

hole_y = scewHolderLeakHeight/2;

HIDE_CUBE_SIDE=100;

difference(){

    
    union(){

        cylinder(r=motorRadius+margin, h=thickness, center=true, $fn=8);

        cube([cubeHeight, cubeWidth , thickness], center=true);
    }

    cylinder(r=motorRadius, h=thickness+10, center=true, $fn=300);


    rotate([0,90,0]) translate([0, hole_x, 0]) cylinder(r=holeDiameter/2, h=scewHolderLeakHeight+10, center=true, $fn=100);
    rotate([0,90,0]) translate([0, -hole_x, 0]) cylinder(r=holeDiameter/2, h=scewHolderLeakHeight+10, center=true, $fn=100);

    cube([midSeparatorThickness, cubeWidth + 10 , thickness+10], center=true);
    
    // Uncomment to hide
    translate([HIDE_CUBE_SIDE/2,0,0]) cube([HIDE_CUBE_SIDE,HIDE_CUBE_SIDE,HIDE_CUBE_SIDE], center=true);

}
