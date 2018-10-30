{module wing() {            // module to draw one wing; the other side is a mirror image
    scale([4, 0.5, 1]) {    // stretches sin waves into wing shape
        for (height = [-3:3]) { //gives the wing depth along the y axis, by layering
            width =  15 - 1.5 * height; 
            
            for (b = [0:90]) {      // this loop just draws out a sin wave
                
                p = 20 * sin(b);
                q = b/width;
                //echo("sin b is", p);
                translate ([q, p, height]) {    // this actually plots the wave
                    sphere(r=1, $fn=5);         //sin wave is made from small spheres
                    
                }
            }
        }
    }
}    
    
module torso() {    // draws a stretched out circle which is the duck's torso
    translate([0, 0, -1]) {
        rotate([0, 0, 0]) { // orients it
            scale([1, 1.75, 1]) sphere(r=4, $fn=30);
        }
    }
}   

torso();           

rotate([90, 0, 0]) wing();                      // draws one wing
mirror([1,0,0]) rotate([90, 0, 0]) wing();      // mirrors the first wing


     


module eye() {          // uses difference function to cut out elipsoid from the head
    
    difference() {
        {translate([15, 0, 50]) {
            scale([1.1, 1.05, 1.15]) sphere(r=20, $fn = 30);
        }}
        {translate([35, 10, 60]) {
            scale([0.5, 1, 1]) sphere(r=6.5, $fn = 60);
        }}
        
        {translate([35, -10, 60]) {
            scale([0.5, 1, 1]) sphere(r=6.5, $fn = 60);
        }}
    }    
}


module halfbeak() {                 
    scale([4, 0.5, 1]) {
        for (height = [-3:3]) {
            width =  15 - 1.5 * height;     // varies the width of the sin wave
                                            //   so as to provid a gradient
                                            //    for the beak
            
            for (b = [0:90]) {              // graph sin function from 0 to 90 deg.
                
                p = 20 * sin(b);
                q = b/width;                // stretches sin function
                //echo("sin b is", p);
                translate ([q, p, height]) {    // determines coordinates for each point
                    sphere(r=1, $fn=20);        // does the actual plotting
                    
                }
            }
        }
    }
    

}



module beak() {                     
    translate ([50, 0, -52]) {  //puts beak in position
        mirror([1, 0, 0]) {
            halfbeak();             //draws half a beak
            mirror ([0, 1, 0]) {   // mirrors one half in order create other 
                halfbeak();
            }
        }
    }
}

module head() {                     //positions eyes and beak (relative to each other)
    translate([25, 0, -25]) {
        eye();
        translate([0, 0, 100]) {
            beak();
        }
    }
    
}


scale([0.15, 0.15, 0.15]) rotate([0, 0, 90]) head();    //scales and rotates head
}


module ripple (a, b, c) {           
                                
    aa = a-40;                       // conveniently ofsets the sin waves of known
                                    // length so that 0, 0, 0, corresponds to center

    bb = b-40 ;
    cc = c-10;
    
    translate([aa, bb, cc]) {       // translates to re-centered coordinates
        scale([3/5, 1, 1/5]) rotate([90, 0, 0]) union(){  //  makes a row of sin waves
            for (b = [0:1000]) {
                
                p = 20 * sin(b);
                q = b/10;           //stretch
                //echo("sin b is", p);
                translate ([q, p, c]) {
                    color("blue", 0.65) sphere(r=1, $fn=5);     // does the plotting
                    
                }
            }
        }
    }
}

$fn = 3; // should make the rendering a bit easier for openscad

//Cr

for (w= [0:3.5:60]) {                   // plots a series of offset sine 
                                        // waves next to each other
        color("blue", 0.2) ripple(0, w, 0);
        color("blue", 0.9) ripple(10, w+2, 0);
}

translate([-5, -5, 0]) {
    rotate ([0, 0, 90]) {               //rotates the "waves" 90 degrees
        for (w= [0:3.5:60]) {  
                color("blue", 0.2) ripple(0, w, 0);
                color("blue", 0.9) ripple(10, w+2, 0);
        }
    }
}
        
    
