# ⚡ Mythos FastAPI Backend

RESTful backend service powering the Mythos ancient Greek mythology application. Built with FastAPI, Pydantic v2, Motor (MongoDB), and bcrypt authentication.

---

## 🏛️ Features

- **JWT Authentication**: HS256 JWT tokens with 7-day expiration.
- **Bcrypt Password Security**: Passwords hashed securely using `passlib` & `bcrypt`.
- **Motor Async MongoDB Driver**: Non-blocking asynchronous database operations.
- **Resilient In-Memory Fallback**: Includes a transparent in-memory document store fallback (`MemoryDatabase`) ensuring that if local MongoDB is offline or unavailable during development or testing, registration, login, and profile updates succeed seamlessly.
- **Gamified Lore Tracking**: Track Initiate experience points (XP), Prometheus daily streaks, and Olympian patron deities.

---

## 🛠️ Tech Stack

- **Python**: 3.10+
- **Framework**: FastAPI 0.115+
- **ASGI Server**: Uvicorn
- **Validation**: Pydantic v2 & `email-validator`
- **Database**: MongoDB with `motor` async driver
- **Security**: `python-jose`, `passlib[bcrypt]`

---

## 🚀 Setup & Execution

### 1. Setup Virtual Environment

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

### 2. Configure Environment

Copy `.env.example` to `.env` (optional, default fallbacks are provided in `app/core/config.py`):

```bash
cp .env.example .env
```

Default variables:
```ini
MONGODB_URL=mongodb://localhost:27017
DATABASE_NAME=mythos_db
JWT_SECRET_KEY=olympus_secret_key_change_in_production
ACCESS_TOKEN_EXPIRE_MINUTES=10080
API_V1_PREFIX=/api/v1
```

### 3. Run Server

```bash
./run.sh
```
Or directly via uvicorn:
```bash
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

---

## 📖 API Documentation

Interactive Swagger documentation is available at [http://localhost:8000/docs](http://localhost:8000/docs) when the server is running.

### Endpoints

#### 1. System Health
```http
GET /health
```
Response:
```json
{
  "status": "healthy",
  "service": "mythos-api",
  "mongodb_live": false
}
```

#### 2. Register Initiate
```http
POST /api/v1/auth/register
Content-Type: application/json

{
  "username": "odysseus",
  "email": "odysseus@ithaca.gr",
  "password": "secretpassword",
  "full_name": "Odysseus of Ithaca",
  "patron_deity": "Athena"
}
```

#### 3. Login
```http
POST /api/v1/auth/login
Content-Type: application/json

{
  "username": "odysseus",
  "password": "secretpassword"
}
```
Response:
```json
{
  "access_token": "eyJhbGciOi...",
  "token_type": "bearer",
  "user": {
    "id": "670...",
    "username": "odysseus",
    "email": "odysseus@ithaca.gr",
    "full_name": "Odysseus of Ithaca",
    "patron_deity": "Athena",
    "experience_points": 100,
    "streak_days": 1,
    "mythic_title": "Initiate of the Mysteries"
  }
}
```

#### 4. Fetch Current User Profile
```http
GET /api/v1/auth/me
Authorization: Bearer <access_token>
```

#### 5. Update Profile (Patron / Name)
```http
PATCH /api/v1/auth/profile
Authorization: Bearer <access_token>
Content-Type: application/json

{
  "patron_deity": "Apollo",
  "full_name": "Odysseus King of Ithaca"
}
```

#### 6. Award Experience Points (XP)
```http
POST /api/v1/auth/experience
Authorization: Bearer <access_token>
Content-Type: application/json

{
  "xp_earned": 50,
  "reason": "Delphic Trial Question Passed"
}
```
