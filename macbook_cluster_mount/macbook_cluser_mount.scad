bar_w = 210;
bar_d = 28;
bar_h = 46;

cut_w = 28;
cut_h = bar_h - (bar_h * (20/100)); // 20%
cut_d = 32;

c1_pos = (bar_w - (3 * cut_w)) / 4;
c2_pos = c1_pos + cut_w + c1_pos;
c3_pos = c2_pos + cut_w + c1_pos;

thread_hole = 8;
t1_pos = [
    (c1_pos / 2),
    (bar_h / 2),
    (-bar_d - 1)
];

t2_pos = [
    ((c3_pos + cut_w) + c1_pos / 2),
    (bar_h / 2),
    (-bar_d - 1)
];




difference() {
    cube(size = [bar_w,bar_d,bar_h], center=false);
    
    color("blue")
    translate([c1_pos,-1,bar_h - cut_h])
    cube(size = [cut_w, cut_d, cut_h+1], center=false);
    
    color("blue")
    translate([c2_pos,-1,bar_h - cut_h])
    cube(size = [cut_w, cut_d, cut_h+1], center=false);
    
    color("blue")
    translate([c3_pos,-1,bar_h - cut_h])
    cube(size = [cut_w, cut_d, cut_h+1], center=false);
    
    // T1
    rotate([90,0,0])
    translate(t1_pos)
    color("red")
    cylinder(d = thread_hole,h = bar_d + 2);
    
    // T2
    rotate([90,0,0])
    translate(t2_pos)
    color("red")
    cylinder(d = thread_hole,h = bar_d + 2);
}