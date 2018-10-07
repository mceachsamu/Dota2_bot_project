

ability_item_usage_disruptor = dofile( GetScriptDirectory().."/ability_item_usage_disruptor" )
item_purchase_disruptor = dofile( GetScriptDirectory().."/item_purchase_disruptor" )
----------------------------------------------------------------------------------------------------

_G._savedEnv = getfenv()
module( "ability_item_usage_generic", package.seeall )

----------------------------------------------------------------------------------------------------

function AbilityUsageThink()

	--print( "Generic.AbilityUsageThink" );

end

----------------------------------------------------------------------------------------------------

function ItemUsageThink()

	--print( "Generic.ItemUsageThink" );

end

----------------------------------------------------------------------------------------------------


for k,v in pairs( ability_item_usage_generic ) do	_G._savedEnv[k] = v end

BotsInit = require( "game/botsinit" );
local MyModule = BotsInit.CreateGeneric();
MyModule.OnStart = OnStart;
MyModule.OnEnd = OnEnd;
MyModule.Think = Think;
MyModule.GetDesire = GetDesire;
return MyModule;
