use crate::Vertex;

pub struct SquarePyramid {
    pub vertices: Vec<Vertex>,
    pub indices: Vec<u16>,
}

impl SquarePyramid {
    pub fn new(color: [f32; 3]) -> Self {
        let vertices = vec![
            Vertex {
                position: [0.0, 0.0, 0.0],
                color,
            },
            Vertex {
                position: [-1.0, -0.2, 0.2],
                color,
            },
            Vertex {
                position: [-1.0, 0.2, 0.2],
                color,
            },
            Vertex {
                position: [-1.0, -0.2, -0.2],
                color,
            },
            Vertex {
                position: [-1.0, 0.2, -0.2],
                color,
            },
        ];

        #[rustfmt::skip]
        let indices = vec![
            0, 2, 4,
            0, 1, 2,
            0, 3, 1,
            0, 4, 3,
            1, 3, 4,
            1, 4, 2,
        ];

        Self { vertices, indices }
    }
}
