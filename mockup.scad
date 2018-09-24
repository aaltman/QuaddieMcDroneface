use <shortcuts.scad>  
use <drone.scad>
use <Naca4.scad>
//use <sweep.scad>

//shrouds();
motor_covers();
arms();
difference() {
    fuselage();
    scale(0.9,0.9,0.9) {
        fuselage();
    }
    translate([-100,-100,100])
        cube(500);
}