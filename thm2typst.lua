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
  proof="proof",
  myproof="proof",
  restatable="thm"
}

local function env_of(classes)
  for _,c in ipairs(classes or {}) do
    if map[c] then return map[c], c end
  end
end

local function esc(s) return s and (s:gsub("\\","\\\\"):gsub('"','\\"')) or s end

-- 先頭段落から \label を抜き出す（Typst では #env[...] の後に置くため）
local function extract_label(blocks)
  if #blocks == 0 or blocks[1].t ~= "Para" then return nil, blocks end
  local inls = blocks[1].content or blocks[1]
  local new_inls, label = {}, nil

  local function pick_from_span(span)
    local attrs = span.attributes or (span.attr and span.attr.attributes) or {}
    if attrs and (attrs.label or attrs.target) then return attrs.label or attrs.target end
    return nil
  end

  for _,el in ipairs(inls) do
    if label == nil and el.t == "Span" then
      label = pick_from_span(el)
    else
      table.insert(new_inls, el) 
    end
  end

  if label then
    -- 先頭段落が空になったら落とす
    local rest = {}
    if #new_inls > 0 then table.insert(rest, pandoc.Para(new_inls)) end
    for i=2,#blocks do table.insert(rest, blocks[i]) end
    return label, rest
  else
    return nil, blocks
  end
end

function Div(el)
  local typ = env_of(el.classes)
  if not typ then return nil end

  local label
  local body = el.content
  label, body = extract_label(body)

  local open = string.format('#%s[', typ)
  local out = { pandoc.RawBlock("typst", open) }
  for _,b in ipairs(body) do
    table.insert(out, b)
  end
  table.insert(out, pandoc.RawBlock("typst", "]"))
  if label then
    table.insert(out, pandoc.RawBlock("typst", " <"..esc(label)..">"))
  end
  return out
end
