# vortex_example:setup
# Runs on load (#minecraft:load) and at the start of demo/run_all.
# Defines three input rules. Rules are NOT a gate: nothing is blocked until a datapack
# calls vortex:input/validate/rule and decides what a failure means.
# AI-assisted: written with Claude (Anthropic); see CREDITS.md in the repo root.

# only "yes" or "no", any case
function vortex:input/validate/rule_define {name:"yesno",rule:{allow:["yes","no"],ignore_case:1b}}
# only 0 or 1 (numbers are compared as text, so "1" and 1 both pass)
function vortex:input/validate/rule_define {name:"bit",rule:{allow:[0,1]}}
# anything except these names, any case
function vortex:input/validate/rule_define {name:"no_admin",rule:{deny:["admin","owner"],ignore_case:1b}}
