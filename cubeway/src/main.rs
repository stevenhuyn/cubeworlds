use cubeway::{run, setup};
use pollster::FutureExt;

fn main() {
    setup();
    run(100).block_on();
}
