module printText(text,r,angle,depth,fontSize) {
    arr = [ for (s = text) ord(s) ];
    l = len(arr);
    echo(str("############# length of ",text," is ",l));
    for (i = [0:1:l-1]) {
      a = angle * i;
      s = chr(arr[i]);
      echo(str("i = ",i," s = ", s, " a=", a));
      rotate([0,0,a])
        translate([r,0,0])
          rotate([0,0,90])
          printLetter(s, depth,fontSize);
    }
}

module printLetter(s, depth, fontSize) {
    linear_extrude( height = depth )
        text(
            text = s, 
            size = fontSize, 
            valign = "center", 
            halign = "center",
            $fn = 180
        );
}