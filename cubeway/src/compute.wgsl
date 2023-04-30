struct SimParams {
    gravity: f32,
}

struct Instance {
    position: vec3<f32>,
    unused: f32,
    velocity: vec3<f32>,
    unused2: f32,
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

    var force: vec3<f32> = vec3<f32>(0.0, 0.0, 0.0);
    for (var i = 0u; i < arrayLength(&instanceBuffer); i++) {
        if i == index {
            continue;
        }

        var diff = instanceBuffer[i].position - instanceBuffer[index].position;
        force += normalize(diff) * params.gravity / length(diff);
    }

    instanceBuffer[index].velocity += force;
    instanceBuffer[index].position += instanceBuffer[index].velocity;
}
