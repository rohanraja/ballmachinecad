include <params.scad>

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

        rotate_extrude(angle = 360, convexity = 9) difference()
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

        // Center hole
        translate([ 0, 0, -Y_DIM / 2 ]) cylinder(r = CENTER_DIM / 2, h = Y_DIM);
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