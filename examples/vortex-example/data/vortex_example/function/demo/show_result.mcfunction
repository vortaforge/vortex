# vortex_example:demo/show_result
# Prints vortex:input_validate result: valid, or the error.
# AI-assisted: written with Claude (Anthropic); see CREDITS.md in the repo root.

execute if data storage vortex:input_validate result{valid:1b} run tellraw @s {"text":"  -> valid","color":"green"}
execute unless data storage vortex:input_validate result{valid:1b} run tellraw @s ["",{"text":"  -> invalid: ","color":"red"},{"nbt":"result.error","storage":"vortex:input_validate","color":"red"}]
