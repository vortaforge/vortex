# vortex_example:callback/on_macro_cmd_blocked
# Listed in #vortex:callback/macro_cmd: runs when a $$(cmd) site is blocked because
# module_macro_cmd is off. stack[-1].site is the blocked function path.
# The macro value itself is not forwarded.
# AI-assisted: written with Claude (Anthropic); see CREDITS.md in the repo root.

tellraw @a ["",{"text":"[example] $$(cmd) blocked at ","color":"gold"},{"nbt":"stack[-1].site","storage":"vortex:callback","color":"yellow"}]
data modify storage vortex_example:tmp site set from storage vortex:callback stack[-1].site
function vortex_example:callback/log_site with storage vortex_example:tmp
