// Pass box for a hall passes
// by Kevin McCormack

// The length of the inside of the box in mm
inside_length = 240; 
// The width of the inside of the box in mm
inside_width = 40; 
// Height of the box in mm
height = 80; 
outside_length = inside_length + 6;
outside_width = inside_width + 6;

// The text for the first line of the label
label_text = "Your Label Here"; 
// The size of the label text scaling
label_size = 1.8; 


module boxBase() {
    difference() {
        translate([0,0,height/2]) cube([outside_length,outside_width,height],center=true);
        translate([0,0,(height/2)+4]) cube([inside_length,inside_width,height],center=true);
        
    }
}

module label(the_text) {
    translate([0,-(outside_width/2)+1,height/2]) rotate([90,0,0]) scale([label_size,label_size,1]) linear_extrude(height=2) text(the_text, halign="center", valign="center");
}

module backCuttout() {
    for (z=[10:10:height-10]) {
        for (x=[0:10:inside_length-10]) {
            translate([x-(inside_length/2)+5,10,z]) rotate([90,0,0]) cylinder(h=outside_width+5,d=6,center=true);
        }
    }
}

module frontCuttout() {
    // Bottom row
    for (x=[0:10:inside_length-10]) {
        translate([x-(inside_length/2)+5,-10,10]) rotate([90,0,0]) cylinder(h=outside_width+5,d=6,center=true);
    }
    // Top row
    for (x=[0:10:inside_length-10]) {
        translate([x-(inside_length/2)+5,-10,height-10]) rotate([90,0,0]) cylinder(h=outside_width+5,d=6,center=true);
    }    
}

module sideCuttout() {
    for (z=[10:10:height-10]) {
        for (y=[0:10:inside_width-10]) {
            translate([0,y-(inside_width/2)+5,z]) rotate([0,90,0]) cylinder(h=outside_length+5,d=6,center=true);
        }
    }
}

difference() {
    boxBase();
    label(label_text);
    backCuttout();
    frontCuttout();
    sideCuttout();
}