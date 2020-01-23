/* Dual Letter Blocks Illusion and Triple Letter Blocks Illusion
   by Lyl3

Creates a series of blocks that are each shaped like two or three different letters
when viewed from two or three orthogonal viewpoints.

This codebase now handles both the dual and the triple letter block illusions published at:
https://www.thingiverse.com/thing:3516901
https://www.thingiverse.com/thing:3530989

The basic parameters are different for each and must be removed from the parameters section
before being published on Thingiverse in order to use the Customizer app.

DualV1.1 Reduced base $fn value from 100 to 50
DualV1.2 Resized and positioned a few special characters so that they can be printed
DualV1.3 Doesn't create post when pair of characters is spaces for both.
         Reduced base $fn value from 50 to 25 and set to 50 for the hull circles. This cuts rendering time in half.
DualV1.4 Made instructions clearer

TripV1.1 Added code to pad strings with spaces if generating all 6 permutations
TripV1.2 Override specified base height and set to zero if generating all 6 permutations
TripV1.3 Module tripleLetterString shifts any block down 0.8 mm (for 20 mm block) if it's "OOO" or "UUU"
TripV1.4 Added measurements and adjustments for *, +, @, /, and \

V2.0 Merged codebase from dual letters and triple letters into single combined codebase
     Added capability to add small characters laying flat between the blocks
     Added capability to create multiple STLs
V2.1 Fixed code to handle separate STL creation when no pad or flat characters are being created
V2.2 Added parameter to adjust thickness of flat chracters on the base
     Added parameter to select which permutation of the strings to create
     Move letter blocks and flat characters down very slightly so that model is one single part
     Separate each of the permutations so that they're easier to examine
V2.3 Added option to rotate the top letters so they can be oriented the same as the right face instead of the same as the front face.
     Removed parameter to select which permutation of the strings to create. Code is still there, but customizer doesn't present the option. Remove enclosing str function if you want the parameter presented.
V2.4 Fixed bug that allowed the base of letters with rounded bottoms to not have a flat bottomed base like they're supposed to have. 
    Added option to change width of a space character from minimal (1.2 mm) to maximal (block width), and the minimal width is now always 1.2 mm instead of scaling with the letter scaling.
V2.5 Generate letter blocks for part = 1 even if no base, since the CGAL is cached anyways.
     Added some letter blocks to the STLs for unrequested parts so that they represent what the thing is
     Increased unscaled $fn base from 25 to 40, and decreased to 20 for triple when generating all permutations
*/

/* [Basic Parameters] */



/* --------------- Triple Letter Parameters - remove for Customizer App, comment out locally
*/
mode = 3 + 0;
// Generate all 6 permutations (FRT, FTR, RFT, RTF, TFR, TRF) of letter/word orientations?
all_permutations = "yes"; // [yes,no]
all_combos = (all_permutations == "yes") ? true: false;

// If generating a single permutation, which faces are the strings below specifying?  (this parameter may be useful when running locally so that you can easily cycle through each of the permutations)
which_faces = str("FRT"); // [FRT:1- front-right-top, FTR:2- front-top-right, RFT:3- right-front-top, RTF:4- right-top-front, TFR:5- top-front-right, TRF:6- top-right-front]

//The top letters can be oriented in one of two ways. Do you want to vertically align the top letters with the front letters or with the right letters?
align_top = "front"; // [front,right]

// First string (use only UPPERCASE letters, numbers, space, or the special characters)
string_1 = "B";

// Second string (use only UPPERCASE letters, numbers, space, or the special characters)
string_2 = "E";

// Third string (use only UPPERCASE letters, numbers, space, or the special characters)
string_3 = "G";

// Scale of letters (1 = letters 20 mm tall and spaced 28.28 mm apart if spacing is set to 0% below )
letterScaling = 2.0; // [0.5:0.1:10.0]

// Additional spacing between letters (% of letter width, none needed, can be negative)
additionalSpacing = 0.0; // [-10.0:0.1:30.0]

// Height of base (mm) - setting ignored and overridden to zero if generating all 6 permutations
baseHeight = 4.0; // [0.0:0.1:30.0]
padHeight = (all_combos == true) ? 0 : baseHeight;
// --------------- End of Triple Letter Parameters



/* [Additional Parameters] */

// Where should small characters laying flat between each block be added to the base? 
add_base_characters_where = "nowhere"; // [nowhere,front,back,front and back]
// Put them in a vector so they can share the same code: index 0 = front, index 1 = back
tinyLocations = [(add_base_characters_where == "front" || add_base_characters_where == "front and back") ? true: false,
                 (add_base_characters_where == "back" || add_base_characters_where == "front and back") ? true: false];

