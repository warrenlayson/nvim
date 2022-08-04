local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

local servers = {
  "cssls",
  "emmet_ls",
  "html",
  "jsonls",
  "sumneko_lua",
  "tsserver",
  "pyright",
  "yamlls",
  "bashls",
}

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local common_setup_opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
  local opts = vim.deepcopy(common_setup_opts)

  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end

  if server == "tsserver" then
    local ts_status_ok, typescript = pcall(require, "typescript")
    if not ts_status_ok then
      return
    end
    typescript.setup {
      disable_commands = false,
      debug = false,
      server = opts,
    }
    goto continue
  end

  lspconfig[server].setup(opts)
  ::continue::
end
