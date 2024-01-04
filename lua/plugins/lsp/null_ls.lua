local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
    },
    on_attach = LSP_ON_ATTACH,
})
