return {
  cmd = { "py" },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        diagnosticMode = "workspace",
        inlayHints = {
          variableTypes = true,
          functionReturnType = true,
        },
      },
    },
  },
}
