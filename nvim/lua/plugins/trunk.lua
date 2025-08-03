return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      
      -- Añadir trunk para archivos TypeScript/React
      opts.formatters_by_ft.typescriptreact = { "trunk" }
      opts.formatters_by_ft.typescript = { "trunk" }
      opts.formatters_by_ft.javascriptreact = { "trunk" }
      opts.formatters_by_ft.javascript = { "trunk" }
      opts.formatters_by_ft.json = { "trunk" }
      opts.formatters_by_ft.yaml = { "trunk" }
      opts.formatters_by_ft.markdown = { "trunk" }
      
      -- Configuración corregida del formateador
      opts.formatters = opts.formatters or {}
      opts.formatters.trunk = {
        command = "trunk",
        args = function(_, ctx)
          return { "fmt", ctx.filename }
        end,
        stdin = false,  -- Cambiado a false
        cwd = require("conform.util").root_file({ ".trunk" }),
      }
      
      return opts
    end,
  },
}
