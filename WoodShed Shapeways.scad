include <MCAD/materials.scad>;

nPosts = 5;
frontPostHeight = 9.0 * 12;
postSpacing = 4.0 * 12 + 7.0 + 5.0 / 8.0;
backPostHeight = 8.0 * 12;

frameDepth = 3 * 12 + 6.0;
backPostDepth = frameDepth - 3.5;

firstBraceHeight = 3.0;
secondBraceHeight = 6.0 * 12;

nBars = 5;
barSpacing = 6.125;

roofExtensionBack = 18;
roofExtensionFront = 12;
roofExtensionSide = 12;
roofThickness = 2;

// Truss cross braces
trussCrossHeight = secondBraceHeight - firstBraceHeight - 3.5 - 1.5;
trussCrossDiagLength = sqrt(pow(trussCrossHeight, 2) + pow(frameDepth, 2));
trussCrossPhi = 90 - acos(3.5 / trussCrossDiagLength) + asin(frameDepth / trussCrossDiagLength);
trussCrossLength = frameDepth / sin(trussCrossPhi);

// Roof diagonal
roofAngle = -atan2(frontPostHeight - backPostHeight, frameDepth);
roofDiagLength = sqrt(pow(frontPostHeight - backPostHeight, 2) + pow(frameDepth, 2)) + roofExtensionBack + roofExtensionFront;
echo("roofAngle=", roofAngle);

// Fence wire
wireRadius = 0.0641;

enableFence = false;

module truss() {
    // Front post
    color(Pine)
    difference() {
        cube([3.5, 3.5, frontPostHeight]);

        translate([0, 0, frontPostHeight])
        rotate([roofAngle, 0, 0])
        translate([-1, -1, 0])
        cube([5.5, 5.5, 10]);
    }
    
    // Back post
    color(Pine)
    difference() {
        translate([0, backPostDepth, 0])
        cube([3.5, 3.5, backPostHeight + 2]);

        translate([0, backPostDepth + 3.5, backPostHeight])
        rotate([roofAngle, 0, 0])
        translate([-1, -5, 0])
        cube([5.5, 7.5, 10]);
    }
    
    // First horizontal braces
    color(Pine)
    translate([-1.5, 0, firstBraceHeight])
    cube([1.5, frameDepth, 3.5]);
    color(Pine)
    translate([3.5, 0, firstBraceHeight])
    cube([1.5, frameDepth, 3.5]);

    // Second horizontal braces
    color(Pine)
    translate([-1.5, 0, secondBraceHeight])
    cube([1.5, frameDepth, 3.5]);
    color(Pine)
    translate([3.5, 0, secondBraceHeight])
    cube([1.5, frameDepth, 3.5]);

    // Roof horizontal braces
    color(Pine)
    translate([-1.5, 0, backPostHeight - 7])
    cube([1.5, frameDepth, 3.5]);
    color(Pine)
    translate([3.5, 0, backPostHeight - 7])
    cube([1.5, frameDepth, 3.5]);

    // Cross braces
    color(Pine)
    intersection() {
        translate([-1.5, 0, firstBraceHeight + 3.5 + 1.5])
        cube([1.5, frameDepth, trussCrossHeight]);

        translate([-1.5, 0, firstBraceHeight + 3.5 + 1.5])
        rotate([90 - trussCrossPhi, 0, 0])
        cube([1.5, trussCrossDiagLength, 3.5]);
    }        

    color(Pine)
    intersection() {
        translate([3.5, 0, firstBraceHeight + 3.5 + 1.5])
        cube([1.5, frameDepth, trussCrossHeight]);

        translate([3.5, frameDepth, firstBraceHeight + 3.5 + 1.5])
        scale([1, -1, 1])
        rotate([90 - trussCrossPhi, 0, 0])
        cube([1.5, trussCrossDiagLength, 3.5]);
    }

    // Roof diagonal
    color(Pine)
    translate([-1.5, frameDepth, backPostHeight - 3.5])
    rotate([roofAngle, 0, 0])
    translate([0, roofExtensionBack, -0.02])
    scale([1, -1, 1])
    cube([1.5, roofDiagLength, 3.5]);

    color(Pine)
    translate([3.5, frameDepth, backPostHeight - 3.5])
    rotate([roofAngle, 0, 0])
    translate([0, roofExtensionBack, -0.02])
    scale([1, -1, 1])
    cube([1.5, roofDiagLength, 3.52]);

