// Code written by "deckingman" Feb 2016
// Use and enjoy
// "Hole in the base"-Remix by Timothy McPrint, 2017-09-16


// User Defined Variables
// Change any of the following to suit

// The number of bottles along the x axis
Number_Of_Bottles_Long=3;

// The number of bottles along the y axis
Number_Of_Bottles_Wide=4;

// The inside diameter of the cylinders which hold the bottles.
// Measure your bottle then add a milimeter or 2 for clearance
Inside_Diameter=27;

// The overall height in mm. Note that the depth of the hole will be this number minus the base thickness
Overall_Height=19;

// The base thickness in mm. For ease of printing, make this divisible by the layer height of you slicer/printer.
// So for example if the layer height is 0.3 mm use 1.8 or 2.1 but not 2.0.
Base_Thickness=1.8;

// Diameter of the hole in the base
Diameter_Base_Hole=15;

// The wall thickness of the cylinders. Note that the cylinders are joined together by whatever this thickness is
// so DO NOT MAKE THIS ANY LESS THAN 2mm. For ease of printing, make this number divisible by your nozzle diameter.
Wall_Thickness=5;

// Suggested Slicer settings. 3 solid top and bottom layers, 2 or 3 perimiters. 20% infill.
// Using a 0.5mm nozzle with 0.3mm layer height.


// Changing any of the following will likely screw things up!!

First_Bottle_Pos = (Inside_Diameter/2)+Wall_Thickness;
Step             = Inside_Diameter+Wall_Thickness;
iMax             = First_Bottle_Pos+(Number_Of_Bottles_Long*(Step-1));
jMax             = First_Bottle_Pos+(Number_Of_Bottles_Wide*(Step-1));
$fn              = 50;

for (i = [First_Bottle_Pos:Step:iMax])
{
	for (j = [First_Bottle_Pos:Step:jMax])
	{
		difference()
		{
			difference()
			{
				translate ([i,j,0])
					cylinder (d=Inside_Diameter+(2*Wall_Thickness),h=Overall_Height);
				translate ([i,j,Base_Thickness])
					cylinder (d=Inside_Diameter, h=Overall_Height+.2);
			}
			translate ([i,j,-0.1])
				cylinder (d=Diameter_Base_Hole, h=Base_Thickness+0.2);
		}
	}
}