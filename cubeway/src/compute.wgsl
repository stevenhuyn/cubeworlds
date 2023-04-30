struct SimParams {
    gravity: f32,
}

struct Instance {
    position: vec3<f32>,
    rotation: vec4<f32>,
}

struct Instances {
    instances: array<Instance>,
}

@binding(0) @group(0) var<uniform> params : SimParams;
@binding(1) @group(0) var<storage, read_write> instanceBuffer : Instances;
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID : vec3<u32>) {
  var index = GlobalInvocationID.x;

  instanceBuffer.instances[index + 0u].position.y -= 0.0001;
//   instanceBuffer.instances[index + 0u].position.y -= 0.0001;
//   instanceBuffer.instances[index + 0u].position.z -= 0.0001;
//   instanceBuffer.instances[index + 0u].rotation.x -= 0.0001;
//   instanceBuffer.instances[index + 0u].rotation.y -= 0.0001;
//   instanceBuffer.instances[index + 0u].rotation.z -= 0.0001;
//   instanceBuffer.instances[index + 0u].rotation.w -= 0.0001;

  if (index < 100u) {
    let bufferIndex = u32(f32(index) * 7.0);
  }
}
