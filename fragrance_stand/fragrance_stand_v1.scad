include <utils.scad>

// 150mm radius
cutout_radius = 18;
num_holes = 24;
num_rows =3 ;
spacing = 8;
border_width = 0;
b_width = spacing + ((cutout_radius + spacing) * (num_holes/num_rows));
b_length = spacing + ((cutout_radius + spacing) * num_rows);
b_height = 25;
echo("LENGTH: ", b_length);
echo("WIDTH: ", b_width);

module hole(row, column) {
    x = spacing + (cutout_radius / 2) + (column * (cutout_radius + spacing));
    y = spacing + (cutout_radius / 2) + (row * (cutout_radius + spacing));
    color("blue")
    translate([x+border_width, y+border_width, 5])
    cylinder(h=30, d=cutout_radius);
}

difference() {
    // base
    // utils.scad
    roundedcube([b_width, b_length, b_height], false, 4, "zmax");
    
    //cube([b_width, b_length, b_height]);

    for (row=[0:num_rows-1],column = [0:num_holes/num_rows-1]) {
       hole(row,column);
    }
}



font="Hurmit Nerd Font Mono:style=Bold";
color("red")
translate([b_width/2,0,b_height/2])
rotate([90,0,0])
linear_extrude(height = 1)
text("You smell nice",size=12, halign="center", valign="center", font=font);