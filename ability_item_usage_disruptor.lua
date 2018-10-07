	
----------------------------------------------------------------------------------------------------

castLBDesire = 0;
castLSADesire = 0;
castDSDesire = 0;
	--i want to log the locations of every unit i can see in realtime so that i can calculate when to glimpse someone
	--glimpse brings an opponent back to 4 seconds ago, so i will work in second chunks
	----------enemy_1
	glimpseMin = 300;--minimum distance to justify glimpse
	enemy1ID = -1;
	LocationXP1 = {0.0,0.0,0.0,0.0};
	LocationZP1 = {0.0,0.0,0.0,0.0};
	----------enemy_2
	enemy2ID = -1;
	LocationXP2 = {0.0,0.0,0.0,0.0};
	LocationZP2 = {0.0,0.0,0.0,0.0};
	-----------enemy_3
	enemy3ID = -1;
	LocationXP3 = {0.0,0.0,0.0,0.0};
	LocationZP3 = {0.0,0.0,0.0,0.0};
	-----------enemy_4
	enemy4ID = -1;
	LocationXP4 = {0.0,0.0,0.0,0.0};
	LocationZP4 = {0.0,0.0,0.0,0.0};
	-----------enemy_5
	enemy5ID = -1;
	LocationXP5 = {0.0,0.0,0.0,0.0};
	LocationZP5 = {0.0,0.0,0.0,0.0};
	
	startT = DotaTime();
	prevTime = 0;
