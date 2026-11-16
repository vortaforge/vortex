<!-- AI-assisted: written with Claude (Anthropic); see CREDITS.md in the repo root. -->
# vortex example pack

A small datapack that uses vortex. It is a demo, not part of the vortex release zip (the release only packs `pack.mcmeta` and `data/` from the repo root).

Needs vortex 0.3+ with the callback, input-rule, dbg and macro-toggle changes (PRs #5 and #7). Minecraft 1.21.7-1.21.8 (pack_format 81).

## Install
Put the `vortex-example` folder (or a zip of it with `pack.mcmeta` and `data/` at its root) into the world's `datapacks/` folder next to vortex, then `/reload`.

## Run
```mcfunction
/tag @s add vortex.admin
/function vortex_example:demo/run_all
```
`run_all` needs `vortex.admin`, because the toggle functions and `dbg/show` check it. Each part can also be run alone: `demo/callback`, `demo/validate`, `demo/blocked`, `demo/dbg`.

## What it shows
| Demo | Feature | Files to read |
|---|---|---|
| `demo/callback` | Shared callback runner. The handler is listed in `#vortex:callback/dispatch` and compares the ID itself. IDs are lower-cased; an empty ID is rejected. | `callback/dispatch_handler`, `callback/on_hello`, `data/vortex/tags/function/callback/dispatch.json` |
| `demo/validate` | Input rules, not a gate: `yesno` (allow, ignore case), `bit` (allow 0 or 1), `no_admin` (deny list). The pack decides what a failure means. | `setup`, `demo/validate`, `demo/show_result` |
| `demo/blocked` | With `macro_function` or `macro_cmd` off, a guarded site still stops but first fires a module callback. Handlers sit in `#vortex:callback/macro_function` and `#vortex:callback/macro_cmd`; `stack[-1].site` is the blocked function. Both toggles are switched back on at the end. | `demo/blocked`, `callback/on_macro_*_blocked`, `provider/one`, `consumer/print` |
| `demo/dbg` | `dbg.out` / `dbg.err` write to storage `vortex:dbg` instead of chat; `dbg/show` prints them. | `demo/dbg`, `callback/log_site` |

## Expected output (abridged)
```
[example] 1/4 callback
[example] hello, team red
[example] hello (no payload)
[example] hello (no payload)          <- "Vortex_Example:Hello" was lower-cased
[example] 2/4 input rules
yesno <- YES (expect valid)           -> valid
yesno <- maybe (expect not allowed)   -> invalid: value not allowed
bit <- 1 (expect valid)               -> valid
bit <- 2 (expect not allowed)         -> invalid: value not allowed
no_admin <- Admin (expect denied)     -> invalid: value is denied
[example] 3/4 blocked macro sites
[example] $function $(id) blocked at api/macro/with_function
[example] $$(cmd) blocked at core/lib/once/cmd
[example] the pipe works
[example] 4/4 dbg
```
followed by the `dbg.err` / `dbg.out` lists (including `callback id is empty` and the two `blocked:` lines).

This output was derived from reading the code; the pack has not been run in a game yet.

## Notes
- `$tellraw` in `consumer/print` and `$function` in `callback/log_site` use a fixed target and static text, so the vortex macro toggles do not gate them.
- Never paste player text into a macro argument. The example passes constants only.
