local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()



-- Definimos el tema con todos los campos necesarios para evitar errores de Nil
WindUI:AddTheme({
    Name = "My Theme",

	    BackgroundTransparency = 1,

	    Outline = Color3.fromHex("#FFFFFF"),

    -- El Accent suele ser el color llamativo (botones, sliders, etc.)
	    Icon = Color3.fromHex("#FFFFFF"),
    Button = Color3.fromHex("#e8a20c"),

	Outline = Color3.fromHex("#FFFFFF"),
	Text = Color3.fromHex("#FFFFFF"),
    Accent = WindUI:Gradient({                                                     
        ["0"] = { Color = Color3.fromHex("#e8a20c"), Transparency = 0.5 }, -- Cambié el color para que se note el "Accent"            
        ["100"] = { Color = Color3.fromHex("#e83f0c"), Transparency = 0.5 },        
    }, {                                                                            
        Rotation = 45,                                                               
    }),


})

-- Aplicamos el tema

-- Ejemplo rápido para verificar que funciona
local Window = WindUI:CreateWindow({
    Title = "Yuxtix Shaders",
    Icon = "rbxassetid://137966710397131",
})

WindUI:SetTheme("My Theme")

Window:Tag({
    Title = "v1.0.0",
    Icon = "github",
    Color = Color3.fromHex("#e8720c"),
    Radius = 13, 
})

