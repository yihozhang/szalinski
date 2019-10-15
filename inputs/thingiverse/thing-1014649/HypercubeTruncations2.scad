//A Hypercube from any angle.

/* [View Point] */

// do you want?
what_perspective = 1;//[1:From a point, 2:From infinity]

//direction do you want?
what_view = 1;//[0:arbitrary view direction (use paramters below), 1:cell centered, 2:vertex centered, 3:edge centered , 4:face centered]

//is the x coordinate of the vector pointing at the viewpoint
a1 =1;//[-10:0.1:10]

//is the y coordinate of the the vector pointing at viewpoint
a2 = 0;//[-10:0.1:10]

//is the z coordinate of the the vector pointing at viewpoint
a3 = 0;//[-10:0.1:10]

//is the w coordinate of the the vector pointing at viewpoint
a4 = 0;//[-10:0.1:10]

//is the length of the vector pointing at the viewpoint
view_distance = 75;//[5:400]


/* [Initial Vertex] */

//truncation do you want?
which = 15;//[0:Arbitrary (use the parameters),1:Hypercube, 2:16_cell, 3:Truncated Hypercube, 4:Truncated 16_cell, 5:Mid_edge Truncated Hypercube, 6:Mid_edge Truncated 16_cell (24_cell), 7:0111, 8:0101, 9:1001, 10:1010, 11:1011, 13:1101, 14:1110, 15:1111, 16, Nonconvex 1]

//is the angle in xy-plane from the x-axis to the initial vertex
b1 = 22.5;//[0:360]

//is the angle from xy-plane to the initial vertex
b2 = 60;//[-90:90]

//is the angle from xyz-space to the initial vertex
b3 = 50;//[-90:90]

//is the distance from the initial vertex to the origin
pt_radius = 65;//[5:400]

//of an edge 
min_thickness = 2;//[1:0.2:5]

//of an edge 
max_thickness = 4;//[1:0.2:10]

/*  Hidden */

plot_points = 30;//[30:100]

//The bone module generates a vertical cylinder that is capped by sphere.
module bone2(rad1,rad2,height,fn){
hull(){
translate([0,0,height])
       sphere(r=rad2,center=true,$fn=fn);
sphere(r=rad1,center=true,$fn=fn);
  }  }     
 
 // The edge module defines a bone from point p1 to point p2
 module edge2(p1,p2,rad1,rad2,fn){
     translate(p1)
     rotate(acos(([0,0,1]*(p2-p1))/norm(p2-p1)),
         (pow((p2-p1)[0],2)+pow((p2-p1)[1],2)==0 &&(p2-p1)[2]<0)?
            [1,0,0]: cross([0,0,1],p2-p1))
     bone2(rad1,rad2,norm(p2-p1),fn);
 }
 
// Polytope draws all the edges. 
module polytope2(verts,edges,dists,minrad,maxrad,plot_points){      
 for(i=[0:len(edges)-1]){
     edge2(verts[edges[i][0]],verts[edges[i][1]],
            minrad+(maxrad-minrad)*pow(1.05,-1*dists[edges[i][0]]),
            minrad+(maxrad-minrad)*pow(1.05,-1*dists[edges[i][1]]),
     plot_points);}
 }
 
scale = (what_perspective == 1)? 1: 10000;

v = (what_view == 1) ? scale*view_distance*[1,0,0,0]:
    (what_view == 2) ? scale*view_distance*[1,1,1,1]/2:
    (what_view == 3) ? scale*view_distance*[1,0,1,0]/sqrt(2):
    (what_view == 4) ? scale*view_distance*[1,1,1,0]/sqrt(3):
                       scale*view_distance*[a1,a2,a3,a4]/norm([a1,a2,a3,a4]);
   
//XB YB ZB are an orthonormal basis for the space that we project onto. 
XB = triplecross([0,0,1,0],[0,0,0,1],v)/norm(triplecross([0,0,1,0],[0,0,0,1],v));

