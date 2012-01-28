-- $Id: unit_explosion_spawner.lua 3171 2008-11-06 09:06:29Z det $
function gadget:GetInfo()
	return {
		name = "Unit Explosion Spawner",
		desc = "Spawns units using an explosion as a trigger.",
		author = "KDR_11k (David Becker), lurker",
		date = "2007-11-18",
		license = "None",
		layer = 50,
		enabled = true
	}
end

if (gadgetHandler:IsSyncedCode()) then

--SYNCED

local spawn_defs_id = {}
local shieldCollide_id = {}
local createList = {}
local expireList = {}
local noCreate = {}
local UseUnitResource = Spring.UseUnitResource

function gadget:Initialize()
	local modOptions = Spring.GetModOptions()
	local spawn_defs_name, shieldCollide_names = VFS.Include("LuaRules/Configs/explosion_spawn_defs.lua")
	for weapon,spawn_def in pairs(spawn_defs_name) do
		if WeaponDefNames[weapon] then
			local weaponID = WeaponDefNames[weapon].id
			if (UnitDefNames[spawn_def.name] and not spawn_def.feature) or (FeatureDefNames[spawn_def.name] and spawn_def.feature) then
				spawn_defs_id[weaponID] = spawn_def
				Script.SetWatchWeapon(weaponID, true)
			end
		end
	end
	for name, v in pairs(shieldCollide_names) do
		if UnitDefNames[name] then
			local id = UnitDefNames[name].id
			shieldCollide_id[id] = v
		end
	end
end

function gadget:Explosion(w, x, y, z, owner)
	if spawn_defs_id[w] and owner then
		if not noCreate[owner] then
			--if not Spring.GetGroundBlocked(x,z) then
			if UseUnitResource(owner, "m", spawn_defs_id[w].cost) then
				table.insert(createList, 
                    {name = spawn_defs_id[w].name, owner = owner, x=x,y=y,z=z, expire=spawn_defs_id[w].expire, feature = spawn_defs_id[w].feature})
				return true
			end
		else
			noCreate[owner] = nil
			return true
		end
	end
	return false
end

-- in event of shield impact, gets data about both units and passes it to UnitPreDamaged
function gadget:ShieldPreDamaged(proID, proOwnerID, shieldEmitterWeaponNum, shieldCarrierUnitID, bounceProjectile)
	
	--[[
	-- Code that causes projectile bounce
	if Spring.ValidUnitID(shieldCarrierUnitID) then
	
		local px, py, pz = Spring.GetProjectilePosition(proID)
		local vx, vy, vz = Spring.GetProjectileVelocity(proID)
		local sx, sy, sz = Spring.GetUnitPosition(shieldCarrierUnitID)
		
		local rx, ry, rz = px-sx, py-sy, pz-sz
		
		local f = 2 * (rx*vx + ry*vy + rz*vz) / (rx^2 + ry^2 + rz^2)
		
		local nx, ny, nz = vx - f*rx, vy - f*ry, vz - f*rz
		Spring.SetProjectileVelocity(proID, nx, ny, nz)
	
		return true
	end
	
	return false
	--]]
	
	if proOwnerID and shieldCarrierUnitID and Spring.ValidUnitID(proOwnerID) 
			and Spring.ValidUnitID(shieldCarrierUnitID) then
		local udid = Spring.GetUnitDefID(proOwnerID)
		if udid and shieldCollide_id[udid] then
			local shieldOn,shieldCharge = Spring.GetUnitShieldState(shieldCarrierUnitID)
			local damage = shieldCollide_id[udid].damage
			if shieldCharge < damage then
				return true
			end
			--Spring.SetUnitShieldState(shieldCarrierUnitID, -1, shieldCharge - shieldCollide_id[udid].gadgetDamage)
			noCreate[proOwnerID] = true
		end
	end
	return false
	
end

function gadget:GameFrame(f)
	for i,c in pairs(createList) do
		if c.feature then
            Spring.CreateFeature(c.name , c.x, c.y, c.z, 0, Spring.GetUnitTeam(c.owner))
        else
            local unitID = Spring.CreateUnit(c.name , c.x, c.y, c.z, 0, Spring.GetUnitTeam(c.owner))
            if (c.expire > 0) then 
                expireList[unitID] = f + c.expire * 32
            end
        end
		createList[i]=nil
	end
  if ((f+6)%64<0.1) then 
    for i, e in pairs(expireList) do
      if (f > e) then
        Spring.DestroyUnit(i, true)
        expireList[i] = nil
      end
    end
  end
end

end
