local name = "commweapon_partillery_napalm"
local weaponDef = {
	name                    = [[Light Napalm Artillery]],
    accuracy                = 350,
    areaOfEffect            = 128,
    
    customParams			= {
    	muzzleEffect = [[custom:THUDMUZZLE]],
		miscEffect = [[custom:THUDDUST]],
		burnchance = [[1]],
    },
    
    craterBoost             = 0,
    craterMult              = 0,

    damage                  = {
		default = 225,
		planes  = 225,
		subs    = 11.25,
    },

    edgeEffectiveness       = 0.5,
    explosionGenerator      = [[custom:NAPALM_Expl]],
    impulseBoost            = 0,
    impulseFactor           = 0.4,
    interceptedByShieldType = 1,
    minbarrelangle          = [[-35]],
    myGravity               = 0.1,
    noSelfDamage            = true,
    range                   = 750,
    reloadtime              = 4,
    size					= 4,
    soundHit                = [[weapon/burn_mixed]],
    soundStart              = [[weapon/cannon/cannon_fire1]],
    startsmoke              = [[1]],
    targetMoveError         = 0.3,
    turret                  = true,
    weaponType              = [[Cannon]],
    weaponVelocity          = 300,
}

return name, weaponDef
