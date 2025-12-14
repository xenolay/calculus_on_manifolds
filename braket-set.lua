-- braket-set.lua
-- Convert LaTeX \set{...} or \Set{...} in Math to Typst { ... }

local function find_balanced_brace(s, open_pos)
  -- open_pos points to the character AFTER '{'
  local depth = 1
  local i = open_pos
  while i <= #s do
    local ch = s:sub(i, i)
    if ch == '{' then
      depth = depth + 1
    elseif ch == '}' then
      depth = depth - 1
      if depth == 0 then
        return i
      end
    end
    i = i + 1
  end
  return nil
end

local function replace_set_macros(s)
  local out = {}
  local i = 1
  while i <= #s do
    -- match \set{ or \Set{
    local a, b, cmd = s:find("\\([sS]et){", i)
    if not a then
      table.insert(out, s:sub(i))
      break
    end

    -- copy text before match
    table.insert(out, s:sub(i, a - 1))

    -- parse the {...} argument (balanced)
    local arg_start = b + 1 -- position after the '{'
    local arg_end = find_balanced_brace(s, arg_start)
    if not arg_end then
      -- unmatched brace; leave as-is
      table.insert(out, s:sub(a))
      break
    end

    local body = s:sub(arg_start, arg_end - 1)
    -- Typst set braces: { ... }
    table.insert(out, "\\{ " .. body .. " \\}")

    i = arg_end + 1
  end
  return table.concat(out)
end

function Math(el)
  -- Apply to both InlineMath and DisplayMath
  if el and el.text then
    el.text = replace_set_macros(el.text)
  end
  return el
end