Window:EditOpenButton({
    Title = "Yuxtix Shaders",
    Icon = "rbxassetid://137966710397131",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

WindUI:Notify({
    Title = "Gracias por usar Yuxtix Shaders",
    Content = "Es mi priemer script publico!!",
    Duration = 10,
    Icon = "rbxassetid://137966710397131",
})
local info = Window:Tab({
    Title = "Inicio",
    Icon = "info",
    Locked = false,
})



local executor = info:Section({ 
    Title = "Executor",
    Box = true,
    TextTransparency = 0.05,
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
    Opened = true,
})

local nameexe, versionexe = identifyexecutor()



local Paragraph = executor:Paragraph({
    Title = "Estas usando ".. nameexe,
    Desc = "En la version ".. versionexe,
    Color = "Orange",
    Image = "",
    ImageSize = 30,
    Thumbnail = "",
    ThumbnailSize = 80,
    Locked = false,
})


local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")

-- Obtener tecnología de iluminación
local tech = Lighting.Technology == Enum.Technology.Future and "Future (High End)" or "Standard"

-- Formatear la descripción con datos de Shaders
local shaderDesc = string.format(
    "Juego: %s\n" ..
    "Tecnología: %s\n" ..
    "Estado: Shaders Optimizados\n" ..
    "Rendimiento: %d FPS",
    game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    tech,
    math.floor(Stats.Workspace.Heartbeat:GetValue())
)



local Paragraph = executor:Paragraph({
    Title = "Configuración de Visuales",
    Desc = shaderDesc,
    Color = "Orange",
    ImageSize = 30,
    Thumbnail = "rbxassetid://" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).IconImageAssetId,
    ThumbnailSize = 80,
    Locked = false,
})

local Lighting = game:GetService("Lighting")

local function ApplyAdvancedShaders(config)
    -- 1. Editar propiedades directas de Lighting (Brightness, ClockTime, etc.)
    if config.Lighting then
        for prop, value in pairs(config.Lighting) do
            pcall(function() Lighting[prop] = value end)
        end
    end

    -- 2. Gestionar Efectos de Post-Procesamiento
    -- El formato esperado es: {NombreEfecto = {Propiedad = Valor}}
    if config.Effects then
        for effectName, props in pairs(config.Effects) do
            -- Buscamos si ya existe el efecto en Lighting
            local effect = Lighting:FindFirstChildOfClass(effectName)
            
            -- Si el valor es "Delete", lo eliminamos y saltamos al siguiente
            if props == "Delete" then
                if effect then effect:Destroy() end
                continue
            end

            -- Si no existe, lo creamos
            if not effect then
                effect = Instance.new(effectName)
                effect.Parent = Lighting
            end

            -- Aplicamos las propiedades al efecto (Bloom, Blur, etc.)
            for p, v in pairs(props) do
                pcall(function() effect[p] = v end)
            end
        end
    end
end

local Lighting = game:GetService("Lighting")

local function SetSkybox(assetId)
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if not sky then
        sky = Instance.new("Sky")
        sky.Parent = Lighting
    end
    
    local tex = "rbxassetid://" .. assetId
    sky.SkyboxBk = tex
    sky.SkyboxDn = tex
    sky.SkyboxFt = tex
    sky.SkyboxLf = tex
    sky.SkyboxRt = tex
    sky.SkyboxUp = tex
end

local Config = Window:Tab({
    Title = "Configuracion",
    Icon = "cog",
    Locked = false,
})



local Presets = Config:Section({ 
    Title = "Presets",
    Box = true,
    TextTransparency = 0.05,
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
    Opened = true,
})

local ButtonMedioDia = Presets:Button({
    Title = "High Noon / Clear",
    Desc = "Sol en lo alto, sin niebla y colores vivos.",
    Locked = false,
    Callback = function()
        ApplyAdvancedShaders({
            Lighting = {
                ClockTime = 12,
                Brightness = 3,
                OutdoorAmbient = Color3.fromRGB(127, 127, 127),
                FogEnd = 100000, -- Sin niebla
                ExposureCompensation = 0
            },
            Effects = {
                ColorCorrectionEffect = {Saturation = 0.2, Contrast = 0.1},
                BloomEffect = {Intensity = 0.4, Size = 12, Threshold = 2},
                SunRaysEffect = {Intensity = 0.05, Spread = 0.1}
            }
        })
    end
})

local ButtonFrio = Presets:Button({
    Title = "Winter / Cold",
    Desc = "Ambiente azulado con niebla blanca y gélida.",
    Locked = false,
    Callback = function()
        ApplyAdvancedShaders({
            Lighting = {
                ClockTime = 10,
                Brightness = 1.5,
                FogColor = Color3.fromRGB(200, 220, 230),
                FogStart = 50,
                FogEnd = 500,
                OutdoorAmbient = Color3.fromRGB(100, 120, 140)
            },
            Effects = {
                ColorCorrectionEffect = {TintColor = Color3.fromRGB(210, 230, 255), Saturation = -0.1},
                BloomEffect = {Intensity = 0.2, Size = 20, Threshold = 1},
                BlurEffect = {Size = 2} -- Simula aire pesado por el frío
            }
        })
    end
})

local ButtonCalor = Presets:Button({
    Title = "Summer Heat / Desert",
    Desc = "Tono cálido, exposición alta y efecto de neblina solar.",
    Locked = false,
    Callback = function()
        ApplyAdvancedShaders({
            Lighting = {
                ClockTime = 14,
                Brightness = 4,
                FogColor = Color3.fromRGB(255, 220, 180),
                FogStart = 200,
                FogEnd = 1200,
                ExposureCompensation = 0.5
            },
            Effects = {
                ColorCorrectionEffect = {TintColor = Color3.fromRGB(255, 240, 200), Saturation = 0.3, Contrast = 0.1},
                SunRaysEffect = {Intensity = 0.25, Spread = 1},
                BloomEffect = {Intensity = 0.8, Size = 50, Threshold = 1}
            }
        })
    end
})

local ButtonNoche = Presets:Button({
    Title = "Deep Night",
    Desc = "Oscuridad total con resalte de luces (Bloom).",
    Locked = false,
    Callback = function()
        ApplyAdvancedShaders({
            Lighting = {
                ClockTime = 0,
                Brightness = 0,
                OutdoorAmbient = Color3.fromRGB(10, 10, 25),
                FogColor = Color3.fromRGB(0, 0, 0),
                FogEnd = 800,
                GlobalShadows = true
            },
            Effects = {
                ColorCorrectionEffect = {Brightness = -0.05, Contrast = 0.2, Saturation = -0.1},
                BloomEffect = {Intensity = 1.2, Size = 24, Threshold = 0.5},
                SunRaysEffect = "Delete" -- No hay sol de noche
            }
        })
    end
})

local Config2 = Window:Tab({
    Title = "Configuracion Avanzado",
    Icon = "building-2",
    Locked = false,
})

local Ilumi = Config2:Section({ 
    Title = "iluminacion basica",
    Box = true,
    TextTransparency = 0.05,
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
    Opened = true,
})

-- Control de Brillo
local BrightnessSlider = Ilumi:Slider({
    Title = "Brillo (Brightness)",
    Desc = "Ajusta la intensidad de la luz solar.",
    Step = 0.1,
    Value = {Min = 0, Max = 10, Default = Lighting.Brightness},
    Callback = function(value)
        Lighting.Brightness = value
    end
})

-- Control de Hora del Día
local ClockSlider = Ilumi:Slider({
    Title = "Hora del Día (ClockTime)",
    Desc = "Cambia el ciclo día/noche.",
    Step = 0.1,
    Value = {Min = 0, Max = 24, Default = Lighting.ClockTime},
    Callback = function(value)
        Lighting.ClockTime = value
    end
})

-- Color de la Luz Ambiental
local AmbientPicker = Ilumi:Colorpicker({
    Title = "Color Ambiental",
    Desc = "Cambia el tono de las sombras y zonas oscuras.",
    Default = Lighting.OutdoorAmbient,
    Callback = function(color) 
        Lighting.OutdoorAmbient = color
    end
})

local fogsec = Config2:Section({ 
    Title = "Niebla",
    Box = true,
    TextTransparency = 0.05,
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
    Opened = true,
})

-- Distancia donde termina la niebla
local FogEndSlider = fogsec:Slider({
    Title = "Distancia de Niebla (FogEnd)",
    Desc = "A qué distancia el mapa se vuelve invisible.",
    Step = 10,
    Value = {Min = 0, Max = 5000, Default = Lighting.FogEnd},
    Callback = function(value)
        Lighting.FogEnd = value
    end
})

-- Color de la niebla
local FogColorPicker = fogsec:Colorpicker({
    Title = "Color de Niebla",
    Desc = "Ajusta el color del horizonte.",
    Default = Lighting.FogColor,
    Callback = function(color) 
        Lighting.FogColor = color
    end
})

local postProc = Config2:Section({ 
    Title = "Postprocesado",
    Box = true,
    TextTransparency = 0.05,
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
    Opened = true,
})

-- Intensidad del Brillo (Bloom)
local BloomSlider = postProc:Slider({
    Title = "Intensidad Bloom",
    Desc = "Ajusta qué tanto brillan las luces blancas.",
    Step = 0.1,
    Value = {Min = 0, Max = 5, Default = 1},
    Callback = function(value)
        local bloom = Lighting:FindFirstChildOfClass("BloomEffect") or Instance.new("BloomEffect", Lighting)
        bloom.Intensity = value
    end
})

-- Saturación de Color
local SaturationSlider = postProc:Slider({
    Title = "Saturación",
    Desc = "Colores más vivos (positivo) o blanco y negro (negativo).",
    Step = 0.1,
    Value = {Min = -1, Max = 2, Default = 0},
    Callback = function(value)
        local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
        cc.Saturation = value
    end
})

-- Desenfoque (Blur)
local BlurSlider = postProc:Slider({
    Title = "Desenfoque (Blur)",
    Desc = "Añade un efecto de suavizado a la pantalla.",
    Step = 1,
    Value = {Min = 0, Max = 20, Default = 0},
    Callback = function(value)
        local blur = Lighting:FindFirstChildOfClass("BlurEffect") or Instance.new("BlurEffect", Lighting)
        blur.Size = value
    end
})

local SkyboxInput = postProc:Input({
    Title = "Custom Skybox ID",
    Desc = "Pega el ID de una imagen para cambiar el cielo.",
    Value = "16573632795", -- Un ID por defecto (Cielo azul)
    InputIcon = "image",
    Type = "Input",
    Placeholder = "Escribe el ID aquí...",
    Callback = function(id) 
        if tonumber(id) then
            SetSkybox(id)
        else
            warn("El ID introducido no es válido.")
        end
    end
})

local ResetButton = Config2:Button({
    Title = "Resetear Todo",
    Color = Color3.fromHex("#ff4b4b"), -- Rojo para advertencia
    Justify = "Center",
    Callback = function()
        Lighting.Brightness = 2
        Lighting.ClockTime = 12
        Lighting.FogEnd = 100000
        Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
        
        -- Eliminar efectos extra
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("PostProcessEffect") then
                effect:Destroy()
            end
        end
    end
})




info:Select() -- Select Tab
