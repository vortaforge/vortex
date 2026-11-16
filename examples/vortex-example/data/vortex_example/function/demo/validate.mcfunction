# vortex_example:demo/validate
# Checks sample values against the rules from setup. Each check puts the value under
# storage vortex:input and names it by path; the result lands in vortex:input_validate result.
# AI-assisted: written with Claude (Anthropic); see CREDITS.md in the repo root.

tellraw @s {"text":"[example] 2/4 input rules","color":"aqua","bold":true}

data modify storage vortex:input example.v set value "YES"
function vortex:input/validate/rule {source:"example.v",rule:"yesno"}
tellraw @s {"text":"yesno <- YES (expect valid)","color":"gray"}
function vortex_example:demo/show_result

data modify storage vortex:input example.v set value "maybe"
function vortex:input/validate/rule {source:"example.v",rule:"yesno"}
tellraw @s {"text":"yesno <- maybe (expect not allowed)","color":"gray"}
function vortex_example:demo/show_result

data modify storage vortex:input example.v set value 1
function vortex:input/validate/rule {source:"example.v",rule:"bit"}
tellraw @s {"text":"bit <- 1 (expect valid)","color":"gray"}
function vortex_example:demo/show_result

data modify storage vortex:input example.v set value "2"
function vortex:input/validate/rule {source:"example.v",rule:"bit"}
tellraw @s {"text":"bit <- 2 (expect not allowed)","color":"gray"}
function vortex_example:demo/show_result

data modify storage vortex:input example.v set value "Admin"
function vortex:input/validate/rule {source:"example.v",rule:"no_admin"}
tellraw @s {"text":"no_admin <- Admin (expect denied)","color":"gray"}
function vortex_example:demo/show_result

data remove storage vortex:input example
