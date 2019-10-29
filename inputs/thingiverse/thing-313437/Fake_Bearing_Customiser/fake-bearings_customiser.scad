// Bearing Customiser (http://www.thingiverse.com/thing:313437)
// *********************************************************************************
// Version history:
// Author:			Date: 			Description:
// Whitecoat		2014-04-28		Initial build
// 
// *********************************************************************************
// customiser script

// Bearing Part Number
PartNo = 608;  // [ 603,  604, 605,606, 607, 608, 609, 623, 624, 625, 626, 627, 628, 629, 633, 634, 635, 636, 637, 638, 639, 673, 674, 675, 676, 677,  678,  683,  684,  685,  686,  687,  688,  689,  693,  694,  695,  696,  697,  698,  699,  6000, 6001, 6002, 6003, 6004, 6005, 6006, 6007, 6008, 6009, 6010, 6011, 6012, 6013, 6014, 6015, 6016, 6017, 6018, 6019, 6020, 6021, 6022, 6024, 6026, 6028, 6030, 6200, 6201, 6202, 6203, 6204, 6205, 6206, 6207, 6208, 6209, 6210, 6211, 6212, 6213, 6214, 6215, 6216, 6217, 6218, 6219, 6220, 6221, 6222, 6224, 6226, 6228, 6230, 6300, 6301, 6302, 6303, 6304, 6305, 6306, 6307, 6308, 6309, 6310, 6311, 6312, 6313, 6314, 6315, 6316, 6317, 6318, 6319, 6320, 6321, 6322, 6324, 6326, 6328, 6330, 6701, 6702, 6703, 6704, 6705, 6706, 6707, 6800, 6801, 6802, 6803, 6804, 6805, 6806, 6807, 6808, 6809, 6810, 6811, 6812, 6813, 6814, 6815, 6816, 6817, 6818, 6819, 6820, 6821, 6822, 6824, 6826, 6828, 6830, 6200, 6201, 6202, 6203, 6204, 6205, 6206, 6207, 6208, 6209, 6210, 6211, 6212, 6213, 6214, 6215, 6216, 6217, 6218, 6219, 6220, 6221, 6222, 6224, 6226, 6228, 6230, 6300, 6301, 6302, 6303, 6304, 6305, 6306, 6307, 6308, 6309, 6310, 6311, 6312, 6313, 6314, 6315, 6316, 6317, 6318, 6319, 6320, 6321, 6322, 6324, 6326, 6328, 6330, 6701, 6702, 6703, 6704,  6705, 6706, 6707, 6800, 6801, 6802, 6803, 6804, 6805, 6806, 6807, 6808, 6809, 6810, 6811, 6812, 6813, 6814, 6815, 6816, 6817, 6818, 6819, 6820, 6821, 6822, 6824, 6826, 6828, 6830, 6900, 6901, 6902, 6903, 6904, 6905, 6906, 6907, 6908, 6909, 6910, 6911, 6912, 6913, 6914, 6915, 6916, 6917, 6918, 6919, 6920, 6921, 6922, 6924, 6926, 6928, 6930, 16001, 16002, 16003, 16004, 16005, 16006, 16007, 16008, 16009, 16010, 16011, 16012, 16013, 16014, 16015, 16016, 16017, 16018, 16019, 16020, 16021, 16022 ]
 

// Printer Tolerance (in mm).  This makes the print just a bit smaller to account for inaccuracy in printing. 
PrintTolerance = 0.25; 

fake_bearing(BearingPartNoToDim(PartNo),PrintTolerance);


// *********************************************************************************
//  Pasted in a bearing library below this point so that there was a single script 
//  for the customiser app
// *********************************************************************************


// Bearing Library
// *********************************************************************************
// Version history:
// Author:			Date: 			Description:
// Whitecoat		2014-02-21		Initial build
// 
// *********************************************************************************
// Included Functions:
// [d, D, B] = BearingPartNoToDim(PartNo);  	//Returns Dimensions given Part Number
//
// *********************************************************************************
// Public Modules:
// fake_bearing([d, D, B],Tolerance);  	 	//Creates Bearing shape for given dimensions
//															// or: fake_bearing(BearingPartNoToDim(608));
// 
// BearingHole(p_bearing_size,p_tolerance)
// *********************************************************************************
// *********************************************************************************
// Included Internal Modules:
//	FakeBearingTest1();  			//Unit Test 1 - Fake Bearing

module FakeBearingTest1()
	{
	Tolerance = 1.0; 		
	fake_bearing([9,12,2],Tolerance);
	}




