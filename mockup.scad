use <shortcuts.scad>  
use <drone.scad>
use <Naca4.scad>
use <sweep.scad>

//shrouds();
//motor_covers();
//arms();

module hollow_fuse_front() {
    difference() {
        fuselage();
        scale(0.98,0.98,0.98) {
            fuselage();
        }
        translate([-100,-100,100])
            cube(500);
    }
}

module longitudinal_ribs() {
    difference() {
        translate([0,0,-20])
        rotate([0,-90,0])
        scale(3 / 1.2)
        for (i=[0:7]) {
            rotate([45*i,0,0])
                // To get it to fit inside: not quite right math though - scale(1/1.2)
                linear_extrude(0.5) {
                    difference() {
                        polygon(airfoil_data(33));
                        scale([1.4,0.9,1])
                            polygon(airfoil_data(33));
                    }
                }
        }
        
        // Punch out the front so I can run wires through.
        translate([0,0,-250])
        linear_extrude(500)
        circle(17);
    }
}

module diagonal_rib_intersecting_plane() {
    translate([-50,-20,-20])
        rotate([60,0,0])
            cube([500,500,2]);
    
}

module diagonal_rib() {
    intersection() {
        hollow_fuse_front();
        diagonal_rib_intersecting_plane();
    }
}

module diagonal_ribs() {
    step_size_degrees = 90;
    for(step=[0:360 / step_size_degrees]) {
        rotate([0,0,step * step_size_degrees])
            diagonal_rib();
    }
}

//hollow_fuse_front();
diagonal_ribs();
longitudinal_ribs();