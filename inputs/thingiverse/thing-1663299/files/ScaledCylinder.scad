scale([3,1,1])
difference(){
cylinder(h=27,r1=15,r2=15,$fn=50);
    translate([0,0,2])
    cylinder(h=25.5,r1=13,r2=13,$fn=50);
}
