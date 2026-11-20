# vortex:api/input/private/anvil_end  [INTERNAL]
# @s = player. Closes the anvil session.
tag @s remove vortex.anvil_session
tag @s remove vortex.anvil_hidden
scoreboard players reset @s vortex.anvil_t

function vortex:api/input/private/anvil_close
