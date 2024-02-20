return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        local ls = require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/snippets" })
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node
        local f = ls.function_node
        local extras = require("luasnip.extras")
        local rep = extras.rep

        local getPath = function()
          -- Get the current file path
          local current_file_path = vim.fn.expand("%:p")

          -- Calculate the parent path (directory one level above)
          local parent_path = vim.fn.fnamemodify(current_file_path, ":h:h")

          -- Return the parent path as a string
          return parent_path
        end

        local makePath = function()
          local current_file_path = vim.fn.expand("%:p")

          -- Get the current working directory
          local current_working_directory = vim.fn.getcwd()

          -- Calculate the relative path
          local relative_path = vim.fn.fnamemodify(current_file_path, ":p:h")
          relative_path =
            vim.fn.substitute(relative_path, "^" .. vim.fn.escape(current_working_directory, "/\\") .. "/", "", "")

          -- Return the relative path as a string
          return relative_path
        end

        local addDirect = function()
          -- Get the current file path
          local current_file_path = vim.fn.expand("%:p")

          -- Set the base path prefix to /~/Documents/mywebsite/src/vimwiki/
          local base_path_prefix = "/Users/stefanjakovljevic/Documents/mywebsite/public/vimwiki/"

          -- Check if the current file path starts with the base path prefix
          if vim.fn.stridx(current_file_path, base_path_prefix) == 0 then
            -- Remove the base path prefix from the current file path
            local relative_path_without_base = vim.fn.substitute(current_file_path, "^" .. base_path_prefix, "", "")

            -- Get the directory part without the file name
            local directory_only = vim.fn.fnamemodify(relative_path_without_base, ":h")

            -- Return the relative directory path with a leading /
            return "/" .. directory_only
          end

          -- If the current file path does not start with the base path prefix, return the full path
          return "ERROR"
        end

        vim.keymap.set({ "i", "s" }, "<C-k>", function()
          if ls.expand_or_jumpable() then
            ls.expand_or_jump()
          end
        end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<C-j>", function()
          if ls.jumpable(-1) then
            ls.jump(-1)
          end
        end, { silent = true })

        ls.add_snippets("vimwiki", {
          s("div", {
            t({ "----", "", "" }),
            i(1, "Write"),
            t({ "", "", "----" }),
          }),

          s("home", {
            t("[[/index|Home]]"),
          }),

          s("to_back)", {
            t("[["),
            t("//"),
            f(getPath),
            t("/"),
            i(1, "back directory"),
            t("|Back]]"),
          }),

          s("create_new_dir", {
            t("[["),
            f(addDirect),
            t("/"),
            i(1, "file"),
            t("/"),
            rep(1),
            t("|"),
            i(2, "name"),
            t("]]"),
          }),

          s("h1", {
            t("= "),
            i(1, "Name header"),
            t(" ="),
          }),

          s("h3", {
            t("=== "),
            i(1, "Name header"),
            t(" ==="),
          }),
          s("h5", {
            t("===== "),
            i(1, "Name header"),
            t(" ====="),
          }),

          s("bold", {
            t("*"),
            i(1, "Text"),
            t("*"),
          }),

          s("italic", {
            t("_"),
            i(1, "Text"),
            t("_"),
          }),

          s("superscript", {
            i(1, "Big"),
            t("^"),
            i(2, "Small"),
            t("^"),
          }),

          s("subscript", {
            i(1, "big"),
            t(",,"),
            i(2, "small"),
            t(",,"),
          }),

          s("create_file", {
            t("[["),
            i(1, "Location"),
            t("|"),
            i(2, "Linktitle"),
            t("]]"),
          }),

          s("image_large_down", {
            t("{{local:"),
            i(1, "file"),
            t("|"),
            i(2, "large picture"),
            t('|style="max-width:500px;height:auto;"}}'),
          }),

          s("image_medium_down", {
            t("{{local:"),
            i(1, "file"),
            t("|"),
            i(2, "medium picture"),
            t('|style="max-width:300px;height:auto;"}}'),
          }),

          s("image_small_down", {
            t("{{local:"),
            i(1, "file"),
            t("|"),
            i(2, "small picture"),
            t('|style="max-width:100px;height:auto;"}}'),
          }),

          s("todo_incomp", {
            t("- [ ] "),
            i(1, "reminder"),
          }),

          s("todo_done", {
            t("- [X] "),
            i(1, "reminder"),
          }),

          s("todo_notyet", {
            t("- [.] "),
            i(1, "reminder"),
          }),

          s("comingsoon", {
            t({ "[[/index|Home]]", "", "" }),
            t("Coming Soon..."),
          }),
        })
      end,
    },
  },
}
