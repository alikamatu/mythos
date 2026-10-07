from contextlib import asynccontextmanager
import logging
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.core.config import settings
from app.db.mongodb import close_mongo_connection, connect_to_mongo, db
from app.routes.auth import router as auth_router

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
)
logger = logging.getLogger("mythos.api")

@asynccontextmanager
async def lifespan(app: FastAPI):
    logger.info("Initializing Mount Olympus API backend...")
    await connect_to_mongo()
    yield
    logger.info("Shutting down Mount Olympus API backend...")
    await close_mongo_connection()

app = FastAPI(
    title=settings.PROJECT_NAME,
    version=settings.VERSION,
    description="Ancient Greek Mythology API powered by FastAPI & MongoDB",
    lifespan=lifespan,
    docs_url="/docs",
    redoc_url="/redoc",
)

# Enable CORS for all mobile & web clients
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.BACKEND_CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include Routers
app.include_router(auth_router, prefix=settings.API_V1_PREFIX)

@app.get("/", tags=["Health"])
async def root():
    return {
        "message": "Welcome to Mythos API • Mount Olympus Gateway",
        "version": settings.VERSION,
        "docs": "/docs",
        "database": "Live MongoDB" if db.is_connected_to_real_mongo else "In-Memory Document Store (Offline Fallback)",
    }

@app.get("/health", tags=["Health"])
async def health_check():
    return {
        "status": "healthy",
        "service": "mythos-api",
        "mongodb_live": db.is_connected_to_real_mongo,
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
