# vortex_example:callback/dispatch_handler
# Listed in #vortex:callback/dispatch, so it sees every callback. It only reads stack[-1]
# and never removes it; the runner pops the entry afterwards.
# AI-assisted: written with Claude (Anthropic); see CREDITS.md in the repo root.

execute if data storage vortex:callback stack[-1]{id:"vortex_example:hello"} run function vortex_example:callback/on_hello
