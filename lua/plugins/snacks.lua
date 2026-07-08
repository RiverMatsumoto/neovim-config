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
          files = {
            hidden = false,
          },

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

        win = {
          input = {
            keys = {
              ["<Esc>h"] = { "toggle_hidden", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["<Esc>h"] = "toggle_hidden",
            },
          },
        },
      },

      explorer = {
        enabled = true,
      },
    },
    keys = {
      {
        "<leader><space>",
        function()
          Snacks.picker.files({ hidden = false })
        end,
        desc = "Find Files (Root Dir)",
      },
    },
  },
}
