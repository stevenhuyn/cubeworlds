use cubeway::run;
use pollster::FutureExt;

fn main() {
    run().block_on();
}
