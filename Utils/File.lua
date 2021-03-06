-----------------------------------------------------------------------------------------
--
-- File I/O Util
--
-----------------------------------------------------------------------------------------

local File = {}
local json = require('json')

-- Save a file to local directory
-- https://docs.coronalabs.com/guide/data/readWriteFiles/index.html#reading-files
File.save = function(dir, data)
    local path = system.pathForFile( dir, system.DocumentsDirectory )
    local file, errorString = io.open( path, "w" )
    
    if not file then
        print( "File error: " .. errorString )
    else
        print('File saved at: ' .. path)
        file:write( json.encode( data ) )
        io.close( file )
    end    
end

-- Read a file from a local directory
File.read = function(dir, data)
    local path = system.pathForFile( dir, system.DocumentsDirectory )
    local file, errorString = io.open( path, "r" )
    local content
    
    if not file then
        print( "File error: " .. errorString )
    else
        contents = file:read( "*a" )
        print('Open File: ' .. path)
        -- print( "Contents of " .. path .. "\n" .. contents )
        io.close( file )
    end

    return contents
end

return File