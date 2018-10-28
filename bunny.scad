//Etch-a-SCAD
/*************************************************
 * In this example, we will be drawing a bunny.
 ************************************************/
 
 /*************************************************
 * Variables
 ************************************************/
 resolution = 100;
 
 
 /*************************************************
 * Primitive/Base Modules
 ************************************************/

/***************************************************
*Module of a cube dependent on the length, width, and height
***************************************************/

module cube_base(length, width, height){
     cube(size = [length, width, height], center = true);
 }

 /***************************************************
*Module of a simple cube with the only variable as length
***************************************************/
 
 module simple_cube_base(length){//, width, height){
     //cube(size = [length, width, height], center = true);
     cube(length, center = true);
 }
 
/***************************************************
*Module of a cylinder dependent on the hieght and radius
***************************************************/
 module cylinder_base(radius, height){
     cylinder(r = radius, h = height, $fn = resolution, center = true);
 }
 /***************************************************
*Module of a cone dependent on the hieght and radius of the bottom and the top
***************************************************/
 
 module cone_base(radius1, radius2, height){
     cylinder(r1 = radius1, r2 = radius2, h = height, $fn = resolution, center = true);
 }
 
/***************************************************
*Module of a sphere dependent on the radius
***************************************************/
 module sphere_base(radius){
     sphere(radius, $fn = resolution, center = true);
 }
 
 /*
 //Examples for each primitive/base module
 
 translate([0, 20, 0]) - would translate 20 in the y direction
 
 simple_cube_base(10); - would create a cube of length 10
 
 cube_base(10, 20, 30); - would  create a cube with proportions 10, 20, and 30
 
 translate([20, 0, 0]) - would translate 20 in the x direction

 cylinder_base(10, 10); - would create a cylinder with a radius of 10 and height of 10
 
 translate([-20, 0, 0]) - would translate -20 in the x direction
 c
 one_base(10, 5, 10); - would create a cone with the base radius of 10, top radius of 5, and hieght of 10

 translate([45, 0, 0]) - would translate 45 in the x direction
 
 sphere_base(10);- would create a sphere of radius 10
 */

 //Assigned variables for further use
 body_size   = 80;
 head_size   = 40;
 foot_rad    = 15;
 foot_length = body_size; //Body size is the same size as foot length
 
 //Torso
rotate([0, 20, 0]) //Rotated 20° in the y direction
scale([0.65, 0.75, 1])//Scale uses a 1x3 array ([x, y, z]) to change the dimensions of whatever comes after it.  A scale of 1 is the original number.
sphere_base(body_size);
 
 //Head
 translate([sin(20) * body_size + 10, 0, cos(20) * body_size + 10]) //The head is translated so that their is a straight line going through the base of the torso to the top of the head
 sphere_base(head_size);
     
 //left ear
 module Left_ear(){
     difference(){ //Subtracts two elipsoids to create ear shape
     rotate([-10,-30,60]) //Rotate -10° in the x direction and 60° in the z direction
     translate([0.6 * body_size, -40, body_size + 40])//Moves the ear over so that it is centered in a good position on the head
     scale([0.10,0.30,0.80])
         //This is what creates the eliptical shape
     sphere_base(head_size);
     rotate([-10,-31,60]) //Rotate -10° in the x direction and 60° in the z direction
     translate([0.61 * body_size, -40, body_size + 40])//Moves the ear over
     scale([0.10,0.28,0.80])//scaled so that it will subtract from the larger ear to create the outer portion of the ear
     sphere_base(head_size);
     }
 }
 
 //Execute Left ear
 Left_ear();
 
 //Right ear
 Left_ear();
    mirror([0,1,0])
    translate([1,0,0])
    Left_ear(); //executes the left ear module but mirrors it
 
 //Left Foot Module
 module Left_foot(){
     union(){ //Connecting the feet to the body
         translate([body_size * 0.25, body_size * 0.55, -body_size * 0.8])//Translate to be underneith the torso
         {
             rotate([0, 90, 0]) //Rotated 90° in the y direction
             cylinder_base(foot_rad, foot_length);//Calling varibales specified above
             translate([-foot_length * 0.5, 0, 0])//Translated to the base of the cylinder
             sphere_base(foot_rad);//Gives a rounded end to the cylinder
         }
     }
 }
 //Execute Left foot 
 Left_foot();
 
 //Right Foot
Left_foot();
    mirror([0,1,0])
    translate([1,0,0])
    Left_foot(); //Mirror the left foot to become the right foot
 
 //Left Arm Module
 module Left_Arm(){
  union(){ //Connecting the arm to the body
      translate([body_size * 0.50, body_size * 0.4, -body_size * -0.2])//Translate to be inside the torso
         {
             rotate([0, 120, 0]) //Rotated 90° in the y direction
             cylinder_base(0.8 * foot_rad, foot_length);//Calling varibales specified above
             translate([-foot_length * 0.5, 0, 0])//Translated to the base of the cylinder
             
             sphere_base(foot_rad);//Gives a rounded end to the cylinder
         }
     }
 }
 //Execute left arm
 Left_Arm();
 
 //Rigth Arm
 Left_Arm();
    mirror([0,1,0])
    translate([1,0,0])
    Left_Arm(); //Mirror the left arm to become the right foot
             
 //Tail
 scale([1, 0.75, 0.60])//Scale uses a 1x3 array ([x, y, z]) to change the dimensions of whatever comes after it.  A scale of 1 is the original number.
 translate([-50,0,-70])//translate -50 units in the x direction and -70 units in the z direction
 sphere_base(30);//Pulls sphere module
 
 //Nose
 
 translate([78,0,80]) sphere_base(5);
 
 
 //Wiskers
translate([78,0,80]) rotate([45,0,0])cylinder_base(1,30);
translate([78,0,80]) rotate([135,0,0])cylinder_base(1,30);
translate([78,0,80]) rotate([90,0,0])cylinder_base(1,30);
 
 //Left eye
 module Left_eye(){
     translate([70,15,95]) sphere_base(7);
 }
 Left_eye();
    mirror([0,1,0])
    translate([1,0,0])
    Left_eye();
 
 
 