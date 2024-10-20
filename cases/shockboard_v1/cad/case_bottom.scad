use <shockboard_v1.scad>
use <openscad-fillets/fillets3d.scad>

module fillet_wall(wall_height, fillet_radius, fillet_steps, fillet_enable, clearance) {
    difference() {
        topFillet(wall_height, fillet_radius, fillet_steps, fillet_enable)
        linear_extrude(wall_height)
        offset(delta=clearance)
        case_outline();
        
        translate([0, 0, -1])
        linear_extrude(wall_height+2)
        offset(delta=clearance)
        plate_outline();
    };
}

module case_bottom_no_cutout(wall_height=18, fillet_radius=2.5, fillet_steps=50, fillet_enable=1, clearance=1) {
    difference() {
        union() {
            linear_extrude(2)
            offset(delta=clearance)
            case_outline();

            linear_extrude(4)
            mounting_holes_outer();
        }

        translate([0, 0, -1])
        linear_extrude(6)
        mounting_holes_inner();
    }

    fillet_wall(wall_height, fillet_radius, fillet_steps, fillet_enable, clearance);
}

module case_bottom(wall_height=18, fillet_radius=3, fillet_steps=20, fillet_enable=1, clearance=1) {
    difference() {
        case_bottom_no_cutout(wall_height, fillet_radius, fillet_steps, fillet_enable, clearance);
        
        translate([0, 0, 5.6])
        linear_extrude(9)
        usbc_cutout();
        
        translate([0, 0, 5.6])
        linear_extrude(wall_height)
        battery_switch_cutout();
    }
    
    linear_extrude(4)
    difference() {
        case_outline();
        promicro_cutout();
        keywell_mx();
        
        translate([187.5, -125, 2])
        square([50, 42]);
    }
}

case_bottom();