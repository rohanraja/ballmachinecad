include <params.scad>

RAD = WHEEL_MAX_RAD - (X_DIM / 2);
SKIRT_RAD = RAD + SKIRT_RADIUS_OFFSET;
SKIRT_WIDTH = BALL_TRAVEL_SPACE + 2 * RAIL_HEIGHT;


wheelSkirt();

module wheelSkirt()
{
    union()
    {
        ballSlideCurve();
        skirtSupport();
        dropTangent();

    }
}

module ballSlideCurve()
{
    rotate_extrude(angle = 65, convexity = 9) 
    2dSkirt(); 
}

module 2dSkirt()
{

    SKIRT_SQUARE_X = SKIRT_THICKNESS;

    RAIL_X = SKIRT_RAD - (SKIRT_SQUARE_X / 2) - (RAIL_WIDTH / 2);
    RAIL_Y = -(SKIRT_WIDTH / 2) + (RAIL_HEIGHT / 2);
    union()
    {

        translate([ SKIRT_RAD, 0, 0 ])
            square([ SKIRT_SQUARE_X, SKIRT_WIDTH ], center = true);

        // Fall protection rails
        translate([ RAIL_X, RAIL_Y, 0 ])
            square([ RAIL_WIDTH, RAIL_HEIGHT ], center = true);
        translate([ RAIL_X, -RAIL_Y, 0 ])
            square([ RAIL_WIDTH, RAIL_HEIGHT ], center = true);
    }
}




SUPP_HEIGHT = SKIRT_RAD + X_DIM / 2;

module skirtSupport(){


    color("red")
        supportCube();

    color("orange") 
        translate([SUPP_HEIGHT+41,-30,0]) rotate([0,0,90]) supportCube(83);

}

module supportCube(h=0){
    HOLE_OFFSET = 20;

        translate([ SKIRT_RAD, SUPP_HEIGHT / 2, 0 ])
            difference(){
                cube([ X_DIM, SUPP_HEIGHT-h, SKIRT_WIDTH ], center = true);
                supportHole();
                translate([0,-HOLE_OFFSET,0])supportHole();
                translate([0,HOLE_OFFSET,0])supportHole();
                translate([0,-2*HOLE_OFFSET,0])supportHole();
                translate([0,2*HOLE_OFFSET,0])supportHole();
            }
}
module supportHole()
{
    rotate([0,90,0]) cylinder(r=BOLT_DIM/2,h=20, center=true);
}

module dropTangent()
{
    translate([0,-(DROP_TANGENT_LENGTH/2),0]) 
        rotate([90,0,0]) 
//            color("blue") 
                linear_extrude(height = DROP_TANGENT_LENGTH, center = true, convexity = 10, twist =0)
                    2dSkirt();
}