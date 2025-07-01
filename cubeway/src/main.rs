use cubeway::{run, setup};
use pollster::FutureExt;

fn main() {
    setup();
    run(15000).block_on();
}
