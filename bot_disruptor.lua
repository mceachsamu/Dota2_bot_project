
function Think()
	print("here");	
	local npcBot = GetBot();
	local tableNearbyEnemyHeros = npcBot:GetNearbyHeroes(1000, false, BOT_MODE_NONE);

	
	local location = npcBot:GetLocation();
	
	
	for _,friendly in pairs(tableNearbyEnemyHeros)
				do
				if(friendly:GetUnitName() == "npc_dota_hero_antimage")
					then
						location = friendly:GetLocation();		
						
				end
	end
	print(location);
	npcBot:Action_MoveDirectly(location);
end