use cubeway::{run, setup};
use pollster::FutureExt;

fn main() {
    setup();
    run(1000).block_on();
}