// build a fake bearing using size vector [d (Inner Diamater), D (Outer Diamater), B (Width)]
// ----------------------------------------------------------------
// This module just creates a cored cylinder in the same of a bearing.
module fake_bearing(p_bearing_size,p_tolerance=0.25)
	{
	// internal parameters
	l_diff_tol = 0.1;  	// a tollerance added to difference operations 
							 	// to ensure surface is subtracted

	// build
	difference()
		{
		cylinder(r=(p_bearing_size[1]-p_tolerance)/2,h=p_bearing_size[2],$fn=50);
		translate([0,0,-l_diff_tol])
			{
			cylinder(r=(p_bearing_size[0])/2+p_tolerance,h=p_bearing_size[2]+l_diff_tol*2,$fn=50);
			}
		}
	}

// BearingHole [d (Inner Diamater), D (Outer Diamater), B (Width)]
// ----------------------------------------------------------------
// This module is intended for subtraction in a difference to make a hole for a bearing
module BearingHole(p_bearing_size,p_tolerance=0.25)
	{
	// internal parameters
	l_diff_tol = 0.1;  	// a tollerance added to difference operations 
							 	// to ensure surface is subtracted

	// build
	difference()
		{
		cylinder(r=(p_bearing_size[1]+p_tolerance)/2,h=p_bearing_size[2],$fn=50);
		}
	}

