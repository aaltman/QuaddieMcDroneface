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

//hollow_fuse_front();

/*echo(airfoil_data(33));
af = airfoil_data(33);
npoints = len(af);
af_z = [for (n = [0:npoints - 1])
        af[n][1]];
echo(af_z);

function f(t) = [
    (t / 1.5 + 0.5) * 100 * cos(6 * 360 * t),
    (t / 1.5 + 0.5) * 100 * sin(6 * 360 * t),
    af_z[0.005 * 200]
]; */

function shape() = [
    [-10, -1],
    [-10,  6],
    [ -7,  6],
    [ -7,  1],
    [  7,  1],
    [  7,  6],
    [ 10,  6],
    [ 10, -1]];

step = 0.005;
path = [for (t=[0:step:1-step]) f(t)];
//path_transforms = construct_transform_path(path);
//sweep(shape(), path_transforms);

//echo(elliptical_path(40,10,40,360,$fa=5));
//translational_sweep(elliptical_path(40,10,40,360,$fa=5)) circle(5);

module translational_sweep(path) {
    dz = h/(len(path)-1);
    for(i=[0:len(path)-2]){
        hull(){
            translate(path[i])
                linear_extrude(0.001) children();
            translate(path[i+1])
                linear_extrude(0.001) children();
        }
    }
}

function elliptical_path(a,b,h,ang) =
    [ for(x=[0:$fa:ang]) [a*cos(x), b*sin(x), h*x/ang] ]; 

//polygon(shape());
    
//polygon(airfoil_data(33));
module longitudinal_ribs() {
    for (i=[0:7]) {
        rotate([45*i,0,0])
            difference() {
                polygon(airfoil_data(33));    
                scale([1.2,0.8,1])
                    polygon(airfoil_data(33));
            }
    }
}

longitudinal_ribs();
