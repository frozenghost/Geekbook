@echo off
echo Setting up Next.js FastAPI Template...
echo.

echo Step 1: Setting up backend dependencies...
cd fastapi-backend
call uv sync
if %errorlevel% neq 0 (
    echo Error: Failed to install backend dependencies
    pause
    exit /b 1
)

echo Step 2: Generating Prisma client...
call uv run prisma generate
if %errorlevel% neq 0 (
    echo Error: Failed to generate Prisma client
    pause
    exit /b 1
)

echo Step 3: Setting up frontend dependencies...
cd ..\nextjs-frontend
call yarn install
if %errorlevel% neq 0 (
    echo Error: Failed to install frontend dependencies
    pause
    exit /b 1
)

cd ..
echo.
echo Setup completed successfully!
echo.
echo To start the development environment:
echo   1. Start database: docker compose up db -d
echo   2. Start backend: make start-backend
echo   3. Start frontend: make start-frontend
echo.
echo Or use Docker: make dev-docker
echo.
pause 