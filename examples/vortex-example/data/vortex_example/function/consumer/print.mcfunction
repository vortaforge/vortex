# vortex_example:consumer/print [MACRO]
# Consumer for api/macro/with_function: reads $(msg) from the pipe.
# AI-assisted: written with Claude (Anthropic); see CREDITS.md in the repo root.

$tellraw @a {"text":"[example] $(msg)","color":"green"}
