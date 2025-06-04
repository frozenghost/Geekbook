"""Health check router."""

from fastapi import APIRouter, Depends
from prisma import Prisma

from app.database import get_database

router = APIRouter()


@router.get("/health")
async def health_check(db: Prisma = Depends(get_database)):
    """Health check endpoint."""
    try:
        # Test database connection
        await db.query_raw("SELECT 1")
        db_status = "healthy"
    except Exception as e:
        db_status = f"unhealthy: {str(e)}"
    
    return {
        "status": "healthy" if db_status == "healthy" else "unhealthy",
        "database": db_status,
        "version": "0.1.0",
    } 