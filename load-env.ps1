$envFile = Join-Path $PSScriptRoot ".env"

if (Test-Path $envFile) {
    Write-Host "Loading environment variables from .env" -ForegroundColor Green
    
    Get-Content $envFile | ForEach-Object {
        # Skip comments and empty lines
        if ($_ -match '^\s*#') { return }
        if ($_ -match '^\s*$') { return }
        
        # Parse lines like: DBT_SERVER = my.server.com
        if ($_ -match '^\s*([^=]+?)\s*=\s*(.+)$') {
            $name  = $matches[1].Trim()
            $value = $matches[2].Trim()
            
            # Remove surrounding quotes if present
            $value = $value -replace '^["'']|["'']$',''
            
            # Set the variable for the current process (PowerShell session)
            [Environment]::SetEnvironmentVariable($name, $value, "Process")
            
            Write-Host "   → Set $name"
        }
    }
    
    Write-Host "`nReady! You can now run dbt commands normally.`n"
} else {
    Write-Host "No .env file found at $envFile" -ForegroundColor Yellow
}