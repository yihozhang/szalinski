// MathGrrl corrugated sign & RDS02Stang Remix

use <write/Write.scad>

////////////////////////////////////////////////////////////////
// PARAMETERS //////////////////////////////////////////////////

/* [Size and Characters] */

// Choose a height for the planels, in mm
height = 30; 

// How many characters, including spaces, are in your word or phrase? (Must be between 3 and 40.)
characters = 3;

// Keep entering characters, including spaces, until you are done.
letter1  = "A";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter2  = "B";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter3  = "C";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter4  = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter5  = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter6  = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter7  = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter8  = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter9  = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter10 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter11 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter12 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter13 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter14 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter15 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter16 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter17 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter18 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter19 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter20 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter21 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter22 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter23 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter24 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter25 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter26 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter27 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter28 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter29 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter30 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter31 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter32 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter33 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter34 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter35 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter36 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter37 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter38 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter39 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]
letter40 = "";
//[,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,?,-,$,#,%,.,0,1,2,3,4,5,6,7,8,9]

/* [Adjustments] */

// Choose a hinge radius (mm)
hinge_radius = 2; 

// Choose a hinge clearance factor (mm)
hinge_clearance = .75;

// Choose panel thickness parameter (mm)
thick = .75;

// Other variables that people don't get to choose
$fn=24*1;
fudge = .01*1;
corner_radius = .05*height;
stacking_clearance = .1*3;
outside_height = .4*(height-2*stacking_clearance);
inside_height = (height-2*stacking_clearance)-2*outside_height;
cone_height = 1.4*hinge_radius; 
hinge_mover = height/2-corner_radius-stacking_clearance;

letters = [letter1,letter2,letter3,letter4,letter5,letter6,letter7,letter8,letter9,letter10,letter11,letter12,letter13,letter14,letter15,letter16,letter17,letter18,letter19,letter20,letter21,letter22,letter23,letter24,letter25,letter26,letter27,letter28,letter29,letter30,letter31,letter32,letter33,letter34,letter35,letter36,letter37,letter38,letter39,letter40];

////////////////////////////////////////////////////////////////
// RENDERS /////////////////////////////////////////////////////

panel_place_first(letters[0],0);
for  (i=[1:characters-2]){
	panel_place(letters[i],i);
}
panel_place_last(letters[characters-1],characters-1);

////////////////////////////////////////////////////////////////
// MODULES /////////////////////////////////////////////////////

// completed letter-hinged-panel placer
module panel_place(letter,i){
	translate([i*2*(thick+corner_radius+stacking_clearance),0,0])
	rotate(i*180,[0,1,0])
	rotate(i*180,[0,0,1])
		difference(){
			hinged_panel();
			rotate(i*180,[1,0,0]) 
			rotate(i*180,[0,0,1]) letter_place(letter);
		}
}

// completed letter-hinged-panel placer for *first* panel
module panel_place_first(letter,i){
	translate([i*2*(thick+corner_radius+stacking_clearance),0,0])
	rotate(i*180,[0,1,0])
	rotate(i*180,[0,0,1])
		difference(){
			hinged_panel_no_outer();
			rotate(i*180,[1,0,0]) 
			rotate(i*180,[0,0,1]) letter_place(letter);
		}
}

// completed letter-hinged-panel placer for *last* panel
module panel_place_last(letter,i){
	translate([i*2*(thick+corner_radius+stacking_clearance),0,0])
	rotate(i*180,[0,1,0])
	rotate(i*180,[0,0,1])
		difference(){
			hinged_panel_no_inner();
			rotate(i*180,[1,0,0]) 
			rotate(i*180,[0,0,1]) letter_place(letter);
		}
}

// letter placer
module letter_place(letter){
	translate([thick+corner_radius-1,-4.5*height/20,-7.5*height/20])
	rotate(90,[0,0,1])
	rotate(90,[1,0,0]) 
	write(letter,h=15*height/20,t=2);
}

