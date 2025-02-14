local function nmap(key, binding, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap('n', key, binding, opts)
end

local function ensure_data_dir(dirname)
    if dirname:sub(1, 1) ~= "/" then
        dirname = "/" .. dirname
    end
    if dirname:sub(-1) ~= "/" then
        dirname = dirname .. "/"
    end
    local path = vim.fn.stdpath('data') .. dirname
    if vim.fn.empty(vim.fn.glob(path)) > 0 then
        vim.fn.mkdir(path, "p")
    end
    return path
end

local function merge_tables(...)
    local args = { select(1, ...) }
    local result = {}
    for _, val in ipairs(args) do
        if type(val) == "table" then
            for k, v in pairs(val) do
                if type(v) == "table" then
                    result[k] = merge_tables(result[k] or {}, v)
                else
                    result[k] = v
                end
            end
        end
    end
    return result
end

return {
    ensure_data_dir = ensure_data_dir,
    merge_tables = merge_tables,
    nmap = nmap,
}
