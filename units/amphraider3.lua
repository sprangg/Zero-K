unitDef = {
  unitname               = [[amphraider3]],
  name                   = [[Duck]],
  description            = [[Amphibious Raider Bot (Sea)]],
  acceleration           = 0.18,
  activateWhenBuilt      = true,
  brakeRate              = 0.375,
  buildCostEnergy        = 150,
  buildCostMetal         = 150,
  buildPic               = [[amphraider3.png]],
  buildTime              = 150,
  canAttack              = true,
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  canstop                = [[1]],
  category               = [[LAND SINK]],
  corpse                 = [[DEAD]],

  customParams           = {
      helptext       = [[The Duck is the basic underwater raider. Armed with short ranged torpedoes, it uses its (relatively) high speed to harass sea targets that cannot shoot back, though it dies to serious opposition. On land it can launch the torpedoes a short distance as a decent short ranged anti-heavy weapon.]],
      helptext_pl    = [[Duck to lekki bot amfibijny ze specjalnymi torpedami krotkiego zasiegu, ktore moze odpalic takze na ladzie. Jest szybki, lecz delikatny.]],
      description_pl = [[Lekki bot amfibijny]],
  },

  explodeAs              = [[BIG_UNITEX]],
  footprintX             = 2,
  footprintZ             = 2,
  iconType               = [[amphtorpraider]],
  idleAutoHeal           = 5,
  idleTime               = 1800,
  leaveTracks            = true,
  maxDamage              = 400,
  maxSlope               = 36,
  maxVelocity            = 2.7,
  maxWaterDepth          = 5000,
  minCloakDistance       = 75,
  movementClass          = [[AKBOT2]],
  noChaseCategory        = [[TERRAFORM SATELLITE FIXEDWING GUNSHIP]],
  objectName             = [[amphraider3.s3o]],
  script                 = [[amphraider3.lua]],
  seismicSignature       = 4,
  selfDestructAs         = [[BIG_UNITEX]],

  sfxtypes               = {
    explosiongenerators = {
    },
  },

  sightDistance          = 500,
  sonarDistance          = 400,
  trackOffset            = 0,
  trackStrength          = 8,
  trackStretch           = 1,
  trackType              = [[ComTrack]],
  trackWidth             = 22,
  turnRate               = 1000,
  upright                = true,

  weapons                = {
    {
      def                = [[TORPMISSILE]],
      badTargetCategory  = [[FIXEDWING GUNSHIP]],
      onlyTargetCategory = [[SWIM FIXEDWING HOVER LAND SINK TURRET FLOAT SHIP GUNSHIP]],
    },
    {
      def                = [[TORPEDO]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[SWIM FIXEDWING LAND SUB SINK TURRET FLOAT SHIP GUNSHIP]],
    },
  },

  weaponDefs             = {

    TORPMISSILE = {
      name                    = [[Torpedo]],
      areaOfEffect            = 32,
      cegTag                  = [[missiletrailyellow]],
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 200,
        subs    = 10,
      },

      explosionGenerator      = [[custom:INGEBORG]],
      flightTime              = 3.5,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      model                   = [[wep_m_ajax.s3o]],
      noSelfDamage            = true,
      projectiles	          = 2,
      range                   = 240,
      reloadtime              = 4,
      smokeTrail              = true,
      soundHit                = [[weapon/cannon/cannon_hit2]],
      soundStart              = [[weapon/missile/missile_fire9]],
      startVelocity           = 140,
      texture2                = [[lightsmoketrail]],
      tolerance               = 1000,
      tracks                  = true,
      turnRate                = 16000,
      turret                  = true,
      weaponAcceleration      = 90,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 200,
    },

    TORPEDO = {
      name                    = [[Torpedo]],
      areaOfEffect            = 32,
      --avoidFriendly           = false,
      --collideFriendly         = false,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 200,
      },

      edgeEffectiveness       = 0.99,
      explosionGenerator      = [[custom:TORPEDO_HIT]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      model                   = [[wep_m_ajax.s3o]],
      noSelfDamage            = true,
      predictBoost            = 1,
      projectiles	      	  = 2,
      range                   = 240,
      reloadtime              = 4,
      soundHit                = [[explosion/wet/ex_underwater]],
      --soundStart              = [[weapon/torpedo]],
      startVelocity           = 100,
      tolerance               = 1000,
      tracks                  = true,
      turnRate                = 8000,
      turret                  = true,
      waterWeapon             = true,
      weaponAcceleration      = 1,
      weaponType              = [[TorpedoLauncher]],
      weaponVelocity          = 140,
    },
  },

  featureDefs            = {

    DEAD      = {
      description      = [[Wreckage - Duck]],
      blocking         = true,
      damage           = 400,
      energy           = 0,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      metal            = 60,
      object           = [[amphraider3_dead.s3o]],
      reclaimable      = true,
      reclaimTime      = 60,
    },

    HEAP      = {
      description      = [[Debris - Duck]],
      blocking         = false,
      damage           = 400,
      energy           = 0,
      footprintX       = 2,
      footprintZ       = 2,
      metal            = 30,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 30,
    },

  },

}

return lowerkeys({ amphraider3 = unitDef })
