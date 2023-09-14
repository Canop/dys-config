

vim.opt.number = true
vim.opt.termguicolors = true
require("bufferline").setup {
        options = {
            numbers = "buffer_id",
            always_show_bufferline = false,
        }
}

require("bacon").setup {
    quickfix  = {
         enabled = false,
         event_trigger = false
    },
    autoload = false
}