function AbilityUsageThink()
	local npcBot = GetBot();
	-- Check if we're already using an ability
	if ( npcBot:IsUsingAbility() ) then
		return 
		end;

	abilityTs = npcBot:GetAbilityByName( "disruptor_thunder_strike" );
	abilityG = npcBot:GetAbilityByName( "disruptor_glimpse" );
	abilityKf = npcBot:GetAbilityByName( "disruptor_kinetic_field" );
	abilitySS = npcBot:GetAbilityByName( "disruptor_static_storm" );
	--itemClarity = npcBot:GetItemByName("clarity");
	if(npcBot:GetAbilityPoints( )>0)
		then
			
			npcBot:ActionImmediate_LevelAbility( "disruptor_glimpse");
			npcBot:ActionImmediate_LevelAbility( "disruptor_thunder_strike");
	end
	--abilityTs.UpgradeAbility();
	-- Consider using each ability
	castTsDesire, castTsTarget = ConsiderThunderStrike();
	castGDesire, castGTarget = 0,0;
	castKfDesire, castKfLocation = ConsiderKineticField();
	castSSDesire, castSSLocation = ConsiderStaticStorm();
	
	--not sure how this will work with illusions
	tableNearbyEnemyHeros = npcBot:GetNearbyHeroes(abilityG:GetCastRange(), true, BOT_MODE_NONE);
	curTime = -(startT + -DotaTime());
	curTime = math.floor(curTime+0.5);
	local p1S = false;
	local p2S = false;
	local p3S = false;
	local p4S = false;
	local p5S = false;
	if(curTime > prevTime)--so only do our loop every second
		then 
			local enemy1H = false;
			local enemy2H = false;
			local enemy3H = false;
			local enemy4H = false;
			local enemy5H = false;
			prevTime = curTime;
			for _,Enemynpc in pairs(tableNearbyEnemyHeros)
				do
					if(enemy1ID == Enemynpc:GetPlayerID( ))	
						then
							enemy1H = true;
							LocationXP1 = PushBack4f(LocationXP1, Enemynpc:GetLocation().x);
							LocationZP1 = PushBack4f(LocationZP1, Enemynpc:GetLocation().z);
							
					elseif(enemy2ID == Enemynpc:GetPlayerID( ))	
						then
							enemy2H = true;
							LocationXP2 = PushBack4f(LocationXP2, Enemynpc:GetLocation().x);
							LocationZP2 = PushBack4f(LocationZP2, Enemynpc:GetLocation().z);
					elseif(enemy3ID == Enemynpc:GetPlayerID( ))	
						then
							enemy3H	= true;
							LocationXP3 = PushBack4f(LocationXP3, Enemynpc:GetLocation().x);
							LocationZP3 = PushBack4f(LocationZP3, Enemynpc:GetLocation().z);
					elseif(enemy4ID == Enemynpc:GetPlayerID( ))
						then
							enemy4H	= true;
							LocationXP4 = PushBack4f(LocationXP4, Enemynpc:GetLocation().x);
							LocationZP4 = PushBack4f(LocationZP4, Enemynpc:GetLocation().z);
					elseif(enemy5ID == Enemynpc:GetPlayerID( ))
						then
							enemy5H	= true;
							LocationXP5 = PushBack4f(LocationXP5, Enemynpc:GetLocation().x);
							LocationZP5 = PushBack4f(LocationZP5, Enemynpc:GetLocation().z);
					else--if we are here then we havent registered this enemy npc and need to do so
						--we register enemy npcs in order of when we first see them
						if(enemy1ID == -1)
							then
							enemy1ID = Enemynpc:GetPlayerID( );
						elseif(enemy2ID == -1)
							then
							enemy2ID = Enemynpc:GetPlayerID( );
						elseif(enemy3ID == -1)
							then
							enemy3ID = Enemynpc:GetPlayerID( );
						elseif(enemy4ID == -1)
							then
							enemy4ID = Enemynpc:GetPlayerID( );
						elseif(enemy5ID == -1)
							then
							enemy5ID = Enemynpc:GetPlayerID( );
						else
							print("UNIDENTIFIED ENEMY");
						end
					end
					-- now we want to set the location of enemies we cant see in this second to be -1,-1
					--this will indicate that we are unsure about the enemies location at this point and we
					--shouldnt use it as a glimpse point
			end
					if(enemy1H == false)
						then
							LocationXP1 = PushBack4f(LocationXP1, 0.0);
							LocationZP1 = PushBack4f(LocationZP1, 0.0);
					end
					if(enemy2H == false)
						then
							LocationXP2 = PushBack4f(LocationXP2, 0.0);
							LocationZP2 = PushBack4f(LocationZP2, 0.0);
					end
					if(enemy3H == false)
						then
							LocationXP3 = PushBack4f(LocationXP3, 0.0);
							LocationZP3 = PushBack4f(LocationZP3, 0.0);
					end
					if(enemy4H == false)
						then
							LocationXP4 = PushBack4f(LocationXP4, 0.0);
							LocationZP4 = PushBack4f(LocationZP4, 0.0);
					end
					if(enemy5H == false)
						then
							LocationXP5 = PushBack4f(LocationXP5, 0.0);
							LocationZP5 = PushBack4f(LocationZP5, 0.0);
					end
		castGDesire, castGTarget = ConsiderGlimpse();
	end
	--thunderstrike has highest priority
	if ( castTsDesire > 0) 
	then
		npcBot:Action_UseAbilityOnEntity(abilityTs, castTsTarget);
		return;
	end
	if(castGDesire > 0)
		then
			npcBot:Action_UseAbilityOnEntity(abilityG, castGTarget);
			npcBot:Action_UseAbilityOnLocation(abilityKf, npcBot:GetLocation());
			local GPosition;
			if(castGTarget:GetPlayerID() == enemy1ID)
				then
					GPosition = {LocationXP1[0], LocationZP1[0]};
			elseif(castGTarget:GetPlayerID() == enemy2ID)
				then
					GPosition = {LocationXP2[0], LocationZP2[0]};
			elseif(castGTarget:GetPlayerID() == enemy3ID)
				then
					GPosition = {LocationXP3[0], LocationZP3[0]};
			elseif(castGTarget:GetPlayerID() == enemy4ID)
				then
					GPosition = {LocationXP4[0], LocationZP4[0]};
			elseif(castGTarget:GetPlayerID() == enemy5ID)
				then
					GPosition = {LocationXP5[0], LocationZP5[0]};
			else
				print("unidentified enemy");
			end
			if(abilityKf:IsCooldownReady())
				then
					npcBot:Action_UseAbilityOnLocation(abilityKf, GPosition);
				end
	end
	if ( castKfDesire > 0 and not abilityG:IsCooldownReady( )) -- we dont use kinetic field unless we have glimpse, this is just for testing for now
	then 													-- it is going to be difficult so say where we decide to glimpse or kinetic field
		--npcBot:Action_UseAbilityOnLocation(abilityKf, castKfLocation);
		return;
	end
end

	
----------------------------------------------------------------------------------------------------

