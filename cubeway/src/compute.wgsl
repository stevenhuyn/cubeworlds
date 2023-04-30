struct SimParams {
    gravity: f32,
}

struct Instance {
    position: vec3<f32>,
    unused: f32,
    rotation: vec4<f32>,
}

struct Instances {
    instances: array<Instance>,
}

@binding(0) @group(0) var<uniform> params : SimParams;
@binding(1) @group(0) var<storage, read_write> instanceBuffer : array<Instance>;
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID: vec3<u32>) {
    var index = GlobalInvocationID.x;


    if index < 100u {
        instanceBuffer[index].position.y -= 0.001;
    }
}
