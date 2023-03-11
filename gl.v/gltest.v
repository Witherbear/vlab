import opengl

fn main() {
    // Initialize the OpenGL library
    opengl.init()

    // Create a window with a title and size
    var window = opengl.create_window(800, 600, "My OpenGL Window")

    // Make the window's OpenGL context the current one
    opengl.make_context_current(window)

    // Set the viewport to match the window's size
    opengl.set_viewport(0, 0, 800, 600)

    // Create a shader program
    var shader_program = opengl.create_shader_program(
        "
        #version 330 core

        layout (location = 0) in vec3 vertex_pos;

        void main()
        {
            gl_Position = vec4(vertex_pos, 1.0);
        }
        ",
        "
        #version 330 core

        out vec4 FragColor;

        void main()
        {
            FragColor = vec4(1.0, 0.5, 0.2, 1.0);
        }
        "
    )

    // Create a vertex array object (VAO)
    var vao = opengl.create_vao()

    // Bind the VAO
    opengl.bind_vao(vao)

    // Create a vertex buffer object (VBO) and populate it with data
    var vbo = opengl.create_vbo([-0.5, -0.5, 0.0,  // Vertex 1
                                 0.5, -0.5, 0.0,  // Vertex 2
                                 0.0,  0.5, 0.0]) // Vertex 3

    // Bind the VBO to the VAO
    opengl.bind_vbo(vbo)

    // Set the vertex attribute pointers
    opengl.set_vertex_attrib_pointer(0, 3, opengl.FLOAT, opengl.FALSE, 0, 0)

    // Render loop
    while !opengl.window_should_close(window) {
        // Poll for events
        opengl.poll_events()

        // Clear the color buffer
        opengl.clear(opengl.COLOR_BUFFER_BIT)

        // Use the shader program
        opengl.use_shader_program(shader_program)

        // Draw the triangle
        opengl.draw_arrays(opengl.TRIANGLES, 0, 3)

        // Swap the front and back buffers
        opengl.swap_buffers(window)
    }

    // Clean up resources
    opengl.devare_vao(vao)
    opengl.devare_vbo(vbo)
    opengl.devare_shader_program(shader_program)
    opengl.destroy_window(window)
}
