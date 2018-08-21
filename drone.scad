// Sampler.scad - library for parametric airfoils of 4 digit NACA series
// Code: Rudolf Huttary, Berlin 
// June 2015
// commercial use prohibited

use <shortcuts.scad>  // see: http://www.thingiverse.com/thing:644830
use <naca4.scad>
use <Ducted_Fan.scad>

module shrouds() {
    R(180,0,0) {
        z_offset = -40;
        xy_offset = 85;
        T(xy_offset, xy_offset, z_offset)
        slice_extruded();
        T(xy_offset, -xy_offset, z_offset)
        slice_extruded();
        T(-xy_offset, -xy_offset, z_offset)
        slice_extruded();
        T(-xy_offset, xy_offset, z_offset)
        slice_extruded();
    }    
}

shrouds();
 
default_af = 33; // NACA 0033 - pretty fat, good stall behavior
prop_length = 153;
prop_radius = prop_length / 2;
arm_body_section_length = 40;
 
module arm_cross_section()
{
    scale(0.35)
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

module motor_cover()
{
    difference()
    {
        rotate_extrude()
        Rz(90)
        scale(0.8) // A little bigger than 1cm radius
        difference()
        {
            polygon(points = airfoil_data(default_af)); 
            square(100, 100);
        }      
        T(-50,-50,20)
        cube(100);
    }
}

module motor_covers()
{
    xy_offset = 85;
    z_offset = 40;
    T(xy_offset, xy_offset, z_offset)
    motor_cover();
    T(xy_offset, -xy_offset, z_offset)
    motor_cover();
    T(-xy_offset, -xy_offset, z_offset)
    motor_cover();
    T(-xy_offset, xy_offset, z_offset)
    motor_cover();
}
motor_covers();
 
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