YB = triplecross([0,0,0,1],v,XB)/norm(triplecross([0,0,0,1],v,XB));

ZB = triplecross(v,XB,YB)/norm(triplecross(v,XB,YB));
 
pt = (which == 1) ? pt_radius*[1,1,1,1]/2:
     (which == 2) ? pt_radius*[0,0,0,1]:
     (which == 3) ? pt_radius*[1,sqrt(2)-1,1,1]/sqrt(6-2*sqrt(2)):
     (which == 4) ? pt_radius*[0,0,1,2]/sqrt(5):
     (which == 5) ? pt_radius*[1,0,1,1]/sqrt(3):
     (which == 6) ? pt_radius*[0,0,1,1]/sqrt(2):
     (which == 7) ? pt_radius*[1,0,2,3]/sqrt(14):
     (which == 8) ? pt_radius*[1,0,1,2]/sqrt(6):
     (which == 9) ? pt_radius*[1,1,1,1+sqrt(2)]/norm([1,1,1,1+sqrt(2)]):
     (which == 10) ? pt_radius*[1,1,1+sqrt(2),1+sqrt(2)]/norm([1,1,1+sqrt(2),1+sqrt(2)]):
     (which == 11) ? pt_radius*[1,1,1+sqrt(2),1+2*sqrt(2)]/norm([1,1,1+sqrt(2),1+2*sqrt(2)]):
     (which == 12) ? pt_radius*[1,0,1,1]/sqrt(3):
     (which == 13) ? pt_radius*[1+sqrt(2),1,1+sqrt(2),1+2*sqrt(2)]/norm([1+sqrt(2),1,1+sqrt(2),1+2*sqrt(2)]):
     (which == 14) ? pt_radius*[1+sqrt(2),1,1+2*sqrt(2),1+2*sqrt(2)]/norm([1+sqrt(2),1,1+2*sqrt(2),1+2*sqrt(2)]):
     (which == 15) ? pt_radius*[1+sqrt(2),1,1+2*sqrt(2),1+3*sqrt(2)]/norm([1+sqrt(2),1,1+2*sqrt(2),1+3*sqrt(2)]):
     (which == 16) ? pt_radius*[-1,1+sqrt(2),-3-sqrt(2),-5-2*sqrt(2)]/norm([-1,1+sqrt(2),-3-sqrt(2),-5-2*sqrt(2)]):
     [pt_radius*cos(b1)*cos(b2)*cos(b3),
      pt_radius*sin(b1)*cos(b2)*cos(b3),
      pt_radius*sin(b2)*cos(b3),
      pt_radius*sin(b3)];  // This is the starting vertex

I4 = [[1,0,0,0],
       [0,1,0,0],
       [0,0,1,0],
       [0,0,0,1]];
       
ReX = [[-1,0,0,0],
       [0,1,0,0],
       [0,0,1,0],
       [0,0,0,1]];
       
ReY = [[1,0,0,0],
       [0,-1,0,0],
       [0,0,1,0],
       [0,0,0,1]];
       
ReZ = [[1,0,0,0],
       [0,1,0,0],
       [0,0,-1,0],
       [0,0,0,1]];
       
ReXY = [[0,1,0,0],
        [1,0,0,0],
        [0,0,1,0],
        [0,0,0,1]];
       
ReXZ = [[0,0,1,0],
        [0,1,0,0],
        [1,0,0,0],
        [0,0,0,1]];
       
ReXW = [[0,0,0,1],
        [0,1,0,0],
        [0,0,1,0],
        [1,0,0,0]];
       
ReXmW = [[0,0,0,-1],
        [0,1,0,0],
        [0,0,1,0],
        [-1,0,0,0]];
       
ReYW = [[1,0,0,0],
        [0,0,0,1],
        [0,0,1,0],
        [0,1,0,0]];
       
