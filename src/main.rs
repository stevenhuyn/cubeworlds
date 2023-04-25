use wgpu_hello_wasm::run;

fn main() {
    pollster::block_on(run());
}
