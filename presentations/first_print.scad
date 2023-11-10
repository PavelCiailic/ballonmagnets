$fn=36;

include <../modules/common_constants.scad>
include <../modules/magnets.scad>
include <../modules/bottom_holder.scad>
include <../modules/sphere.scad>

all_together = false;
all_details = false;
onlyMagnetSupportPlatform = false;
onlyMagnetSupportLeg = false;
onlySingleMagnetSupport = false;
onlyBottomMagnetHolderPaint = true;
paintZeroLevelPlate = false;

if (onlyMagnetSupportPlatform) {
  paintMagnetSupportPlatform();
}

if (onlyMagnetSupportLeg) {
  paintMagnetSupportLeg();
}

if (onlySingleMagnetSupport) {
  paintSingleMagnetSupport();
}

if (all_together) {
  bottomMagnetHolderPaint();
}

if (onlyBottomMagnetHolderPaint) {
  paintSingleMagnetSupport();
}

if (paintZeroLevelPlate) {
  color([0.2,0.5,0.2,0.3])
  translate([0,0,-5])
    cylinder(5,32,32,center=false);
}

if (all_details) {
  paintMagnetSupportPlatform();
  translate([0,-90,0]) {
    for ( i = [-30:20:30] ) {
      translate([i,0,0])
        paintMagnetSupportLeg();
    }
  }
  translate([130,0,0]) {
    for (x = [0:20:40]) {
      for (y = [-45:10:45]) {
        translate([-x,y,0])
          rotate([0,0,180])
            paintSingleMagnetSupport();
      }
    }
  }
  translate([0,100,-22.8])
  rotate([180,0,0])
  bottomMagnetHolderPaint(0,0,false);
}

module paintMagnetSupportPlatform() {
  magnetsSupport(8,paintSingleMagnetSupports=false,paintMagnetSupportLegs=false);
}

module paintMagnetSupportLeg() {
  magnetSupportLeg(10,10,SUPPORT_LEGS_HOLE-0.4,SUPPORT_WIDTH);
}

module paintSingleMagnetSupport() {
  translate([0,0,-23.30])
    rotate([180,0,0])
    bottomMagnetHolderPaint(0,0,false);
}

module bottomMagnetHolderPaint2() {
  translate([0,0,-1])
    bottomMagnetHolderPaint(0,0,true);
  magnetsSupport(paintSingleMagnetSupports=true);
}

