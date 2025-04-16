require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code action", silent = true })
-- Example: Define a keybinding to show diagnostics for the current buffer
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show LTeX Diagnostics" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
