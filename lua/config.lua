-- Show line numbers
vim.opt.number = true

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

-- Set up lazy, our plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
      lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Define our plugins
plugins = {
    -- For our default theme, don't load it lazily, and make it the most important one
    {
	"aktersnurra/no-clown-fiesta.nvim",
	lazy = False,
	priority = 1000,
	config = function()
            vim.cmd([[colorscheme no-clown-fiesta]])
	end,
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "ctrlpvim/ctrlp.vim",
    },
}

-- Kick off the plugin loading
require("lazy").setup(plugins)


-- My own find-across-project thing
search_project = function()
    regex = vim.fn.input("Search for: ")
    vim.cmd.grep { args = { "-Iir", regex, "."} }
    vim.cmd.copen()
end
-- This works on Linux (where alacritty swallows control-shift-F
vim.keymap.set("n", "<S-D-F>", search_project)
-- This works on the Mac (where the iTerm2 swallows command-shift-F
vim.keymap.set("n", "<C-S-F>", search_project)


-- CtrlP config
vim.g.ctrlp_working_path_mode = "ra"
vim.g.ctrlp_root_markers = { "pyproject.toml" }
vim.g.ctrlp_custom_ignore = "\\v(\\.git|__pycache__)/"
vim.keymap.set("n", "<C-p>", ":CtrlP<CR>")
vim.keymap.set("n", "<C-=>", ":CtrlPBuffer<CR>")

