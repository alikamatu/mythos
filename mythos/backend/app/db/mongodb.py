import logging
from typing import Any, Optional
import uuid
from motor.motor_asyncio import AsyncIOMotorClient, AsyncIOMotorDatabase
from app.core.config import settings

logger = logging.getLogger("mythos.db")

class MemoryCollection:
    """In-memory async mock collection for fallback when local mongod is offline."""
    def __init__(self, name: str):
        self.name = name
        self.documents: list[dict[str, Any]] = []

    async def create_index(self, *args, **kwargs):
        pass

    async def find_one(self, query: dict[str, Any]) -> Optional[dict[str, Any]]:
        for doc in self.documents:
            match = True
            for k, v in query.items():
                if doc.get(k) != v:
                    match = False
                    break
            if match:
                return dict(doc)
        return None

    async def insert_one(self, doc: dict[str, Any]):
        inserted = dict(doc)
        if "_id" not in inserted:
            inserted["_id"] = str(uuid.uuid4())
        self.documents.append(inserted)
        
        class InsertResult:
            inserted_id = inserted["_id"]
        return InsertResult()

    async def update_one(self, query: dict[str, Any], update: dict[str, Any]):
        doc = await self.find_one(query)
        if doc and "$set" in update:
            for k, v in update["$set"].items():
                doc[k] = v
        class UpdateResult:
            modified_count = 1 if doc else 0
        return UpdateResult()

class MemoryDatabase:
    def __init__(self):
        self.collections: dict[str, MemoryCollection] = {}

    def __getitem__(self, name: str) -> MemoryCollection:
        if name not in self.collections:
            self.collections[name] = MemoryCollection(name)
        return self.collections[name]

    def __getattr__(self, name: str) -> MemoryCollection:
        return self[name]

class MongoDB:
    client: Optional[AsyncIOMotorClient] = None
    db: Optional[AsyncIOMotorDatabase | MemoryDatabase] = None
    is_connected_to_real_mongo: bool = False

db = MongoDB()

async def connect_to_mongo():
    logger.info("Connecting to MongoDB at %s...", settings.MONGODB_URL)
    try:
        db.client = AsyncIOMotorClient(
            settings.MONGODB_URL,
            serverSelectionTimeoutMS=2000,
        )
        # Ping the server to verify connectivity
        await db.client.admin.command('ping')
        db.db = db.client[settings.DATABASE_NAME]
        db.is_connected_to_real_mongo = True
        logger.info("Successfully connected to live MongoDB (%s)!", settings.DATABASE_NAME)
        
        # Ensure indexes
        await db.db.users.create_index("email", unique=True)
        await db.db.users.create_index("username", unique=True)
    except Exception as e:
        logger.warning(
            "Could not connect to live MongoDB (%s). Activating in-memory mock store for offline development.",
            str(e),
        )
        db.db = MemoryDatabase()
        db.is_connected_to_real_mongo = False

async def close_mongo_connection():
    if db.client:
        logger.info("Closing MongoDB connection...")
        db.client.close()
        logger.info("MongoDB connection closed.")

def get_database() -> AsyncIOMotorDatabase | MemoryDatabase:
    if db.db is None:
        db.db = MemoryDatabase()
    return db.db
