return {
  {
    "folke/snacks.nvim",
    opts = {
      scratch = {
        ft = "text",
      },

      scroll = {
        animate = {
          duration = { step = 5, total = 120 },
          easing = "outCubic",
        },

        animate_repeat = {
          delay = 100,
          duration = { step = 5, total = 60 },
          easing = "outCubic",
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
            exclude = { "*.uid" },
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
