-- User commands for managing the config.

-- :PackClean -- remove plugins installed on disk but no longer loaded via
-- vim.pack.add() in the current session (i.e. ones you deleted from config).
vim.api.nvim_create_user_command("PackClean", function()
  local unused = vim.tbl_filter(function(p)
    return not p.active
  end, vim.pack.get())

  if #unused == 0 then
    vim.notify("PackClean: no unused plugins", vim.log.levels.INFO)
    return
  end

  local names = vim.tbl_map(function(p)
    return p.spec.name
  end, unused)

  local prompt = "Delete unused plugins?\n  " .. table.concat(names, "\n  ")
  if vim.fn.confirm(prompt, "&Yes\n&No", 2) == 1 then
    vim.pack.del(names)
    vim.notify("PackClean: removed " .. #names .. " plugin(s)", vim.log.levels.INFO)
  end
end, { desc = "Remove plugins not loaded via vim.pack.add()" })
