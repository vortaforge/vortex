# vortex_example:demo/callback
# Fires the shared callback runner. The handler is registered in
# data/vortex/tags/function/callback/dispatch.json and compares the ID itself.
# IDs are stored lower-case, so write them lower-case.
# AI-assisted: written with Claude (Anthropic); see CREDITS.md in the repo root.

tellraw @s {"text":"[example] 1/4 callback","color":"aqua","bold":true}
data modify storage vortex:callback in set value {id:"vortex_example:hello",args:{team:"red"}}
function vortex:api/callback/run

# shortcut without a payload
function vortex:api/callback/run_id {id:"vortex_example:hello"}

# An ID with upper-case letters is lower-cased, so this one still reaches the handler.
data modify storage vortex:callback in set value {id:"Vortex_Example:Hello"}
function vortex:api/callback/run

# An empty ID is dropped and logged to dbg.err (shown by demo/dbg).
data modify storage vortex:callback in set value {id:""}
function vortex:api/callback/run
