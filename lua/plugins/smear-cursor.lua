return {
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
      smear_insert_mode = true,
      stiffness = 0.75,
      trailing_stiffness = 0.5,
      matrix_pixel_threshold = 0.5,
      damping = 0.9,
      damping_insert_mode = 0.9,
      time_interval = 8,
      distance_stop_animating = 0.1,
    },
  },
}
