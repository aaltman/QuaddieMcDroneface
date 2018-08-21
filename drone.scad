// Sampler.scad - library for parametric airfoils of 4 digit NACA series
// Code: Rudolf Huttary, Berlin 
// June 2015
// commercial use prohibited

use <shortcuts.scad>  // see: http://www.thingiverse.com/thing:644830
use <naca4.scad>
 
default_af = 33; // NACA 0033 - pretty fat, good stall behavior
prop_length = 153;
prop_radius = prop_length / 2;
arm_body_section_length = 40;
 
module arm_cross_section()
{
    scale(0.2)
    polygon(points = airfoil_data(32));    
}

module arm_near_body()
{
    linear_extrude(height = arm_body_section_length, scale = 0.6)
    arm_cross_section();
}

module arm_near_prop()
{
    T(0,0,arm_body_section_length)
    linear_extrude(height = prop_radius + 5, scale = 1)
    scale(0.6)
    arm_cross_section();
}

module arm()
{
    arm_near_body();
    arm_near_prop();
}

module arms()
{
    T(0,0,40)
    {
        R(45,-90,0)
        arm();
        R(135,-90,0)
        arm();
        R(225,-90,0)
        arm();
        R(315,-90,0)
        arm();
    }
}

arms();
 
module fuselage()
{
    scale([0.8, 1.2])
    rotate_extrude()
    Rz(90)
    scale(1.8)
    difference()
    {
        polygon(points = airfoil_data(default_af)); 
        square(100, 100); 
    }    
}
fuselage();
 
T(350,0,0)
place_in_rect(110, 70) // arange that stuff in a grid
{
// duct
  T(50, 30, 0)
  rotate_extrude($fn = 100)
  translate([30, 100, 0])
  R(0, -180, 90)
  polygon(points = airfoil_data([-.1, .4, .1], L=100)); 

// some winding airfoils
linear_extrude(height = 100, twist = 30, scale = .5)
  polygon(points = airfoil_data(30)); 
}




