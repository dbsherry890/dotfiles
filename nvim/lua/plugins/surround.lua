return {
  'kylechui/nvim-surround',
  version = '^3.0.0', -- stable version; omit for latest main branch
  event = 'VeryLazy',
  opts = {
    keymaps = {
      normal = 'ys', -- add surround
      normal_cur = 'yss', -- add surround to whole line
      visual = 'S', -- surround in visual mode
      delete = 'ds', -- delete surround
      change = 'cs', -- change surround
    },
  },
}

--
-- ============================
-- nvim-surround Cheatsheet
-- ============================
--
-- ➕ Add Surround
--   ysiw)   → (word)
--   ysiw"   → "word"
--   ysiw'   → 'word'
--   yss)    → (whole line)
--   S)      → (visual selection)
--
-- ✏️ Change Surround
--   cs"'    → "word"   → 'word'
--   cs([    → (word)   → [word]
--   cs{"    → {word}   → "word"
--
-- ❌ Delete Surround
--   ds"     → "word"   → word
--   ds)     → (word)   → word
--   ds}     → {word}   → word
--
-- 🧠 Motions
--   iw      → inner word
--   ap      → a paragraph
--   s       → a sentence
--
-- General:
--   ys      → add surround
--   ds      → delete surround
--   cs      → change surround
--
-- ============================
