use <threads.scad>

// Hose thread dimensions
// Male hose thread, outer diameter
mhtOuterDiameter = 1.0625;

// Male hose thread, threads per inch
mhtThreadsPerInch = 11.5;

// Height of the connection piece.
hoseHeight = 0.5;


// Bottle dimensions
botOuterDiameter = 27.5; // mm
botPitch = 2.75; // mm
botLength = 11.5; // mm

// Adapter dimensions
adapterWidth = 1.4 / 2 * 25.4;
adapterHeight = hoseHeight * 25.4 + botLength + 5;
cylSides = 180;

// Via (cut through) dimensions
viaRadius = 0.25 * 25.4;

// Taper height to avoid problematic walls.
taperHeight = 5.0;

difference () {
    translate([0,0,0.01])
    cylinder(r1=adapterWidth, r2=adapterWidth, h=adapterHeight-0.02, $fn=cylSides);
    
    english_thread(mhtOuterDiameter, mhtThreadsPerInch, hoseHeight, internal=true);
    
    translate([0, -2, 0])
    cube(size=[40.0, 4.0, 2.0]);
    
    translate([0, 0, adapterHeight-botLength+0.01])
    metric_thread(botOuterDiameter, botPitch, botLength, internal=true, square=true);
    
    translate([0,0,-0.01])
    cylinder(r1=viaRadius, r2=viaRadius, h=adapterHeight+0.02, $fn=cylSides);

    translate([0, 0, adapterHeight-taperHeight])
    cylinder(r1=mhtOuterDiameter/2*25.4-5, r2=mhtOuterDiameter/2*25.4+2, h=taperHeight, $fn=cylSides);
    
    cylinder(r1=mhtOuterDiameter/2*25.4+2, r2=mhtOuterDiameter/2*25.4-5, h=taperHeight, $fn=cylSides);
}

