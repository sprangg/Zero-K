--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function widget:GetInfo()
  return {
	name      = "Deferred rendering",
	version   = 3,
	desc      = "Collects projectiles and renders deferred lights for them",
	author    = "beherith",
	date      = "2015 Sept.",
	license   = "GPL V2",
	layer     = -1000000000,
	enabled   = true
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local GL_MODELVIEW           = GL.MODELVIEW
local GL_NEAREST             = GL.NEAREST
local GL_ONE                 = GL.ONE
local GL_ONE_MINUS_SRC_ALPHA = GL.ONE_MINUS_SRC_ALPHA
local GL_PROJECTION          = GL.PROJECTION
local GL_QUADS               = GL.QUADS
local GL_SRC_ALPHA           = GL.SRC_ALPHA
local glBeginEnd             = gl.BeginEnd
local glBlending             = gl.Blending
local glCallList             = gl.CallList
local glColor                = gl.Color
local glColorMask            = gl.ColorMask
local glCopyToTexture        = gl.CopyToTexture
local glCreateList           = gl.CreateList
local glCreateShader         = gl.CreateShader
local glCreateTexture        = gl.CreateTexture
local glDeleteShader         = gl.DeleteShader
local glDeleteTexture        = gl.DeleteTexture
local glDepthMask            = gl.DepthMask
local glDepthTest            = gl.DepthTest
local glGetMatrixData        = gl.GetMatrixData
local glGetShaderLog         = gl.GetShaderLog
local glGetUniformLocation   = gl.GetUniformLocation
local glGetViewSizes         = gl.GetViewSizes
local glLoadIdentity         = gl.LoadIdentity
local glLoadMatrix           = gl.LoadMatrix
local glMatrixMode           = gl.MatrixMode
local glMultiTexCoord        = gl.MultiTexCoord
local glPopMatrix            = gl.PopMatrix
local glPushMatrix           = gl.PushMatrix
local glResetMatrices        = gl.ResetMatrices
local glTexCoord             = gl.TexCoord
local glTexture              = gl.Texture
local glTexRect              = gl.TexRect
local glRect                 = gl.Rect
local glUniform              = gl.Uniform
local glUniformMatrix        = gl.UniformMatrix
local glUseShader            = gl.UseShader
local glVertex               = gl.Vertex
local glTranslate            = gl.Translate
local spEcho                 = Spring.Echo
local spGetCameraPosition    = Spring.GetCameraPosition
local spGetCameraVectors     = Spring.GetCameraVectors
local spGetDrawFrame         = Spring.GetDrawFrame
local spIsSphereInView       = Spring.IsSphereInView
local spWorldToScreenCoords  = Spring.WorldToScreenCoords
local spTraceScreenRay       = Spring.TraceScreenRay
local spGetSmoothMeshHeight  = Spring.GetSmoothMeshHeight

local spGetProjectilesInRectangle = Spring.GetProjectilesInRectangle
local spGetVisibleProjectiles     = Spring.GetVisibleProjectiles
local spGetProjectilePosition     = Spring.GetProjectilePosition
local spGetProjectileType         = Spring.GetProjectileType
local spGetProjectileDefID        = Spring.GetProjectileDefID
local spGetCameraPosition         = Spring.GetCameraPosition
local spGetPieceProjectileParams  = Spring.GetPieceProjectileParams 
local spGetProjectileVelocity     = Spring.GetProjectileVelocity 
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- Config

local GLSLRenderer = true

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local vsx, vsy
local ivsx = 1.0 
local ivsy = 1.0 
local screenratio = 1.0

local depthPointShader
local depthBeamShader

local lightposlocPoint = nil
local lightcolorlocPoint = nil
local lightparamslocPoint = nil
local uniformEyePosPoint
local uniformViewPrjInvPoint

local lightposlocBeam  = nil
local lightpos2locBeam  = nil
local lightcolorlocBeam  = nil
local lightparamslocBeam  = nil
local uniformEyePosBeam 
local uniformViewPrjInvBeam 

local projectileLightTypes = {}
	--[1] red
	--[2] green
	--[3] blue
	--[4] radius
	--[5] BEAMTYPE, true if BEAM

-- parameters for each light:
-- RGBA: strength in each color channel, radius in elmos.
-- pos: xyz positions
-- params: ABC: where A is constant, B is quadratic, C is linear (only for point lights)

--------------------------------------------------------------------------------
--Light falloff functions: http://gamedev.stackexchange.com/questions/56897/glsl-light-attenuation-color-and-intensity-formula
--------------------------------------------------------------------------------

local verbose = false
local function VerboseEcho(...)
	if verbose then
		Spring.Echo(...) 
	end
end

--------------------------------------------------------------------------------

local function GetLightsFromUnitDefs()
	--The GetProjectileName function returns 'unitname_weaponnname'. EG: armcom_armcomlaser
	--This is fine with BA, because unitnames dont use '_' characters
	--Spring.Echo('GetLightsFromUnitDefs init')
	local plighttable = {}
	for weaponDefID = 1, #WeaponDefs do
		--These projectiles should have lights:
			--Cannon (projectile size: tempsize = 2.0f + std::min(wd.damages[0] * 0.0025f, wd.damageAreaOfEffect * 0.1f);)
			--Dgun
			--MissileLauncher
			--StarburstLauncher
			--LightningCannon --projectile is centered on emit point
			--BeamLaser --Beamlasers shouldnt, because they are buggy (GetProjectilePosition returns center of beam, no other info avalable)
		--Shouldnt:
			--AircraftBomb
			--LaserCannon --only sniper uses it, no need to make shot more visible
			--Melee
			--Shield
			--TorpedoLauncher
			--EmgCannon (only gorg uses it, and lights dont look so good too close to ground)
			--Flame --a bit iffy cause of long projectile life... too bad though because it looks great.
		
		local weaponDef = WeaponDefs[weaponDefID]
		
		if (weaponDef.type == 'Cannon') then
			VerboseEcho('Cannon', weaponDef.name, 'size', weaponDef.size)
			size = weaponDef.size
			plighttable[weaponDefID] = {r = 0.5, g = 0.5, b = 0.25, radius = 100 * size, beam = false}
		elseif (weaponDef.type == 'DGun') then
			VerboseEcho('DGun', weaponDef.name, 'size', weaponDef.size)
			--size = weaponDef.size
			plighttable[weaponDefID] = {r = 2, g = 2, b = 1, radius = 300, beam = false}
		elseif (weaponDef.type == 'MissileLauncher') then
			VerboseEcho('MissileLauncher', weaponDef.name, 'size', weaponDef.size)
			size = weaponDef.size
			plighttable[weaponDefID] = {r = 0.5, g = 0.5, b = 0.6, radius = 100 * size, beam = false}
		elseif (weaponDef.type == 'StarburstLauncher') then
			VerboseEcho('StarburstLauncher', weaponDef.name, 'size', weaponDef.size)
			--size = weaponDef.size
			plighttable[weaponDefID] = {r = 0.5, g = 0.5, b = 0.4, radius = 200, beam = false}
		elseif (weaponDef.type == 'LightningCannon') then
			VerboseEcho('LightningCannon', weaponDef.name, 'size', weaponDef.size)
			--size = weaponDef.size
			plighttable[weaponDefID] = {r = 0.3, g = 0.3, b = 1.5, radius = 100, beam = true}
		elseif (weaponDef.type == 'BeamLaser') then
			VerboseEcho('BeamLaser', weaponDef.name, 'rgbcolor', weaponDef.visuals.colorR)
			--size = weaponDef.size
			local r = weaponDef.visuals.colorR
			local g = weaponDef.visuals.colorG
			local b = weaponDef.visuals.colorB
			plighttable[weaponDefID] = {r = r, g = g, b = b, radius = math.min(weaponDef.range, 250), beam = true}
		end
	end
	return plighttable
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:ViewResize()
	vsx, vsy = gl.GetViewSizes()
	ivsx = 1.0 / vsx --we can do /n here!
	ivsy = 1.0 / vsy
	if (Spring.GetMiniMapDualScreen() == 'left') then
		vsx = vsx / 2
	end
	if (Spring.GetMiniMapDualScreen() == 'right') then
		vsx = vsx / 2
	end
	screenratio = vsy / vsx --so we dont overdraw and only always draw a square
end

widget:ViewResize()

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local vertSrc = [[
  void main(void)
  {
	gl_TexCoord[0] = gl_MultiTexCoord0;
	gl_Position    = gl_Vertex;
  }
]]
local fragSrc

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:Initialize()
	if (Spring.GetConfigString("AllowDeferredMapRendering") == '0' or Spring.GetConfigString("AllowDeferredModelRendering") == '0') then
		Spring.Echo('Deferred Rendering (gfx_deferred_rendering.lua) requires  AllowDeferredMapRendering and AllowDeferredModelRendering to be enabled in springsettings.cfg!') 
		widgetHandler:RemoveWidget()
		return
	end
	if ((not forceNonGLSL) and Spring.GetMiniMapDualScreen() ~= 'left') then --FIXME dualscreen
		if (not glCreateShader) then
			spEcho("gfx_deferred_rendering.lua: Shaders not found, removing self.")
			GLSLRenderer = false
			widgetHandler:RemoveWidget()
		else
			fragSrc = VFS.LoadFile("shaders\\deferred_lighting.glsl", VFS.ZIP)
			--Spring.Echo('gfx_deferred_rendering.lua: Shader code:', fragSrc)
			depthPointShader = glCreateShader({
				vertex = vertSrc,
				fragment = fragSrc,
				uniformInt = {
					modelnormals = 0,
					modeldepths = 1,
					mapnormals = 2,
					mapdepths = 3,
					modelExtra = 4,
				},
			})

			if (not depthPointShader) then
				spEcho(glGetShaderLog())
				spEcho("gfx_deferred_rendering.lua: Bad depth point shader, removing self.")
				GLSLRenderer = false
				widgetHandler:RemoveWidget()
			else
				lightposlocPoint = glGetUniformLocation(depthPointShader, "lightpos")
				lightcolorlocPoint = glGetUniformLocation(depthPointShader, "lightcolor")
				uniformEyePosPoint       = glGetUniformLocation(depthPointShader, 'eyePos')
				uniformViewPrjInvPoint   = glGetUniformLocation(depthPointShader, 'viewProjectionInv')
			end
			fragSrc = "#define BEAM_LIGHT \n" .. fragSrc
			depthBeamShader = glCreateShader({
				vertex = vertSrc,
				fragment = fragSrc,
				uniformInt = {
					modelnormals = 0,
					modeldepths = 1,
					mapnormals = 2,
					mapdepths = 3,
					modelExtra = 4,
				},
			})

			if (not depthBeamShader) then
				spEcho(glGetShaderLog())
				spEcho("gfx_deferred_rendering.lua: Bad depth beam shader, removing self.")
				GLSLRenderer = false
				widgetHandler:RemoveWidget()
			else
				lightposlocBeam       = glGetUniformLocation(depthBeamShader, 'lightpos')
				lightpos2locBeam      = glGetUniformLocation(depthBeamShader, 'lightpos2')
				lightcolorlocBeam     = glGetUniformLocation(depthBeamShader, 'lightcolor')
				uniformEyePosBeam     = glGetUniformLocation(depthBeamShader, 'eyePos')
				uniformViewPrjInvBeam = glGetUniformLocation(depthBeamShader, 'viewProjectionInv')
			end
		end
		projectileLightTypes = GetLightsFromUnitDefs()
		screenratio = vsy / vsx --so we dont overdraw and only always draw a square
	else
		GLSLRenderer = false
	end
end

function widget:Shutdown()
	if (GLSLRenderer) then
		if (glDeleteShader) then
			glDeleteShader(depthPointShader)
			glDeleteShader(depthBeamShader)
		end
	end
end

local function TableConcat(t1, t2)
	tnew = {}
	for k, v in pairs(t1) do
		tnew[k] = v
	end
	for k, v in pairs(t2) do
		tnew[k] = v
	end
	return tnew
end

local function DrawLightType(lights, lighttype) -- point = 0 beam = 1
	--Spring.Echo('Camera FOV = ', Spring.GetCameraFOV()) -- default TA cam fov = 45
	--set uniforms:
	local cpx, cpy, cpz = spGetCameraPosition()
	if lighttype == 0 then --point
		glUseShader(depthPointShader)
		glUniform(uniformEyePosPoint, cpx, cpy, cpz)
		glUniformMatrix(uniformViewPrjInvPoint,  "viewprojectioninverse")
	else --beam
		 glUseShader(depthBeamShader)
		glUniform(uniformEyePosBeam, cpx, cpy, cpz)
		glUniformMatrix(uniformViewPrjInvBeam,  "viewprojectioninverse")
	end

	glTexture(0, "$model_gbuffer_normtex")
	glTexture(1, "$model_gbuffer_zvaltex")
	glTexture(2, "$map_gbuffer_normtex")
	glTexture(3, "$map_gbuffer_zvaltex")
	glTexture(4, "$model_gbuffer_spectex")
			
	local cx, cy, cz = spGetCameraPosition()
	for key, light in pairs(lights) do
		VerboseEcho('gfx_deferred_rendering.lua: Light being drawn:', key, to_string(light))
		if lighttype == 0 then 
			local lightradius = light.radius
			--Spring.Echo("Drawlighttype position = ", light.px, light.py, light.pz)
			local sx, sy, sz = spWorldToScreenCoords(light.px, light.py, light.pz) -- returns x, y, z, where x and y are screen pixels, and z is z buffer depth.
			sx = sx/vsx
			sy = sy/vsy --since FOV is static in the Y direction, the Y ratio is the correct one
			local dist_sq = (light.px-cx)^2 + (light.py-cy)^2 + (light.pz-cz)^2
			local ratio = lightradius / math.sqrt(dist_sq) * 1.5
			glUniform(lightposlocPoint, light.px, light.py, light.pz, light.radius) --in world space
			glUniform(lightcolorlocPoint, light.r, light.g, light.b, 1) 
			glTexRect(
				math.max(-1 , (sx-0.5)*2-ratio*screenratio), 
				math.max(-1 , (sy-0.5)*2-ratio), 
				math.min( 1 , (sx-0.5)*2+ratio*screenratio), 
				math.min( 1 , (sy-0.5)*2+ratio), 
				math.max( 0 , sx - 0.5*ratio*screenratio), 
				math.max( 0 , sy - 0.5*ratio), 
				math.min( 1 , sx + 0.5*ratio*screenratio),
				math.min( 1 , sy + 0.5*ratio)
			) -- screen size goes from -1, -1 to 1, 1; uvs go from 0, 0 to 1, 1
		end 
		if lighttype == 1 then 
			local lightradius = 0
			local px = light.px+light.dx*0.5
			local py = light.py+light.dy*0.5
			local pz = light.pz+light.dz*0.5
			local lightradius = light.radius + math.sqrt(light.dx^2 + light.dy^2 + light.dz^2)*0.5
			--Spring.Echo("Drawlighttype position = ", light.px, light.py, light.pz)
			local sx, sy, sz = spWorldToScreenCoords(px, py, pz) -- returns x, y, z, where x and y are screen pixels, and z is z buffer depth.
			sx = sx/vsx
			sy = sy/vsy --since FOV is static in the Y direction, the Y ratio is the correct one
			local dist_sq = (px-cx)^2 + (py-cy)^2 + (pz-cz)^2
			local ratio = lightradius / math.sqrt(dist_sq)
			ratio = ratio*2

			glUniform(lightposlocBeam, light.px, light.py, light.pz, light.radius) --in world space
			glUniform(lightpos2locBeam, light.px+light.dx, light.py+light.dy+24, light.pz+light.dz, light.radius) --in world space, the magic constant of +24 in the Y pos is needed because of our beam distance calculator function in GLSL
			glUniform(lightcolorlocBeam, light.r, light.g, light.b, 1) 
			--TODO: use gl.Shape instead, to avoid overdraw
			glTexRect(
				math.max(-1 , (sx-0.5)*2-ratio*screenratio), 
				math.max(-1 , (sy-0.5)*2-ratio), 
				math.min( 1 , (sx-0.5)*2+ratio*screenratio), 
				math.min( 1 , (sy-0.5)*2+ratio), 
				math.max( 0 , sx - 0.5*ratio*screenratio), 
				math.max( 0 , sy - 0.5*ratio), 
				math.min( 1 , sx + 0.5*ratio*screenratio),
				math.min( 1 , sy + 0.5*ratio)
			) -- screen size goes from -1, -1 to 1, 1; uvs go from 0, 0 to 1, 1
		end
	end
	glUseShader(0)
end

function widget:DrawWorld()
	if (GLSLRenderer) then
		local projectiles = spGetVisibleProjectiles()
		if #projectiles == 0 then
			return
		end
		local beamlightprojectiles = {}
		local pointlightprojectiles = {}
		local no_duplicate_projectileIDs_hackyfix = {}
		for i, pID in ipairs(projectiles) do
			
			if no_duplicate_projectileIDs_hackyfix[pID] == nil then -- hacky hotfix for https://springrts.com/mantis/view.php?id=4551
				--Spring.Echo(Spring.GetDrawFrame(), i, pID)
				no_duplicate_projectileIDs_hackyfix[pID] = true
				local x, y, z = spGetProjectilePosition(pID)
				--Spring.Echo("projectilepos = ", x, y, z, 'id', pID)
				local weapon, piece = spGetProjectileType(pID)
				if piece then
					local explosionflags = spGetPieceProjectileParams(pID)
					if explosionflags and (explosionflags%32) > 15  then --only stuff with the FIRE explode tag gets a light
						--Spring.Echo('explosionflag = ', explosionflags)
						table.insert(pointlightprojectiles, {r = 0.5, g = 0.5, b = 0.25, radius = 100, constant = 1, squared = 1, linear = 0, beam = false, px = x, py = y, pz = z, dx = 0, dy = 0, dz = 0})
					end
				else
					lightparams = projectileLightTypes[spGetProjectileDefID(pID)]
					if lightparams then
						if lightparams.beam then --BEAM type
							local deltax, deltay, deltaz = spGetProjectileVelocity(pID) -- for beam types, this returns the endpoint of the beam
							table.insert(beamlightprojectiles, TableConcat(lightparams, {px = x, py = y, pz = z, dx = deltax, dy = deltay, dz = deltaz}))
						else --point type
							--TODO: clip some lights based on height
							--local smoothheight = spGetSmoothMeshHeight(x, z) -- this check is never perfect, and is not worth the additional cost.
							table.insert(pointlightprojectiles, TableConcat(lightparams, {px = x, py = y, pz = z, dx = 0, dy = 0, dz = 0}))
						end
					end
				end
			end
		end 
		
		glBlending(GL.DST_COLOR, GL.ONE) -- VERY IMPORTANT: ResultR = LightR*DestinationR+1*DestinationR
		--http://www.andersriggelsen.dk/glblendfunc.php
		--glBlending(GL.ONE, GL.ZERO) --default
		if #beamlightprojectiles > 0 then
			DrawLightType(beamlightprojectiles, 1)
		end
		if #pointlightprojectiles > 0 then
			DrawLightType(pointlightprojectiles, 0)
		end
		glBlending(false)
	else
		Spring.Echo('Removing deferred rendering widget: failed to use GLSL shader')
		widgetHandler:RemoveWidget()
	end
end

function to_string(data, indent)
	local str = ""

	if (indent == nil) then
		indent = 0
	end

	-- Check the type
	if (type(data) == "string") then
		str = str .. ("    "):rep(indent) .. data .. "\n"
	elseif (type(data) == "number") then
		str = str .. ("    "):rep(indent) .. data .. "\n"
	elseif (type(data) == "boolean") then
		if (data == true) then
			str = str .. "true"
		else
			str = str .. "false"
		end
	elseif (type(data) == "table") then
		local i, v
		for i, v in pairs(data) do
			-- Check for a table in a table
			if(type(v) == "table") then
				str = str .. ("    "):rep(indent) .. i .. ":\n"
				str = str .. to_string(v, indent + 2)
			else
				str = str .. ("    "):rep(indent) .. i .. ": " .. to_string(v, 0)
			end
		end
	elseif (data == nil) then
		str = str..'nil'
	else
		--print_debug(1, "Error: unknown data type: %s", type(data))
		str = str.. "Error: unknown data type:" .. type(data)
		Spring.Echo('X data type')
	end

	return str
end