// hinged panel
module hinged_panel_no_outer(){
translate([-thick-corner_radius,-height/2,-height/2])
	difference(){
	// cube and cylinders to start
		union(){
		// cube with inside top and bottom cylinders carved out
			difference(){
			// start with clearance cube in corner
				translate([height/2,height/2,height/2])
					rotate(the_angle,the_vector)
						mirror(the_mirror)
							translate([hinge_mover-thick,0,0])
								rounded_cube(); 
			// take away inside top cylinder with clearance
				translate([height+2*(-hinge_mover+thick),height,0])
						rotate(90,[0,0,1])
							translate([0,0,stacking_clearance+outside_height+inside_height])
								cylinder(	h=outside_height+fudge, 
												r1=hinge_radius+fudge+hinge_clearance, 
												r2=hinge_radius+fudge+hinge_clearance);
			// take away inside bottom cylinder with clearance
				translate([height+2*(-hinge_mover+thick),height,0])
						rotate(90,[0,0,1])
							translate([0,0,stacking_clearance-fudge])
								cylinder(	h=outside_height+fudge, 
												r1=hinge_radius+fudge+hinge_clearance, 
												r2=hinge_radius+fudge+hinge_clearance);
			}
	
		
		// inside hinge cylinder
			translate([height+2*(-hinge_mover+thick),height,0])
					rotate(90,[0,0,1])
						translate([0,0,stacking_clearance+outside_height])
							cylinder(	h=inside_height, 
											r1=hinge_radius, 
											r2=hinge_radius);
		// attacher for inside hinge cylinder
			translate([height+2*(-hinge_mover+thick),height,0])
					rotate(90,[0,0,1])
						translate([0,0,stacking_clearance+outside_height])
							rotate(45,[0,0,1])
								translate([-.8*hinge_radius,0,0])
									cube([1.6*hinge_radius,2*hinge_radius,inside_height]);			
		// inside hinge top cone 
			translate([height+2*(-hinge_mover+thick),height,0])
					rotate(90,[0,0,1])
						translate([0,0,stacking_clearance+outside_height+inside_height])
							cylinder(	h=cone_height, 
											r1=hinge_radius, 
											r2=0);
		// inside hinge bottom cone 
			translate([height+2*(-hinge_mover+thick),height,0])
					rotate(90,[0,0,1])
						translate([0,0,stacking_clearance+outside_height-cone_height])
							cylinder(	h=cone_height, 
											r1=0, 
											r2=hinge_radius);
		}

	
	}
}

// hinged panel
module hinged_panel_no_inner(){
translate([-thick-corner_radius,-height/2,-height/2])
	difference(){
	// cube and cylinders to start
		union(){
		// cube with inside top and bottom cylinders carved out
			difference(){
			// start with clearance cube in corner
				translate([height/2,height/2,height/2])
					rotate(the_angle,the_vector)
						mirror(the_mirror)
							translate([hinge_mover-thick,0,0])
								rounded_cube(); 
			
			}
		// top cylinder on outside hinge
			translate([0,0,stacking_clearance+outside_height+inside_height+hinge_clearance])
				cylinder(	h=outside_height-hinge_clearance-corner_radius/2, 
								r1=hinge_radius, 
								r2=hinge_radius);
		// bottom cylinder on outside hinge
			translate([0,0,stacking_clearance+corner_radius/2])
				cylinder(	h=outside_height-hinge_clearance-corner_radius/2,
								r1=hinge_radius,
								r2=hinge_radius);
				
		}
	// take away middle cylinder with clearance
		translate([0,0,stacking_clearance+outside_height-hinge_clearance-fudge])
			cylinder(	h=inside_height+2*hinge_clearance+2*fudge, 
							r1=hinge_radius+fudge+hinge_clearance, 
							r2=hinge_radius+fudge+hinge_clearance);
	// take away top cone with clearance
		translate([0,0,stacking_clearance+outside_height+inside_height+hinge_clearance-fudge])
			cylinder(h=cone_height, r1=hinge_radius, r2=0);
	// take away bottom cone with clearance
		translate([0,0,stacking_clearance+outside_height-cone_height-hinge_clearance+fudge])
			cylinder(h=cone_height, r1=0, r2=hinge_radius);
	}
}

