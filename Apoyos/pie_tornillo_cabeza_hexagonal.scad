// Pie para tornillo con cabeza hexagonal [ACCIONES EN CASA]
// (c) Jorge Medal (@oblomobka)  2015.09 
// GPL license

// Librerías que deben instalarse en Built-In library location
// según https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries 
// Se pueden encontrar aquí -> https://github.com/oblomobka/OpenSCAD/tree/master/libraries
include <oblomobka/constants.scad>
use <oblomobka/functions.scad>
use <oblomobka/transformations.scad>
use <oblomobka/solids.scad>
 
M10 = [10, 17, 6];   // [Caña, d cabeza, altura cabeza]
M8 = [8, 13, 5];

module pata_electrodomestico (  metrica = M10,
                                h_pie = 35
                                ){
                                
n = 56;

f_pie = 2.5;        // Factor que determina el diametro del pie                                
f_altura = 0.5;     // [0 : 1] Factor para determinar altura de la base y del cono del pie
f_cuello = 8;       // pared en el pico del cono

d_pie = metrica[1] * f_pie;
base_pie = h_pie * f_altura;
cono_pie = h_pie * (1 - f_altura);

juego = 0.5;
rosca = metrica[0] + juego;
cuello = rosca + f_cuello;

d_cabeza = metrica[1] + juego/2;
h_cabeza = metrica[2] + 1;                           

// PIEZA PRINCIPAL                                 

difference () {
    union () {
        prism_circumscribed ( d = d_pie, h = base_pie, n = n);
        translate( [0, 0, base_pie] )   
            pyramid_circumscribed ( d1 = d_pie, d2 = cuello, h = cono_pie, n = n );  
        }   
    translate( [0, 0, -0.1] )                
        prism_circumscribed ( d = metrica[1], h = base_pie, n = 6 );
    translate( [0, 0, base_pie+0.2] ) 
        cylinder ( d = rosca, h = h_pie * 3);
        
    for( i = [0 : 720/n : 360] ){
        rotate( [0 ,0 ,i] )
        translate( [d_pie / 2, 0, -base_pie / 2] )
        cylinder( r = side_r(d_pie / 2, n) / 2 , h = base_pie * 3, $fn = 50);
        }                                                      
    }

                                    
}
 

//sector(270)
pata_electrodomestico( metrica=M10, h_pie=40 );


