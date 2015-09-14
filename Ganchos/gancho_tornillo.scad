// Gancho atornillable [ACCIONES EN CASA]
// (c) Jorge Medal (@oblomobka)  2015.09 
// GPL license

// Librerías que deben instalarse en Built-In library location
// según https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries 
// Se pueden encontrar aquí -> https://github.com/oblomobka/OpenSCAD/tree/master/libraries
include <oblomobka/constants.scad>
use <oblomobka/functions.scad>
use <oblomobka/transformations.scad>
use <oblomobka/solids.scad>

//

module gancho_atornillable( angulo=180,
                            d=25,
                            pared=3,
                            remate=0,
                            longitud=50,
                            tornillo=[4,20,8]      // [ d_caña, long caña, d_cabeza ]
                            ){

$fn=100;
                                
d_cabeza=tornillo[2];
d_tornillo=tornillo[0];                               

ajuste=1.8;
base_tornillo=d_cabeza+ajuste+4;
base_gancho=5;

extrusion=d_cabeza+ajuste+2;

f_soporte= (base_tornillo+d/2+pared)/longitud;
    
    union(){
        // Arco
        mirror([1,0,0]){
            mirror([0,1,0])
               tube(tube=[d,pared,extrusion],angle=360-angulo,mode=3,extreme=0,res=50);
            
            // Remate arco
            if(remate==0){
                rotate([0,0,angulo])
                    translate([d/2+0.5*pared,0,0])   
                        cylinder(d=pared,h=extrusion);
                }
            if(remate==1){
                rotate([0,0,angulo])
                    translate([d/2+0*pared,0,0])   
                        cylinder(d=pared*2,h=extrusion);
                }
            if(remate==2){
                rotate([0,0,angulo])
                    translate([d/2+1*pared,0,0])   
                        cylinder(d=pared*2,h=extrusion);
                }   
            }
   
    // Soporte
    difference(){   
        scale([f_soporte,1,1])
            translate([0,longitud-d/2-pared])
                rotate(180)
                    sector(90)
                        cylinder(r=longitud, h=extrusion);
            
        cylinder(d=d,h=2*extrusion+3,center=true);

        translate([-d/2,0,-0.5])
            cube([d,longitud+1,extrusion+1]);
            
        // Resta del hueco para el tornillo
        // Cabeza
        translate([-((d_cabeza+2)/2+pared+d/2),longitud-d/2-pared-base_gancho,extrusion/2])
            rotate([90,0,0])
            cylinder(d=d_cabeza+ajuste, h=longitud, $fn=50);
        
        // Caña
        translate([-((d_cabeza+2)/2+pared+d/2),longitud-d/2,extrusion/2])
            rotate([90,0,0])
            cylinder(d=d_tornillo+1, h=longitud,$fn=50);
        
        }

    }

}

  
angulo=150;
d=30;
pared=5;
longitud=50;

gancho_atornillable(angulo=angulo,d=d,pared=pared,remate=0,longitud=longitud,tornillo=[4,20,8]);