// hinged panel
module hinged_panel(){
translate([-thick-corner_radius,-height/2,-height/2])
	difference(){
	// cube and cylinders to start
		union(){
		// cube with inside top and bottom cylinders carved out
			difference(){
			// start with clearance cube in corner
				translate([height/2,height/2,height/2])
					rotate(the_angle,the_vector)
						mirror(the_mirror)
							translate([hinge_mover-thick,0,0])
								rounded_cube(); 
			// take away inside top cylinder with clearance
				translate([height+2*(-hinge_mover+thick),height,0])
						rotate(90,[0,0,1])
							translate([0,0,stacking_clearance+outside_height+inside_height])
								cylinder(	h=outside_height+fudge, 
												r1=hinge_radius+fudge+hinge_clearance, 
												r2=hinge_radius+fudge+hinge_clearance);
			// take away inside bottom cylinder with clearance
				translate([height+2*(-hinge_mover+thick),height,0])
						rotate(90,[0,0,1])
							translate([0,0,stacking_clearance-fudge])
								cylinder(	h=outside_height+fudge, 
												r1=hinge_radius+fudge+hinge_clearance, 
												r2=hinge_radius+fudge+hinge_clearance);
			}
		// top cylinder on outside hinge
			translate([0,0,stacking_clearance+outside_height+inside_height+hinge_clearance])
				cylinder(	h=outside_height-hinge_clearance-corner_radius/2, 
								r1=hinge_radius, 
								r2=hinge_radius);
		// bottom cylinder on outside hinge
			translate([0,0,stacking_clearance+corner_radius/2])
				cylinder(	h=outside_height-hinge_clearance-corner_radius/2,
								r1=hinge_radius,
								r2=hinge_radius);
		// inside hinge cylinder
			translate([height+2*(-hinge_mover+thick),height,0])
					rotate(90,[0,0,1])
						translate([0,0,stacking_clearance+outside_height])
							cylinder(	h=inside_height, 
											r1=hinge_radius, 
											r2=hinge_radius);
		// attacher for inside hinge cylinder
			translate([height+2*(-hinge_mover+thick),height,0])
					rotate(90,[0,0,1])
						translate([0,0,stacking_clearance+outside_height])
							rotate(45,[0,0,1])
								translate([-.8*hinge_radius,0,0])
									cube([1.6*hinge_radius,2*hinge_radius,inside_height]);			
		// inside hinge top cone 
			translate([height+2*(-hinge_mover+thick),height,0])
					rotate(90,[0,0,1])
						translate([0,0,stacking_clearance+outside_height+inside_height])
							cylinder(	h=cone_height, 
											r1=hinge_radius, 
											r2=0);
		// inside hinge bottom cone 
			translate([height+2*(-hinge_mover+thick),height,0])
					rotate(90,[0,0,1])
						translate([0,0,stacking_clearance+outside_height-cone_height])
							cylinder(	h=cone_height, 
											r1=0, 
											r2=hinge_radius);
		}
	// take away middle cylinder with clearance
		translate([0,0,stacking_clearance+outside_height-hinge_clearance-fudge])
			cylinder(	h=inside_height+2*hinge_clearance+2*fudge, 
							r1=hinge_radius+fudge+hinge_clearance, 
							r2=hinge_radius+fudge+hinge_clearance);
	// take away top cone with clearance
		translate([0,0,stacking_clearance+outside_height+inside_height+hinge_clearance-fudge])
			cylinder(h=cone_height, r1=hinge_radius, r2=0);
	// take away bottom cone with clearance
		translate([0,0,stacking_clearance+outside_height-cone_height-hinge_clearance+fudge])
			cylinder(h=cone_height, r1=0, r2=hinge_radius);
	}
}

// module for making rounded cubes from convex hull of corners
module rounded_cube() {
	dist = height/2-corner_radius-stacking_clearance; // this is same as hinge_mover
		hull() {
		// seven of the eight vertices of a cube
			translate([thick,dist,dist])
				sphere(r=corner_radius); 
			translate([-thick,dist,dist]) 
				sphere(r=corner_radius);
			translate([thick,-dist,dist]) // outer hinge corner
				sphere(r=corner_radius);
			translate([-thick,-dist,dist]) 
				sphere(r=corner_radius);
			translate([thick,dist,-dist])
				sphere(r=corner_radius);
			translate([thick,-dist,-dist]) // outer hinge corner
				sphere(r=corner_radius);
			translate([-thick,-dist,-dist]) 
				sphere(r=corner_radius);
			translate([-thick,dist,-dist]) 
				sphere(r=corner_radius);
		}
}
