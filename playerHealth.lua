local M = {}

M.health = 10  -- Set the health to 10 initially

function M.init( options )

    local customOptions = options or {}
    local opt = {}
    opt.fontSize = customOptions.fontSize or 24
    opt.font = customOptions.font or native.systemFont
    opt.x = customOptions.x or display.contentCenterX
    opt.y = customOptions.y or opt.fontSize*0.5
    opt.maxDigits = customOptions.maxDigits or 6
    opt.leadingZeros = customOptions.leadingZeros or false

    local prefix = "Health : "
    if ( opt.leadingZeros ) then
        prefix = "0"
    end
    M.format = "%" .. prefix .. opt.maxDigits .. "d"

    -- Create the health display object
    M.playerHealthText = display.newText( "Health : 1" .. string.format( M.format, 0 ), opt.x, opt.y, opt.font, opt.fontSize )

    return M.playerHealthText
end

function M.set( value )
    M.health = tonumber(value)
    M.playerHealthText.text =  "Health : " .. string.format( M.format, M.health )
end

function M.get()
    return M.health
end

function M.add( amount )
    M.health = M.health + tonumber(amount)
    M.playerHealthText.text =  "Health : " .. string.format( M.format, M.health )
end

function M.save()
    local saved = system.setPreferences( "app", { currentHealth=M.health } )
    if ( saved == false ) then
        print( "ERROR: could not save health" )
    end
end

function M.load()
    local health = system.getPreference( "app", "currentHelath", "number" )
    if ( health ) then
        return tonumber(health)
    else
        print( "ERROR: could not load health (health may not exist in storage)" )
    end
end
return M