// What characters should be added to the base? (Multiple characters allowed, defaults to heart if nothing specified, will cycle through the characters for each location)
what_base_characters = "";
baseChars =  (what_base_characters == " " || what_base_characters == "" || what_base_characters == undef) ? chr(9829): what_base_characters;

// How should the characters added to the base be rotated?
rotate_base_characters = -1; // [0:No rotation, -1:Angled in, 1:Angled out, 2:Random]
rotateBaseChars = (rotate_base_characters != 0 ) ? true: false;

// How much should they be rotated (specifies maximum angle if random rotation is selected)
rotation_angle = 30; // [0:5:180]


/* [Advanced Parameters] */

// Which one would you like to see? (When "Create Thing" is clicked, multiple STL files will be created, one for each choice here)
part = 4; // [1:Letter blocks Only, 2:Base only, 3:Small flat characters only, 4:Everything]

// Thickness adjustment ratio for the small flat characters on the base (default is half the thickness of the base)
BaseCharactersThickness = 1.0;  //[0.5:0.1:10]

/* [Hidden] */
fudge = 0.00001;                               // 
letterWidth = 18.4;                            // enough space for the W
letterHeight = 21.37;                          // height of typical letter in chosen font size, could be larger
blockSize = (mode == 2) ? letterWidth : 20;
blockHeight = (mode == 2) ? 21.37 : blockSize; 
myScale = letterScaling * 20 / blockHeight;    // adjust scaling so that selected scale is based on nice even number
minWidth = (mode == 3 || width_of_space_character == "minimal - 1.2 mm") ? 1.2/myScale : blockSize;      // width of block for a space character

fontName = "Overpass Mono:style=Bold";
fontSize = 22;                                      // chosen as reasonable base size for 3D printing
spacingRatio = 1+(additionalSpacing/100); //
blockWidth = sqrt(2*blockSize*blockSize);           // hypotenuse of the block sides
padWidth = blockWidth * 1.1;                        // additional 10% around the blocks
defaultSpacing = (mode == 2) ? 0.9 : 1.05;          // Default is 10% closer for dual and 5% farther for triple
blockSpace = blockWidth * (defaultSpacing+(additionalSpacing/100)); 
adjustedPadHeight = padHeight / myScale;      // adjust pad height before being scaled with the letters

StringFront = (mode == 2 || which_faces[0] == "F") ? string_1 : (which_faces[1] == "F") ? string_2 : string_3;
StringRight = (mode == 2 || which_faces[1] == "R") ? string_2 : (which_faces[2] == "R") ? string_3 : string_1;
StringTop =   (mode == 2 || which_faces[2] == "T") ? string_3 : (which_faces[0] == "T") ? string_1 : string_2;

// Settings for the small letters laying flat on the base
// The sizing and spacing fudges were chosen to approximately center it between the letter blocks
tinyFactor = 2.5;                                     // The inverse of the scaling for the small letters
tinyShifts = [-padWidth/2+1.2*letterHeight/tinyFactor/2, padWidth/2-1.3*letterHeight/tinyFactor/2];

maxStringLength = max(len(string_1),len(string_2),len(string_3));

BaseCharsRotation = (rotate_base_characters == 2) ? 
                     rands(-rotation_angle,rotation_angle,2*(maxStringLength-1))
                     : concat(
                         [for (r = [1 : 1 : (maxStringLength-1)/2]) -rotation_angle*rotate_base_characters],
                         [for (r = [1 : 1 : (maxStringLength-1)%2]) 0],
                         [for (r = [1 : 1 : (maxStringLength-1)/2]) rotation_angle*rotate_base_characters],
                         [for (r = [1 : 1 : (maxStringLength-1)/2]) -rotation_angle*rotate_base_characters],
                         [for (r = [1 : 1 : (maxStringLength-1)%2]) 0],
                         [for (r = [1 : 1 : (maxStringLength-1)/2]) rotation_angle*rotate_base_characters]);
//echo (BaseCharsRotation);
                     
// Lower resolution for triple letters when all permutations being generated                         
$fn = letterScaling * ((mode == 3 && all_combos) ? 20 : 40);
/* 
Thingiverse customizer can't handle these characters even in comments
so the chr function must be used to enter them
*/
specialCharacters = chr([9829, 9824, 9830, 9827, 9834, 9835, 9792, 9794, 8592, 8594, 960]);
//echo("Special characters:", specialCharacters);  // Uncomment to see what the characters are

