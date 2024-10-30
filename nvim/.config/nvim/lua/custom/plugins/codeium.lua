return {
  'Exafunction/codeium.vim',
  config = function()
    -- Change '<C-g>' here to any keycode you like.
    vim.keymap.set('i', '<C-.>', function() return vim.fn['codeium#CycleCompletions(1)']() end,
      { expr = true, silent = true })
  end,
  event = 'BufEnter'
}
