from datetime import datetime, timezone
import uuid
from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer

from app.core.security import (
    create_access_token,
    decode_access_token,
    hash_password,
    verify_password,
)
from app.db.mongodb import get_database
from app.models.user import (
    TokenResponse,
    UserLogin,
    UserRegister,
    UserResponse,
    UserProfileUpdate,
    XPAddRequest,
)

router = APIRouter(prefix="/auth", tags=["Authentication"])
security = HTTPBearer(auto_error=False)

def _doc_to_user_response(doc: dict) -> UserResponse:
    user_id = str(doc.get("_id", doc.get("id", "")))
    return UserResponse(
        id=user_id,
        email=doc["email"],
        username=doc["username"],
        full_name=doc.get("full_name"),
        patron_deity=doc.get("patron_deity", "Apollo"),
        mythic_title=doc.get("mythic_title", "Initiate of Olympus"),
        experience_points=doc.get("experience_points", 100),
        streak_days=doc.get("streak_days", 1),
        is_active=doc.get("is_active", True),
        created_at=doc.get("created_at") or datetime.now(timezone.utc),
    )

async def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(security),
) -> UserResponse:
    if not credentials or not credentials.credentials:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Missing authentication credentials.",
            headers={"WWW-Authenticate": "Bearer"},
        )
    
    payload = decode_access_token(credentials.credentials)
    if not payload or "sub" not in payload:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid or expired mythic token.",
            headers={"WWW-Authenticate": "Bearer"},
        )
    
    user_id = payload["sub"]
    db = get_database()
    user_doc = await db.users.find_one({"_id": user_id})
    if not user_doc:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Mortal soul not found in records of Delphi.",
        )
    
    return _doc_to_user_response(user_doc)

@router.post("/register", response_model=TokenResponse, status_code=status.HTTP_201_CREATED)
async def register(payload: UserRegister):
    db = get_database()
    
    # Check if email exists
    existing_email = await db.users.find_one({"email": payload.email.lower()})
    if existing_email:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="An initiate with this email is already enrolled in the temple.",
        )
    
    # Check if username exists
    existing_user = await db.users.find_one({"username": payload.username.lower()})
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="This mythic moniker has already been claimed by another hero.",
        )
    
    user_id = str(uuid.uuid4())
    now = datetime.now(timezone.utc)
    
    # Title based on patron deity
    title_map = {
        "Zeus": "Thunderbolt Bearer",
        "Athena": "Strategist of Wisdom",
        "Apollo": "Oracle Lyrist",
        "Poseidon": "Wave Shaker",
        "Artemis": "Silver Huntress",
        "Hades": "Shadow Walker",
    }
    mythic_title = title_map.get(payload.patron_deity, "Initiate of Olympus")

    new_user_doc = {
        "_id": user_id,
        "email": payload.email.lower(),
        "username": payload.username.lower(),
        "full_name": payload.full_name,
        "hashed_password": hash_password(payload.password),
        "patron_deity": payload.patron_deity,
        "mythic_title": mythic_title,
        "experience_points": 150,  # Welcome gift from the Gods
        "streak_days": 1,
        "is_active": True,
        "created_at": now,
        "updated_at": now,
    }
    
    await db.users.insert_one(new_user_doc)
    
    token = create_access_token(subject=user_id)
    user_resp = _doc_to_user_response(new_user_doc)
    
    return TokenResponse(
        access_token=token,
        token_type="bearer",
        user=user_resp,
    )

@router.post("/login", response_model=TokenResponse)
async def login(payload: UserLogin):
    db = get_database()
    identifier = payload.email_or_username.lower().strip()
    
    # Search by email or username
    user_doc = await db.users.find_one({"email": identifier})
    if not user_doc:
        user_doc = await db.users.find_one({"username": identifier})
        
    if not user_doc:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid credentials. Verify your name or scroll of inscription.",
        )
    
    if not verify_password(payload.password, user_doc.get("hashed_password", "")):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="The sacred passphrase does not align with Olympian truth.",
        )
    
    user_id = str(user_doc["_id"])
    token = create_access_token(subject=user_id)
    user_resp = _doc_to_user_response(user_doc)
    
    return TokenResponse(
        access_token=token,
        token_type="bearer",
        user=user_resp,
    )

@router.get("/me", response_model=UserResponse)
async def get_my_profile(current_user: UserResponse = Depends(get_current_user)):
    return current_user

@router.patch("/profile", response_model=UserResponse)
async def update_profile(
    payload: UserProfileUpdate,
    current_user: UserResponse = Depends(get_current_user),
):
    db = get_database()
    update_data: dict[str, Any] = {"updated_at": datetime.now(timezone.utc)}
    
    if payload.full_name is not None:
        update_data["full_name"] = payload.full_name
        
    if payload.patron_deity is not None:
        title_map = {
            "Zeus": "Thunderbolt Bearer",
            "Athena": "Strategist of Wisdom",
            "Apollo": "Oracle Lyrist",
            "Poseidon": "Wave Shaker",
            "Artemis": "Silver Huntress",
            "Hades": "Shadow Walker",
        }
        update_data["patron_deity"] = payload.patron_deity
        update_data["mythic_title"] = title_map.get(
            payload.patron_deity, f"Initiate of {payload.patron_deity}"
        )
        
    await db.users.update_one({"_id": current_user.id}, {"$set": update_data})
    updated_doc = await db.users.find_one({"_id": current_user.id})
    return _doc_to_user_response(updated_doc or {})

@router.post("/experience", response_model=UserResponse)
async def award_experience(
    payload: XPAddRequest,
    current_user: UserResponse = Depends(get_current_user),
):
    db = get_database()
    user_doc = await db.users.find_one({"_id": current_user.id})
    current_xp = user_doc.get("experience_points", 100) if user_doc else 100
    new_xp = current_xp + payload.xp_to_add
    
    await db.users.update_one(
        {"_id": current_user.id},
        {"$set": {"experience_points": new_xp, "updated_at": datetime.now(timezone.utc)}},
    )
    updated_doc = await db.users.find_one({"_id": current_user.id})
    return _doc_to_user_response(updated_doc or {})

