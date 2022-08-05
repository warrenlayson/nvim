local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Gobal mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when create keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  L = {
    name = "Typescript",
    m = { "<cmd>TypescriptAddMissingIMports<cr>", "Add Missing Imports" },
    o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize Imports" },
    u = { "<cmd>TypescriptRemoveUnused<cr>", "Remove Unused" },
    f = { "<cmd>TypescriptFixAll<cr>", "Fix All" },
    r = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
  },
}

wk.register(mappings, opts)
