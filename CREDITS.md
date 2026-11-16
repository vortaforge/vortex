# Credits

## AI involvement

Parts of this pack were written with AI. Files that were AI-assisted carry the line
`# AI-assisted: written with Claude (Anthropic); see CREDITS.md.` in their header, and the
commits carry an `AI-assisted:` trailer.

| Change | Files | AI |
|---|---|---|
| Macro toggles (`macro_cmd`, `macro_function`) | `api/toggle/macro_*`, guard lines before `$$(cmd)` / `$function $(id)`, `core/config/*` | Claude (Anthropic) |
| Shared callback runner | `api/callback/*`, `tags/function/callback/dispatch.json` | Claude (Anthropic) |
| Internal callback runner, module tags, blocked-macro hooks | `core/internal/callback/*`, `api/callback/*`, `tags/function/callback/*`, guard lines | Claude (Anthropic) |
| Example datapack | `examples/vortex-example/*` | Claude (Anthropic) |
| Storage debug output | `systems/dbg/*`, converted `tellraw` lines | Claude (Anthropic) |
| Input rules | `input/validate/rule*`, `input/validate/_rule_*` | Claude (Anthropic) |

Static checks only (JSON validity, function and tag references). Not run in a game.
