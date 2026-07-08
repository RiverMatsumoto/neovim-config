local M = {}
local extensions = { "plantuml", "puml", "pu", "uml" }

local function notify(message, level)
  vim.notify(message, level or vim.log.levels.INFO, { title = "PlantUML" })
end

local function plantuml_env()
  local java_options = vim.env._JAVA_OPTIONS or ""

  if not java_options:find("java%.awt%.headless", 1, false) then
    java_options = vim.trim(java_options .. " -Djava.awt.headless=true")
  end

  return {
    _JAVA_OPTIONS = java_options,
  }
end

local function output_path(source, format, output_dir)
  local basename = vim.fn.fnamemodify(source, ":t:r")
  return vim.fs.joinpath(output_dir or vim.fn.fnamemodify(source, ":p:h"), basename .. "." .. format)
end

local function opener_commands(path)
  if vim.env.PLANTUML_PREVIEW_OPEN and vim.env.PLANTUML_PREVIEW_OPEN ~= "" then
    return { vim.list_extend(vim.split(vim.env.PLANTUML_PREVIEW_OPEN, "%s+"), { path }) }
  end

  if vim.fn.has("mac") == 1 then
    return { { "open", path } }
  end

  if vim.fn.has("win32") == 1 then
    return { { "cmd.exe", "/c", "start", "", path } }
  end

  local commands = {}
  if vim.fn.executable("sxiv") == 1 then
    local sxiv = { "sxiv", "-g", "1600x1100", path }
    if vim.fn.executable("setsid") == 1 then
      table.insert(commands, vim.list_extend({ "setsid", "-f" }, sxiv))
    else
      table.insert(commands, sxiv)
    end
  end

  vim.list_extend(commands, {
    { "brave", path },
    { "gio", "open", path },
    { "xdg-open", path },
  })

  return commands
end

local function open_rendered(path)
  local errors = {}

  for _, command in ipairs(opener_commands(path)) do
    if vim.fn.executable(command[1]) == 1 then
      local result = vim.system(command, { text = true }):wait()
      if result.code == 0 then
        return true
      end

      table.insert(errors, table.concat(command, " ") .. ": " .. vim.trim(result.stderr or result.stdout or "failed"))
    end
  end

  notify("Rendered " .. path .. ", but could not open it:\n" .. table.concat(errors, "\n"), vim.log.levels.ERROR)
  return false
end

local function render(opts)
  opts = opts or {}

  if vim.fn.executable("plantuml") ~= 1 then
    notify("Install the `plantuml` command to render diagrams.", vim.log.levels.ERROR)
    return
  end

  local source = vim.api.nvim_buf_get_name(0)
  if source == "" then
    notify("Save the buffer before rendering.", vim.log.levels.ERROR)
    return
  end

  if vim.bo.modified then
    vim.cmd.silent("write")
  end

  source = vim.fn.fnamemodify(source, ":p")
  local format = opts.format or "svg"
  local output_dir = opts.output_dir
  local args = { "plantuml", "--format", format, "--ignore-startuml-filename" }

  if opts.dpi then
    vim.list_extend(args, { "--skinparam", "dpi=" .. opts.dpi })
  end

  if output_dir then
    vim.fn.mkdir(output_dir, "p")
    vim.list_extend(args, { "--output-dir", output_dir })
  end

  table.insert(args, source)

  local result = vim.system(args, { text = true, env = plantuml_env() }):wait()
  if result.code ~= 0 then
    notify(vim.trim(result.stderr ~= "" and result.stderr or result.stdout), vim.log.levels.ERROR)
    return
  end

  local rendered = output_path(source, format, output_dir)
  if vim.fn.filereadable(rendered) ~= 1 then
    notify("Rendered output was not found at " .. rendered, vim.log.levels.ERROR)
    return
  end

  if opts.preview then
    open_rendered(rendered)
  elseif opts.open then
    open_rendered(rendered)
  end

  notify("Rendered " .. rendered)
end

function M.setup()
  local extension_filetypes = {}
  for _, extension in ipairs(extensions) do
    extension_filetypes[extension] = "plantuml"
  end

  vim.filetype.add({ extension = extension_filetypes })

  vim.api.nvim_create_user_command("PlantumlPreview", function()
    render({
      format = "svg",
      dpi = 180,
      output_dir = vim.fn.stdpath("cache"),
      preview = true,
    })
  end, { desc = "Render PlantUML to SVG in sxiv" })

  vim.api.nvim_create_user_command("PlantumlExport", function(command)
    render({ format = command.args ~= "" and command.args or "svg" })
  end, {
    nargs = "?",
    complete = function()
      return { "svg", "png", "txt", "utxt" }
    end,
    desc = "Render PlantUML next to the source file",
  })

  local group = vim.api.nvim_create_augroup("PlantumlPreview", { clear = true })

  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = group,
    pattern = vim.tbl_map(function(extension)
      return "*." .. extension
    end, extensions),
    callback = function()
      vim.bo.filetype = "plantuml"
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "plantuml",
    callback = function(event)
      vim.keymap.set("n", "<leader>mp", "<cmd>PlantumlPreview<cr>", {
        buffer = event.buf,
        desc = "PlantUML Preview SVG",
      })
      vim.keymap.set("n", "<leader>me", "<cmd>PlantumlExport<cr>", {
        buffer = event.buf,
        desc = "PlantUML Export SVG",
      })
    end,
  })
end

return M
