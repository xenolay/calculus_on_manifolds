-- fix-typst-math.lua
local function gsub_all(s, reps)
  for _, r in ipairs(reps) do
    s = s:gsub(r[1], r[2])
  end
  return s
end

function Math(el)
  local s = el.text

  -- kill LaTeX inline-math delimiters that sometimes leak into Math text
  s = gsub_all(s, {
    {"\\\\%(", "("},   -- \(
    {"\\\\%)", ")"},   -- \)
  })

  -- common macros
  s = gsub_all(s, {
    {"\\\\delta", "delta"},
  })

  -- \overline{...} -> overline(...)
  -- (simple version; works for most non-nested cases)
  s = s:gsub("\\\\overline%s*%{([^{}]*)%}", "overline(%1)")

  el.text = s
  return el
end
