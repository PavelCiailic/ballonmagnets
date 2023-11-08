$fn=36;

include <../modules/common_constants.scad>
include <../modules/magnets.scad>
include <../modules/bottom_holder.scad>
include <../modules/sphere.scad>

// BASIC VISUALIZATION

//basicVisualizasion();
onlyBottomMagnetHolderPaint();
//singleMagnetSupport(0,0,true,true);

module onlyBottomMagnetHolderPaint() {
  translate([0,0,-1])
    bottomMagnetHolderPaint(0,0,true);
  magnetsSupport(-support_diff,paintSingleMagnetSupports=true);
}

module basicElements(moveZ) {
  translate([0,0,moveZ]) {
      color([0.5,0.1,0.1,1])
        magnet(0,1);
      translate([10,0,0])
      color([0.8,0.3,0.3,0.5])
        magnet(0.2,1);
      translate([20,0,0])
      color([0.8,0.3,0.3,0.5])
        magnetSpinnerSlot();
  }
}

module basicVisualizasion() {
  // show basic compos separtely
  //basicElements(30);

  difference() {
    bottomSphereP1();
    union() {
      slotsForSpinnerMagnets();
      cutVisualizasion();
    }
  }
  translate([0,0,-1])
    bottomMagnetHolderPaint(0,0,true);
  //translate([SPINNER_DIAMETER,0,-3])
  //  bottomMagnetHolderPaint(30,-0.4,true);
  translate([0,0,-2])
  bottomRing();
  magnetsSupport(paintSingleMagnetSupports=true);
}






