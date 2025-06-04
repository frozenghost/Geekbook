"""Database connection and Prisma client management."""

import asyncio
from contextlib import asynccontextmanager
from typing import AsyncGenerator

from prisma import Prisma

from app.config import settings

# Global Prisma client instance
prisma = Prisma()


async def connect_db() -> None:
    """Connect to the database."""
    if not prisma.is_connected():
        await prisma.connect()


async def disconnect_db() -> None:
    """Disconnect from the database."""
    if prisma.is_connected():
        await prisma.disconnect()


@asynccontextmanager
async def get_db() -> AsyncGenerator[Prisma, None]:
    """Get database connection context manager."""
    await connect_db()
    try:
        yield prisma
    finally:
        # Don't disconnect here as we want to keep the connection alive
        # for the duration of the application
        pass


async def init_db() -> None:
    """Initialize database connection."""
    await connect_db()


async def close_db() -> None:
    """Close database connection."""
    await disconnect_db()


# Database dependency for FastAPI
async def get_database() -> Prisma:
    """FastAPI dependency to get database connection."""
    if not prisma.is_connected():
        await connect_db()
    return prisma 