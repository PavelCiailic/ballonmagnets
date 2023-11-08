include <common_constants.scad>
include <magnets.scad>
include <printLetters.scad>

module magnetSupportLeg(diameter,heigh,innerDiameter,innerHeight) {
  color([0.5,0.6,0.5,1]) {
    difference() {
      union() {
        cylinder(heigh+innerHeight,innerDiameter/2,innerDiameter/2,center=false);
        cylinder(heigh,diameter/2,diameter/2,center=false);
      }
      translate([0,0,-1])
        cylinder(heigh+innerHeight+2,innerDiameter/2-1,innerDiameter/2-1,center=false);
    }
  }
}

module singleMagnetSupport(shiftZ,shiftX,showMagnet,showCut) {
  length = 15;
  height = 9.0;
  height2 = 2;
  width  = 7;
  if (showCut) {
    difference() {
      singleMagnetSupport(shiftZ,shiftX,false,false);
      color([0.8,0.5,0.6,1])
      translate([shiftX-1,0,shiftZ-1])
      cube([length+2,width,height+2]);
    }
    if (showMagnet) {
      translate([shiftX+width/2,-width/2,shiftZ])
      translate([5.3,width/2,4.4])
        rotate([0,-SPINNER_MAGNET_ANGLE,0])
          magnet(0,1);
    }
  } else {
  translate([shiftX+width/2,-width/2,shiftZ]) {
    color([0.6,0.3,0.4,1])
    difference(){
      union() {
        cube([length-width,width,height],center = false);
        translate([0,width/2,0])
          cylinder(height,width/2,width/2,center=false);
        translate([length-width,width/2,0])
          cylinder(height,width/2,width/2,center=false);
      }
      union() {
          difference(){
            translate([-3.76,-0.5,-0.9])
              rotate([0,-45,0])
                cube([14,9,10],center=false);
            translate([-9,-0.5,0])
              cube([10,9,height2]);
          }
          translate([-1.4,width/2,+2])
            cylinder(3,3/2+0.8,3/2+0.8,center=false);
          translate([-1.4,width/2,-1])
            cylinder(5,3/2,3/2,center=false);
          translate([length-width+1,width/2,-1])
            cylinder(11,3/2,3/2,center=false);
          translate([5.3,width/2,4.4])
            rotate([0,-SPINNER_MAGNET_ANGLE,0])
              magnet(0.2,1);
          translate([-5,-3,-0.5])
            rotate([0,0,-15])
              cube([15,5,7]);
          translate([-5,4.7,-0.5])
            rotate([0,0,15])
              cube([15,5,7]);
      }
    }
    if (showMagnet) {
      translate([5.3,width/2,4.4])
        rotate([0,-SPINNER_MAGNET_ANGLE,0])
          magnet(0,1);
    }
  }

  }
}

module magnetsSupport(z,paintSingleMagnetSupports,paintMagnetSupportLegs) {
  //z   = - support_diff;
  h1  = SUPPORT_WIDTH; // support width
  h2  = 10.00; // rings under support
  urd = SUPPORT_LEGS_HOLE; // diameter of the rings under support
  chd = 30.00; // central hole diameter
  h3  = 05.00; //
  bd  = 03.00; // bolt diameter
  r   = support_diameter/2+20;
  rgl = 20.5; // radial groove length
  rgs = 29; // radial groove shift from center
//  r2  = SUPPORT_FROM_CENTER * cos(SPINNER_MAGNET_ANGLE)+5;
//  r3  = SPINNER_DIAMETER * cos(SPINNER_MAGNET_ANGLE)/2;
//  echo("r2-r3 = ",r2-r3);
  step = 360/MAGNETS_SUPP_QTY;
  translate([0,0,z-h1-h3]) {
    color([0.5,0.5,0.8,1])
    difference() {
      cylinder(h1,r,r,center=false);
      union() {
        translate([0,0,-0.5]) {
          cylinder(h1+1,chd/2,chd/2,center=false);
          for (angle = [0:120:240]) {
              rotate([0,0,angle+step/2])
              translate([rgl+rgs+urd,0,-0.5])
                cylinder(h1+2,urd/2,urd/2,center=false);
          }
          for (angle = [0:90:270]) {
              rotate([0,0,angle+step/2])
              translate([rgl+rgs+urd,0,-0.5])
                cylinder(h1+2,urd/2,urd/2,center=false);
          }
        }
        for (angle = [0:step:360-step]) {
        rotate([0,0,angle])
        translate([rgs,-bd/2,-0.5])
          union() {
            cube([rgl,bd,h1+1],center = false);
            translate([0,bd/2,0])
              cylinder(h1+1,bd/2,bd/2,center=false);
            translate([rgl,bd/2,0])
              cylinder(h1+1,bd/2,bd/2,center=false);
          }
        }
      }
    }
    if (paintSingleMagnetSupports) {
      for (angle = [0:step:360-step]) {
        rotate([0,0,angle])
        translate([0,0,-0.05])
          singleMagnetSupport(h1,33.4);
      }
    }

    if (paintMagnetSupportLegs) {
      for (angle = [0:120:240]) {
        rotate([0,0,angle+step/2])
          translate([rgl+rgs+urd,0,-10])
            magnetSupportLeg(10,10,urd-0.4,h1);
      }
      for (angle = [90:90:270]) {
        rotate([0,0,angle+step/2])
          translate([rgl+rgs+urd,0,-10])
            magnetSupportLeg(10,10,urd-0.4,h1);
      }
    }

    color([0.5,0.5,0.8,1]){
      rotate([0,0,0])
      translate([0,0,3])
        printText("| * magnets * magnets * magnets * magnets * |",21,8.2,0.6,3);
      rotate([0,0,-62])
      translate([0,0,3])
        printText("CIAILIC ILIA &",r-5.5,4.5,0.6,6);
      rotate([0,0,13])
      translate([0,0,3])
        printText("ROBERT CHICIUC",r-5.5,5.7,0.6,6);
      rotate([0,0,141])
      translate([0,0,3])
        printText("LICEUL",r-5.5,5.7,0.6,6);
      rotate([0,0,193])
      translate([0,0,3])
        printText("'ORIZONT'",r-5.5,5.7,0.6,6);
    }
  }
}