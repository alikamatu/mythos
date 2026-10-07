# 🏛️ MYTHOS (ΜΥΘΟΣ)

> *Ancient Greek Mythology, History, and Classical Storytelling Made Alive, Interactive, and Personal.*

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.115+-009688?logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![MongoDB](https://img.shields.io/badge/MongoDB-Motor%20Async-47A248?logo=mongodb&logoColor=white)](https://www.mongodb.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-D4AF37.svg)](LICENSE)

---

## 🌟 Overview

**Mythos** is a classical Greek mythology and ancient history platform built as a full-stack monorepo. It combines immersive reading, narrated audio dramas, interactive Delphic trials, ancient geography, and customizable Olympian patron heraldry into a seamless mobile experience.

### Designed For
- 🎓 **Students & Lifelong Learners**: Accurate classical texts, historical footnotes, and pronunciation guides.
- ⚡ **Mythology Enthusiasts & Classicists**: In-depth lore from Homer, Hesiod, Ovid, and Athenian playwrights.
- 🏺 **History Buffs & Archaeophiles**: Explore ancient sanctuaries, bronze age citadels, and underworld gates.
- 🏛️ **Educators & Classrooms**: Dedicated classroom mode revealing study questions, historical context, and analysis.
- 📖 **Casual Readers**: Short, captivating epics accessible in 5–8 minute reads or audio listens.

---

## ✨ Key Features & Interactive Screens

Mythos features an `IndexedStack` architecture with five main destinations in the classical Greek bottom navigation bar:

```
[ Sanctuary ] ── [ Chronicles ] ── [ Trials ] ── [ Hellas Map ] ── [ Settings ]
   (Home)         (Story Codex)    (Delphi Quiz)    (Sacred Sites)   (Preferences)
```

### 1. 🏛️ Sanctuary (Home Portal)
- **3D Hero Card with Gyro Depth**: Interactive tilt and specular lighting on featured epics (*The Fall of Icarus*).
- **Pythian Oracle of Delphi**: Daily philosophical aphorisms with interactive oracle consultation cycling.
- **Prometheus 7-Day Spark**: Gamified daily reading streaks and classical lore tracking.
- **Realms of Antiquity**: Quick portals to the Chronicles, Audio Dramas, Pantheon, and Trials.
- **Olympian Pantheon Carousel**: Inspect deities (*Zeus, Athena, Apollo, Poseidon, Artemis, Hades*) with Greek titles, domains, symbols, and Homeric hymn previews.
- **Relic Codex**: Daily interactive artifact inspect sheet (*Aegis of Athena*).

### 2. 📜 The Chronicles (Story Codex)
- **Real-Time Myth Search**: Instant filter across English titles, Greek polytonic names, tags, and epochs.
- **Scrollable Category Filters**: *All Epics*, *Heroic Quests*, *Creation Myths*, *Underworld*, *The Trojan War*.
- **Comprehensive Story Sheets**: Drop caps, Greek polytonic sub-captions, narrator credits, reading progress, and quick audio launch.

### 3. ⚔️ Trials of Delphi (Quiz Arena)
- **Delphic Trivia Arena**: Interactive multiple-choice challenges covering the Titanomachy, Athena's contest, Oedipus and the Sphinx, and Orpheus.
- **Oracle Verification**: Instant visual feedback in laurel green, revealing historical explanations and primary sources.
- **Live XP Synchronization**: Correct answers award **+50 XP**, synced automatically via REST API to the backend service.
- **Hellas Leaderboard**: Global community ranks with Olympian patron heraldry and Initiate titles.

### 4. 🗺️ Hellas Map & Sacred Geography
- **Interactive Sanctuary Inspection**: Explore *Mount Olympus*, *Sanctuary of Delphi*, *The Acropolis of Athens*, *The Labyrinth of Knossos*, *Cape Taenarum (Gates of Hades)*, and *The Citadel of Troy*.
- **3D Landmark Cards**: Dynamic card updates showing guardian deities, Greek polytonic titles, mythic significance, and archaeological context.

### 5. ⚙️ User Settings & Sanctuary Codex
- **Initiate Crest Header**: Displays initiate rank (*Seeker of Wisdom* / *Archon*), current XP, and spark streak.
- **Olympian Patron Deity Switcher**: Live selection between *Athena, Zeus, Apollo, Poseidon, Artemis, Hades*, instantly synced to the database.
- **Narrative Audio Voices**: Choose among *Nikolaos of Rhodes (Epic Homeric)*, *Helena Cassander (Delphic Choirs)*, *Orion Valerius*, and *Cassandra Dorian*.
- **Ancient Lyre & Kithara Ambiance**: Custom volume slider (0%–100%) and auto-play toggle.
- **Classics & Classroom Codex**:
  - Scripture font scale adjustment (80% to 150%).
  - Classical Greek subtitles and polytonic script toggle.
  - Ancient illuminated drop caps toggle.
  - **Educator & Classroom Mode**: Reveals student discussion questions, historical context, and footnotes.
- **Backend Gateway Diagnostic**: Live ping button testing connectivity to the FastAPI server at `/health`.

### 6. 🎧 Persistent Floating Audio Bar
- Mini player docked above navigation across all screens, allowing users to listen to lyre-backed narrations while browsing the map or taking quizzes.

### 7. 🔐 Initiation & Sanctuary Auth
- Modal registration and sign-in with Olympian patron selector, JWT authentication, and guest fallback.

---

## 🎨 Classical Design System

The visual identity is modeled on classical Greek aesthetics, ancient inscriptions, and architectural motifs:

| Token | Hex Color | Description |
|---|---|---|
| **Olympus Gold** | `#D4AF37` | Divine radiance, borders, active badges |
| **Gold Light** | `#F3E5AB` | Shimmer highlights and classical headings |
| **Obsidian Dark** | `#0B0E17` | Deep cosmos/stone background |
| **Card Surface** | `#151D33` | Polished Athenian marble tile |
| **Aegean Sky** | `#38BDF8` | Coastal waters, navigation accents |
| **Prometheus Fire** | `#F97316` | Streak flames and sacrificial embers |
| **Laurel Green** | `#4ADE80` | Victory wreaths, correct trial answers |
| **Underworld Violet** | `#C084FC` | Chthonic mysteries and nocturnal deities |

- **Typography**: Google Fonts [`Cinzel`](https://fonts.google.com/specimen/Cinzel) (heroic inscriptional serif) and [`EB Garamond`](https://fonts.google.com/specimen/EB+Garamond) (humanist classical verse).
- **Greek Ornaments**: Custom-rendered Greek meander (key) border banners, Corinthian column dividers, and vector heraldry SVGs.

---

## 📁 Repository Structure

```
mythos/
├── lib/                             # Flutter Mobile Client
│   ├── data/
│   │   └── mythos_data.dart         # Epics, deities, relics, and oracle wisdom
│   ├── models/
│   │   ├── mythos_models.dart       # Stories, Deities, Relics, and Quizzes
│   │   └── user_profile.dart        # Initiate profile & XP model
│   ├── screens/
│   │   ├── auth_screen.dart         # Initiation & Sign-in
│   │   ├── chronicles_screen.dart   # Interactive story codex & filters
│   │   ├── hellas_map_screen.dart   # Sacred sites & landmark inspector
│   │   ├── settings_screen.dart     # Preferences, patron switcher & API diagnostic
│   │   └── trials_screen.dart       # Delphic quiz arena & XP reward
│   ├── services/
│   │   └── auth_service.dart        # Token storage & backend API client
│   ├── theme/
│   │   └── mythos_theme.dart        # Classical colors & typography tokens
│   ├── widgets/
│   │   ├── deity_detail_sheet.dart  # Deity inspect sheet with hymns
│   │   ├── deity_showcase.dart      # Olympian pantheon carousel
│   │   ├── floating_audio_bar.dart  # Persistent mini audio player
│   │   ├── greek_ornaments.dart     # Meander banners & column dividers
│   │   ├── hero_story_carousel.dart # 3D Hero card with specular highlights
│   │   ├── interactive_3d_card.dart # Gyroscopic tilt card wrapper
│   │   ├── oracle_banner.dart       # Delphi wisdom cycler
│   │   ├── particle_background.dart # Floating Olympian golden particles
│   │   ├── realms_grid.dart         # Four classical portal shortcuts
│   │   ├── relic_card.dart          # Daily artifact showcase
│   │   ├── relic_detail_sheet.dart  # Relic inspection sheet
│   │   ├── story_detail_sheet.dart  # Full story reader modal
│   │   ├── story_shelf.dart         # Story list cards with audio tags
│   │   └── user_profile_sheet.dart  # Initiate rank modal
│   └── main.dart                    # Application root & 5-tab IndexedStack
├── backend/                         # FastAPI Backend Service
│   ├── app/
│   │   ├── core/
│   │   │   ├── config.py            # App settings & JWT secrets
│   │   │   └── security.py          # Password hashing (bcrypt) & JWT creation
│   │   ├── db/
│   │   │   └── mongodb.py           # Motor async driver + resilient in-memory fallback
│   │   ├── models/
│   │   │   └── user.py              # Pydantic schemas (Auth, XP, Profile)
│   │   └── routes/
│   │       └── auth.py              # Authentication, Profile & XP endpoints
│   ├── main.py                      # FastAPI app entry point & CORS
│   ├── requirements.txt             # Python dependencies
│   ├── run.sh                       # Backend bootstrap script
│   └── .env.example                 # Environment template
└── test/
    └── widget_test.dart             # Comprehensive multi-tab automated tests
```

---

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK**: `>= 3.10.0`
- **Dart SDK**: `>= 3.0.0`
- **Python**: `>= 3.10`
- **MongoDB** *(Optional)*: Locally running on `mongodb://localhost:27017` or MongoDB Atlas.
  > *Note: If MongoDB is offline, the backend automatically activates an in-memory document store fallback so the app continues to operate without error.*

---

### 1. Running the FastAPI Backend

```bash
cd backend

# Create virtual environment
python3 -m venv .venv
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Start backend server
./run.sh
```

The API server will launch at `http://0.0.0.0:8000`.
- Interactive Swagger Documentation: [http://localhost:8000/docs](http://localhost:8000/docs)
- Health Endpoint: [http://localhost:8000/health](http://localhost:8000/health)

#### API Endpoints
| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/health` | Service health & database status |
| `POST` | `/api/v1/auth/register` | Register initiate with Olympian patron deity |
| `POST` | `/api/v1/auth/login` | Login and receive JWT access token |
| `GET` | `/api/v1/auth/me` | Fetch active initiate profile & XP |
| `PATCH` | `/api/v1/auth/profile` | Update patron deity or initiate full name |
| `POST` | `/api/v1/auth/experience` | Award XP for completed Delphic trials |

---

### 2. Running the Flutter App

From the root directory:

```bash
# Get Flutter dependencies
flutter pub get

# Run on macOS desktop, iOS simulator, Android emulator, or Web
flutter run
```

---

## 🧪 Testing & Verification

The project includes static analysis and automated test suites:

```bash
# Verify static analysis (0 errors, 0 warnings)
flutter analyze

# Run automated widget & interaction tests
flutter test
```

### Verified Test Cases
- ✅ **Sanctuary Tab**: 3D hero cards, Delphi oracle quote cycling, Olympian modal inspect sheets.
- ✅ **5-Tab Navigation**: Seamless switching between Sanctuary, Chronicles, Trials, Hellas Map, and Settings.
- ✅ **Trials Arena**: Selecting Delphic quiz options, verifying oracle answers, and validating lore explanations.
- ✅ **Hellas Map**: Inspecting sacred sites and toggling landmark detail cards.
- ✅ **Settings Screen**: Verifying patron switcher, narrator voices, classroom mode, and live `/health` ping.
- ✅ **Initiation Flow**: Switching between Sign Up and Sign In modes with patron deity selection.

---

## 📜 Classical Attribution & Colophon

- *Texts and adaptations drawn from Homer (Iliad, Odyssey, Homeric Hymns), Hesiod (Theogony, Works and Days), Apollodorus (Bibliotheca), and Ovid (Metamorphoses).*
- *Meander vectors and iconography inspired by Greek vase painting and Hellenistic architectural reliefs.*

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