function PushBack4f(array, target)--pushes target to the start of array and pushes remaining elements along, removing the last element
	local hold = array[0];
	array[0] = target;
							
	local hold3 = array[1];
	array[1] = hold;
							
	hold = array[2];
	array[2] = hold3;
	array[3] = hold;
	return array;
end
----------------------------------------------------------------------------------------------------


function CanCastThunderStrikeOnTarget( npcTarget )
	return npcTarget:CanBeSeen() and not npcTarget:IsMagicImmune() and not npcTarget:IsInvulnerable();
end


function canCastGlimpseOnTarget( npcTarget )
	return npcTarget:CanBeSeen() and not npcTarget:IsMagicImmune();
end


function canCastKineticFieldOnTarget( npcTarget )
	return npcTarget:CanBeSeen() and not npcTarget:IsMagicImmune();
end

----------------------------------------------------------------------------------------------------

function ConsiderStaticStorm()
	return BOT_ACTION_DESIRE_NONE,0;
end


function CalculateKineticFieldPosition(npcEnemy, delay)
	local velocity = npcEnemy:GetVelocity();
	local position = npcEnemy:GetLocation();
	local nPos = position + velocity*delay;
	return nPos;
end

function magnitude(vec)
	return vec;
end
	

function ConsiderKineticField()
	local npcBot = GetBot();
	local nCastRange = abilityKf:GetCastRange();
	local gCastRange = abilityG:GetCastRange();
	local radius = abilityKf:GetAOERadius();
	local duration = abilityKf:GetSpecialValueFloat("duration");
	local delay = 1.2;
	--i want to see if ui can calculate a position to place this such that the field will be active by the time the enemy npc get to the edge
	--first need to get activation time
	--local nDamage = abilityTs:GetSpecialValueFloat( "duration" );
	local eDamageType = DAMAGE_TYPE_MAGICAL;
	
	-- if we cant cast then we dont wanna cast it
	if ( not abilityKf:IsFullyCastable() ) then
		return BOT_ACTION_DESIRE_NONE, 0;
	end
	--defensive casting -we want to cast kinetic field on a target if they are 
	--1) chasing disrupter
	--2) chasing a team mate
	tableNearbyEnemyHeros = npcBot:GetNearbyHeroes(abilityG:GetCastRange(), true, BOT_MODE_NONE);
	local tableNearbyEnemyHerossmall = npcBot:GetNearbyHeroes(nCastRange, true, BOT_MODE_NONE );
	local tableNearbyFriendlyHeros = npcBot:GetNearbyHeroes(nCastRange, false, BOT_MODE_NONE );
	--count the number of allies nearby
	local numAllies = #tableNearbyFriendlyHeros;
	local numEnemies = #tableNearbyEnemyHeros;
	local numEnemiesSmall = #tableNearbyEnemyHerossmall;
	
	if (numEnemies > 0 and (npcBot:GetActiveMode( ) == BOT_MODE_DEFEND_ALLY or npcBot:GetActiveMode( ) == BOT_MODE_RETREAT or npcBot:GetActiveMode( ) == BOT_MODE_EVASIVE_MANEUVERS))
		then
			local lowhp = 100000;
			local lowNpc = npcBot;
			for _,npcAlly in pairs( tableNearbyFriendlyHeros )--cast kinetic field around the ally with lowest health
				do
					if(npcAlly:GetHealth() < lowhp)
						then
							lowhp = npcAlly:GetHealth();
							lowNpc = npcAlly
					end
			end
					return BOT_ACTION_DESIRE_HIGH,lowNpc:GetLocation();
		
	end
			local lowhp = 100000;
			local lowNpc = npcBot;
			for _,npcEnemy in pairs( tableNearbyEnemyHerossmall )
				do
				if(lowhp > npcEnemy:GetHealth())
					then
					lowhp = npcEnemy:GetHealth();
					lowNpc = npcEnemy
				end
			end
		if(lowNpc ~= npcBot)
			then
				return BOT_ACTION_DESIRE_HIGH,lowNpc:GetLocation();-- CalculateKineticFieldPosition(lowNpc, delay);
		end
	return BOT_ACTION_DESIRE_NONE, 0;

end

----------------------------------------------------------------------------------------------------

