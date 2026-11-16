# vortex_example:demo/run_all
# Runs every demo in order. Needs the vortex.admin tag:
#   /tag @s add vortex.admin
#   /function vortex_example:demo/run_all
# AI-assisted: written with Claude (Anthropic); see CREDITS.md in the repo root.

execute unless entity @s[tag=vortex.admin] run return run tellraw @s {"text":"[example] needs the vortex.admin tag: /tag @s add vortex.admin","color":"red"}

function vortex_example:setup
function vortex_example:demo/callback
function vortex_example:demo/validate
function vortex_example:demo/blocked
function vortex_example:demo/dbg
