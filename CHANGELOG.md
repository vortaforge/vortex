# Changelog

## Unreleased

### Added
- Macro toggles: `module_macro_cmd` (every `$$(cmd)` line) and `module_macro_function` (every `$function $(id)` line whose target comes from the caller). Both default to `1b`. Switch them with `vortex:api/toggle/macro_cmd/{true,false}` and `vortex:api/toggle/macro_function/{true,false}` (vortex.admin only), the toggle menu, or `core/config/set`. `$function` lines with a fixed target (dialog, rate_limit, rng, fiber plumbing) are not gated, so turning the toggle off cannot break the engine itself.
- Shared callback runner `vortex:core/internal/callback/run`, with `vortex:api/callback/run` and `run_id` as thin public wrappers. No module toggle and no config flag. The ID comes from storage `vortex:callback in`, is string-checked (coerced to a string, rejected when empty or when it has a quote or backslash, lower-cased), pushed on a stack, and passed to the handlers in the function tags. Handlers compare the ID themselves (`stack[-1].id`). Re-entrant up to 8 levels; deeper calls are dropped and logged to `dbg.err`.
- Module-specific callback tags: `#vortex:callback/macro_cmd` and `#vortex:callback/macro_function` run (before the shared `#vortex:callback/dispatch`) for callbacks with `module:"macro_cmd"` / `"macro_function"`.
- When `module_macro_cmd` / `module_macro_function` is off, each of the 21 guarded `$$(cmd)` / `$function $(id)` sites now fires a callback (`vortex:macro_cmd_blocked` / `vortex:macro_function_blocked`, `stack[-1].site` = the blocked function path) before it returns 0. The macro value itself is not forwarded.
- `vortex:systems/dbg/{out,err,show,clear}`: storage-based debug output (`vortex:dbg out` / `err`, 50 entries each). `show` is the only place that prints to chat.
- Input rules, not a gate: `vortex:input/validate/rule_define` (`allow`, `deny`, `ignore_case`) and `vortex:input/validate/rule`. Example: `allow:["yes","no"]` or `allow:[0,1]`. The result goes to `vortex:input_validate result` like the other validators.
- `examples/vortex-example`: a demo datapack for the callback runner, the module callback tags, the blocked-macro hooks, input rules and dbg. It is not part of the release zip.

### Changed
- The diagnostic `tellraw` lines in `api/cb/*` (10), `core/internal/api/gamerule/debug_print` and the "passed the dynamic-command gate" notice to admins now write to `vortex:dbg` instead of chat. Menu and permission messages are unchanged.

### Added
- `vortex:api/notice/show`: a dialog (built with `vortex:api/dialog/*`) that tells players the pack was written with AI, that the dialog module was ported from Modalith instead of rewritten, what player data it keeps, that datapacks are not sandboxed, and where to report problems. It is shown once to every player who has not seen it (flag: `vortex.notice_seen`), including players online during a `/reload`; call it again with `execute as <player> run function vortex:api/notice/show`.
- `vortex:core/internal/notice/load` (called from `vortex:setup`) and `vortex:core/internal/notice/tick` (registered in `#minecraft:tick`).

## 0.3.0

Adds the dialog module, ported from [Modalith](https://github.com/tickwarden/modalith) 2.2.0 (MIT, see `NOTICE-modalith.md`).

### Added
- `vortex:api/dialog/*` (public API), `vortex:api/dialog/native_action/*` (client-side button actions) and `vortex:core/internal/dialog/*` (runtime, not API). 176 functions.
- Hook tags `#vortex:hook/dialog_{after_action,before_action,on_close,on_event,on_reject,on_show,on_timeout}`.
- `vortex:core/internal/dialog/load` is called from `vortex:setup`; `vortex:core/internal/dialog/tick` is registered directly in `#minecraft:tick`, so ticket TTLs and cooldowns are not slowed by the engine's `tick.rate`.
- `.github/rulesets/main.json`: the `main` branch ruleset (no deletion, no force-push, pull request required, no bypass actors).

### Renames (Modalith -> vortex)
- Functions: `mdl:api/*` -> `vortex:api/dialog/*`, `mdl:action/*` -> `vortex:api/dialog/native_action/*`, `mdl:internal/*` -> `vortex:core/internal/dialog/*`.
- Storage: `mdl:<x>` -> `vortex:dialog_<x>`. Objectives and tags: `mdl.<x>` -> `vortex.dialog_<x>`.

### Not verified
- Modalith targets Minecraft 26.3 (data pack version 121.0); vortex targets 1.21.7-1.21.8 (pack_format 81). Only static checks were run (JSON validity, every `function` reference and tag resolves, macro lines carry `$(...)`). The dialog definition fields were not run against a 1.21.8 game.
- Modalith's test suite and `mdl_demo` were not ported.

## 0.2.0

Fixes every data file that failed to load on Minecraft 1.21.7-1.21.8 (pack_format 81).

### Fixed
- `item_modifier/discard`: `minecraft:discard` does not exist in 1.21.8; now `set_count` with `count: 0`, which empties the stack.
- `predicate/core/internal/player/equals_uuid`: `minecraft:int_value_check` does not exist in 1.21.8; now `minecraft:value_check` with a score-provider `range` (min = max).
- 34 advancements (`core/internal/player/*`, `input/anvil_open`, `systems/hook/*`): trigger conditions are now a list of loot conditions that use the `condition` key (was a single object with `type`).
- `advancement/core/internal/player/interact_click_entity`: entity predicate key `minecraft:entity_type` is now `type`.
- `events/fire_queued`: pointed at the missing `events/internal/fire_deferred`; now calls `core/internal/events/fire_deferred`, so queued events run.

### Changed
- Version bumped to 0.2.0 (`pack.mcmeta`, `README.md`, `core/version/define`).
