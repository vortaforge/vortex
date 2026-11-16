# vortex_example:demo/blocked
# Switches the macro toggles off, calls a guarded site, and switches them back on.
# With a toggle off the site still stops, but first fires a callback whose handler is listed in
# #vortex:callback/macro_function or #vortex:callback/macro_cmd.
# Needs vortex.admin (the toggles check it). Both toggles are restored at the end.
# AI-assisted: written with Claude (Anthropic); see CREDITS.md in the repo root.

tellraw @s {"text":"[example] 3/4 blocked macro sites","color":"aqua","bold":true}

function vortex:api/toggle/macro_function/false
function vortex:api/macro/with_function {source:"vortex_example:provider/one",target:"vortex_example:consumer/print"}
function vortex:api/toggle/macro_function/true

function vortex:api/toggle/macro_cmd/false
function vortex:core/lib/once/cmd {key:"vortex_example_once",cmd:"say never runs while macro_cmd is off"}
function vortex:api/toggle/macro_cmd/true

# toggles on again: the same call now runs the provider and the consumer
function vortex:api/macro/with_function {source:"vortex_example:provider/one",target:"vortex_example:consumer/print"}
