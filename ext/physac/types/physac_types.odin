//
// generated by bindgen (https://github.com/Breush/odin-binding-generator)
//

package physac_types

import _c "core:c"

import raylib_types "../../../raylib/types"
PHYSAC_H :: 1;
PHYSAC_MAX_BODIES :: 64;
PHYSAC_MAX_MANIFOLDS :: 4096;
PHYSAC_MAX_VERTICES :: 24;
PHYSAC_CIRCLE_VERTICES :: 24;
PHYSAC_DESIRED_DELTATIME :: 0.017;
PHYSAC_MAX_TIMESTEP :: 0.020;
PHYSAC_COLLISION_ITERATIONS :: 100;
PHYSAC_PENETRATION_ALLOWANCE :: 0.050;
PHYSAC_PENETRATION_CORRECTION :: 0.400;
PHYSAC_PI :: 3.142;
PHYSAC_DEG2RAD :: 0.017;

PhysicsBody :: ^PhysicsBodyData;

PhysicsShapeType :: enum i32 {
    PHYSICS_CIRCLE,
    PHYSICS_POLYGON,
};

PhysicsBodyData :: struct #packed {
    id : _c.uint,
    enabled : bool,
    position : raylib_types.Vector2,
    velocity : raylib_types.Vector2,
    force    : raylib_types.Vector2,
    angular_velocity : _c.float,
    torque : _c.float,
    orient : _c.float,
    inertia : _c.float,
    inverse_inertia : _c.float,
    mass : _c.float,
    inverse_mass : _c.float,
    static_friction : _c.float,
    dynamic_friction : _c.float,
    restitution : _c.float,
    use_gravity : bool,
    is_grounded : bool,
    freeze_orient : bool,
    shape : PhysicsShape,
};

Mat2 :: struct #packed {
    m00 : _c.float,
    m01 : _c.float,
    m10 : _c.float,
    m11 : _c.float,
};

PolygonData :: struct #packed {
    vertex_count : _c.uint,
    positions : [24]raylib_types.Vector2,
    normals   : [24]raylib_types.Vector2,
};

PhysicsShape :: struct #packed {
    type : PhysicsShapeType,
    body : PhysicsBody,
    radius : _c.float,
    transform : Mat2,
    vertex_data : PolygonData,
};

PhysicsManifoldData :: struct #packed {
    id : _c.uint,
    body_a : PhysicsBody,
    body_b : PhysicsBody,
    penetration : _c.float,
    normal : raylib_types.Vector2,
    contacts : [2]raylib_types.Vector2,
    contacts_count : _c.uint,
    restitution : _c.float,
    dynamic_friction : _c.float,
    static_friction : _c.float,
};

physac_Funcs :: struct {
    init_physics : proc "c" (),
    is_physics_enabled : proc "c" () -> bool,
    set_physics_gravity : proc "c" (
        x : _c.float,
        y : _c.float
    ),
    create_physics_body_circle : proc "c" (
        pos : raylib_types.Vector2,
        radius : _c.float,
        density : _c.float
    ) -> PhysicsBody,
    create_physics_body_rectangle : proc "c" (
        pos : raylib_types.Vector2,
        width : _c.float,
        height : _c.float,
        density : _c.float
    ) -> PhysicsBody,
    create_physics_body_polygon : proc "c" (
        pos : raylib_types.Vector2,
        radius : _c.float,
        sides : _c.int,
        density : _c.float
    ) -> PhysicsBody,
    physics_add_force : proc "c" (
        body : PhysicsBody,
        force : raylib_types.Vector2
    ),
    physics_add_torque : proc "c" (
        body : PhysicsBody,
        amount : _c.float
    ),
    physics_shatter : proc "c" (
        body : PhysicsBody,
        position : raylib_types.Vector2,
        force : _c.float
    ),
    get_physics_bodies_count : proc "c" () -> _c.int,
    get_physics_body : proc "c" (index : _c.int) -> PhysicsBody,
    get_physics_shape_type : proc "c" (index : _c.int) -> _c.int,
    get_physics_shape_vertices_count : proc "c" (index : _c.int) -> _c.int,
    get_physics_shape_vertex : proc "c" (
        body : PhysicsBody,
        vertex : _c.int
    ) -> raylib_types.Vector2,
    set_physics_body_rotation : proc "c" (
        body : PhysicsBody,
        radians : _c.float
    ),
    destroy_physics_body : proc "c" (body : PhysicsBody),
    reset_physics : proc "c" (),
    close_physics : proc "c" (),
    physics_loop : proc "c" (data : rawptr) -> rawptr,
}

