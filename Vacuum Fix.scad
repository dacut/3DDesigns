thickness = 0.125;
holeSpacing = 2.5875;
holeDiameter = 0.2;
holeDepth = 0.125;
nHoles = 5;
margin = 0.5;
pipeDiameter = 2.0;
totalHeight = nHoles * holeSpacing + holeDiameter + 2 * margin;
epsilon = 0.001;
nSides=180;

scale([25.4, 25.4, 25.4])
difference() {
    union() {
        translate([0, 0, -margin])
        cylinder(h=totalHeight, d=pipeDiameter, $fn=nSides);

        for (holeZ = [0 : holeSpacing : totalHeight]) {
            translate([0, 0.5 * pipeDiameter - 2 * epsilon, holeZ])
            rotate([-90, 0, 0])
            cylinder(h=2 * epsilon + holeDepth, d=holeDiameter, $fn=nSides);
        }
    }

    union() {
        translate([0, 0, -margin - epsilon])
        cylinder(h=totalHeight + 2*epsilon, d=pipeDiameter-thickness, $fn=nSides);

        translate([-0.5 * pipeDiameter - epsilon, -0.5 * pipeDiameter, -margin - epsilon])
        cube([pipeDiameter + 2 * epsilon, 0.5 * pipeDiameter + 2 * epsilon, totalHeight + 2*epsilon]);
    }
}
