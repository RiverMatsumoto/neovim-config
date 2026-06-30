#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
nvim="${NVIM_BIN:-nvim}"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

mkdir -p "$tmp/config"
ln -s "$root" "$tmp/config/nvim"

export XDG_CONFIG_HOME="$tmp/config"
export XDG_DATA_HOME="$tmp/data"
export XDG_STATE_HOME="$tmp/state"
export XDG_CACHE_HOME="$tmp/cache"
export NVIM_SKIP_TOOL_INSTALL=1

"$nvim" --headless "+Lazy! restore" +qa
"$nvim" --headless \
  "+Lazy load overseer.nvim" \
  "+Lazy load nvim-dap" \
  "+Lazy load snacks.nvim" \
  "+lua assert(vim.fn.exists(':OverseerRun') == 2, 'Overseer did not load')" \
  "+lua assert(vim.fn.exists(':DapContinue') == 2, 'nvim-dap did not load')" \
  "+lua if vim.v.errmsg ~= '' then print(vim.v.errmsg); vim.cmd('cquit 1') end" \
  +qa
