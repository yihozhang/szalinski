
/////////////////////////////////////////////////////////////////////////
// parameters

fontSize_1 = 8; //[4:Small,6:Medium,8:Large]

font_1 = (fontSize_1 == 4) ? "Source Sans Pro:style=Bold" :
         (fontSize_1 == 6) ? "Source Sans Pro:style=Regular" :
         (fontSize_1 == 8) ? "Source Sans Pro:style=Black" : 
                           0;
                           
fontSize_2 = 6; //[4:Small,6:Medium,8:Large]

font_2 = (fontSize_2 == 4) ? "Source Sans Pro:style=Bold" :
         (fontSize_2 == 6) ? "Source Sans Pro:style=Regular" :
         (fontSize_2 == 8) ? "Source Sans Pro:style=Black" : 
                           0;

line_1 = "Sweethearts";
line_2 = "Wedding Anniversary 2018";

baseWidth = 100; //[50:120]

/////////////////////////////////////////////////////////////////////////
// renders


base();

translate([-15,-15,67])
AI3M_coupleKissingVoroV01_x5_PLA_04nz_6h22m();
/////////////////////////////////////////////////////////////////////////
// MODULE text

translate([0,-30,16])
rotate(90*0.85,[1,0,0])
color("white")
linear_extrude(height=2.5)
union(){
    translate([0,0,0]) 
        text(line_1,font=font_1,size=fontSize_1,halign="center");
    translate([0,-11,0]) 
        text(line_2,font=font_2,size=fontSize_2,halign="center");
}

/////////////////////////////////////////////////////////////////////////
// MODULE base

module base(){
    linear_extrude(height=30,scale=4/5) 
    square([baseWidth,70],center=true);
}

//
//    Usage:
//
//        To reference this file in another OpenSCAD file
//            use <coupleKissingVoroV01.scad>;

/////////////////////
// MODULE AI3M_coupleKissingVoroV01_x5_PLA_04nz_6h22m
/////////////////////

// Examples/Tests
//AI3M_coupleKissingVoroV01_x5_PLA_04nz_6h22m();

// Functions and Utilities
function AI3M_coupleKissingVoroV01_x5_PLA_04nz_6h22m_dimX() = 58.36;
function AI3M_coupleKissingVoroV01_x5_PLA_04nz_6h22m_dimY() = 61.07;
function AI3M_coupleKissingVoroV01_x5_PLA_04nz_6h22m_dimZ() = 183.56;
function AI3M_coupleKissingVoroV01_x5_PLA_04nz_6h22m_multmatrix() = [[1.000000,0.000000,0.000000,14.526562],[0.000000,1.000000,0.000000,11.507761],[0.000000,0.000000,1.000000,-40.251423],[0.000000,0.000000,0.000000,1.000000]];

/////////////////////
// geometry for AI3M_coupleKissingVoroV01_x5_PLA_04nz_6h22m
function AI3M_coupleKissingVoroV01_x5_PLA_04nz_6h22m_faces() = [
function AI3M_coupleKissingVoroV01_x5_PLA_04nz_6h22m_points() = [
    multmatrix(AI3M_coupleKissingVoroV01_x5_PLA_04nz_6h22m_multmatrix()) polyhedron(faces = AI3M_coupleKissingVoroV01_x5_PLA_04nz_6h22m_faces(), points = AI3M_coupleKissingVoroV01_x5_PLA_04nz_6h22m_points(), convexity=10);
};