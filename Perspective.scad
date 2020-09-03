difference() {
    union() {
        translate([0, 0, -3])
        cube(size=[90, 90, 4]);
        for (x = [0:2:9]) {
            for (y = [0:2:9]) {
                translate([10 * x, 10 * y, 0])
                cube(size=[10, 10, 3 * x + 5 * y + 2]);
            }
        }
    }
    
    union() {
        for (x = [0:2:9]) {
            for (y = [0:2:9]) {
                translate([10 * x + 2.1, 10 * y + 2.1, -5])
                cube(size=[5.8, 5.8, 3 * x + 5 * y + 2 + 2.8]);
            }
        }
    }
}