    // Side Fencing
    if (enableFence) {
        for (xOffset = [0, 3.5]) {
            for (fenceY = [3.5 : 4 : frameDepth]) {
                color(Steel)
                translate([xOffset, fenceY, firstBraceHeight + 3.5])
                cylinder(secondBraceHeight - firstBraceHeight - 3.5, wireRadius, wireRadius);
            }

            for (fenceZ = [firstBraceHeight + 3.5 : 2 : secondBraceHeight + 1.5]) {
                color(Steel)
                translate([xOffset, 0, fenceZ])
                rotate([-90, 0, 0])
                cylinder(frameDepth, wireRadius, wireRadius);
            }
        }
    }
}

module backSupport() {
    let(height = backPostHeight - 9 - firstBraceHeight - 5.5,
        diag = sqrt(pow(height, 2) + pow(postSpacing + 7.0, 2)),
        phi = 90 - acos(3.5 / diag) + asin((postSpacing + 7.0) / diag),
        length = (postSpacing + 7.0) / sin(phi)) {
        intersection() {
            translate([0, frameDepth, firstBraceHeight + 5.6])
            cube([postSpacing + 7.0, 1.5, height]);
            
            translate([0, frameDepth, firstBraceHeight + 5.5])
            rotate([0, phi - 90, 0])
            cube([diag, 1.5, 3.5]);
        }
    }
}

scale([0.5, 0.5, 0.5])
union() {
// Trusses
for (postId = [0 : nPosts - 1]) {
    translate([postId * (3.5 + postSpacing), 0, 0])
    truss();
}

// Back diagonal supports
for (postId = [0 : nPosts - 2]) {
    color(Pine)
    translate([postId * (3.5 + postSpacing), 0, 0])
    backSupport();
}

// Support bars
for (postId = [0 : nPosts - 2]) {
    for (barId = [0 : nBars - 1]) {
        color(Pine)
        translate([postId * (3.5 + postSpacing) + 3.5, barId * (3.5 + barSpacing), firstBraceHeight + 3.5])
        cube([postSpacing, 3.5, 1.5]);
        
        if (barId == 0 || barId == nBars - 1) {
            color(Pine)
            translate([postId * (3.5 + postSpacing) + 3.5, barId * (3.5 + barSpacing), secondBraceHeight + 3.5])
            cube([postSpacing, 3.5, 1.5]);
        }
    }
}

for (barId = [1 : nBars - 2]) {
    color(Pine)
    translate([3.5, barId * (3.5 + barSpacing), secondBraceHeight + 3.5])
    cube([233.5, 3.5, 1.5]);
}

// Front and back cross pieces
color(Pine)
translate([0, -1.5, frontPostHeight - 9.25])
cube([240.0, 1.5, 5.5]);

color(Pine)
translate([0, frameDepth, backPostHeight - 9.25])
cube([240.0, 1.5, 5.48]);

color(Pine)
translate([0, frameDepth, firstBraceHeight])
cube([240.0, 1.5, 5.5]);

// Rear fencing
if (enableFence) {
    for (sectionX = [0 : 4 * 12 + 0.25 : 240]) {
        for (fenceX = [sectionX : 4 : min(sectionX + 4 * 12, 240)]) {
            color(Steel)
            translate([fenceX, frameDepth + 1.5 + wireRadius, firstBraceHeight + 3.5])
            cylinder(backPostHeight - firstBraceHeight - 3.5 - 6, wireRadius, wireRadius);
        }

        for (fenceZ = [firstBraceHeight + 3.5 : 2 : backPostHeight - firstBraceHeight - 3.5 - 6]) {
            color(Steel)
            translate([sectionX, frameDepth + 1.5 + wireRadius, fenceZ])
            rotate([0, 90, 0])
            cylinder(min(4 * 12, 240 - sectionX), wireRadius, wireRadius);
        }
    }
}

// Roof
color(BlackPaint)
translate([-1.5 - roofExtensionSide, frameDepth, backPostHeight - 3.5])
rotate([roofAngle, 0, 0])
translate([0, roofExtensionBack, 3.5])
scale([1, -1, 1])
cube([242.5 + 2 * roofExtensionSide, roofDiagLength, roofThickness]);

}
