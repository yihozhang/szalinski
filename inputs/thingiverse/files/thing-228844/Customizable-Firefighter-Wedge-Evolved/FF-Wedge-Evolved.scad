//Parametric Firefighter Wedge By schlem
//
//"We use wedges like these to block open doors like a doorstop or at the hinge. Two wedges can be pushed together inside the frame of a sprinkler head to shut off the (copious) flow of water... Print it in a bright color so that you don't lose it on the fireground."
//
//After http://www.thingiverse.com/thing:43931 by schlem
//
//User defined parameters for text, and lanyard hole
// size and font customization pending



// First Things **************************

//$fs=1;
//$fa=3;

	use <write/Write.scad>  // Customizer 
 	// use <Write.scad> // local install

// Parameters ****************************  

// Long dimension of wedge
L=102*1;

// Short dimension of wedge
W=30*1;

// Thickness of wedge
HW=15*1;

// Label on wedge, limited to 5 characters
// +++++++++++++++++++++++++++++++++++++++
//on wedge (not too much!)
text="329";
label=str(text);
// +++++++++++++++++++++++++++++++++++++++

// Radius; 0 = no hole
hole=3;

// Depth; 0-3 (0 = no teeth)
tooth=2;

//	Angle of wedge
theta=atan(W/L);

//default font settings
	center=0*1;
	h = W*.5;			 //mm letter height
	t = 2*1; 			//mm letter thickness
	space =.8*1; 			//extra space between characters in (character widths)
	rotate=0*1;			// text rotation (clockwise)
// (designed to work with Black Rose
//	font = "/BlackRose.dxf"; // <-- local execution
	font = "write/BlackRose.dxf"; // <-- Customizer
// ["write/BlackRose.dxf":Black Rose,"write/knewave.dxf":Knewave,"write/Letters.dxf":Letters,"write/orbitron.dxf":Orbitron]



// Top Level code **************************** 


difference(){
	wedge(L,W,HW);
	translate([((10+len(label))*L/12)-(len(label)*8),W/8,t*.9])rotate([0,180,0])write(label,t=t,h=h,font=font,space=space,rotate=rotate,center=center);
	translate([10*L/12-(len(label)*8),W/8,(HW-t*.9)])write(label,t=t,h=h,font=font,space=space,rotate=rotate,center=center);
	teeth();
	
}

// Modules **************************** 

module wedge(L=150, W=40, HW=15)
{
	
	hypotenoos=sqrt(pow(L,2)+pow(W,2));
	difference()
	{
		render(convexity=10)cube([L,W,HW]); //cube dimensioned to LxWxHW
		rotate(theta, 0,0,0)translate([0,0,-1])#cube([hypotenoos,W,HW*1.1]); //subtract along hypoteneuse
		rotate(theta/2, 0,0,0)translate([0,0,1])#cube([L/6,W/4,HW*2,],center=true);
		translate([L,W,1])rotate(-45)#cube([L/6,W/5,HW*2,], center=true);
  		translate([L,0,1])rotate(45)#cube([L/6,W/5,HW*2,], center=true);
		perforate();
//-theta/2
	}
}


module perforate(radius=hole)
{

	translate([(0.9*L),(0.45*W),-.5])#cylinder(h = HW*1.1, r=hole);
}


module teeth(depth=tooth)
{
	echo (depth);
	cube_size=6;
	offset=(sqrt(2*pow(cube_size/2,2)));
	spacing=L/20;
	echo (offset);

	for (i = [0:9]) // ten iterations, 0-7
	{
			echo (spacing);
		translate([(spacing*8)+(i*spacing),-offset+depth,1])
		rotate([0,0,45])
		#cube([cube_size, cube_size, HW*2], center = true);
	}
}

	

