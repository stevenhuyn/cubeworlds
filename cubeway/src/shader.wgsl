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
    let c = cos(euler_angle);
    let s = sin(euler_angle);
    let cx = vec4<f32>(1.0, 0.0, 0.0, 0.0);
    let cy = vec4<f32>(0.0, c.x, s.x, 0.0);
    let cz = vec4<f32>(0.0, -s.x, c.x, 0.0);
    let translation = vec4<f32>(position, 1.0);

    return mat4x4<f32>(cx, cy, cz, translation);
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    return vec4<f32>(in.color, 1.0);
}