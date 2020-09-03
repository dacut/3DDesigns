innerRadius = 35.0 * 0.5;
outerRadius = 37.5 * 0.5;
lipRadius = 47.5 * 0.5;
height = 43.67;
ringHeight = 1.75;
sliceWidth = 0.5;

innerTaperRadius = 36.3  * 0.5;
taperHeight = 5;

cylSides = 180;

difference() {
    union() {
        cylinder(r1=outerRadius, r2=outerRadius, h=height, $fn=cylSides);
        
        translate([0, 0, height - ringHeight])
        cylinder(r1=lipRadius, r2=lipRadius, h=ringHeight, $fn=cylSides);
    }
    
    union() {
        translate([0, 0, -0.01])
        cylinder(r1=innerRadius, r2=innerRadius, h=height+0.02, $fn=cylSides );
        
        translate([-height * 0.5 * sin(22), -lipRadius-0.01, -0.01])
        rotate([0, 22, 0])
        cube([sliceWidth, lipRadius, height * 2 + 0.05]);
        
        difference() {
            translate([-outerRadius, -outerRadius, -0.005])
            cube([outerRadius*2, outerRadius*2, taperHeight+0.01]);
            
            translate([0, 0, -0.01])
            cylinder(r2=outerRadius, r1=innerTaperRadius, h=taperHeight+0.02, $fn=cylSides);
        }
    }
}