/*
Measurements, scaling, and positioning for characters is fine-tuned for
fontName = "Overpass Mono:style=Bold", fontSize = 22

                  A       B       C       D       E      F      G      H      I       J       K      L       M
                  N       O       P       Q       R      S      T      U      V       W       X      Y       Z
                  0       1       2       3       4      5      6      7      8       9
                  $       &       <       >       *      +      @      /      \
                  heart   spade   diamond club    note1  note2  female male   left    right   pi
*/
letterIDs = str("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789$&<>*+@/\\", specialCharacters);
letterWidths =   [17.40,  14.78,  15.17,  15.203, 14.35, 14.41, 15.54, 14.17, 12.58,  13.92,  15.60, 13.494, 14.17,
                  14.17,  16.21,  14.68,  16.21,  14.38, 14.68, 16.06, 14.44, 17.40,  18.01,  16.61, 16.18,  14.44,
                  15.48,  14.17,  14.32,  14.62,  16.49, 14.47, 15.33, 14.53, 15.51,  15.05,
                  14.59,  18.35,  14.35,  14.35,  14.26, 14.35, 17.00, 15.60, 15.60,
                  15.75,  15.75,  15.75,  16.06,  12.61, 14.29, 12.03, 12.03, 16.67,  16.67,  18.01];
letterHeights =  [21.37,  21.37,  22.04,  21.37,  21.37, 21.37, 22.10, 21.37, 21.37,  21.74,  21.37, 21.37,  21.37,
                  21.37,  22.10,  21.37,  21.74,  21.37, 22.10, 21.37, 21.74, 21.37,  21.37,  21.37, 21.37,  21.37,
                  22.10,  21.40,  21.74,  22.10,  21.37, 21.74, 22.10, 21.37, 22.10,  22.10,
                  26.87,  22.10,  14.62,  14.62,  14.17, 14.35, 22.10, 25.70, 25.70,
                  20.30,  20.61,  20.76,  20.61,  20.88, 25.22, 21.74, 22.10, 12.79,  12.79,  16.30];
letterXShifts =  [-0.808, -3.15,  -1.71,  -3.052, -3.23, -3.22, -1.69, -3.27, -4.95,  -3.60,  -2.97, -3.438, -3.27,
                  -3.27,  -1.62,  -3.16,  -1.62,  -3.22, -2.80, -1.71, -3.04, -0.81,  -0.44,  -1.32, -1.62,  -3.04,
                  -2.17,   -3.27, -2.86,  -2.885, -1.48, -3,    -2.27, -2.94, -2.12,  -2.47,
                  -2.89,  -0.265, -3.105, -3.105, -3.21, -3.1,  -1.04, -2.0,  -0.5,
                  -1.94,  -1.94,  -1.94,  -1.71,  -4.94, -1.28, -5.63, -5.63, -1.1,   -1.464, -0.44];
letterYShifts =  [0,      0,      0,      0,      0,     0,     0,     0,     0,      0,      0,     0,      0,
                  0,      0,      0,      0,      0,     0,     0,     0,     0,      0,      0,     0,      0,
                  0,      0,      0,      0,      0,     0,     0,     0,     0,      0,                  
                  2.137,  0,      -4.4,   -4.555, -6.15, -4.6,  0.0,   3.08,  3.08,
                  -2.0,   0,      -2.0,   0,     -1.0,   2.3,   0,     0,     -10.55, -10.55, -0.099]; 
letterYResizes = [1,      1,      1.015,  1,      1,     1,     1.016, 1,     1,      1.017,  1,     1,      1,
                  1,      1.016,  1,      1,      1,     1.016, 1,     1.017, 1,      1,      1,     1,      1,
                  1.016,  1,      1,      1.016,  1,     1.017, 1.016, 1,     1.016,  1.016,                  
                  1,      1.015,  1,      1,      1.15,  1,     1.016, 1,     1,
                  1.1,    1,      1.1,    1,      1.025, 1.025, 1,     1,     1.2,    1.2,    1.05]; 

