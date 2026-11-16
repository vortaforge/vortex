# Vortex (0.3.0)

Library pack: it provides functions for other datapacks and does nothing useful on its own.
Targets Minecraft 1.21.7-1.21.8 (pack_format 81). Renamed and reorganized from
macroEngine-Datapack-v26.3; old-to-new names for this layout are listed in `RENAMES.md`.

## Layout (`data/vortex/function/`)

| Folder | Purpose | Stable API? |
|---|---|---|
| `api/` | Public entry points, grouped by feature (`cmd`, `perm`, `store`, `toggle`, `title`, `cb`, `block`, `container`, `notice`, ...) | Yes |
| `player/` | Player helpers: `get/*`, `is/*`, `var/*`, `run/*`, plus `inv/` and `team/` | Yes |
| `world/` | World helpers: `block/*`, `region/*` (clone, fill), `time/*`, `entity/*`, `weather` | Yes |
| `input/` | Text-input capture: `anvil`, `sign`, `lectern`, ... with `give/*`, `summon/*` and `validate/*` | Yes |
| `api/dialog/` | Runtime dialog builder (`begin`, `title`, `body`, `button`, `input`, `show`, ...): per-player tickets route non-OP button clicks back to server functions. Ported from Modalith 2.2.0, see https://github.com/vortaforge/docs and `NOTICE-modalith.md` | Yes |
| `events/`, `tui/` | Event bus and text-UI helpers | Yes |
| `systems/` | Reusable building blocks (`math`, `string`, `hook`, `flag`, `rng`, `uuid`, `log`, ...) | Yes |
| `core/` | Engine runtime: `config`, `state`, `tick`, `queue`, `cooldown`, `dispatch`, `runtime` | No |
| `core/lib/` | Scheduling toolkit, one folder per feature: `schedule/`, `wait/`, `repeat/`, `once/`, `debounce/`, `queue/`, `for_each/`, `batch/`, `fiber/`, `string/` | No |
| `core/internal/` | Implementation behind the folders above (mirrors their layout) | No |

Other data folders: `advancement/`, `predicate/`, `loot_table/`, `item_modifier/`, `recipe/`, `tags/`.

## Conventions

- Every `.mcfunction` carries its own function ID in its header comment, plus `[MACRO]` when it uses `$` lines.
- Function folders group by feature, then by action: `player/var/set`, `core/lib/wait/cmd_as`.
- Scoreboard objectives, entity tags and macro keys are `snake_case` and prefixed `vortex.` (objectives and tags).
- Storage IDs are `vortex:<module>` with no leading underscore.
- Files use LF line endings, end with a newline, and JSON uses 2-space indentation.

## Callbacks (`api/callback`)

`function vortex:api/callback/run` is the public entry of one shared runner (`core/internal/callback/run`). It cannot be disabled by any toggle.
Put the ID in storage, run it; handlers registered in a function tag compare the ID themselves:

```mcfunction
# caller
data modify storage vortex:callback in set value {id:"mypack:round_won",args:{team:"red"}}
function vortex:api/callback/run

# handler, listed by your pack in data/vortex/tags/function/callback/dispatch.json
execute if data storage vortex:callback stack[-1]{id:"mypack:round_won"} run function mypack:on_round_won
```

- IDs are stored lower-case; empty IDs and IDs with a quote or backslash are rejected (reason in `dbg.err`).
- Tags: `#vortex:callback/dispatch` sees every callback. `#vortex:callback/macro_cmd` and `#vortex:callback/macro_function` additionally run for callbacks with `module:"macro_cmd"` / `"macro_function"`.
- When `macro_cmd` or `macro_function` is switched off, every guarded `$$(cmd)` / `$function $(id)` site fires `vortex:macro_cmd_blocked` / `vortex:macro_function_blocked` before it stops; `stack[-1].site` names the blocked function. The macro value is not forwarded.
- Handlers only read `stack[-1]`. Nesting is allowed up to 8 levels.

## Debug output (`systems/dbg`)

`function vortex:systems/dbg/out {src:"mypack",msg:"text"}` and `.../err` append to `vortex:dbg out` / `err` (50 entries each) instead of printing. `function vortex:systems/dbg/show` (vortex.admin) prints them on request.

## Input rules (`input/validate/rule*`)

Restrict or block values without a gate; your datapack decides what a failure means:

```mcfunction
function vortex:input/validate/rule_define {name:"yesno",rule:{allow:["yes","no"],ignore_case:1b}}
function vortex:input/validate/rule {source:"book.raw",rule:"yesno"}
execute if data storage vortex:input_validate result{valid:1b} run say ok
```

`allow` = only these values, `deny` = never these, entries may be strings or numbers (`allow:[0,1]`).

## Example pack

`examples/vortex-example` is a small datapack that uses the callback runner, the module callback tags, the blocked-macro hooks, input rules and dbg. See its README.
