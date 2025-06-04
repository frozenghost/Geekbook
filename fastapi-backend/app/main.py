"""FastAPI main application."""

import json
import os
from contextlib import asynccontextmanager
from typing import AsyncGenerator

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.config import settings
from app.database import close_db, init_db
from app.routers import health


@asynccontextmanager
async def lifespan(app: FastAPI) -> AsyncGenerator[None, None]:
    """Application lifespan events."""
    # Startup
    await init_db()
    
    # Export OpenAPI schema for frontend
    if settings.openapi_output_file:
        os.makedirs(os.path.dirname(settings.openapi_output_file), exist_ok=True)
        with open(settings.openapi_output_file, "w") as f:
            json.dump(app.openapi(), f, indent=2)
    
    yield
    
    # Shutdown
    await close_db()


# Create FastAPI application
app = FastAPI(
    title="FastAPI Backend",
    description="A modern FastAPI backend with Prisma ORM",
    version="0.1.0",
    docs_url="/docs",
    redoc_url="/redoc",
    lifespan=lifespan,
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.allowed_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(health.router, prefix="/api", tags=["health"])


@app.get("/")
async def root():
    """Root endpoint."""
    return {
        "message": "Welcome to FastAPI Backend",
        "docs": "/docs",
        "redoc": "/redoc",
        "version": "0.1.0",
    }