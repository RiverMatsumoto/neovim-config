return {
  {
    "folke/snacks.nvim",
    opts = {
      scroll = {
        animate = {
          duration = { step = 5, total = 80 },
        },
      },

      image = {
        enabled = true,
        formats = {
          "png",
          "jpg",
          "jpeg",
          "gif",
          "bmp",
          "webp",
          "tiff",
          "heic",
          "avif",
          "mp4",
          "mov",
          "avi",
          "mkv",
          "webm",
          "pdf",
          "icns",
          "svg",
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
            hidden = true,
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
