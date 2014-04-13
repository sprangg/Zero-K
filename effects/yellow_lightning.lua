-- yellow_lightning_bomb
-- yellow_lightning_bluebolts
-- yellow_lightning_groundflash
-- yellow_lightning_bomb_yellowbolts
-- yellow_lightning_muzzle
-- yellow_lightning_yellowbolts
-- yellow_lightning_bomb_bluebolts
-- yellow_lightningplosion
-- yellow_lightning_stormbolt

return {
  ["white_lightning_bomb"] = {
    whitebolts = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        delay              = 3,
        explosiongenerator = [[custom:WHITE_LIGHTNING_BOMB_BOLTS]],
        pos                = [[0, 0, 0]],
      },
    },
    groundflash = {
      circlealpha        = 1,
      circlegrowth       = 0,
      flashalpha         = 0.3,
      flashsize          = 32,
      ttl                = 12,
      color = {
        [1]  = 1,
        [2]  = 1,
        [3]  = 1,
      },
    },
    pikes = {
      air                = true,
      class              = [[explspike]],
      count              = 2,
      ground             = true,
      water              = true,
      properties = {
        alpha              = 0.8,
        alphadecay         = 0.1,
        color              = [[1,1,1]],
        dir                = [[-15 r30,-15 r30,-15 r30]],
        length             = 16,
        width              = 2,
      },
    },
  },

  ["white_lightning_bomb_bolts"] = {
    bluebolts = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.95,
        colormap           = [[1 1 1 0.01  1 1 1 0.01 0.5 0.5 0.5 0.01  1 1 1 0.01   0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 180,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 5,
        particlelife       = 2,
        particlelifespread = 5,
        particlesize       = 40,
        particlesizespread = 0,
        particlespeed      = 2,
        particlespeedspread = 0,
        pos                = [[0, 1.0, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[whitelightb]],
      },
    },
  },
  
  ["yellow_lightning_stormbolt"] = {
    groundflash = {
      circlealpha        = 1,
      circlegrowth       = 0,
      flashalpha         = 0.3,
      flashsize          = 32,
      ttl                = 3,
      color = {
        [1]  = 1,
        [2]  = 1,
        [3]  = 1,
      },
    },
    lightningballs = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 1,
        colormap           = [[0 0 0 0.01 1 1 1 0.01 0 0 0 0.01]],
        directional        = true,
        emitrot            = 80,
        emitrotspread      = 0,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 3,
        particlelifespread = 0,
        particlesize       = 2,
        particlesizespread = 20,
        particlespeed      = 0.01,
        particlespeedspread = 0,
        pos                = [[-10 r20, 1.0, -10 r20]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[whitelightb]],
      },
    },
  },


  ["yellow_lightning_bomb"] = {
    bluebolts = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        delay              = 3,
        explosiongenerator = [[custom:YELLOW_LIGHTNING_BOMB_BLUEBOLTS]],
        pos                = [[0, 0, 0]],
      },
    },
    electricstorm = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        delay              = [[10 r200]],
        explosiongenerator = [[custom:YELLOW_LIGHTNING_STORMBOLT]],
        pos                = [[-100 r200, 1, -100 r200]],
      },
    },
    groundflash = {
      circlealpha        = 1,
      circlegrowth       = 0,
      flashalpha         = 0.3,
      flashsize          = 32,
      ttl                = 12,
      color = {
        [1]  = 1,
        [2]  = 1,
        [3]  = 0.25,
      },
    },
    pikes = {
      air                = true,
      class              = [[explspike]],
      count              = 2,
      ground             = true,
      water              = true,
      properties = {
        alpha              = 0.8,
        alphadecay         = 0.1,
        color              = [[1,1,0.25]],
        dir                = [[-15 r30,-15 r30,-15 r30]],
        length             = 16,
        width              = 2,
      },
    },
    yellowbolts = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        delay              = 3,
        explosiongenerator = [[custom:YELLOW_LIGHTNING_BOMB_YELLOWBOLTS]],
        pos                = [[0, 0, 0]],
      },
    },
  },

  ["yellow_lightning_bluebolts"] = {
    ["electric thingies"] = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.95,
        colormap           = [[1 1 0.25 0.01  1 1 0.25 0.01 0.5 0.5 1 0.01  1 1 0.25 0.01   0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 180,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 5,
        particlelife       = 2,
        particlelifespread = 5,
        particlesize       = 40,
        particlesizespread = 0,
        particlespeed      = 2,
        particlespeedspread = 0,
        pos                = [[0, 1.0, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[whitelightb]],
      },
    },
   sparks = {
     air                = true,
     class              = [[CSimpleParticleSystem]],
     count              = 1,
     ground             = true,
     water              = true,
     properties = {
       airdrag            = 0.97,
       colormap           = [[1 1 0.2 0.01   1 1 0.4 0.01   0.0 0.0 0 0.01]],
       directional        = true,
       emitrot            = 0,
       emitrotspread      = 60,
       emitvector         = [[0, 1, 0]],
       gravity            = [[0, 0, 0]],
       numparticles       = 40,
       particlelife       = 20,
       particlelifespread = 5,
       particlesize       = 5,
       particlesizespread = 0,
       particlespeed      = 5,
       particlespeedspread = 0,
       pos                = [[0, 0, 0]],
       sizegrowth         = 0,
       sizemod            = 1.0,
       texture            = [[spark]],
     },
   },
  },

  ["yellow_lightning_groundflash"] = {
    groundflash = {
      circlealpha        = 1,
      circlegrowth       = 0,
      flashalpha         = 0.3,
      flashsize          = 46,
      ttl                = 12,
      color = {
        [1]  = 1,
        [2]  = 1,
        [3]  = 0.25,
      },
    },
  },

  ["yellow_lightning_bomb_yellowbolts"] = {
    yellowbolts = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.1,
        colormap           = [[1 1 0.25 0.01  1 1 0.25 0.01   1 1 0.25 0.01  1 1 0.25 0.01  1 1 0.25 0.01 0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 80,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 5,
        particlelife       = 8,
        particlelifespread = 4,
        particlesize       = 15,
        particlesizespread = 15,
        particlespeed      = 20,
        particlespeedspread = 20,
        pos                = [[0, 1.0, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[whitelightb]],
      },
    },
  },

  ["yellow_lightning_muzzle"] = {
    usedefaultexplosions = false,
    lightball = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.95,
        colormap           = [[0.7 0.6 0 0.01  1 0.85 0 0.01  0 0 0 0.01]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 1,
        emitvector         = [[dir]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 20,
        particlelifespread = 0,
        particlesize       = 15,
        particlesizespread = 0,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[lightb3]],
      },
    },
    lightball2 = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.95,
        colormap           = [[0 0 0 0.01  0.3 0.25 0 0.01  0.7 0.6 0 0.01  1 0.85 0 0.01  0 0 0 0.01]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 1,
        emitvector         = [[dir]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 20,
        particlelifespread = 0,
        particlesize       = 15,
        particlesizespread = 0,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[lightb4]],
      },
    },
    lightring = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.95,
        colormap           = [[0.7 0.7 0 0.01  1 1 0 0.01  0 0 0 0.01]],
        directional        = false,
        emitrot            = 0,
        emitrotspread      = 1,
        emitvector         = [[dir]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 20,
        particlelifespread = 0,
        particlesize       = 1,
        particlesizespread = 0,
        particlespeed      = 0,
        particlespeedspread = 0,
        pos                = [[0, 0, 0]],
        sizegrowth         = 1,
        sizemod            = 1.0,
        texture            = [[lightring]],
      },
    },
  },

  ["yellow_lightning_yellowbolts"] = {
    ["electric thingies2"] = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.1,
        colormap           = [[1 1 0.25 0.01  1 1 0.25 0.01   1 1 0.25 0.01  1 1 0.25 0.01  1 1 0.25 0.01 0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 80,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 10,
        particlelife       = 8,
        particlelifespread = 4,
        particlesize       = 15,
        particlesizespread = 15,
        particlespeed      = 20,
        particlespeedspread = 20,
        pos                = [[0, 1.0, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[whitelightb]],
      },
    },
  },

  ["yellow_lightning_bomb_bluebolts"] = {
    bluebolts = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 0.95,
        colormap           = [[1 1 0.25 0.01  1 1 0.25 0.01 0.5 0.5 1 0.01  1 1 0.25 0.01   0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 180,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 5,
        particlelife       = 2,
        particlelifespread = 5,
        particlesize       = 40,
        particlesizespread = 0,
        particlespeed      = 2,
        particlespeedspread = 0,
        pos                = [[0, 1.0, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[whitelightb]],
      },
    },
  },

  ["yellow_lightningplosion"] = {
    bluebolts = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        delay              = 0,
        explosiongenerator = [[custom:YELLOW_LIGHTNING_BLUEBOLTS]],
        pos                = [[0, 0, 0]],
      },
    },
    electricstorm = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 20,
      ground             = true,
      water              = true,
      properties = {
        delay              = [[10 r200]],
        explosiongenerator = [[custom:YELLOW_LIGHTNING_STORMBOLT]],
        pos                = [[-100 r200, 1, -100 r200]],
      },
    },
    groundflash = {
      circlealpha        = 1,
      circlegrowth       = 0,
      flashalpha         = 0.3,
      flashsize          = 86,
      ttl                = 12,
      color = {
        [1]  = 1,
        [2]  = 1,
        [3]  = 0.25,
      },
    },
    pikes = {
      air                = true,
      class              = [[explspike]],
      count              = 15,
      ground             = true,
      water              = true,
      properties = {
        alpha              = 0.8,
        alphadecay         = 0.1,
        color              = [[1,1,0.25]],
        dir                = [[-15 r30,-15 r30,-15 r30]],
        length             = 30,
        width              = 5,
      },
    },
    yellowbolts = {
      air                = true,
      class              = [[CExpGenSpawner]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        delay              = 3,
        explosiongenerator = [[custom:YELLOW_LIGHTNING_YELLOWBOLTS]],
        pos                = [[0, 0, 0]],
      },
    },
  },

  ["yellow_lightning_stormbolt"] = {
    groundflash = {
      circlealpha        = 1,
      circlegrowth       = 0,
      flashalpha         = 0.3,
      flashsize          = 32,
      ttl                = 3,
      color = {
        [1]  = 1,
        [2]  = 1,
        [3]  = 0.25,
      },
    },
    lightningballs = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        airdrag            = 1,
        colormap           = [[0 0 0 0.01 1 1 0.25 0.01 0 0 0 0.01]],
        directional        = true,
        emitrot            = 80,
        emitrotspread      = 0,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 3,
        particlelifespread = 0,
        particlesize       = 2,
        particlesizespread = 20,
        particlespeed      = 0.01,
        particlespeedspread = 0,
        pos                = [[-10 r20, 1.0, -10 r20]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[whitelightb]],
      },
    },
  },

}

