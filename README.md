# Neovim development template

A fresh [LazyVim](https://www.lazyvim.org/) configuration designed for people
moving from VS Code or Zed. The editor handles files, builds, tests, debugging,
and one ad-hoc shell without requiring terminal tabs.

## Workflow

| Action             | Key                            |
| ------------------ | ------------------------------ |
| Quick open         | `Ctrl-P`                       |
| Command palette    | `Ctrl-Shift-P`                 |
| Workspace search   | `Ctrl-Shift-F`                 |
| File explorer      | `Ctrl-B`                       |
| Toggle terminal    | `Ctrl-Backtick` or `Ctrl-/`    |
| Run build/task     | `Ctrl-Shift-B` or `<leader>rr` |
| Task list          | `<leader>rl`                   |
| Debug continue     | `F5`                           |
| Breakpoint         | `F9`                           |
| Step over/into/out | `F10` / `F11` / `Shift-F11`    |

Use the terminal for one-off shell commands. Use Overseer for repeatable builds,
tests, watchers, and servers. It automatically discovers many common project
commands and reads `.vscode/tasks.json`. Use tmux only when a process must
survive Neovim or when working across several projects.

## Install

Requirements: Neovim 0.12+, Git, a C compiler, `make`, `curl`, `unzip`, `fd`,
`ripgrep`, and the `tree-sitter` CLI. A Nerd Font is recommended. LazyVim can
install the CLI through Mason during the first interactive startup.

Clone the template into Neovim's configuration directory, then start Neovim:

Dependencies:

```sh
git clone https://github.com/RiverMatsumoto/nvim-config.git ~/.config/nvim
nvim
```

If GitHub SSH access is already configured, clone with SSH instead:

```sh
git clone git@github.com:RiverMatsumoto/nvim-config.git ~/.config/nvim
```

To update an existing installation later:

```sh
git -C ~/.config/nvim pull --ff-only
```

Run `:LazyHealth` after the first installation. Enable language support through
`:LazyExtras`; language extras configure the relevant LSP, formatter, debugger,
Treesitter parsers, and test adapters together.

## Project tasks

Keep tasks with each project in `.vscode/tasks.json`. Example:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "build",
      "type": "shell",
      "command": "make",
      "group": { "kind": "build", "isDefault": true },
      "problemMatcher": "$gcc"
    },
    {
      "label": "test",
      "type": "shell",
      "command": "make test",
      "group": "test"
    }
  ]
}
```

The committed `lazy-lock.json` makes plugin updates reversible. Update plugins
on a branch with `:Lazy update`, run `:LazyHealth`, and commit the resulting
lockfile only after the checks pass.
