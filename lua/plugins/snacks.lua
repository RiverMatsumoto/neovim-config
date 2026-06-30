return {
  {
    "folke/snacks.nvim",
    opts = {
      scroll = {
        animate = {
          duration = { step = 5, total = 80 },
        },
      },

      picker = {
        matcher = {
          fuzzy = true,
          smartcase = false,
          ignorecase = true,
        },

        sources = {
          explorer = {
            hidden = false,
            ignored = false,

            matcher = {
              fuzzy = true,
              smartcase = false,
              ignorecase = true,
            },

            exclude = {
              ".git",
              ".godot",
              ".import",
              ".mono",
              "*.uid",
              "*.tmp",
            },
          },
        },
      },

      explorer = {
        enabled = true,
      },
    },
  },
}
