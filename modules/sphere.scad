include <common_constants.scad>
include <magnets.scad>

module magnetsInSphere(delta, koeff, addAngle, socketShift,withPolarity) {
  r = SPINNER_DIAMETER/2;
  ang = SPINNER_MAGNET_ANGLE;
  step = 360/MAGNETS_QTY;
  for (angle = [0:step:360-step]) {
    rotate([0,0,angle])
    rotate([ang,0,0])
    translate([0,0,-r])
      translate([0,0,0])
      rotate([0,addAngle,0])
      translate([0,0,-MAGNET_HEIGHT*socketShift]) {
        magnet(delta,koeff);
        if (withPolarity) {
          translate([0,0,MAGNET_HEIGHT/2])
          magnetPolars(0.5,20,2,true);
        }
      }
  }
}

module slotsForSpinnerMagnets() {
  r = SPINNER_DIAMETER/2;
  ang = SPINNER_MAGNET_ANGLE;
  step = 360/MAGNETS_QTY;
  for (angle = [0:step:360-step]) {
    rotate([0,0,angle])
    rotate([ang,0,0])
    translate([0,0,-r])
      translate([0,0,-MAGNET_DIAMETER/9])
      rotate([0,30,0])
      translate([-MAGNET_DIAMETER*3/4,0,0])
        magnetSpinnerSlot();
  }
}

module bottomSphereRadialGain() {
  r = SPINNER_DIAMETER/2;
  sr = r - SPINNER_BOTTOM_THICK+0.1;
  shift = SPINNER_INTW_DIAMETER/2;
  width = 1;
  ir = 1.5;
  er = 2.5;
  step = 360/6;
  intersection() {
    for (angle = [0:step:360-step]) {
      rotate([0,0,angle])
      translate([shift-0.1,0,-r]) {
        difference() {
          union() {
            translate([0,-width/2,0]) cube([r-shift+0.2,width,r],false);
            translate([1.6,0,0]) cylinder(r,er,er,false);
            translate([16,0,0]) cylinder(r,er,er,false);
          }
          union() {
            translate([1.6,0,-1])cylinder(r+2,ir,ir,false);
            translate([16,0,-1])cylinder(r+2,ir,ir,false);
          }
        }
      }
    }
    sphere(r=sr);
  }
}

module bottomSphereAddWeightSupp() {
  h = SPINNER_DIAMETER/2-SPINNER_BOTTOM_THICK+0.1;
  r = SPINNER_DIAMETER/2;
  sr = r - SPINNER_BOTTOM_THICK+0.1;
  iwr = SPINNER_INTW_DIAMETER/2;
  delta = 1;
  intersection() {
    translate([0,0,-h])
      union() {
        difference() {
          cylinder(h,iwr,iwr,false);
          translate([0,0,-0.5]) cylinder(h+1,iwr-delta,iwr-delta,false);
        }
        translate([0,0,0])
          cylinder(6,iwr,iwr,false);
    }
    sphere(r=sr);
  }
}

module bottomSphereGain() {
  r = (SPINNER_DIAMETER-SPINNER_BOTTOM_THICK)/2;
  step = 360/SPINNER_VERT_GAINS_QTY;
  for (angle = [0:step:360-step]) {
    rotate([0,0,angle])
    rotate([90,0,0])
      rotate_extrude()
        translate([r, 0])
          circle(2.0);
  }
}

module cutUpperSemiSphere() {
    r = SPINNER_DIAMETER/2;
    cylinder(h=r+10,r1=r+10,r2=r+10,center = false);
}

module bottomSphere() {
  r = SPINNER_DIAMETER/2;
  r2 = r - SPINNER_BOTTOM_THICK;
  difference() {
    color([0.6,0.7,0.8,1]) sphere(r=r);
    color([0.4,0.4,0.9,1]) union() {
      cutUpperSemiSphere();
      sphere(r=r2);

    }
  }
  color([0.6,0.7,0.8,1])
    difference() {
      intersection() {
        bottomSphereGain();
        sphere(r=r);
      }
      cutUpperSemiSphere();
    }
  color([0.6,0.7,0.8,1]) bottomSphereAddWeightSupp();
  color([0.9,0.7,0.8,1])
    bottomSphereRadialGain();
}

