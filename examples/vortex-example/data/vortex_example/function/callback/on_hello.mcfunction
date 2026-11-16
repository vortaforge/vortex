# vortex_example:callback/on_hello
# AI-assisted: written with Claude (Anthropic); see CREDITS.md in the repo root.

execute if data storage vortex:callback stack[-1].args.team run tellraw @a ["",{"text":"[example] hello, team ","color":"green"},{"nbt":"stack[-1].args.team","storage":"vortex:callback","color":"yellow"}]
execute unless data storage vortex:callback stack[-1].args.team run tellraw @a {"text":"[example] hello (no payload)","color":"green"}
