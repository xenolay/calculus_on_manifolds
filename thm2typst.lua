-- thm2typst.lua
local map = {
  thm="thm",
  defi="defi",
  lem="lem",
  que="que",
  cor="cor",
  prop="prop",
  dig="dig",
  state="state",
  exm="exm",
  rem="rem",
  proof="proof"
}

local function env_of(classes)
  for _,c in ipairs(classes or {}) do
    if map[c] then return map[c], c end
  end
end

local function esc(s) return s and (s:gsub("\\","\\\\"):gsub('"','\\"')) or s end

-- try to strip "Theorem 1 (Title)." prefix that pandoc injects
local function peel_header(blocks)
  if #blocks == 0 or blocks[1].t ~= "Para" then return nil, blocks end
  local inls = blocks[1].content or blocks[1] -- pandoc 3.x
  if not inls or #inls == 0 then return nil, blocks end

  -- Heuristic: starts with Strong["Theorem"/"Lemma"/...]
  local headword = nil
  if inls[1] and inls[1].t == "Strong" then
    headword = pandoc.utils.stringify(inls[1])
  end
  if not headword then return nil, blocks end

  -- collect title between first (...) after headword; drop until first period after that
  local title, stage, new_inls = {}, "seek_open", {}
  for i=1,#inls do
    local el = inls[i]
    local txt = (el.t == "Str") and el.text or nil
    if stage == "seek_open" then
      if txt == "(" then stage = "in_title" end
    elseif stage == "in_title" then
      if txt == ")" then stage = "seek_period" else table.insert(title, el) end
    elseif stage == "seek_period" then
      if txt == "." then stage = "keep_rest" end
    else -- keep_rest
      table.insert(new_inls, el)
    end
  end
  local t = pandoc.utils.stringify(pandoc.Inlines(title))
  local rest = {}
  if #new_inls > 0 then table.insert(rest, pandoc.Para(new_inls)) end
  for i=2,#blocks do table.insert(rest, blocks[i]) end
  return (t ~= "" and t or nil), rest
end

function Div(el)
  local typ = env_of(el.classes)
  if not typ then return nil end

  local title, body = peel_header(el.content)
  local open
  if title then
    open = string.format('#%s("%s")[', typ, esc(title))
  else
    open = string.format('#%s[', typ)
  end

  local out = { pandoc.RawBlock("typst", open) }
  for _,b in ipairs(body) do table.insert(out, b) end
  table.insert(out, pandoc.RawBlock("typst", "]"))
  return out
end
