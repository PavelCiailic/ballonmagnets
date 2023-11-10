//
// MAGNET VERTICAL SPINNER
//
// All sizes in millimeters [mm]

// MAGNETS USED:
MAGNET_DIAMETER = 5;
MAGNET_HEIGHT = 3;
MAGNETS_QTY = 20;
MAGNETS_SUPP_QTY = 30;

// SPINNER PARAMETERS:
SPINNER_DIAMETER = 80;
SPINNER_BOTTOM_THICK = 2;
SPINNER_MAGNET_ANGLE = 45; // magnets should be places on this angel to the vertical
SPINNER_VERT_GAINS_QTY = 6;
SPINNER_INTW_DIAMETER = 38;

// SUPPORT PARAMETERS
SUPPORT_FROM_CENTER = 60;
SUPPORT_LEGS_HOLE = 06.4;
SUPPORT_WIDTH = 3;



// to calculate:
spinner_bottom_height = SPINNER_DIAMETER * sin(SPINNER_MAGNET_ANGLE)/2 - MAGNET_DIAMETER-2;
magnets_holder_height = MAGNET_DIAMETER + 4;
support_diameter = 2 * SUPPORT_FROM_CENTER * cos(SPINNER_MAGNET_ANGLE);
support_diff = SUPPORT_FROM_CENTER * sin(SPINNER_MAGNET_ANGLE);

echo ("#############   centers' magnets ring radius = ", SPINNER_DIAMETER * sin(SPINNER_MAGNET_ANGLE)/2 );
echo ("#############   spinner_bottom_height=",spinner_bottom_height);
echo ("#############   magnets_holder_height=",magnets_holder_height);
echo ("#############   support_diameter=",support_diameter);
echo ("#############   support_diff=",support_diff);

CUT_VISUAL = false;

module cutVisualizasion() {
  if (CUT_VISUAL) {
    sd = SPINNER_DIAMETER;
    // cut for inner view 1
    translate([0,0,-sd+0.5]) cube(sd+1);
    // cut for inner view 2
    //translate([0,0,-sd/2]) cylinder(sd/2,sd/2,0,false);
  }
}