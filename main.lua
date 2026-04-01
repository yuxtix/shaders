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
