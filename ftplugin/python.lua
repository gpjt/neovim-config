vim.lsp.start({
  name = 'python-lsp-server',
  cmd = {'pylsp'},
  root_dir = vim.fs.dirname(vim.fs.find({'setup.py', 'pyproject.toml'}, { upward = true })[1]),
})