function width (letter) = ((search(letter,letterIDs)[0])==undef ? blockSize : letterWidths[search(letter,letterIDs)[0]]);
function scaleX (letter) = blockSize / ((search(letter,letterIDs)[0])==undef || mode == 2 ? blockSize : letterWidths[search(letter,letterIDs)[0]]);
function scaleY (letter) = blockHeight / ((search(letter,letterIDs)[0])==undef ? blockHeight : letterHeights[search(letter,letterIDs)[0]]);
function shiftX (letter) = (search(letter,letterIDs)[0])==undef  || mode == 2 ? 0 : letterXShifts[search(letter,letterIDs)[0]];
function shiftY (letter) = (search(letter,letterIDs)[0])==undef ? 0 : letterYShifts[search(letter,letterIDs)[0]];
function resizeY (letter) = (search(letter,letterIDs)[0])==undef ? 1 : letterYResizes[search(letter,letterIDs)[0]];

module extrudeLetter (letter) {
  if (letter != " " && letter != undef)
    scale([1,resizeY(letter),1])                      // Some characters need to be resized because they're too short or too tall
    translate ([shiftX(letter),shiftY(letter),0])     // After scaling to fill the cube, move it into the cube
    scale ([scaleX(letter),scaleY(letter),1])         // Scale the character to fill the cube
    linear_extrude(blockSize) text (letter, size=fontSize, font=fontName);
  else
    if (mode == 2)
      translate ([(blockSize-minWidth)/2,0,0]) 
        cube([minWidth,blockHeight,blockSize]);
    else 
      cube([blockSize,blockSize,blockSize]);    
}
    
module tripleLetterBlock (letter1, letter2, letter3) {
  if ((letter1 != " " && letter1 != undef) || (letter2 != " " && letter2 != undef) || (letter3 != " " && letter3 != undef))
  intersection() {
//  union() {     // Change intersection to union to and use highlight/debug modifer on letter of interest to see scaling & positioning
    cube([blockSize,blockSize,blockHeight]);          // cube needed to ensure flat bottomed characters
    translate ([0,blockSize, 0]) rotate([90,0,0])   // front face: move it to orthogonally into position
      extrudeLetter (letter1);
    rotate([90,0,90])                               // right face: rotate to correct orientation
      extrudeLetter (letter2);
    if (mode == 3) {
      translate ([(align_top=="front")?0:blockSize,0,0]) rotate([0,0,(align_top=="front")?0:90])      
        extrudeLetter (letter3);                      // top face is already oriented and position correctly
    }
  }
}

module tripleLetterString (string1, string2, string3, codeMessage) {
  stringLength = max(len(string1),len(string2),len(string3));

  // Create the sequence of letter blocks
  if (codeMessage || part == 4 || part == 1)
      translate([- (blockSpace*(stringLength-1)/2) - blockWidth/2, 0, adjustedPadHeight-fudge])
        for (i = [0:stringLength-1]) {
          color("lightblue") translate ([i*blockSpace,0, ((string1[i]=="O" || string1[i]=="U") &&                                                      (string2[i]=="O" || string2[i]=="U") &&
                                                          (string3[i]=="O" || string3[i]=="U")) ? -0.8 : 0])
            rotate ([0,0,-45]) tripleLetterBlock (string1[i], string2[i], string3[i]);
        }
  // Create a base for the letters
  if (!codeMessage && ((part == 2 || part == 4) && padHeight != 0))
      translate([-blockSpace*(stringLength-1)/2,0,0])
        color("green") linear_extrude (adjustedPadHeight) hull() {
          translate([blockSpace*(stringLength-1),0,0]) circle(d=padWidth, $fn=50*letterScaling);
           circle(d=padWidth, $fn=50*letterScaling);
        }

  // Add in the small characters flat on the base
  if (!codeMessage && ((part == 3 || part == 4) && padHeight != 0))
      for (tl=[0:1]) {
        if (tinyLocations[tl] && padHeight != 0) {
          translate([-(blockSpace*(stringLength)/2), tinyShifts[tl], adjustedPadHeight-fudge])
          for (i = [1:1:stringLength-1]) {
            color("red")
              translate ([i*blockSpace,0, 0])
                rotate ([0,0,(rotateBaseChars) ? BaseCharsRotation[tl*(stringLength-1)+i-1]:0])
                  linear_extrude(BaseCharactersThickness*adjustedPadHeight/2)
                    text (baseChars[(tl*(tinyLocations[0]? 1:0)*(stringLength-1)+i-1)%len(baseChars)], size=fontSize/tinyFactor, font=fontName, valign="center", halign="center");
            }
          }
      }

}

