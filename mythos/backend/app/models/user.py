from datetime import datetime, timezone
from typing import Optional
from pydantic import BaseModel, EmailStr, Field

class UserBase(BaseModel):
    email: EmailStr
    username: str = Field(..., min_length=3, max_length=30)
    full_name: Optional[str] = None
    patron_deity: str = Field(default="Apollo", description="Zeus, Athena, Apollo, Poseidon, Artemis, Hades")
    mythic_title: str = Field(default="Initiate of Olympus")

class UserRegister(UserBase):
    password: str = Field(..., min_length=6, max_length=128)

class UserLogin(BaseModel):
    email_or_username: str
    password: str

class UserResponse(UserBase):
    id: str
    experience_points: int = 100
    streak_days: int = 1
    is_active: bool = True
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))

class TokenResponse(BaseModel):
    access_token: str
    token_type: str = "bearer"
    user: UserResponse

class UserProfileUpdate(BaseModel):
    full_name: Optional[str] = None
    patron_deity: Optional[str] = None

class XPAddRequest(BaseModel):
    xp_to_add: int = Field(default=50, ge=1, le=500)