function ConsiderGlimpse()
	local npcBot = GetBot();
	local castRangeKF = abilityKf:GetCastRange();
	local castRangeG = abilityG:GetCastRange();
	local tableNearbyAllys = npcBot:GetNearbyHeroes(1500, false, BOT_MODE_NONE );
	tableNearbyEnemyHeros = npcBot:GetNearbyHeroes(abilityG:GetCastRange(), true, BOT_MODE_NONE);
	--firstly we dont want to use glimpse unless we are attacking
	--also dont want to use it unless we can back it  up with our team
	if(npcBot:GetActiveMode() ~= BOT_MODE_ATTACK or #tableNearbyAllys < #tableNearbyEnemyHeros)
		then
			return BOT_ACTION_DESIRE_NONE;
	end
	--now we need to go through each position vector for each enemy bot
	--if we have data for the position of an enemy (ie they have been in our vision for the past 4 seconds) then we want to go through their position vector
	--if the fourth position (where the npc was four seconds ago) is within the cast range of our abilities, or within the range of an ally, we want to glimpse them
	print(#tableNearbyEnemyHeros);
	for _,Enemy in pairs(tableNearbyEnemyHeros)
		do
			if(Enemy:GetPlayerID() == enemy1ID)
				then
					--distance between distupter and enemy position 4 seconds ago
					local dist1 = LocationXP1[3] - npcBot:GetLocation().x;
					local dist2 = LocationZP1[3] - npcBot:GetLocation().z;
					local mag = (dist1^2 + dist2^2)^0.5;
					--we also need to consider how far away they are from the glimpse location
					--theres no need to glimpse someone back to where they already are
					local dist3 = LocationXP1[3] - Enemy:GetLocation().x;
					local dist4 = LocationZP1[3] - Enemy:GetLocation().z;
					local mag2 = (dist3^2 + dist4^2)^0.5;
					--distance between disruptor and the enemy
					local dist = npcBot:GetLocation() - Enemy:GetLocation();
					local mag3 = (dist.x^2 + dist.z^2)^0.5;
					if(mag3 <= castRangeG and mag <= castRangeKF + 100 and mag2 >= glimpseMin and canCastGlimpseOnTarget(Enemy))
						then
							return BOT_ACTION_DESIRE_HIGH, Enemy;-- the enemy we target at this point is fairly arbitrary, just whoever we can get pretty much
					end
			elseif(Enemy:GetPlayerID() == enemy2ID)
				then
				--distance between distupter and enemy position 4 seconds ago
					local dist1 = LocationXP2[3] - npcBot:GetLocation().x;
					local dist2 = LocationZP2[3] - npcBot:GetLocation().z;
					local mag = (dist1^2 + dist2^2)^0.5;
					--we also need to consider how far away they are from the glimpse location
					--theres no need to glimpse someone back to where they already are
					local dist3 = LocationXP2[3] - Enemy:GetLocation().x;
					local dist4 = LocationZP2[3] - Enemy:GetLocation().z;
					local mag2 = (dist3^2 + dist4^2)^0.5;
					--distance between disruptor and the enemy
					local dist = npcBot:GetLocation() - Enemy:GetLocation();
					local mag3 = (dist.x^2 + dist.z^2)^0.5;
					if(mag3 <= castRangeG and mag <= castRangeKF + 100 and mag2 >= glimpseMin and canCastGlimpseOnTarget(Enemy))
						then
							return BOT_ACTION_DESIRE_HIGH, Enemy;-- the enemy we target at this point is fairly arbitrary, just whoever we can get pretty much
						end
			elseif(Enemy:GetPlayerID() == enemy3ID)
				then
				--distance between distupter and enemy position 4 seconds ago
					local dist1 = LocationXP3[3] - npcBot:GetLocation().x;
					local dist2 = LocationZP3[3] - npcBot:GetLocation().z;
					local mag = (dist1^2 + dist2^2)^0.5;
					--we also need to consider how far away they are from the glimpse location
					--theres no need to glimpse someone back to where they already are
					local dist3 = LocationXP3[3] - Enemy:GetLocation().x;
					local dist4 = LocationZP3[3] - Enemy:GetLocation().z;
					local mag2 = (dist3^2 + dist4^2)^0.5;
					--distance between disruptor and the enemy
					local dist = npcBot:GetLocation() - Enemy:GetLocation();
					local mag3 = (dist.x^2 + dist.z^2)^0.5;
					if(mag3 <= castRangeG and mag <= castRangeKF + 100 and mag2 >= glimpseMin and canCastGlimpseOnTarget(Enemy))
						then
							return BOT_ACTION_DESIRE_HIGH, Enemy;-- the enemy we target at this point is fairly arbitrary, just whoever we can get pretty much
						end
			elseif(Enemy:GetPlayerID() == enemy4ID)
				then
				--distance between distupter and enemy position 4 seconds ago
					local dist1 = LocationXP4[3] - npcBot:GetLocation().x;
					local dist2 = LocationZP4[3] - npcBot:GetLocation().z;
					local mag = (dist1^2 + dist2^2)^0.5;
					--we also need to consider how far away they are from the glimpse location
					--theres no need to glimpse someone back to where they already are
					local dist3 = LocationXP4[3] - Enemy:GetLocation().x;
					local dist4 = LocationZP4[3] - Enemy:GetLocation().z;
					local mag2 = (dist3^2 + dist4^2)^0.5;
					--distance between disruptor and the enemy
					local dist = npcBot:GetLocation() - Enemy:GetLocation();
					local mag3 = (dist.x^2 + dist.z^2)^0.5;
					if(mag3 <= castRangeG and mag <= castRangeKF + 100 and mag2 >= glimpseMin and canCastGlimpseOnTarget(Enemy))
						then
							return BOT_ACTION_DESIRE_HIGH, Enemy;-- the enemy we target at this point is fairly arbitrary, just whoever we can get pretty much
						end
			elseif(Enemy:GetPlayerID() == enemy5ID)
				then
				--distance between distupter and enemy position 4 seconds ago
					local dist1 = LocationXP5[3] - npcBot:GetLocation().x;
					local dist2 = LocationZP5[3] - npcBot:GetLocation().z;
					local mag = (dist1^2 + dist2^2)^0.5;
					--we also need to consider how far away they are from the glimpse location
					--theres no need to glimpse someone back to where they already are
					local dist3 = LocationXP5[3] - Enemy:GetLocation().x;
					local dist4 = LocationZP5[3] - Enemy:GetLocation().z;
					local mag2 = (dist3^2 + dist4^2)^0.5;
					--distance between disruptor and the enemy
					local dist = npcBot:GetLocation() - Enemy:GetLocation();
					local mag3 = (dist.x^2 + dist.z^2)^0.5;
					if(mag3 <= castRangeG and mag <= castRangeKF + 100 and mag2 >= glimpseMin and canCastGlimpseOnTarget(Enemy))
						then
							return BOT_ACTION_DESIRE_HIGH, Enemy;-- the enemy we target at this point is fairly arbitrary, just whoever we can get pretty much
						end
			else
				print("unidentified enemy 03");
			end
			

	end
	return BOT_ACTION_DESIRE_NONE, 0;
end


----------------------------------------------------------------------------------------------------

function ConsiderThunderStrike()
	local npcBot = GetBot();
	local nCastRange = abilityTs:GetCastRange();
	local nDamage = abilityTs:GetSpecialValueInt( "damage" );
	local eDamageType = DAMAGE_TYPE_MAGICAL;
	--print(nCastRange);
	local tableNearbyEnemies = npcBot:GetNearbyHeroes(nCastRange, true, BOT_MODE_NONE );
	--print(#tableNearbyEnemies);
	-- if we cant cast then we dont wanna cast it
	if ( not abilityTs:IsFullyCastable() ) then
		return BOT_ACTION_DESIRE_NONE, 0;
	end
	npcLow = npcBot;
	npcHp = 100000;
	if(npcBot:GetActiveMode( ) == BOT_MODE_ATTACK  or npcBot:GetActiveMode( ) ==  BOT_MODE_LANING)
		then
		for _,npcEnemy in pairs (tableNearbyEnemies)
			do
				if(npcEnemy:GetHealth() < npcHp)
					then
						npcHp = npcEnemy:GetHealth();
						npcLow = npcEnemy;
				end
		end
		if(npcLow ~= npcBot)
			then
				return BOT_ACTION_DESIRE_HIGH, npcLow;
		end
	end
	return BOT_ACTION_DESIRE_NONE;
end

