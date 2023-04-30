struct Particle {
  pos : vec2<f32>,
  vel : vec2<f32>,
}

struct SimParams {
    gravity: f32,
}

struct Particles {
  particles : array<Particle>,
}

struct Instance {
    position: vec3<f32>,
    rotation: vec4<f32>,
}

struct Instances {
    instances: array<Instance>,
}

@binding(0) @group(0) var<uniform> params : SimParams;
@binding(1) @group(0) var<storage, read> particlesA : Particles;
@binding(2) @group(0) var<storage, read_write> particlesB : Particles;
@binding(3) @group(0) var<storage, read_write> instanceBuffer : Instances;
@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) GlobalInvocationID : vec3<u32>) {
  var index = GlobalInvocationID.x;

  var vPos = particlesA.particles[index].pos;
  var vVel = particlesA.particles[index].vel;

//   for (var i = 0u; i < arrayLength(&particlesA.particles); i++) {
//     if (i == index) {
//       continue;
//     }

//     // Do something
//   }
  let bufferIndex = u32(f32(index) * 8.0);
  instanceBuffer.instances[index + 0u].position.y -= 0.01;
  instanceBuffer.instances[index + 1u].position.y -= 0.01;
  instanceBuffer.instances[index + 2u].position.y -= 0.01;
  instanceBuffer.instances[index + 3u].position.y -= 0.01;
  instanceBuffer.instances[index + 4u].position.y -= 0.01;
  instanceBuffer.instances[index + 5u].position.y -= 0.01;
  instanceBuffer.instances[index + 6u].position.y -= 0.01;
  instanceBuffer.instances[index + 7u].position.y -= 0.01;
  instanceBuffer.instances[index + 8u].position.y -= 0.01;

  // Do something

  // Write back
  particlesB.particles[index].pos = vPos;
  particlesB.particles[index].vel = vVel;
}