ReYmW = [[1,0,0,0],
        [0,0,0,-1],
        [0,0,1,0],
        [0,-1,0,0]];
       
ReZW = [[1,0,0,0],
        [0,1,0,0],
        [0,0,0,1],
        [0,0,1,0]];
       
ReZmW = [[1,0,0,0],
        [0,1,0,0],
        [0,0,0,-1],
        [0,0,-1,0]];
       
RoXY = [[0,-1,0,0],
        [1,0,0,0],
        [0,0,1,0],
        [0,0,0,1]];
       
RoXY2 = [[-1,0,0,0],
        [0,-1,0,0],
        [0,0,1,0],
        [0,0,0,1]];
       
RoXY3 = [[0,1,0,0],
        [-1,0,0,0],
        [0,0,1,0],
        [0,0,0,1]];
       
ReZ = [[1,0,0,0],
        [0,1,0,0],
        [0,0,-1,0],
        [0,0,0,1]];
       
ReW = [[1,0,0,0],
        [0,1,0,0],
        [0,0,1,0],
        [0,0,0,-1]];
   
// These are the vertices in 4D.
THcube_verts4D = 
     [for (l = [I4,ReW,ReZW,ReZmW,ReYW,ReYmW,ReXW,ReXmW],
           k = [I4,ReXZ,RoXY*ReXZ,RoXY2*ReXZ,RoXY3*ReXZ,ReXZ*RoXY2*ReXZ],
           j = [I4,RoXY,RoXY2,RoXY3],
           i = [I4,ReXY]
           )
             l*k*j*i*pt];
            
// These are the vertices projected into 3D.  
 THcube_verts = [for (i = [0:len(THcube_verts4D)-1])
                      project(THcube_verts4D[i],v,XB,YB,ZB)];

// This calculates the distance from each vertex to the viewpoint.
 THcube_dists = [for (i = [0:len(THcube_verts4D)-1])
                      norm(v-THcube_verts4D[i])];

