Write-Host "Setting up Next.js FastAPI Template..." -ForegroundColor Green
Write-Host ""

try {
    Write-Host "Step 1: Setting up backend dependencies..." -ForegroundColor Yellow
    Set-Location fastapi-backend
    & uv sync
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to install backend dependencies"
    }

    Write-Host "Step 2: Generating Prisma client..." -ForegroundColor Yellow
    & uv run prisma generate
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to generate Prisma client"
    }

    Write-Host "Step 3: Setting up frontend dependencies..." -ForegroundColor Yellow
    Set-Location ..\nextjs-frontend
    & yarn install
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to install frontend dependencies"
    }

    Set-Location ..
    Write-Host ""
    Write-Host "Setup completed successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "To start the development environment:" -ForegroundColor Cyan
    Write-Host "  1. Start database: docker compose up db -d" -ForegroundColor White
    Write-Host "  2. Start backend: make start-backend" -ForegroundColor White
    Write-Host "  3. Start frontend: make start-frontend" -ForegroundColor White
    Write-Host ""
    Write-Host "Or use Docker: make dev-docker" -ForegroundColor White
    Write-Host ""
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
    Set-Location ..
    exit 1
}

Read-Host "Press Enter to continue" 