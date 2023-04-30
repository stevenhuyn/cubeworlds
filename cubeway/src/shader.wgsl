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
    @location(4) model_rotation: vec4<f32>
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
    out.clip_position = camera.view_proj * model_matrix * vec4<f32>(model.position, 1.0);
    return out;
}

fn create_model_matrix(position: vec3<f32>, quaternion: vec4<f32>) -> mat4x4<f32> {
    let q = quaternion;
    let x = q.x;
    let y = q.y;
    let z = q.z;
    let w = q.w;

    let xx = x * x;
    let xy = x * y;
    let xz = x * z;
    let xw = x * w;

    let yy = y * y;
    let yz = y * z;
    let yw = y * w;

    let zz = z * z;
    let zw = z * w;

    let m00 = 1.0 - 2.0 * (yy + zz);
    let m01 = 2.0 * (xy + zw);
    let m02 = 2.0 * (xz - yw);
    let m03 = 0.0;

    let m10 = 2.0 * (xy - zw);
    let m11 = 1.0 - 2.0 * (xx + zz);
    let m12 = 2.0 * (yz + xw);
    let m13 = 0.0;

    let m20 = 2.0 * (xz + yw);
    let m21 = 2.0 * (yz - xw);
    let m22 = 1.0 - 2.0 * (xx + yy);
    let m23 = 0.0;

    let m30 = position.x;
    let m31 = position.y;
    let m32 = position.z;
    let m33 = 1.0;

    return mat4x4<f32>(vec4<f32>(m00, m01, m02, m03), vec4<f32>(m10, m11, m12, m13), vec4<f32>(m20, m21, m22, m23), vec4<f32>(m30, m31, m32, m33));
}
// Fragment shader

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let color = normalize(in.clip_position.xyz / in.clip_position.w);
    return vec4<f32>(color, 1.0);
}