//All of the edges 
THcube_edges = 
      [/* Begin Outside */
       [0,1],[1,2],[2,3],[3,4],[4,5],[5,6],[6,7],[7,0],
       [8,9],[9,10],[10,11],[11,12],[12,13],[13,14],[14,15],[15,8],
         [0,8],[7,15],
       [16,17],[17,18],[18,19],[19,20],[20,21],[21,22],[22,23],[23,16],
         [1,23],[2,16],[22,9],[21,10],
       [24,25],[25,26],[26,27],[27,28],[28,29],[29,30],[30,31],[31,24],
         [4,24],[3,31],[30,17],[29,18],
       [32,33],[33,34],[34,35],[35,36],[36,37],[37,38],[38,39],[39,32],
         [5,39],[6,32],[14,33],[13,34],[25,38],[26,37],
       [40,41],[41,42],[42,43],[43,44],[44,45],[45,46],[46,47],[47,40],
         [11,47],[12,40],[41,35],[42,36],[43,27],[44,28],[45,19],[46,20],
       /*  End Outside */
       /*  Begin Inside */
       [48,49],[49,50],[50,51],[51,52],[52,53],[53,54],[54,55],[55,48],
       [56,57],[57,58],[58,59],[59,60],[60,61],[61,62],[62,63],[63,56],
         [48,56],[55,63],
       [64,65],[65,66],[66,67],[67,68],[68,69],[69,70],[70,71],[71,64],
         [49,71],[50,64],[70,57],[69,58],
       [72,73],[73,74],[74,75],[75,76],[76,77],[77,78],[78,79],[79,72],
         [52,72],[51,79],[78,65],[77,66],
       [80,81],[81,82],[82,83],[83,84],[84,85],[85,86],[86,87],[87,80],
         [53,87],[54,80],[62,81],[61,82],[73,86],[74,85],
       [88,89],[89,90],[90,91],[91,92],[92,93],[93,94],[94,95],[95,88],
         [59,95],[60,88],[89,83],[90,84],[91,75],[92,76],[93,67],[94,68],
       /*  End Inside */
       /* Begin Top */
       [96,97],[97,98],[98,99],[99,100],
       [100,101],[101,102],[102,103],[103,96],
       [104,105],[105,106],[106,107],[107,108],
       [108,109],[109,110],[110,111],[111,104],
         [96,104],[103,111],
       [112,113],[113,114],[114,115],[115,116],
       [116,117],[117,118],[118,119],[119,112],
         [97,119],[98,112],[118,105],[117,106],
       [120,121],[121,122],[122,123],[123,124],
       [124,125],[125,126],[126,127],[127,120],
         [100,120],[99,127],[126,113],[125,114],
       [128,129],[129,130],[130,131],[131,132],
       [132,133],[133,134],[134,135],[135,128],
         [101,135],[102,128],[110,129],[109,130],[121,134],[122,133],
       [136,137],[137,138],[138,139],[139,140],
       [140,141],[141,142],[142,143],[143,136],
         [107,143],[108,136],[137,131],[138,132],
         [139,123],[140,124],[141,115],[142,116],
       /*  End Top */
       /* Outside to Top Connections */
       [0,96],[1,97],[2,98],[3,99],
       [4,100],[5,101],[6,102],[7,103],
       /* Inside to Top Connections */
       [48,143],[49,142],[50,141],[51,140],
       [52,139],[53,138],[54,137],[55,136],
       /*  Top to Front Connections */
       [112,194],[113,195],[114,196],[115,197],
       [116,198],[117,199],[118,192],[119,193],
       /*  Top to Back Connections */
       [128,246],[129,247],[130,240],[131,241],
       [132,242],[133,243],[134,244],[135,245],
       /*  Top to Right Connections */
       [104,288],[105,289],[106,290],[107,291],
       [108,292],[109,293],[110,294],[111,295],
       /*  Top to Left Connections */
       [120,340],[121,341],[122,342],[123,343],
       [124,336],[125,337],[126,338],[127,339],
       /*  Begin Bottom */
       [144,145],[145,146],[146,147],[147,148],
       [148,149],[149,150],[150,151],[151,144],
       [152,153],[153,154],[154,155],[155,156],
       [156,157],[157,158],[158,159],[159,152],
         [144,152],[151,159],
       [160,161],[161,162],[162,163],[163,164],
       [164,165],[165,166],[166,167],[167,160],
         [145,167],[146,160],[166,153],[165,154],
       [168,169],[169,170],[170,171],[171,172],
       [172,173],[173,174],[174,175],[175,168],
         [148,168],[147,175],[174,161],[173,162],
       [176,177],[177,178],[178,179],[179,180],
       [180,181],[181,182],[182,183],[183,176],
         [149,183],[150,176],[158,177],[157,178],[169,182],[170,181],
       [184,185],[185,186],[186,187],[187,188],
       [188,189],[189,190],[190,191],[191,184],
         [155,191],[156,184],[185,179],[186,180],
         [187,171],[188,172],[189,163],[190,164],
       /*  End Bottom */
       /* Outside to Bottom Connections */
       [40,184],[41,185],[42,186],[43,187],
       [44,188],[45,189],[46,190],[47,191],
       /* Inside to Bottom Connections */
       [88,151],[89,150],[90,149],[91,148],
       [92,147],[93,146],[94,145],[95,144],
       /*  Bottom to Front Connections */
       [160,234],[161,235],[162,236],[163,237],
       [164,238],[165,239],[166,232],[167,233],
       /*  Bottom to Back Connections */
       [176,286],[177,287],[178,280],[179,281],
       [180,282],[181,283],[182,284],[183,285],
       /*  Bottom to Right Connections */
       [152,332],[153,333],[154,334],[155,335],
       [156,328],[157,329],[158,330],[159,331],
       /*  Bottom to Left Connections */
       [168,376],[169,377],[170,378],[171,379],
       [172,380],[173,381],[174,382],[175,383],
       /* Begin Front */
       [192,193],[193,194],[194,195],[195,196],
       [196,197],[197,198],[198,199],[199,192],
       [200,201],[201,202],[202,203],[203,204],
       [204,205],[205,206],[206,207],[207,200],
         [192,200],[199,207],
       [208,209],[209,210],[210,211],[211,212],
       [212,213],[213,214],[214,215],[215,208],
         [193,215],[194,208],[214,201],[213,202],
       [216,217],[217,218],[218,219],[219,220],
       [220,221],[221,222],[222,223],[223,216],
         [196,216],[195,223],[222,209],[221,210],
       [224,225],[225,226],[226,227],[227,228],
       [228,229],[229,230],[230,231],[231,224],
         [197,231],[198,224],[206,225],[205,226],[217,230],[218,229],
       [232,233],[233,234],[234,235],[235,236],
       [236,237],[237,238],[238,239],[239,232],
         [203,239],[204,232],[233,227],[234,228],
         [235,219],[236,220],[237,211],[238,212],
       /*  End Front */
       /*  Outside to Front Connections */
       [16,208],[17,209],[18,210],[19,211],
       [20,212],[21,213],[22,214],[23,215],
       /*  Inside to Front Connections */
       [71,224],[70,225],[69,226],[68,227],
       [67,228],[66,229],[65,230],[64,231],
       /*  Front to Right Connections */
       [200,311],[201,310],[202,309],[203,308],
       [204,307],[205,306],[206,305],[207,304],
       /*  Front to Left Connections */
       [216,359],[217,358],[218,357],[219,356],
       [220,355],[221,354],[222,353],[223,352],
       /*  Begin Back */
       [240,241],[241,242],[242,243],[243,244],
       [244,245],[245,246],[246,247],[247,240],
       [248,249],[249,250],[250,251],[251,252],
       [252,253],[253,254],[254,255],[255,248],
         [240,248],[247,255],
       [256,257],[257,258],[258,259],[259,260],
       [260,261],[261,262],[262,263],[263,256],
         [241,263],[242,256],[262,249],[261,250],
       [264,265],[265,266],[266,267],[267,268],
       [268,269],[269,270],[270,271],[271,264],
         [244,264],[243,271],[270,257],[269,258],
       [272,273],[273,274],[274,275],[275,276],
       [276,277],[277,278],[278,279],[279,272],
         [245,279],[246,272],[254,273],[253,274],[265,278],[266,277],
       [280,281],[281,282],[282,283],[283,284],
       [284,285],[285,286],[286,287],[287,280],
         [251,287],[252,280],[281,275],[282,276],
         [283,267],[284,268],[285,259],[286,260],
       /*  End Back */
       /*  Outside to Back Connections */
       [32,272],[33,273],[34,274],[35,275],
       [36,276],[37,277],[38,278],[39,279],
       /*  Inside to Back Connections */
       [87,256],[86,257],[85,258],[84,259],
       [83,260],[82,261],[81,262],[80,263],
       /*  Back to Right Connections */
       [248,327],[249,326],[250,325],[251,324],
       [252,323],[253,322],[254,321],[255,320],
       /*  Back to Left Connections */
       [264,375],[265,374],[266,373],[267,372],
       [268,371],[269,370],[270,369],[271,368],
       /*  Begin Right */
       [288,289],[289,290],[290,291],[291,292],
       [292,293],[293,294],[294,295],[295,288],
       [296,297],[297,298],[298,299],[299,300],
       [300,301],[301,302],[302,303],[303,296],
         [288,296],[295,303],
       [304,305],[305,306],[306,307],[307,308],
       [308,309],[309,310],[310,311],[311,304],
         [289,311],[290,304],[310,297],[309,298],
       [312,313],[313,314],[314,315],[315,316],
       [316,317],[317,318],[318,319],[319,312],
         [292,312],[291,319],[318,305],[317,306],
       [320,321],[321,322],[322,323],[323,324],
       [324,325],[325,326],[326,327],[327,320],
         [293,327],[294,320],[302,321],[301,322],[313,326],[314,325],
       [328,329],[329,330],[330,331],[331,332],
       [332,333],[333,334],[334,335],[335,328],
         [299,335],[300,328],[329,323],[330,324],
         [331,315],[332,316],[333,307],[334,308],
       /*  End Right */
       /*  Outside to Right Connections */
       [8,296],[9,297],[10,298],[11,299],
       [12,300],[13,301],[14,302],[15,303],
       /*  Inside to Right Connections */
       [56,319],[57,318],[58,317],[59,316],
       [60,315],[61,314],[62,313],[63,312],
       /*  Begin Left */
       [336,337],[337,338],[338,339],[339,340],
       [340,341],[341,342],[342,343],[343,336],
       [344,345],[345,346],[346,347],[347,348],
       [348,349],[349,350],[350,351],[351,344],
         [336,344],[343,351],
       [352,353],[353,354],[354,355],[355,356],
       [356,357],[357,358],[358,359],[359,352],
         [337,359],[338,352],[358,345],[357,346],
       [360,361],[361,362],[362,363],[363,364],
       [364,365],[365,366],[366,367],[367,360],
         [340,360],[339,367],[366,353],[365,354],
       [368,369],[369,370],[370,371],[371,372],
       [372,373],[373,374],[374,375],[375,368],
         [341,375],[342,368],[350,369],[349,370],[361,374],[362,373],
       [376,377],[377,378],[378,379],[379,380],
       [380,381],[381,382],[382,383],[383,376],
         [347,383],[348,376],[377,371],[378,372],
         [379,363],[380,364],[381,355],[382,356],
       /*  End Left */
       /*  Outside to Left Connections */
       [24,360],[25,361],[26,362],[27,363],
       [28,364],[29,365],[30,366],[31,367],
       /*  Inside to Left Connections  */
       [72,351],[73,350],[74,349],[75,348],
       [76,347],[77,346],[78,345],[79,344],
              ];
 
