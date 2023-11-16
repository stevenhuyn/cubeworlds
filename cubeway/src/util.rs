/// Generates a f32 between 0 and 1 from a seed.
pub fn rand(seed: u32) -> f32 {
    let hash = (seed.wrapping_mul(0x5D588B68))
        .wrapping_add(0x269EC3)
        .rotate_left(17)
        .wrapping_mul(0xADD42B);

    (hash % 1_000_000_000) as f32 / 1_000_000_000 as f32
}