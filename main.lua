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
    Image = "rbxassetid://10734950309", -- Un icono de "ojo" o "brillo"
    ImageSize = 30,
    Thumbnail = "rbxassetid://" .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).IconImageAssetId,
    ThumbnailSize = 80,
    Locked = false,
})


info:Select() -- Select Tab
