local mod = RegisterMod("TsukinoMito", 1) -- Change the part in quotes to match your mod name



mod.SFX = SFXManager()
mod.RNG = RNG()
mod.reloaded = reloaded


local Mito = { -- Change Mito everywhere to match your character. No spaces!
	DAMAGE = 3,	-- These are all relative to Isaac's base stats.
	SPEED = 0.3,
	SHOTSPEED = 0.5,
	TEARHEIGHT = 2,
	TEARFALLINGSPEED = 0,
	LUCK = -1,
	FLYING = false,									
	TEARFLAG = 2, -- 0 is default
	TEARCOLOR = Color(0.6, 1.0, 0.0, 1.0, 0, 0, 0) 	-- Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0) is default
}

-- local IinchoDiary = {}
-- IinchoDiary.id = Isaac.GetItemIdByName("Iincho Diary")
-- IinchoDiary.costume = Isaac.GetCostumeIdByPath("gfx/characters/IinchoDiary.anm2")
-- IinchoDiary.giantbookSprite = Sprite()
-- IinchoDiary.giantbookSprite:Load("gfx/ui/giantbook/giantbook_IinchoDiary.anm2", true)


local IinchoGiantBookSprite = Sprite()


local giantbookState = -9
local Diary = CollectibleType.COLLECTIBLE_IINCHO_DIARY 
-- local Diary = CollectibleType.COLLECTIBLE_IINCHO_DIARY = IinchoDiary.id
local usedIincho = {}



local MitoCostume = Isaac.GetCostumeIdByPath("gfx/characters/Mitoprprblackhair.anm2")
local MitoPlayerType = Isaac.GetPlayerTypeByName("Mito")

local characterIndex = 0

function Mito:onCache(player, cacheFlag) -- I do mean everywhere!
	if player:GetName() == "Mito" then -- Especially here!
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + Mito.DAMAGE
		end
		if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed + Mito.SHOTSPEED
		end
		if cacheFlag == CacheFlag.CACHE_RANGE then
			player.TearHeight = player.TearHeight - Mito.TEARHEIGHT
			player.TearFallingSpeed = player.TearFallingSpeed + Mito.TEARFALLINGSPEED
		end
		if cacheFlag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + Mito.SPEED
		end
		if cacheFlag == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + Mito.LUCK
		end
		if cacheFlag == CacheFlag.CACHE_FLYING and Mito.FLYING then
			player.CanFly = true
		end
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | Mito.TEARFLAG
		end
		if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
			player.TearColor = Mito.TEARCOLOR
		end
	end
end




local function GetAllPlayers()

	local players = {}
	for i = 0, Game():GetNumPlayers() - 1 do
		
		players[i] = Game():GetPlayer(i)
	end

	return players
end

local function IsPlayerMito(player)

	if (player) then

		local playerType = player:GetPlayerType()
		if (playerType == MitoPlayerType) then
			return true
		end
	end

	return false
end


function mod:PostPlayerInit(player