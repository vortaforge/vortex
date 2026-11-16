# vortex_example:callback/log_site [MACRO]
# Writes the blocked site to dbg.out. $(site) is a constant from the guard line, not player input.
# AI-assisted: written with Claude (Anthropic); see CREDITS.md in the repo root.

$function vortex:systems/dbg/out {src:"vortex_example",msg:"blocked: $(site)"}
