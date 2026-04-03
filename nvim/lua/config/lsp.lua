vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end

    -- Completion
    if client:supports_method('textDocument/completion') then
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      vim.keymap.set('i', '<C-Space>', vim.lsp.completion.get, { buffer = ev.buf })
    end

    -- Keymaps
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = 'LSP: ' .. desc })
    end

    map('gl', vim.diagnostic.open_float, 'Open Diagnostic Float')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('gt', vim.lsp.buf.type_definition, 'Goto Type Definition')
    -- map('gs', vim.lsp.buf.signature_help, 'Signature Documentation')
    -- map('gD', vim.lsp.buf.declaration,    'Goto Declaration')
    -- map('<leader>la', vim.lsp.buf.code_action, 'Code Action')
    -- map('<leader>lr', vim.lsp.buf.rename,      'Rename all references')
    -- map('<leader>lf', vim.lsp.buf.format,       'Format')

    -- Document highlight
    local function supports_method(method)
      if vim.fn.has('nvim-0.11') == 1 then
        return client:supports_method(method, ev.buf)
      else
        return client.supports_method(method, { bufnr = ev.buf })
      end
    end

    if supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local hl_group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer   = ev.buf,
        group    = hl_group,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer   = ev.buf,
        group    = hl_group,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group    = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        buffer   = ev.buf,
        callback = function()
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = ev.buf })
        end,
      })
    end
  end,
})

vim.diagnostic.config({
  virtual_lines = {
    current_line = true,
  },
})
