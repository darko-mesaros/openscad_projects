// Higher definition curves
$fs = 0.01;

module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	module build_point(type = "sphere", rotate = [0, 0, 0]) {
		if (type == "sphere") {
			sphere(r = radius);
		} else if (type == "cylinder") {
			rotate(a = rotate)
			cylinder(h = diameter, r = radius, center = true);
		}
	}

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							build_point("sphere");
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							build_point("cylinder", rotate);
						}
					}
				}
			}
		}
	}
}

// An [x, y, z] vector specifies distance on each axis. Default [1, 1, 1]
size = [60, 60, 2];

// An integer creates a cube with specified wall distance. Default [1, 1, 1]
//size = 5;

// Whether or not to place the object centered on the origin. Default false
center = true;

// Specify a rounding radius. Default 0.5
radius = 1;

// Specify where to apply the rounded corners. Default "all"
apply_to = "z";//|"x"|"y"|"z"|"zmax"|"zmin"|"xmax"|"xmin"|"ymax"|"ymin"

color("blue")
roundedcube(size, center, radius, apply_to);

difference() {
    // An [x, y, z] vector specifies distance on each axis. Default [1, 1, 1]
    size_o = [58, 58, 2];
    // Whether or not to place the object centered on the origin. Default false
    center_o = true;
    // Specify a rounding radius. Default 0.5
    radius_o = 1;
    // Specify where to apply the rounded corners. Default "all"
    apply_to_o = "z";//|"x"|"y"|"z"|"zmax"|"zmin"|"xmax"|"xmin"|"ymax"|"ymin"
    color("red")
    translate([0,0,1])
    roundedcube(size_o, center_o, radius_o, apply_to_o);
    
    // An [x, y, z] vector specifies distance on each axis. Default [1, 1, 1]
    size_i = [55, 55, 5];
    // Whether or not to place the object centered on the origin. Default false
    center_i = true;
    // Specify a rounding radius. Default 0.5
    radius_i = 1;
    // Specify where to apply the rounded corners. Default "all"
    apply_to_i = "z";//|"x"|"y"|"z"|"zmax"|"zmin"|"xmax"|"xmin"|"ymax"|"ymin"
    color("purple")
    roundedcube(size_i, center_i, radius_i, apply_to_i);
    }

//translate([0,0,10])
color("red")
linear_extrude(3)
text(":wq!", halign="center", valign="center", font = "Perfect DOS VGA 437", size=16 );
