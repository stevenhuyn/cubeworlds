// Vertex shader

struct Camera {
    view_proj: mat4x4<f32>,
}
@group(0) @binding(0)
var<uniform> camera: Camera;

struct VertexInput {
    @location(0) position: vec3<f32>,
    @location(1) color: vec3<f32>,
}
struct InstanceInput {
    @location(2) model_position: vec3<f32>,
    @location(3) model_velocity: vec3<f32>,
    @location(4) model_rotation: vec3<f32>
}

struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) color: vec3<f32>,
}

@vertex
fn vs_main(
    model: VertexInput,
    instance: InstanceInput,
) -> VertexOutput {
    let model_matrix = create_model_matrix(instance.model_position, instance.model_rotation);
    var out: VertexOutput;
    out.color = (normalize(instance.model_velocity) + vec3<f32>(1., 1., 1.)) / 2.;
    out.clip_position = camera.view_proj * model_matrix * vec4<f32>(model.position, 1.0);
    return out;
}

fn create_model_matrix(position: vec3<f32>, euler_angle: vec3<f32>) -> mat4x4<f32> {
    let pitch = euler_angle.x;
    let yaw = euler_angle.y;
    let roll = euler_angle.z;

    let c1 = cos(yaw);
    let s1 = sin(yaw);
    let c2 = cos(pitch);
    let s2 = sin(pitch);
    let c3 = cos(roll);
    let s3 = sin(roll);

    let r11 = c1 * c3 + s1 * s2 * s3;
    let r12 = c3 * s1 * s2 - c1 * s3;
    let r13 = c2 * s1;
    let r14 = 0.0;

    let r21 = c2 * s3;
    let r22 = c2 * c3;
    let r23 = -s2;
    let r24 = 0.0;

    let r31 = c1 * s2 * s3 - c3 * s1;
    let r32 = c1 * c3 * s2 + s1 * s3;
    let r33 = c1 * c2;
    let r34 = 0.0;

    let r41 = position.x;
    let r42 = position.y;
    let r43 = position.z;
    let r44 = 1.0;

    return mat4x4<f32>(
        vec4<f32>(r11, r12, r13, r14),
        vec4<f32>(r21, r22, r23, r24),
        vec4<f32>(r31, r32, r33, r34),
        vec4<f32>(r41, r42, r43, r44)
    );
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    return vec4<f32>(in.color, 1.0);
}