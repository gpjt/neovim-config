local set = vim.opt
set.number = true

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

plugins = {
    { 
	"aktersnurra/no-clown-fiesta.nvim",
	lazy = False,
	priority = 1000,
	config = function()
            vim.cmd([[colorscheme no-clown-fiesta]])
	end,
    },
}

require("lazy").setup(plugins)

search_project = function()
    regex = vim.fn.input("Search for: ")
    vim.cmd.grep { args = { "-Iir", regex, "."} }
    vim.cmd.copen()
end

vim.keymap.set("n", "<C-S-f>", search_project, { silent = True })
