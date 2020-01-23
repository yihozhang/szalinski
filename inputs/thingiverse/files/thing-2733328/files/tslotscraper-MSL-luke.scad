//T-slot cleaner for CNC, parametric
// MakerSpaceLeiden 2017 Lucas

THICKNESS = 3 ;
SLOTWIDTH = 25;
SLOTDEPTH = 10;
EXTENSION = 18;
HANDLELEN = 50;
HANDLEWID = 42;

HOLEDIA = HANDLEWID/3;

linear_extrude(THICKNESS)
difference(){
union(){
square([SLOTWIDTH,SLOTDEPTH]);
translate([SLOTWIDTH/2-0.5*SLOTWIDTH/3,SLOTDEPTH]) square([SLOTWIDTH/3,EXTENSION]);
translate([SLOTWIDTH/2-0.5*HANDLEWID,SLOTDEPTH+EXTENSION]) square([HANDLEWID,HANDLELEN]);
translate([SLOTWIDTH/2,SLOTDEPTH+EXTENSION+HANDLELEN]) circle(d=HANDLEWID);
}
translate([SLOTWIDTH/2,SLOTDEPTH+EXTENSION+HANDLELEN]) circle(d=HOLEDIA);
}