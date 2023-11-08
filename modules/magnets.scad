include <common_constants.scad>

module magnet(delta, widthKoeff) {
  h = MAGNET_HEIGHT*widthKoeff+delta ;
  r = (MAGNET_DIAMETER+delta)/2;
  translate([0,0,-MAGNET_HEIGHT*(widthKoeff-1)])
    cylinder(h,r,r,false);
}

module magnetSpinnerSlot() {
  delta = 0.2;
  h = MAGNET_HEIGHT + delta;
  l = MAGNET_DIAMETER + delta;
  translate([l,0,h/2])
    cube([l*2,l,h],center = true);
  magnet(delta,1);
}

module magnetPolars(weidth,length,shift,NorthUp) {
    cNorth = [0.9,0.4,0.4,0.3]; // red
    cSouth = [0.4,0.4,0.9,0.3]; // blue
    cUp = NorthUp ? cNorth : cSouth;
    cDown = NorthUp ? cSouth : cNorth;
    translate([0,0,shift])
      color(cUp)
      cylinder(length-shift,weidth/2,weidth/2,false);
    translate([0,0,-length])
      color(cDown)
      cylinder(length-shift,weidth/2,weidth/2,false);
}

module magnetsInSupport(delta, koeff, addAngle, socketShift,withPolarity) {
  r = SUPPORT_FROM_CENTER;
  ang = SPINNER_MAGNET_ANGLE;
  step = 360/MAGNETS_SUPP_QTY;
  for (angle = [0:step:360-step]) {
    rotate([0,0,angle])
    rotate([0,-ang,0])
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