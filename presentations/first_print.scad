$fn=180;

include <../modules/common_constants.scad>
include <../modules/magnets.scad>
include <../modules/bottom_holder.scad>
include <../modules/sphere.scad>

all_together = false;
all_details = true;

if (all_together) {
  onlyBottomMagnetHolderPaint();
}

if (all_details) {
  magnetsSupport(8,paintSingleMagnetSupports=false,paintMagnetSupportLegs=false);
  translate([0,-70,0]) {
    for ( i = [0:20:60] ) {
      translate([i,0,0])
        magnetSupportLeg(10,10,SUPPORT_LEGS_HOLE-0.4,SUPPORT_WIDTH);
    }
  }
  translate([90,0,0])
  rotate([0,0,180])
  singleMagnetSupport(0,0);
  translate([0,100,32])
  bottomMagnetHolderPaint(0,0,false);
}

module onlyBottomMagnetHolderPaint() {
  translate([0,0,-1])
    bottomMagnetHolderPaint(0,0,true);
  magnetsSupport(paintSingleMagnetSupports=true);
}

