// Junction cylinder dimensions
jcInnerRadius = 21.082;
jcOuterRadius = 21.082 + 5;

// Funnel dimensions
funInnerRadius = 55.0;
funOuterRadius = 60.0;

cylSides = 192;

union() {
    difference() {
        cylinder(r=jcOuterRadius, h=25.5, $fn=cylSides);
        translate([0,0,-0.1]) cylinder(r=jcInnerRadius, h=25.7, $fn=cylSides);
    }

    difference() {
        union() {
            translate([0,0,25.4]) cylinder(r1=jcOuterRadius, r2=funOuterRadius, h=25.4, $fn=cylSides);
            translate([0,0,50.8 + 2.5]) cube(size=[120, 120, 5.0], center=true);
            translate([0,0,50.8]) cylinder(r=65, h=5.0, $fn=cylSides);
        }
        translate([0,0,25.35]) cylinder(r1=jcInnerRadius, r2=   funInnerRadius, h=30.5, $fn=cylSides);
        
        // Screw holes
        for (dx = [-50.25, 50.25]) {
            for (dy = [-50.25, 50.25]) {
                translate([dx, dy, 50.79]) cylinder(r=2.15, h=5.01, $fn=cylSides);
            }
        }
    }
}