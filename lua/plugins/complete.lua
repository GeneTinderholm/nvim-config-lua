local cmp = require 'cmp'
cmp.setup({
    snippet = {
        view = {
            entries = "native"
        },
        expand = function(args)
            vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            {
                name = 'omni',
                option = {
                    disable_omnifuncs = { 'v:lua.vim.lsp.omnifunc' }
                }
            },
            { name = 'nvim_lsp_signature_help' },
            {
                name = "spell",
                option = {
                    keep_all_entries = false,
                    enable_in_context = function()
                        return true
                    end,
                    preselect_correct_word = true,
                }
            }
        }
    ),
})
