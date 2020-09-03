baseRadius = 2.5 * 0.5 * 25.4;
depth = 7.25 * 25.4;
height = 0.25 * 25.4;

blockWidth = 3 * 25.4;
blockDepth = 7.75 * 25.4;
blockHeight = 0.25 * 25.4;
inset = 0.25 * 25.4;
baseInset = 0.06125 * 25.4;

grooveWidth = 0.025 * 25.4;

difference() {
    translate([-blockWidth * 0.5, -inset, -baseInset])
    cube([blockWidth, blockDepth, blockHeight]);
    
    translate([0, baseRadius, 0])
    cylinder(r1=baseRadius, r2=baseRadius, h=height+0.01);
}