// The cross product in 4D
function triplecross(v1,v2,v3) = 
         [v1[1]*(v2[2]*v3[3]-v2[3]*v3[2])
         -v1[2]*(v2[1]*v3[3]-v2[3]*v3[1])
         +v1[3]*(v2[1]*v3[2]-v2[2]*v3[1]),
             -v1[0]*(v2[2]*v3[3]-v2[3]*v3[2])
             +v1[2]*(v2[0]*v3[3]-v2[3]*v3[0])
             -v1[3]*(v2[0]*v3[2]-v2[2]*v3[0]),
                   v1[0]*(v2[1]*v3[3]-v2[3]*v3[1])
                  -v1[1]*(v2[0]*v3[3]-v2[3]*v3[0])
                  +v1[3]*(v2[0]*v3[1]-v2[1]*v3[0]),
                       -v1[0]*(v2[1]*v3[2]-v2[2]*v3[1])
                       +v1[1]*(v2[0]*v3[2]-v2[2]*v3[0])
                       -v1[2]*(v2[0]*v3[1]-v2[1]*v3[0])];

//Convert the 4D shadow to 3D coordinates                    
function project(p,V,xb,yb,zb,) = 
    [xb*shadow(p,V),yb*shadow(p,V),zb*shadow(p,V)];

// In 4D this calculates the point on the shadow of point p viewed from V
function shadow(p,V)=
    V-((V*V)/((p-V)*V)*(p-V));

// This is the object that is plotted
polytope2(THcube_verts,THcube_edges,THcube_dists,
                min_thickness,max_thickness,plot_points);
 
 //programmed by Will Webber 2015