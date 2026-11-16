# vortex_example:callback/on_macro_function_blocked
# Listed in #vortex:callback/macro_function: runs when a $function $(id) site is blocked because
# module_macro_function is off. stack[-1].site is the blocked function path.
# The macro value itself is not forwarded.
# AI-assisted: written with Claude (Anthropic); see CREDITS.md in the repo root.

tellraw @a ["",{"text":"[example] $function $(id) blocked at ","color":"gold"},{"nbt":"stack[-1].site","storage":"vortex:callback","color":"yellow"}]
data modify storage vortex_example:tmp site set from storage vortex:callback stack[-1].site
function vortex_example:callback/log_site with storage vortex_example:tmp
