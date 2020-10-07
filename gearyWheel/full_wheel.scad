include <params.scad>

OUTER_CIRCLE_FN = 60;

/* Private Vars */

RAD = WHEEL_MAX_RAD - (X_DIM / 2);

DIST_TO_CHORD =
    sqrt(((BALL_CURAVTURE_RAD * BALL_CURAVTURE_RAD) - ((Y_DIM * Y_DIM) / 4)));
// We want the main rectangle's side to form a chord with the curvature circle

BALL_TRANS = RAD + (X_DIM / 2) + DIST_TO_CHORD;

FILLER_WIDTH = RAD - (X_DIM / 2);
FILLER_X = FILLER_WIDTH / 2;

serverWheel();

module serverWheel()
{

    /* Model Definition */

    difference()
    {

        rotate_extrude(angle = 360, convexity = 9, $fn=OUTER_CIRCLE_FN) 
        difference()
        {

            union()
            {

                difference()
                {

                    translate([ RAD, 0, 0 ])
                        square([ X_DIM, Y_DIM ], center = true);

                    translate([ BALL_TRANS, 0, 0 ])
                        circle(BALL_CURAVTURE_RAD, $fn = CURVE_FACETS);
                }

                translate([ FILLER_X, 0 ])
                    square([ FILLER_WIDTH, FILLER_HEIGHT ], center = true);
            }

            if (MAKE_HALF == true) {
                halfVolumneBlocker();
            }
        };

        // Flange screw holes
        screwHoleCylinders();
        
        lightnerHoleCylinders();

        // Center hole
        translate([ 0, 0, -Y_DIM / 2 ]) cylinder(r = CENTER_DIM / 2, h = Y_DIM);
        
        treads();

    }
    
}

module
halfVolumneBlocker()
{

    translate([ WHEEL_MAX_RAD / 2, -Y_DIM / 2 ])
        square([ WHEEL_MAX_RAD, Y_DIM ], center = true);
}

module
screwHoleCylinders()
{

    for (i = [0:(360 / BOLT_COUNT):360]) {

        theta = i;
        x = (BOLT_SPREAD / 2) * cos(theta);        y = (BOLT_SPREAD / 2) * sin(theta);        translate([ x, y, -Y_DIM / 2 ]) cylinder(r = BOLT_DIM / 2, h = Y_DIM);    }
        
}

LIGHTER_HOLE_COUNT = 8;
LIGHTER_SPREAD = 70;
LIGHTER_DIM = 23;

module
lightnerHoleCylinders()
{

    for (i = [0:(360 / LIGHTER_HOLE_COUNT):360]) {

        theta = i;
        x = (LIGHTER_SPREAD / 2) * cos(theta);        y = (LIGHTER_SPREAD / 2) * sin(theta);        translate([ x, y, -Y_DIM / 2 ]) cylinder(r = LIGHTER_DIM / 2, h = Y_DIM);    }
        
}


TREAD_OFFSET = 10;
TREAD_COUNT = OUTER_CIRCLE_FN/2;
TREAD_WIDTH = 5;

module
treads()
{
    for (i = [0:(360 / TREAD_COUNT):360]) {

        theta = i;
        rotate([ 0, 0, theta ]) tread_single();   
        
    }
        
}

module
tread_single()
{
        translate([WHEEL_MAX_RAD, 0 ,0 ])cube([2*TREAD_OFFSET,TREAD_WIDTH,Y_DIM], center = true);
}