// bearing PartNo to Dimension conversion - result [d, D, B] in mm
// ----------------------------------------------------------------
// I did find something like this in the generic bearing library with MCAD, but 
// it had a farily limited set of part numbers, I wanted a more complete 
// table for this purpose, so I wrote my own.
function BearingPartNoToDim(PartNo) =
// 600 series (ZZ)
	PartNo == 603 ? [3, 9,  5]:
	PartNo == 604 ? [4, 12, 4]:
	PartNo == 605 ? [5, 14, 5]:
	PartNo == 606 ? [6, 17, 6]:
	PartNo == 607 ? [7, 19, 6]:
	PartNo == 608 ? [8, 22, 7]:
	PartNo == 609 ? [9, 24, 7]:
	PartNo == 623 ? [3, 10, 4]:
	PartNo == 624 ? [4, 13, 5]:
	PartNo == 625 ? [5, 16, 5]:
	PartNo == 626 ? [6, 19, 6]:
	PartNo == 627 ? [7, 22, 7]:
	PartNo == 628 ? [8, 22, 7]:
	PartNo == 629 ? [9, 22, 7]:
	PartNo == 633 ? [3, 13, 5]:
	PartNo == 634 ? [4, 16, 5]:
	PartNo == 635 ? [5, 19, 6]:
	PartNo == 636 ? [6, 22, 7]:
	PartNo == 637 ? [7, 26, 9]:
	PartNo == 638 ? [8, 28, 9]:
	PartNo == 639 ? [9, 30, 10]:
	PartNo == 673 ? [3, 6, 2.5]:
	PartNo == 674 ? [4, 7, 2.5]:
	PartNo == 675 ? [5, 8, 2.5]:
	PartNo == 676 ? [6, 10, 3]:
	PartNo == 677 ? [7, 11, 3]:
	PartNo == 678 ? [8, 12, 3.5]:
	PartNo == 683 ? [3, 7, 3]:
	PartNo == 684 ? [4, 9, 4]:
	PartNo == 685 ? [5, 11, 5]:
	PartNo == 686 ? [6, 13, 5]:
	PartNo == 687 ? [7, 14, 5]:
	PartNo == 688 ? [8, 16, 5]:
	PartNo == 689 ? [9, 17, 5]:
	PartNo == 693 ? [3, 8, 4]:
	PartNo == 694 ? [4, 11, 4]:
	PartNo == 695 ? [5, 13, 4]:
	PartNo == 696 ? [6, 15, 5]:
	PartNo == 697 ? [7, 17, 5]:
	PartNo == 698 ? [8, 19, 6]:
	PartNo == 699 ? [9, 20, 6]:
	PartNo == 6000 ? [10,  26,  8]:
	PartNo == 6001 ? [12,  28,  8]:
	PartNo == 6002 ? [15,  32,  9]:
	PartNo == 6003 ? [17,  35,  10]:
	PartNo == 6004 ? [20,  42,  12]:
	PartNo == 6005 ? [25,  47,  12]:
	PartNo == 6006 ? [30,  55,  13]:
	PartNo == 6007 ? [35,  62,  14]:
	PartNo == 6008 ? [40,  68,  15]:
	PartNo == 6009 ? [45,  75,  16]:
	PartNo == 6010 ? [50,  80,  16]:
	PartNo == 6011 ? [55,  90,  18]:
	PartNo == 6012 ? [60,  95,  18]:
	PartNo == 6013 ? [65,  100,  18]:
	PartNo == 6014 ? [70,  110,  20]:
	PartNo == 6015 ? [75,  115,  20]:
	PartNo == 6016 ? [80,  125,  22]:
	PartNo == 6017 ? [85,  130,  22]:
	PartNo == 6018 ? [90,  140,  24]:
	PartNo == 6019 ? [95,  145,  24]:
	PartNo == 6020 ? [100,  150,  24]:
	PartNo == 6021 ? [105,  160,  26]:
	PartNo == 6022 ? [110,  170,  28]:
	PartNo == 6024 ? [120,  180,  28]:
	PartNo == 6026 ? [130,  200,  33]:
	PartNo == 6028 ? [140,  210,  33]:
	PartNo == 6030 ? [150,  225,  35]:
	PartNo == 6200 ? [10,  30,  9]:
	PartNo == 6201 ? [12,  32,  10]:
	PartNo == 6202 ? [15,  35,  11]:
	PartNo == 6203 ? [17,  40,  12]:
	PartNo == 6204 ? [20,  47,  14]:
	PartNo == 6205 ? [25,  52,  15]:
	PartNo == 6206 ? [30,  62,  16]:
	PartNo == 6207 ? [35,  72,  17]:
	PartNo == 6208 ? [40,  80,  18]:
	PartNo == 6209 ? [45,  85,  19]:
	PartNo == 6210 ? [50,  90,  20]:
	PartNo == 6211 ? [55,  100,  21]:
	PartNo == 6212 ? [60,  110,  22]:
	PartNo == 6213 ? [65,  120,  23]:
	PartNo == 6214 ? [70,  125,  24]:
	PartNo == 6215 ? [75,  130,  25]:
	PartNo == 6216 ? [80,  140,  26]:
	PartNo == 6217 ? [85,  150,  28]:
	PartNo == 6218 ? [90,  160,  30]:
	PartNo == 6219 ? [95,  170,  32]:
	PartNo == 6220 ? [100,  180,  34]:
	PartNo == 6221 ? [105,  190,  36]:
	PartNo == 6222 ? [110,  200,  38]:
	PartNo == 6224 ? [120,  215,  40]:
	PartNo == 6226 ? [130,  230,  40]:
	PartNo == 6228 ? [140,  250,  42]:
	PartNo == 6230 ? [150,  270,  45]:
	PartNo == 6300 ? [10,  35,  11]:
	PartNo == 6301 ? [12,  37,  12]:
	PartNo == 6302 ? [15,  42,  13]:
	PartNo == 6303 ? [17,  47,  14]:
	PartNo == 6304 ? [20,  52,  15]:
	PartNo == 6305 ? [25,  62,  17]:
	PartNo == 6306 ? [30,  72,  19]:
	PartNo == 6307 ? [35,  80,  21]:
	PartNo == 6308 ? [40,  90,  23]:
	PartNo == 6309 ? [45,  100,  25]:
	PartNo == 6310 ? [50,  110,  27]:
	PartNo == 6311 ? [55,  120,  29]:
	PartNo == 6312 ? [60,  130,  31]:
	PartNo == 6313 ? [65,  140,  33]:
	PartNo == 6314 ? [70,  150,  35]:
	PartNo == 6315 ? [75,  160,  37]:
	PartNo == 6316 ? [80,  170,  39]:
	PartNo == 6317 ? [85,  180,  41]:
	PartNo == 6318 ? [90,  190,  43]:
	PartNo == 6319 ? [95,  200,  45]:
	PartNo == 6320 ? [100,  215,  47]:
	PartNo == 6321 ? [105,  225,  49]:
	PartNo == 6322 ? [110,  240,  50]:
	PartNo == 6324 ? [120,  260,  55]:
	PartNo == 6326 ? [130,  280,  58]:
	PartNo == 6328 ? [140,  300,  62]:
	PartNo == 6330 ? [150,  320,  65]:
	PartNo == 6701 ? [12,  18,  4]:
	PartNo == 6702 ? [15,  21,  4]:
	PartNo == 6703 ? [17,  23,  4]:
	PartNo == 6704 ? [20,  27,  4]:
	PartNo == 6705 ? [25,  32,  4]:
	PartNo == 6706 ? [30,  37,  4]:
	PartNo == 6707 ? [35,  44,  5]:
	PartNo == 6800 ? [10,  19,  5]:
	PartNo == 6801 ? [12,  21,  5]:
	PartNo == 6802 ? [15,  24,  5]:
	PartNo == 6803 ? [17,  26,  5]:
	PartNo == 6804 ? [20,  32,  7]:
	PartNo == 6805 ? [25,  37,  7]:
	PartNo == 6806 ? [30,  42,  7]:
	PartNo == 6807 ? [35,  47,  7]:
	PartNo == 6808 ? [40,  52,  7]:
	PartNo == 6809 ? [45,  58,  7]:
	PartNo == 6810 ? [50,  65,  7]:
	PartNo == 6811 ? [55,  72,  9]:
	PartNo == 6812 ? [60,  78,  10]:
	PartNo == 6813 ? [65,  85,  10]:
	PartNo == 6814 ? [70,  90,  10]:
	PartNo == 6815 ? [75,  95,  10]:
	PartNo == 6816 ? [80,  100,  10]:
	PartNo == 6817 ? [85,  110,  13]:
	PartNo == 6818 ? [90,  115,  13]:
	PartNo == 6819 ? [95,  120,  13]:
	PartNo == 6820 ? [100,  125,  13]:
	PartNo == 6821 ? [105,  130,  13]:
	PartNo == 6822 ? [110,  140,  16]:
	PartNo == 6824 ? [120,  150,  16]:
	PartNo == 6826 ? [130,  165,  18]:
	PartNo == 6828 ? [140,  175,  18]:
	PartNo == 6830 ? [150,  190,  20]:
	PartNo == 6200 ? [10,  30,  9]:
	PartNo == 6201 ? [12,  32,  10]:
	PartNo == 6202 ? [15,  35,  11]:
	PartNo == 6203 ? [17,  40,  12]:
	PartNo == 6204 ? [20,  47,  14]:
	PartNo == 6205 ? [25,  52,  15]:
	PartNo == 6206 ? [30,  62,  16]:
	PartNo == 6207 ? [35,  72,  17]:
	PartNo == 6208 ? [40,  80,  18]:
	PartNo == 6209 ? [45,  85,  19]:
	PartNo == 6210 ? [50,  90,  20]:
	PartNo == 6211 ? [55,  100,  21]:
	PartNo == 6212 ? [60,  110,  22]:
	PartNo == 6213 ? [65,  120,  23]:
	PartNo == 6214 ? [70,  125,  24]:
	PartNo == 6215 ? [75,  130,  25]:
	PartNo == 6216 ? [80,  140,  26]:
	PartNo == 6217 ? [85,  150,  28]:
	PartNo == 6218 ? [90,  160,  30]:
	PartNo == 6219 ? [95,  170,  32]:
	PartNo == 6220 ? [100,  180,  34]:
	PartNo == 6221 ? [105,  190,  36]:
	PartNo == 6222 ? [110,  200,  38]:
	PartNo == 6224 ? [120,  215,  40]:
	PartNo == 6226 ? [130,  230,  40]:
	PartNo == 6228 ? [140,  250,  42]:
	PartNo == 6230 ? [150,  270,  45]:
	PartNo == 6300 ? [10,  35,  11]:
	PartNo == 6301 ? [12,  37,  12]:
	PartNo == 6302 ? [15,  42,  13]:
	PartNo == 6303 ? [17,  47,  14]:
	PartNo == 6304 ? [20,  52,  15]:
	PartNo == 6305 ? [25,  62,  17]:
	PartNo == 6306 ? [30,  72,  19]:
	PartNo == 6307 ? [35,  80,  21]:
	PartNo == 6308 ? [40,  90,  23]:
	PartNo == 6309 ? [45,  100,  25]:
	PartNo == 6310 ? [50,  110,  27]:
	PartNo == 6311 ? [55,  120,  29]:
	PartNo == 6312 ? [60,  130,  31]:
	PartNo == 6313 ? [65,  140,  33]:
	PartNo == 6314 ? [70,  150,  35]:
	PartNo == 6315 ? [75,  160,  37]:
	PartNo == 6316 ? [80,  170,  39]:
	PartNo == 6317 ? [85,  180,  41]:
	PartNo == 6318 ? [90,  190,  43]:
	PartNo == 6319 ? [95,  200,  45]:
	PartNo == 6320 ? [100,  215,  47]:
	PartNo == 6321 ? [105,  225,  49]:
	PartNo == 6322 ? [110,  240,  50]:
	PartNo == 6324 ? [120,  260,  55]:
	PartNo == 6326 ? [130,  280,  58]:
	PartNo == 6328 ? [140,  300,  62]:
	PartNo == 6330 ? [150,  320,  65]:
	PartNo == 6701 ? [12,  18,  4]:
	PartNo == 6702 ? [15,  21,  4]:
	PartNo == 6703 ? [17,  23,  4]:
	PartNo == 6704 ? [20,  27,  4]:
	PartNo == 6705 ? [25,  32,  4]:
	PartNo == 6706 ? [30,  37,  4]:
	PartNo == 6707 ? [35,  44,  5]:
	PartNo == 6800 ? [10,  19,  5]:
	PartNo == 6801 ? [12,  21,  5]:
	PartNo == 6802 ? [15,  24,  5]:
	PartNo == 6803 ? [17,  26,  5]:
	PartNo == 6804 ? [20,  32,  7]:
	PartNo == 6805 ? [25,  37,  7]:
	PartNo == 6806 ? [30,  42,  7]:
	PartNo == 6807 ? [35,  47,  7]:
	PartNo == 6808 ? [40,  52,  7]:
	PartNo == 6809 ? [45,  58,  7]:
	PartNo == 6810 ? [50,  65,  7]:
	PartNo == 6811 ? [55,  72,  9]:
	PartNo == 6812 ? [60,  78,  10]:
	PartNo == 6813 ? [65,  85,  10]:
	PartNo == 6814 ? [70,  90,  10]:
	PartNo == 6815 ? [75,  95,  10]:
	PartNo == 6816 ? [80,  100,  10]:
	PartNo == 6817 ? [85,  110,  13]:
	PartNo == 6818 ? [90,  115,  13]:
	PartNo == 6819 ? [95,  120,  13]:
	PartNo == 6820 ? [100,  125,  13]:
	PartNo == 6821 ? [105,  130,  13]:
	PartNo == 6822 ? [110,  140,  16]:
	PartNo == 6824 ? [120,  150,  16]:
	PartNo == 6826 ? [130,  165,  18]:
	PartNo == 6828 ? [140,  175,  18]:
	PartNo == 6830 ? [150,  190,  20]:
	PartNo == 6900 ? [10,  22,  6]:
	PartNo == 6901 ? [12,  24,  6]:
	PartNo == 6902 ? [15,  28,  7]:
	PartNo == 6903 ? [17,  30,  7]:
	PartNo == 6904 ? [20,  37,  9]:
	PartNo == 6905 ? [25,  42,  9]:
	PartNo == 6906 ? [30,  47,  9]:
	PartNo == 6907 ? [35,  55,  10]:
	PartNo == 6908 ? [40,  62,  12]:
	PartNo == 6909 ? [45,  68,  12]:
	PartNo == 6910 ? [50,  72,  12]:
	PartNo == 6911 ? [55,  80,  13]:
	PartNo == 6912 ? [60,  85,  13]:
	PartNo == 6913 ? [65,  90,  13]:
	PartNo == 6914 ? [70,  100,  16]:
	PartNo == 6915 ? [75,  105,  16]:
	PartNo == 6916 ? [80,  110,  16]:
	PartNo == 6917 ? [85,  120,  18]:
	PartNo == 6918 ? [90,  125,  18]:
	PartNo == 6919 ? [95,  130,  18]:
	PartNo == 6920 ? [100,  140,  20]:
	PartNo == 6921 ? [105,  145,  20]:
	PartNo == 6922 ? [110,  150,  20]:
	PartNo == 6924 ? [120,  165,  22]:
	PartNo == 6926 ? [130,  180,  24]:
	PartNo == 6928 ? [140,  190,  24]:
	PartNo == 6930 ? [150,  210,  28]:
	PartNo == 16001 ? [12,  28,  7]:
	PartNo == 16002 ? [15,  32,  8]:
	PartNo == 16003 ? [17,  35,  8]:
	PartNo == 16004 ? [20,  42,  8]:
	PartNo == 16005 ? [25,  47,  8]:
	PartNo == 16006 ? [30,  55,  9]:
	PartNo == 16007 ? [35,  62,  9]:
	PartNo == 16008 ? [40,  68,  9]:
	PartNo == 16009 ? [45,  75,  10]:
	PartNo == 16010 ? [50,  80,  10]:
	PartNo == 16011 ? [55,  90,  11]:
	PartNo == 16012 ? [60,  95,  11]:
	PartNo == 16013 ? [65,  100,  11]:
	PartNo == 16014 ? [70,  110,  13]:
	PartNo == 16015 ? [75,  115,  13]:
	PartNo == 16016 ? [80,  125,  14]:
	PartNo == 16017 ? [85,  130,  14]:
	PartNo == 16018 ? [90,  140,  16]:
	PartNo == 16019 ? [95,  145,  16]:
	PartNo == 16020 ? [100,  150,  16]:
	PartNo == 16021 ? [105,  160,  18]:
	PartNo == 16022 ? [110,  170,  19]:
	// default
   BearingPartNoToDim(608); // default to 608