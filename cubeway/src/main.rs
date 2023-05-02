use cubeway::{run, setup};
use pollster::FutureExt;

fn main() {
    setup();
    run(10000).block_on();
}
