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
 module cube_base(length, width, height){
     cube(size = [length, width, height], center = true);
 }
 
 module simple_cube_base(length){//, width, height){
     //cube(size = [length, width, height], center = true);
     cube(length, center = true);
 }
 
 module cylinder_base(radius, height){
     cylinder(r = radius, h = height, $fn = resolution, center = true);
 }
 
 module cone_base(radius1, radius2, height){
     cylinder(r1 = radius1, r2 = radius2, h = height, $fn = resolution, center = true);
 }
 
 module sphere_base(radius){
     sphere(radius, $fn = resolution, center = true);
 }
 
 /*
 //Examples for each primitive/base module
 translate([0, 20, 0])
 simple_cube_base(10);
 cube_base(10, 20, 30);
 translate([20, 0, 0])
 cylinder_base(10, 10);
 translate([-20, 0, 0])
 cone_base(10, 5, 10);
 translate([45, 0, 0])
 sphere_base(10);*/
 
 body_size   = 80;
 head_size   = 40;
 foot_rad    = 15;
 foot_length = body_size; 
 //Torso

rotate([0, 20, 0])
scale([0.65, 0.75, 1])//Scale uses a 1x3 array ([x, y, z]) to change the dimensions of whatever comes after it.  A scale of 1 is the original number.
sphere_base(body_size);
 //Head
 translate([sin(20) * body_size + 10, 0, cos(20) * body_size + 10])
 sphere_base(head_size);
     //Nose
     //Eyes
     //Whiskers
     //Teeth
     //Mouth
     //Ears (right, and left)

 //Feet
 
 union(){
     translate([body_size * 0.25, body_size * 0.55, -body_size * 0.8]){
         rotate([0, 90, 0])
         cylinder_base(foot_rad, foot_length);
         translate([-foot_length * 0.5, 0, 0])
         sphere_base(foot_rad);
     }
 }
 //Tail
 