/* Example and testing values go here
string_1 = "ABCDEFGHIJKLM";
string_2 = "NOPQRSTUVWXYZ";

string_1 = "0123456789";
string_2 = "9876543210";

string_1 = "EEEEEEEEEEEE";
string_2 = chr([36, 60, 62, 9829, 9824, 9830, 9827, 9834, 9835, 8592, 8594, 960]);

string_1 = "GOOD";
string_2 = "LUCK";
string_3 = "GRAD";

string_1 = str("I",chr(9829),"U");
string_2 = "MOM";
string_3 = str("I",chr(9829),"U");

string_1 = str(chr(9829),"M");
string_2 = "UM";
string_3 = "IO";

string_1 = "LUCK";
string_2 = "BABE";
string_3 = "GOOD";

string_1 = "BEFHIKLOPRTUWXZ";  // these letters can be combined with itself as all 3 letters in a block
string_2 = "BEFHIKLOPRTUWXZ";
string_3 = "BEFHIKLOPRTUWXZ";

string_1 = "TRIPLE";
string_2 = "TRIPLE";
string_3 = "TRIPLE";

string_1 = "0123456789";    // all digits can be combined with itself as all 3 characters in a block
string_2 = "0123456789";
string_3 = "0123456789";

all_combos = false;
padHeight = 0;
tripleLetterBlock ("B", "E", "G");
linear_extrude(blockSize) text ("A", size=fontSize, font=fontName);  // Used to get letter dimensions
*/

scale ([myScale,myScale,myScale]) 
if (all_combos == true ) {
  translate ([0,-7.5*padWidth,0]) tripleLetterString (StringFront, StringRight, StringTop);
  translate ([0,-4.5*padWidth,0]) tripleLetterString (StringFront, StringTop,   StringRight);
  translate ([0,-1.5*padWidth,0]) tripleLetterString (StringRight, StringFront, StringTop);
  translate ([0, 1.5*padWidth,0]) tripleLetterString (StringRight, StringTop,   StringFront);
  translate ([0, 4.5*padWidth,0]) tripleLetterString (StringTop,   StringFront, StringRight);
  translate ([0, 7.5*padWidth,0]) tripleLetterString (StringTop,   StringRight, StringFront);
} else
  tripleLetterString (StringFront,StringRight,StringTop,false);

// Make sure each STL created by the Thingiverse Customizer has some content
//if (part == 1 && padHeight == 0)
//  linear_extrude (1) text ("No base added. View model with all parts.", size=fontSize/4, font=fontName, $fn=10);
if (part == 2 && padHeight == 0) {
   if (mode == 2) 
      scale ([0.7,0.7,0.7]) translate([46,18,0]) tripleLetterString ("DUAL","WORD",StringTop,true);
   if (mode == 3) 
      scale ([0.37,0.37,0.37]) translate([83,30,0]) tripleLetterString ("TRIPLE","TRIPLE","TRIPLE",true);
  linear_extrude (1) text ("No base added.", size=fontSize/4, font=fontName, $fn=10);
}
if (part == 3 && (!tinyLocations[0] && !tinyLocations[1] || padHeight == 0)) {
   if (mode == 2) 
      scale ([1.26,1.26,1.26]) translate([46,18,0]) tripleLetterString ("DUAL","WORD",StringTop,true);
   if (mode == 3) 
      scale ([0.66,0.66,0.66]) translate([83,24,0]) tripleLetterString ("TRIPLE","TRIPLE","TRIPLE",true);
  linear_extrude (1) text ("No flat characters added.", size=fontSize/4, font=fontName, $fn=10);
}



/* --------------- Dual Letter Parameters - remove for Customizer App, comment out locally
mode = 2 + 0;
all_combos = false + false;

// Letters on left side (use only UPPERCASE letters, numbers, space, or the special characters)
string_1 = "DUAL WORD";

// Letters on right side (use only UPPERCASE letters, numbers, space, or the special characters)
string_2 = "ILLUSION";

string_3 = str("");

// Scale of letters (1 = letters 20 mm tall and spaced 22.2 mm apart if spacing is set to 0% below )
letterScaling = 1.5; // [0.5:0.1:10.0]

// Additional spacing between letters (% of letter width, none needed, can be negative)
additionalSpacing = 0.0; // [-10.0:0.1:30.0]

// Height of base (mm) 
baseHeight = 3.0; // [0.0:0.1:30.0]
padHeight = (all_combos == true) ? 0 : baseHeight;

// The width of a space character can't be 0 because the paired character on the other face of the block wouldn't show. By default it's set to 1.2 mm, which is a minimal width for acceptable strength. You can change this to full block width if you prefer. 
width_of_space_character = "minimal - 1.2 mm"; // [minimal - 1.2 mm,maximal - full block width]
// --------------- End of Dual Letter Parameters
*/