module bottomMagnetHolderRadialGain() {
  r = magnets_holder_height; //SPINNER_DIAMETER/2;
  x = SPINNER_DIAMETER/2;
  h = MAGNET_DIAMETER + 4;
  sr = SPINNER_DIAMETER/2 - SPINNER_BOTTOM_THICK+0.1;
  shift = SPINNER_INTW_DIAMETER/2;
  width = 1;
  ir = 1.5;
  er = 2.5;
  step = 360/6;
  intersection() {
    for (angle = [0:step:360-step]) {
      rotate([0,0,angle])
      translate([shift-0.1,0,0]) {
        difference() {
          union() {
            translate([1.6,0,0]) cylinder(r,er,er,false);
            translate([0,-width/2,0]) cube([x-shift+0.2,width,r],false);
          }
          union() {
            translate([1.6,0,-1])cylinder(r+2,ir,ir,false);
          }
        }
      }
    }
    sphere(r=sr);
  }
}

module bottomMagnetHolderAddWeightSupp() {
  h = magnets_holder_height;
  r = SPINNER_DIAMETER/2;
  sr = r - SPINNER_BOTTOM_THICK+0.1;
  iwr = SPINNER_INTW_DIAMETER/2;
  delta = 1;
  intersection() {
    translate([0,0,0])
      difference() {
        cylinder(h,iwr,iwr,false);
        translate([0,0,-0.5])
          cylinder(h+1,iwr-delta,iwr-delta,false);
      }
    sphere(r=sr);
  }
}

module bottomMagnetHolder() {
  h = magnets_holder_height;
  r = SPINNER_DIAMETER/2;
  z = h + spinner_bottom_height;
  r2 = SPINNER_DIAMETER * cos(SPINNER_MAGNET_ANGLE)/2-MAGNET_DIAMETER;
  delta = 2;
  intersection() {
    translate([0,0,-z-delta])
      union() {
        difference() {
          cylinder(h,r,r,false);
          translate([0,0,-1]) cylinder(h+2,r2,r2,false);
        }
        bottomMagnetHolderAddWeightSupp();
        bottomMagnetHolderRadialGain();
      }
    sphere(r=r);
  }
}

module bottomRing() {
  delta = 2;
  r = SPINNER_DIAMETER/2;
  z = spinner_bottom_height + magnets_holder_height + delta;
  h = r - z;
  echo("####### h=",h);
  echo("####### r=",r);
  echo("####### z=",z);
  color([0.6,0.6,0.9,1])
  intersection() {
    translate([0,0,-z-h])
    difference() {
      cylinder(h,r,r,false);
      translate([0,0,-0.5]) cylinder(h+1,3,3,false);
    }
    sphere(r=r);
  }
}

module bottomMagnetHolderPaint(magnetsAngle,magnetsSocket,showMagnets) {
  color([0.9,0.7,0.3,1])
    translate([0,0,0.0])
      difference() {
        bottomMagnetHolder();
        union() {
          magnetsInSphere(0.2,2,magnetsAngle,magnetsSocket,false);
          cutVisualizasion();
        }
      }
  if (showMagnets) {
    magnetsInSphere(0,1,magnetsAngle,magnetsSocket,true);
    magnetsInSupport(0,1,magnetsAngle,magnetsSocket,false);
  }
}

module bottomSphereP1() {
  h = SPINNER_DIAMETER/2 - spinner_bottom_height;
  r = SPINNER_DIAMETER/2;
  z = h + spinner_bottom_height;
  h2 = 2;
  difference() {
    bottomSphere();
    translate([0,0,-z-h2])
      cylinder(h,r,r,false);
  }
}